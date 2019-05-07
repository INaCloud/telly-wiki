After configuration, the next most common problem is with Plex returning a network error when a channel is tuned.

Telly by default doesn't do any stream processing; it just redirects Plex to the provider URL.  The lineup data that telly provides to plex is a set of channels and URLS:

```JSON
[
  {
    "GuideName": "A&E",
    "GuideNumber": "10000",
    "URL": "http:\/\/192.168.1.7:6077\/auto\/v10000"
  },
  {
    "GuideName": "A&E low bandwith",
    "GuideNumber": "10001",
    "URL": "http:\/\/192.168.1.7:6077\/auto\/v10001"
  },
  {
    "GuideName": "ABC",
    "GuideNumber": "10002",
    "URL": "http:\/\/192.168.1.7:6077\/auto\/v10002"
  },
  {
    "GuideName": "ABC West",
    "GuideNumber": "10003",
    "URL": "http:\/\/192.168.1.7:6077\/auto\/v10003"
  },
```

That IP address is the IP address you specified as the "Base address" in the config.

When Plex tunes to a channel, it makes a request to that URL.  Telly then responds in one of two ways:

If ffmpeg is DISABLED, telly just redirects Plex's request to the provider stream as supplied in the M3U file.  Plex follows the redirect and presumably displays the stream.  Telly isn't involved after that point.

If ffmpeg is ENABLED, telly connects to the provider's stream and runs it through ffmpeg on the way back to Plex; this allows telly to buffer the stream to even out network hiccups as well as ensure that the stream being provided to Plex is in a Plex-compatible format.  In this situation, telly is in the line throughout the playback of the stream.

You can review and may be able to diagnose problems here using curl.  Here are some transcripts showing successful runs in both cases.  You can try these same things and compare your results.

For both of these cases, I set up a filter that allowed one group of 303 channels into the lineup.  I turned the log level up to debug and ran telly.  In a second ssh session, I used curl to retrieve one channel [ABC in the JSON extract above].  I let it run for a little bit and then hit control-C in the second terminal to end the stream request.

Comments are interspersed in the log output.

# ffmpeg disabled

telly's output:

