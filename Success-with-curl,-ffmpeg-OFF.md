To generate these logs, I started telly and then retrieved a channel from the lineup using `curl`.

Here most of the activity is on the client side because telly's doing the minimum, just redirecting.

Here you can see telly responding to the channel request; it's issuing a redirect to the provider stream.

### telly side
```
time="2019-03-13T22:04:26Z" level=info msg="telly is preparing to go live (version=1.1.0.5, branch=dev, revision=0d28df61af33f5f0779427d8ad24d62a719e478c)"
time="2019-03-13T22:04:26Z" level=info msg="Loading M3U from http://iptv-area-51.tv:2095/get.php?username=REDACTED&password=REDACTED&type=m3u_plus&output=ts"
time="2019-03-13T22:04:27Z" level=info msg="Loading XMLTV from http://iptv-area-51.tv:2095/xmltv.php?username=REDACTED&password=REDACTED"
time="2019-03-13T22:04:37Z" level=info msg="Loaded 322 channels into the lineup from Area51"
time="2019-03-13T22:04:37Z" level=info msg="telly is live and on the air!"
time="2019-03-13T22:04:37Z" level=info msg="Broadcasting from http://0.0.0.0:6077/"
time="2019-03-13T22:04:37Z" level=info msg="EPG URL: http://0.0.0.0:6077/epg.xml"
time="2019-03-13T22:04:45Z" level=info msg="Serving channel number 10321"
```

### client side

Some identifying data has been redacted here.

Here we request the channel.  Telly returns a redirect to the URL from the M3U, which starts streaming the video data.

```
ChazTD-MBP~(:|✔) % curl -fLv -o output.dat http://192.168.43.244:6077/auto/v10321
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 192.168.43.244...
* TCP_NODELAY set
* Connected to 192.168.43.244 (192.168.43.244) port 6077 (#0)
> GET /auto/v10321 HTTP/1.1
> Host: 192.168.43.244:6077
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< Content-Type: text/html; charset=utf-8
< Location: http://iptv-area-51.tv:2095/USERNAME/PASSWORD/103
< Date: Wed, 13 Mar 2019 22:04:45 GMT
< Content-Length: 92
<
* Ignoring the response-body
{ [92 bytes data]
100    92  100    92    0     0  13379      0 --:--:-- --:--:-- --:--:-- 15333
* Connection #0 to host 192.168.43.244 left intact
* Issue another request to this URL: 'http://iptv-area-51.tv:2095/USERNAME/PASSWORD/103'
*   Trying 185.59.220.186...
* TCP_NODELAY set
* Connected to iptv-area-51.tv (185.59.220.186) port 2095 (#1)
> GET /USERNAME/PASSWORD/103 HTTP/1.1
> Host: iptv-area-51.tv:2095
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 302 Found
< Server: nginx
< Date: Wed, 13 Mar 2019 22:04:01 GMT
< Content-Type: text/html; charset=UTF-8
< Connection: close
< Access-Control-Allow-Origin: *
< Location: http://185.152.66.40:2095/USERNAME/PASSWORD/103?token=REDACTED==
<
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0{ [0 bytes data]
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
* Closing connection 1
* Issue another request to this URL: 'http://185.152.66.40:2095/USERNAME/PASSWORD/103?token=REDACTED=='
*   Trying 185.152.66.40...
* TCP_NODELAY set
* Connected to 185.152.66.40 (185.152.66.40) port 2095 (#2)
> GET /USERNAME/PASSWORD/103?token=REDACTED== HTTP/1.1
> Host: 185.152.66.40:2095
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx
< Date: Wed, 13 Mar 2019 22:04:43 GMT
< Content-Type: video/mp2t
< Connection: close
< Access-Control-Allow-Origin: *
<
{ [2632 bytes data]
100 7422k    0 7422k    0     0  1174k      0 --:--:--  0:00:06 --:--:-- 1483k^C
```