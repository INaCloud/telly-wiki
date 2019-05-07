Problem: telly seems to be running without errors, but when added to plex shows no channels.

There are two common causes for this problem.

1. telly couldn't find its config file.

   The telltale sign of this is that the telly output doesn't mention anything about reading an M3U or EPG XML.

   A typical *successful* startup looks like this:
   ```
   INFO[2019-01-03T15:55:45-06:00] telly is preparing to go live (version=1.1.0.5, branch=dev, revision=567f9062e94f32fd46bd6b82f10c1ac2e7f711c5)
   time="2019-01-03T22:09:31Z" level=info msg="Loading M3U from http://irislinks.net:83/get.php?username=REDACTED&password=REDACTED&type=m3u_plus&output=ts"
   time="2019-01-03T22:09:33Z" level=info msg="Loading XMLTV from http://irislinks.net:83/xmltv.php?username=REDACTED&password=REDACTED"
   time="2019-01-03T22:09:47Z" level=info msg="Loaded 302 channels into the lineup from Iris"
   time="2019-01-03T22:09:48Z" level=info msg="telly is live and on the air!"
   time="2019-01-03T22:09:48Z" level=info msg="Broadcasting from http://0.0.0.0:6077/"
   time="2019-01-03T22:09:48Z" level=info msg="EPG URL: http://0.0.0.0:6077/epg.xml"
   ```

   While a "No config file found" startup looks like this:
   ```
   INFO[2019-01-03T15:55:45-06:00] telly is preparing to go live (version=1.1.0.5, branch=dev, revision=567f9062e94f32fd46bd6b82f10c1ac2e7f711c5)
   INFO[2019-01-03T15:55:45-06:00] telly is live and on the air!
   INFO[2019-01-03T15:55:45-06:00] Broadcasting from http://localhost:6077/
   INFO[2019-01-03T15:55:45-06:00] EPG URL: http://localhost:6077/epg.xml
   ```

   Note the lack of anything between "Preparing to go live" and "telly is live".  That's a telltale that the config file was not read.

   The most common cause of this problem is: The config file is next to the telly executable AND that directory is NOT the CWD when telly is launched.

   See the [config file page](https://github.com/tellytv/telly/wiki/Running-Telly%3A-Config-File) for details about where telly looks for the config file.  You can eliminate this problem by storing the config file in one of the stock locations OR by always cd-ing to the telly directory before you run it.

2. The filters aren't letting anything through.

   That will look like this:

   ```
   INFO[2019-01-03T15:55:45-06:00] telly is preparing to go live (version=1.1.0.5, branch=dev, revision=567f9062e94f32fd46bd6b82f10c1ac2e7f711c5)
   time="2019-01-03T22:17:07Z" level=info msg="Loading M3U from http://irislinks.net:83/get.php?username=REDACTED&password=REDACTED&type=m3u_plus&output=ts"
   time="2019-01-03T22:17:09Z" level=info msg="Loading XMLTV from http://irislinks.net:83/xmltv.php?username=REDACTED&password=REDACTED"
   time="2019-01-03T22:17:23Z" level=info msg="Loaded 0 channels into the lineup from Iris"
   time="2019-01-03T22:17:23Z" level=info msg="telly is live and on the air!"
   time="2019-01-03T22:17:23Z" level=info msg="Broadcasting from http://0.0.0.0:6077/"
   time="2019-01-03T22:17:23Z" level=info msg="EPG URL: http://0.0.0.0:6077/epg.xml"
   ```

   Note: no errors reported with the M3U or MXL, and then "Loaded 0 channels". That means either the m3u contains no channels [unlikely] or the filter filtered them all out [most likely].

   If you turn on debug logging, the log will contain a list of channels reporting which ones did not match the filter.

   See the [filtering article](https://github.com/tellytv/telly/wiki/Running-Telly%3A-Filtering) for details on creating a filter and a link to some test scripts that can help with the process.