```
time="2018-11-16T20:17:46Z" level=info msg="telly is preparing to go live (version=, branch=, revision=)"
time="2018-11-16T20:17:46Z" level=debug msg="Build context (go=go1.11, user=, date=)"
time="2018-11-16T20:17:46Z" level=debug msg="Loaded configuration {\n    \"config\": {\n        \"file\": \"\"\n    },\n    \"discovery\": {\n        \"device-auth\": \"telly123\",\n        \"device-firmware-name\": \"hdhomeruntc_atsc\",\n        \"device-firmware-version\": \"20150826\",\n        \"device-friendly-name\": \"HDHomerun (telly)\",\n        \"device-id\": 12345678,\n        \"device-manufacturer\": \"Silicondust\",\n        \"device-model-number\": \"HDTC-2US\",\n        \"device-uuid\": \"12345678-AE2A-4E54-BBC9-33AF7D5D6A92\",\n        \"ssdp\": true\n    },\n    \"filter\": {\n        \"regex\": \".*\",\n        \"regex-inclusive\": false\n    },\n    \"iptv\": {\n        \"playlist\": \"\",\n        \"starting-channel\": 10000,\n        \"streams\": 1,\n        \"xmltv-channels\": true\n    },\n    \"log\": {\n        \"level\": \"debug\",\n        \"requests\": true\n    },\n    \"source\": [\n        {\n            \"Filter\": \"USA ENTERTAINMENT\",\n            \"FilterKey\": \"group-title\",\n            \"FilterRaw\": false,\n            \"Name\": \"\",\n            \"Password\": \"22222222\",\n            \"Provider\": \"Iris\",\n            \"Sort\": \"group-title\",\n            \"Username\": \"11111111\"\n        }\n    ],\n    \"version\": false,\n    \"web\": {\n        \"base-address\": \"192.168.1.7:6077\",\n        \"listen-address\": \"0.0.0.0:6077\"\n    }\n}"
time="2018-11-16T20:17:46Z" level=info msg="Loading M3U from http://irislinks.net:83/get.php?username=REDACTED&password=REDACTED&type=m3u_plus&output=ts"
time="2018-11-16T20:17:47Z" level=info msg="Loading XMLTV from http://irislinks.net:83/xmltv.php?username=REDACTED&password=REDACTED"
time="2018-11-16T20:17:59Z" level=debug msg="track.Tags map[tvg-id:btsport1.uk tvg-name:VIP BT Sports 1 HD tvg-logo:http://picon.helixhosting.ninja/30926.png group-title:UK VIP HD/FHD]"
time="2018-11-16T20:17:59Z" level=debug msg="Checking if filter (USA ENTERTAINMENT) matches string UK VIP HD/FHD"

** 7522 lines doing 3761 channel checks just like the previous one redacted **

time="2018-11-16T20:17:59Z" level=debug msg="These channels (303) passed the filter and successfully parsed: A&E, A&E low bandwith, ABC, ABC West, TRUNCATED FOR SPACE"
time="2018-11-16T20:17:59Z" level=debug msg="These channels (3459) did NOT pass the filter: VIP BT Sports 1 HD, VIP BT Sports 1 FHD, VIP BT Sports 2 HD, TRUNCATED FOR SPACE"
time="2018-11-16T20:17:59Z" level=info msg="Loaded 303 channels into the lineup from Iris"
time="2018-11-16T20:17:59Z" level=debug msg="creating device xml"
time="2018-11-16T20:17:59Z" level=debug msg="creating webserver routes"
[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:	export GIN_MODE=release
 - using code:	gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /metrics                  --> github.com/tellytv/telly/internal/go-gin-prometheus.prometheusHandler.func1 (4 handlers)
[GIN-debug] GET    /                         --> main.deviceXML.func1 (4 handlers)
[GIN-debug] GET    /discover.json            --> main.discovery.func1 (4 handlers)
[GIN-debug] GET    /lineup_status.json       --> main.serve.func1 (4 handlers)
[GIN-debug] POST   /lineup.post              --> main.serve.func2 (4 handlers)
[GIN-debug] GET    /device.xml               --> main.deviceXML.func1 (4 handlers)
[GIN-debug] GET    /lineup.json              --> main.serveLineup.func1 (4 handlers)
[GIN-debug] GET    /lineup.xml               --> main.serveLineup.func1 (4 handlers)
[GIN-debug] GET    /auto/:channelID          --> main.stream.func1 (4 handlers)
[GIN-debug] GET    /epg.xml                  --> main.xmlTV.func2 (4 handlers)
[GIN-debug] GET    /debug.json               --> main.serve.func3 (4 handlers)
time="2018-11-16T20:18:00Z" level=debug msg="Advertising telly as HDHomerun (telly) (12345678-AE2A-4E54-BBC9-33AF7D5D6A92)"
[GIN-debug] GET    /manage/*filepath         --> github.com/tellytv/telly/vendor/github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1 (4 handlers)
[GIN-debug] HEAD   /manage/*filepath         --> github.com/tellytv/telly/vendor/github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1 (4 handlers)
time="2018-11-16T20:18:00Z" level=info msg="telly is live and on the air!"
time="2018-11-16T20:18:00Z" level=info msg="Broadcasting from http://0.0.0.0:6077/"
time="2018-11-16T20:18:00Z" level=info msg="EPG URL: http://0.0.0.0:6077/epg.xml"
[GIN-debug] Listening and serving HTTP on 0.0.0.0:6077

** at this point I made the curl request in the other terminal **

time="2018-11-16T20:18:14Z" level=info msg="Serving channel number 10002"

** And that's the end of telly's involvement; it issued the redirect and is done **

```

second terminal output:

