To generate these logs, I started telly and then retrieved a channel from the lineup using `curl`.

You'll note that the volume of activity is reversed because telly's doing more of the work.

Here you can see telly responding to the channel request; it retrieves the provider stream, runs it through ffmpeg, then feeds the transcoded data to Plex.  The error at the end is when I terminated the stream from the client.

### telly side
```
time="2019-03-13T22:00:23Z" level=info msg="telly is preparing to go live (version=1.1.0.5, branch=dev, revision=0d28df61af33f5f0779427d8ad24d62a719e478c)"
time="2019-03-13T22:00:23Z" level=info msg="Loading M3U from http://iptv-area-51.tv:2095/get.php?username=REDACTED&password=REDACTED&type=m3u_plus&output=ts"
time="2019-03-13T22:00:25Z" level=info msg="Loading XMLTV from http://iptv-area-51.tv:2095/xmltv.php?username=REDACTED&password=REDACTED"
time="2019-03-13T22:00:39Z" level=info msg="Loaded 322 channels into the lineup from Area51"
time="2019-03-13T22:00:39Z" level=info msg="telly is live and on the air!"
time="2019-03-13T22:00:39Z" level=info msg="Broadcasting from http://0.0.0.0:6077/"
time="2019-03-13T22:00:39Z" level=info msg="EPG URL: http://0.0.0.0:6077/epg.xml"
time="2019-03-13T22:01:06Z" level=info msg="Serving channel number 10321"
time="2019-03-13T22:01:06Z" level=info msg="Transcoding stream with ffmpeg"
time="2019-03-13T22:01:06Z" level=info msg="ffmpeg version 4.0.3 Copyright (c) 2000-2018 the FFmpeg developers"
time="2019-03-13T22:01:06Z" level=info msg="  built with gcc 6.4.0 (Alpine 6.4.0)"
time="2019-03-13T22:01:06Z" level=info msg="  configuration: --disable-debug --disable-doc --disable-ffplay --enable-shared --enable-avresample --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-gpl --enable-libass --enable-libfreetype --enable-libvidstab --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx265 --enable-libxvid --enable-libx264 --enable-nonfree --enable-openssl --enable-libfdk_aac --enable-libkvazaar --enable-libaom --extra-libs=-lpthread --enable-postproc --enable-small --enable-version3 --extra-cflags=-I/opt/ffmpeg/include --extra-ldflags=-L/opt/ffmpeg/lib --extra-libs=-ldl --prefix=/opt/ffmpeg"
time="2019-03-13T22:01:06Z" level=info msg="  libavutil      56. 14.100 / 56. 14.100"
time="2019-03-13T22:01:06Z" level=info msg="  libavcodec     58. 18.100 / 58. 18.100"
time="2019-03-13T22:01:06Z" level=info msg="  libavformat    58. 12.100 / 58. 12.100"
time="2019-03-13T22:01:06Z" level=info msg="  libavdevice    58.  3.100 / 58.  3.100"
time="2019-03-13T22:01:06Z" level=info msg="  libavfilter     7. 16.100 /  7. 16.100"
time="2019-03-13T22:01:06Z" level=info msg="  libavresample   4.  0.  0 /  4.  0.  0"
time="2019-03-13T22:01:06Z" level=info msg="  libswscale      5.  1.100 /  5.  1.100"
time="2019-03-13T22:01:06Z" level=info msg="  libswresample   3.  1.100 /  3.  1.100"
time="2019-03-13T22:01:06Z" level=info msg="  libpostproc    55.  1.100 / 55.  1.100"
time="2019-03-13T22:01:13Z" level=info msg="Input #0, mpegts, from 'http://iptv-area-51.tv:2095/REDACTED/REDACTED/103':"
time="2019-03-13T22:01:13Z" level=info msg="  Duration: N/A, start: 17920.016933, bitrate: N/A"
time="2019-03-13T22:01:13Z" level=info msg="  Program 1 "
time="2019-03-13T22:01:13Z" level=info msg="    Metadata:"
time="2019-03-13T22:01:13Z" level=info msg="      service_name    : Service01"
time="2019-03-13T22:01:13Z" level=info msg="      service_provider: FFmpeg"
time="2019-03-13T22:01:13Z" level=info msg="    Stream #0:0[0x100]: Video: h264 ([27][0][0][0] / 0x001B), yuv420p(progressive), 1280x720 [SAR 1:1 DAR 16:9], Closed Captions, 59.94 fps, 59.94 tbr, 90k tbn, 119.88 tbc"
time="2019-03-13T22:01:13Z" level=info msg="    Stream #0:1[0x101]: Audio: aac ([15][0][0][0] / 0x000F), 48000 Hz, stereo, fltp, 129 kb/s"
time="2019-03-13T22:01:13Z" level=info msg="Output #0, mpegts, to 'pipe:1':"
time="2019-03-13T22:01:13Z" level=info msg="  Metadata:"
time="2019-03-13T22:01:13Z" level=info msg="    encoder         : Lavf58.12.100"
time="2019-03-13T22:01:13Z" level=info msg="    Stream #0:0: Video: h264 ([27][0][0][0] / 0x001B), yuv420p(progressive), 1280x720 [SAR 1:1 DAR 16:9], q=2-31, 59.94 fps, 59.94 tbr, 90k tbn, 90k tbc"
time="2019-03-13T22:01:13Z" level=info msg="    Stream #0:1: Audio: aac ([15][0][0][0] / 0x000F), 48000 Hz, stereo, fltp, 129 kb/s"
time="2019-03-13T22:01:13Z" level=info msg="Stream mapping:"
time="2019-03-13T22:01:13Z" level=info msg="  Stream #0:0 -> #0:0 (copy)"
time="2019-03-13T22:01:13Z" level=info msg="  Stream #0:1 -> #0:1 (copy)"
time="2019-03-13T22:01:13Z" level=info msg="Press [q] to stop, [?] for help"
time="2019-03-13T22:01:13Z" level=info msg="frame=   32 fps=0.0 q=-1.0 size=     434kB time=00:00:00.50 bitrate=7077.4kbits/s speed=   1x    "
time="2019-03-13T22:01:14Z" level=info msg="frame=   61 fps= 61 q=-1.0 size=     892kB time=00:00:01.00 bitrate=7290.0kbits/s speed=   1x    "
time="2019-03-13T22:01:14Z" level=info msg="frame=   91 fps= 60 q=-1.0 size=    1167kB time=00:00:01.51 bitrate=6314.2kbits/s speed=1.01x    "
time="2019-03-13T22:01:15Z" level=info msg="frame=  122 fps= 61 q=-1.0 size=    1361kB time=00:00:02.00 bitrate=5563.8kbits/s speed=0.998x    "
time="2019-03-13T22:01:15Z" level=info msg="frame=  153 fps= 61 q=-1.0 size=    1585kB time=00:00:02.52 bitrate=5149.7kbits/s speed=   1x    "
time="2019-03-13T22:01:16Z" level=info msg="frame=  183 fps= 61 q=-1.0 size=    1859kB time=00:00:03.02 bitrate=5038.8kbits/s speed=   1x    "
time="2019-03-13T22:01:16Z" level=info msg="frame=  213 fps= 61 q=-1.0 size=    2396kB time=00:00:03.52 bitrate=5572.2kbits/s speed=   1x    "
time="2019-03-13T22:01:17Z" level=info msg="frame=  244 fps= 61 q=-1.0 size=    2803kB time=00:00:04.03 bitrate=5685.4kbits/s speed=   1x    "
time="2019-03-13T22:01:17Z" level=info msg="frame=  274 fps= 60 q=-1.0 size=    3105kB time=00:00:04.53 bitrate=5603.9kbits/s speed=   1x    "
time="2019-03-13T22:01:18Z" level=info msg="frame=  304 fps= 60 q=-1.0 size=    3424kB time=00:00:05.04 bitrate=5565.1kbits/s speed=   1x    "
time="2019-03-13T22:01:18Z" level=info msg="frame=  334 fps= 60 q=-1.0 size=    3675kB time=00:00:05.54 bitrate=5434.0kbits/s speed=   1x    "
time="2019-03-13T22:01:19Z" level=info msg="frame=  364 fps= 60 q=-1.0 size=    3911kB time=00:00:06.04 bitrate=5303.8kbits/s speed=   1x    "
time="2019-03-13T22:01:19Z" level=info msg="frame=  395 fps= 60 q=-1.0 size=    4168kB time=00:00:06.55 bitrate=5206.3kbits/s speed=   1x    "
time="2019-03-13T22:01:20Z" level=error msg="Error when copying data" error="write tcp 172.17.0.2:6077->172.17.0.1:57394: write: broken pipe"
time="2019-03-13T22:01:20Z" level=info msg="Stopped streaming 10321"
```

### client side

Some identifying data has been redacted here.

Here we request the channel.  There's no redirect, telly just starts streaming the video data.
```
ChazTD-MBP~(:|✔) % curl -Lv -o output.dat http://192.168.43.244:6077/auto/v10321
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
  0     0    0     0    0     0      0      0 --:--:--  0:00:06 --:--:--     0< HTTP/1.1 200 OK
< Date: Wed, 13 Mar 2019 22:01:13 GMT
< Content-Type: application/octet-stream
< Transfer-Encoding: chunked
<
{ [16260 bytes data]
100 4263k    0 4263k    0     0   319k      0 --:--:--  0:00:13 --:--:--  603k^C
```