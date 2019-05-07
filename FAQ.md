### HOW CAN I TELL IF MY PROVIDER IS BLOCKING CONNECTIONS?

From the machine which is running telly, assuming it's linux, use curl to try to retrieve one of the media links from inside the M3U.  If you're wondering about a specific channel, use that one.

Here's a successful case which is not being blocked:

```bash
➜  telly-testing curl -f -v -L -o output.txt http://SERVER:PORT/path/to/46254.ts
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 123.123.123.123...
* TCP_NODELAY set
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Connected to SERVER (123.123.123.123) port PORT (#0)
> GET /path/to/46254.ts HTTP/1.1
> Host: SERVER:PORT
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 302 Found
< Server: nginx
< Date: Wed, 05 Sep 2018 04:59:57 GMT
< Content-Type: text/html; charset=UTF-8
< Connection: close
< Access-Control-Allow-Origin: *
< Location: http://234.234.234.234:PORT/path/to/46254.ts?token=TOKEN_TEXT
<
{ [0 bytes data]
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
* Closing connection 0
* Issue another request to this URL: 'http://234.234.234.234:PORT/path/to/46254.ts?token=TOKEN_TEXT'
*   Trying 234.234.234.234...
* TCP_NODELAY set
* Connected to 234.234.234.234 (234.234.234.234) port PORT (#1)
> GET /path/to/46254.ts?token=TOKEN_TEXT HTTP/1.1
> Host: 234.234.234.234:PORT
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx
< Date: Wed, 05 Sep 2018 04:59:58 GMT
< Content-Type: video/mp2t
< Connection: close
< Access-Control-Allow-Origin: *
<
{ [4232 bytes data]
100 6121k    0 6121k    0     0  2798k      0 --:--:--  0:00:02 --:--:-- 6478k^C
```
[Once that data file starts loading you can cancel with control-c.

If that request were blocked it would be apparent in the middle somewhere with a message about failed authorization or a timeout.