```
plex@dara:~$ curl -fLv -o output.ts http://192.168.1.7:6077/auto/v10002
*   Trying 192.168.1.7...
* TCP_NODELAY set
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Connected to 192.168.1.7 (192.168.1.7) port 6077 (#0)
> GET /auto/v10002 HTTP/1.1
> Host: 192.168.1.7:6077
> User-Agent: curl/7.60.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< Content-Type: text/html; charset=utf-8
< Location: http://irislinks.net:83/live/11111111/22222222/143434.ts
< Date: Fri, 16 Nov 2018 20:13:02 GMT
< Content-Length: 91
<
* Ignoring the response-body
{ [91 bytes data]
100    91  100    91    0     0  30333      0 --:--:-- --:--:-- --:--:-- 45500
* Connection #0 to host 192.168.1.7 left intact
* Issue another request to this URL: 'http://irislinks.net:83/live/11111111/22222222/143434.ts'
*   Trying 162.218.64.206...
* TCP_NODELAY set
* Connected to irislinks.net (162.218.64.206) port 83 (#1)
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0> GET /live/11111111/22222222/143434.ts HTTP/1.1
> Host: irislinks.net:83
> User-Agent: curl/7.60.0
> Accept: */*
>
< HTTP/1.1 302 Found
< Server: nginx
< Date: Fri, 16 Nov 2018 20:13:02 GMT
< Content-Type: text/html; charset=UTF-8
< Connection: close
< Access-Control-Allow-Origin: *
< Location: http://185.246.209.210:25461/live/11111111/22222222/143434.ts?token=REDACTED==
<
{ [0 bytes data]
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
* Closing connection 1
* Issue another request to this URL: 'http://185.246.209.210:25461/live/11111111/22222222/143434.ts?token=REDACTED=='
*   Trying 185.246.209.210...
* TCP_NODELAY set
* Connected to 185.246.209.210 (185.246.209.210) port 25461 (#2)
> GET /live/11111111/22222222/143434.ts?token=REDACTED== HTTP/1.1
> Host: 185.246.209.210:25461
> User-Agent: curl/7.60.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx
< Date: Fri, 16 Nov 2018 20:13:03 GMT
< Content-Type: video/mp2t
< Connection: close
< Access-Control-Allow-Origin: *
<
{ [11532 bytes data]
100 22.2M    0 22.2M    0     0  1206k      0 --:--:--  0:00:18 --:--:--  661k^C
plex@dara:~$
```

You can see there that telly issues a redirect to the Iris stream URL from the M3U and the client [curl in this case] follows that redirect [and a second done by Iris] until the video data starts coming in.

If there were a problem getting to the redirected URL it would show up there.  Perhaps an authentication error or something else.


# ffmpeg enabled

```
time="2018-11-16T20:07:57Z" level=info msg="telly is preparing to go live (version=, branch=, revision=)"

REMOVED LINES HERE IDENTICAL TO THE RUN ABOVE

[GIN-debug] Listening and serving HTTP on 0.0.0.0:6077

** at this point I made the curl request in the other terminal **

time="2018-11-16T20:08:23Z" level=info msg="Serving channel number 10002"
time="2018-11-16T20:08:23Z" level=info msg="Transcoding stream with ffmpeg"
time="2018-11-16T20:08:23Z" level=info msg="ffmpeg version 4.0.1 Copyright (c) 2000-2018 the FFmpeg developers"
time="2018-11-16T20:08:23Z" level=info msg="  built with gcc 6.2.1 (Alpine 6.2.1) 20160822"
time="2018-11-16T20:08:23Z" level=info msg="  configuration: --disable-debug --disable-doc --disable-ffplay --enable-shared --enable-avresample --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-gpl --enable-libass --enable-libfreetype --enable-libvidstab --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx265 --enable-libxvid --enable-libx264 --enable-nonfree --enable-openssl --enable-libfdk_aac --enable-libkvazaar --enable-libaom --extra-libs=-lpthread --enable-postproc --enable-small --enable-version3 --extra-cflags=-I/opt/ffmpeg/include --extra-ldflags=-L/opt/ffmpeg/lib --extra-libs=-ldl --prefix=/opt/ffmpeg"
time="2018-11-16T20:08:23Z" level=info msg="  libavutil      56. 14.100 / 56. 14.100"
time="2018-11-16T20:08:23Z" level=info msg="  libavcodec     58. 18.100 / 58. 18.100"
time="2018-11-16T20:08:23Z" level=info msg="  libavformat    58. 12.100 / 58. 12.100"
time="2018-11-16T20:08:23Z" level=info msg="  libavdevice    58.  3.100 / 58.  3.100"
time="2018-11-16T20:08:23Z" level=info msg="  libavfilter     7. 16.100 /  7. 16.100"
time="2018-11-16T20:08:23Z" level=info msg="  libavresample   4.  0.  0 /  4.  0.  0"
time="2018-11-16T20:08:23Z" level=info msg="  libswscale      5.  1.100 /  5.  1.100"
time="2018-11-16T20:08:23Z" level=info msg="  libswresample   3.  1.100 /  3.  1.100"
time="2018-11-16T20:08:23Z" level=info msg="  libpostproc    55.  1.100 / 55.  1.100"
time="2018-11-16T20:08:24Z" level=info msg="Input #0, mpegts, from 'http://irislinks.net:83/live/11111111/22222222/143434.ts':"
time="2018-11-16T20:08:24Z" level=info msg="  Duration: N/A, start: 48241.949122, bitrate: N/A"
time="2018-11-16T20:08:24Z" level=info msg="  Program 1 "
time="2018-11-16T20:08:24Z" level=info msg="    Metadata:"
time="2018-11-16T20:08:24Z" level=info msg="      service_name    : Service01"
time="2018-11-16T20:08:24Z" level=info msg="      service_provider: FFmpeg"
time="2018-11-16T20:08:24Z" level=info msg="    Stream #0:0[0x100]: Video: h264 ([27][0][0][0] / 0x001B), yuv420p(progressive), 1280x720 [SAR 1:1 DAR 16:9], Closed Captions, 59.94 fps, 59.94 tbr, 90k tbn, 119.88 tbc"
time="2018-11-16T20:08:24Z" level=info msg="    Stream #0:1[0x101]: Audio: aac ([15][0][0][0] / 0x000F), 48000 Hz, stereo, fltp, 121 kb/s"
time="2018-11-16T20:08:24Z" level=info msg="Output #0, mpegts, to 'pipe:1':"
time="2018-11-16T20:08:24Z" level=info msg="  Metadata:"
time="2018-11-16T20:08:24Z" level=info msg="    encoder         : Lavf58.12.100"
time="2018-11-16T20:08:24Z" level=info msg="    Stream #0:0: Video: h264 ([27][0][0][0] / 0x001B), yuv420p(progressive), 1280x720 [SAR 1:1 DAR 16:9], q=2-31, 59.94 fps, 59.94 tbr, 90k tbn, 90k tbc"
time="2018-11-16T20:08:24Z" level=info msg="    Stream #0:1: Audio: aac ([15][0][0][0] / 0x000F), 48000 Hz, stereo, fltp, 121 kb/s"
time="2018-11-16T20:08:24Z" level=info msg="Stream mapping:"
time="2018-11-16T20:08:24Z" level=info msg="  Stream #0:0 -> #0:0 (copy)"
time="2018-11-16T20:08:24Z" level=info msg="  Stream #0:1 -> #0:1 (copy)"
time="2018-11-16T20:08:24Z" level=info msg="Press [q] to stop, [?] for help"
time="2018-11-16T20:08:24Z" level=info msg="frame=   32 fps=0.0 q=-1.0 size=     441kB time=00:00:00.51 bitrate=7064.2kbits/s speed=1.02x    "
time="2018-11-16T20:08:25Z" level=info msg="frame=   61 fps= 60 q=-1.0 size=     753kB time=00:00:01.00 bitrate=6150.0kbits/s speed=0.991x    "
time="2018-11-16T20:08:25Z" level=info msg="frame=   92 fps= 61 q=-1.0 size=     982kB time=00:00:01.51 bitrate=5312.3kbits/s speed=0.997x    "
time="2018-11-16T20:08:26Z" level=info msg="frame=  122 fps= 60 q=-1.0 size=    1189kB time=00:00:02.01 bitrate=4838.5kbits/s speed=0.997x    "
time="2018-11-16T20:08:26Z" level=info msg="frame=  152 fps= 60 q=-1.0 size=    1399kB time=00:00:02.51 bitrate=4557.8kbits/s speed=0.998x    "
time="2018-11-16T20:08:27Z" level=info msg="frame=  183 fps= 61 q=-1.0 size=    1688kB time=00:00:03.03 bitrate=4562.6kbits/s speed=   1x    "
time="2018-11-16T20:08:27Z" level=info msg="frame=  213 fps= 61 q=-1.0 size=    1959kB time=00:00:03.53 bitrate=4543.7kbits/s speed=   1x    "
time="2018-11-16T20:08:28Z" level=info msg="frame=  243 fps= 60 q=-1.0 size=    2270kB time=00:00:04.03 bitrate=4612.7kbits/s speed=   1x    "
time="2018-11-16T20:08:28Z" level=info msg="frame=  273 fps= 60 q=-1.0 size=    2561kB time=00:00:04.53 bitrate=4629.0kbits/s speed=   1x    "
time="2018-11-16T20:08:29Z" level=info msg="frame=  303 fps= 60 q=-1.0 size=    2853kB time=00:00:05.03 bitrate=4644.4kbits/s speed=   1x    "
time="2018-11-16T20:08:29Z" level=info msg="frame=  333 fps= 60 q=-1.0 size=    3199kB time=00:00:05.53 bitrate=4735.5kbits/s speed=   1x    "
time="2018-11-16T20:08:30Z" level=info msg="frame=  364 fps= 60 q=-1.0 size=    3473kB time=00:00:06.05 bitrate=4702.4kbits/s speed=   1x    "
time="2018-11-16T20:08:30Z" level=info msg="frame=  394 fps= 60 q=-1.0 size=    3798kB time=00:00:06.55 bitrate=4749.5kbits/s speed=   1x    "
time="2018-11-16T20:08:31Z" level=info msg="frame=  424 fps= 60 q=-1.0 size=    4127kB time=00:00:07.05 bitrate=4793.9kbits/s speed=   1x    "
time="2018-11-16T20:08:31Z" level=info msg="frame=  455 fps= 60 q=-1.0 size=    4401kB time=00:00:07.56 bitrate=4763.4kbits/s speed=   1x    "
time="2018-11-16T20:08:32Z" level=info msg="frame=  485 fps= 60 q=-1.0 size=    4921kB time=00:00:08.06 bitrate=4996.2kbits/s speed=   1x    "
time="2018-11-16T20:08:32Z" level=info msg="frame=  515 fps= 60 q=-1.0 size=    5251kB time=00:00:08.56 bitrate=5019.3kbits/s speed=   1x    "
time="2018-11-16T20:08:33Z" level=info msg="frame=  546 fps= 60 q=-1.0 size=    5611kB time=00:00:09.08 bitrate=5058.5kbits/s speed=   1x    "
time="2018-11-16T20:08:33Z" level=info msg="frame=  576 fps= 60 q=-1.0 size=    5925kB time=00:00:09.58 bitrate=5062.2kbits/s speed=   1x    "
time="2018-11-16T20:08:34Z" level=info msg="frame=  607 fps= 60 q=-1.0 size=    6226kB time=00:00:10.10 bitrate=5047.5kbits/s speed=   1x    "
time="2018-11-16T20:08:35Z" level=info msg="frame=  637 fps= 60 q=-1.0 size=    6610kB time=00:00:10.60 bitrate=5105.8kbits/s speed=   1x    "
time="2018-11-16T20:08:35Z" level=info msg="frame=  668 fps= 60 q=-1.0 size=    6893kB time=00:00:11.12 bitrate=5077.1kbits/s speed=   1x    "
time="2018-11-16T20:08:36Z" level=info msg="frame=  698 fps= 60 q=-1.0 size=    7162kB time=00:00:11.62 bitrate=5047.9kbits/s speed=   1x    "
time="2018-11-16T20:08:36Z" level=info msg="frame=  728 fps= 60 q=-1.0 size=    7475kB time=00:00:12.12 bitrate=5050.9kbits/s speed=   1x    "
time="2018-11-16T20:08:37Z" level=info msg="frame=  759 fps= 60 q=-1.0 size=    7850kB time=00:00:12.64 bitrate=5087.2kbits/s speed=   1x    "
time="2018-11-16T20:08:37Z" level=error msg="Error when copying data" error="write tcp 192.168.1.7:6077->192.168.1.7:44930: write: broken pipe"
time="2018-11-16T20:08:37Z" level=info msg="Stopped streaming 10002"

** I'd cancelled the stream here **
```
You can see there that telly itself makes the request to the provider stream URL and runs it through ffmpeg, converting to h264/aac on the way out.  That "broken pipe" is when I cancelled in the other terminal.

Second terminal output:
```
plex@dara:~$ curl -fLv -o output.ts http://192.168.1.7:6077/auto/v10002
*   Trying 192.168.1.7...
* TCP_NODELAY set
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Connected to 192.168.1.7 (192.168.1.7) port 6077 (#0)
> GET /auto/v10002 HTTP/1.1
> Host: 192.168.1.7:6077
> User-Agent: curl/7.60.0
> Accept: */*
>
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0< HTTP/1.1 200 OK
< Date: Fri, 16 Nov 2018 20:08:24 GMT
< Content-Type: application/octet-stream
< Transfer-Encoding: chunked
<
{ [3972 bytes data]
100 7565k    0 7565k    0     0   569k      0 --:--:--  0:00:13 --:--:--  656k^C
```
You can see there that no redirect occurs.  Telly just starts streaming the video data.