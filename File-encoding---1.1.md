It seems that telly [or some dependency] doesn't like "UTF-8 with BOM" encoding:

New copy of problem M3U:
```
> cp ~/Downloads/tv-3.m3u tv.m3u
> file tv.m3u
tv.m3u: M3U playlist text, UTF-8 Unicode (with BOM) text, with CRLF line terminators
```
Run telly:
```
>./telly
INFO[2019-01-01T14:47:41-06:00] telly is preparing to go live (version=1.1.0.3, branch=dev, revision=cec8d730177b15a6d1f60d879d2db493f9de51a3)
INFO[2019-01-01T14:47:41-06:00] Loading M3U from tv.m3u
ERRO[2019-01-01T14:47:41-06:00] unable to parse m3u file                      error="malformed M3U provided"
ERRO[2019-01-01T14:47:41-06:00] error when preparing provider                 error="malformed M3U provided"
ERRO[2019-01-01T14:47:41-06:00] error when processing provider                error="malformed M3U provided"
INFO[2019-01-01T14:47:41-06:00] telly is live and on the air!
INFO[2019-01-01T14:47:41-06:00] Broadcasting from http://0.0.0.0:6077/
INFO[2019-01-01T14:47:41-06:00] EPG URL: http://0.0.0.0:6077/epg.xml
^C
```
Strip BOM from text file:
```
> dos2unix tv.m3u
dos2unix: converting file tv.m3u to Unix format...
> file tv.m3u
tv.m3u: M3U playlist text, UTF-8 Unicode text
```
And try telly again:
```
> ./telly
INFO[2019-01-01T14:47:52-06:00] telly is preparing to go live (version=1.1.0.3, branch=dev, revision=cec8d730177b15a6d1f60d879d2db493f9de51a3)
INFO[2019-01-01T14:47:52-06:00] Loading M3U from tv.m3u
INFO[2019-01-01T14:47:52-06:00] Loading XMLTV from http://BLAH.cz/xmltv/ps11.xml
INFO[2019-01-01T14:47:54-06:00] Loaded 46 channels into the lineup from
INFO[2019-01-01T14:47:54-06:00] telly is live and on the air!
INFO[2019-01-01T14:47:54-06:00] Broadcasting from http://0.0.0.0:6077/
INFO[2019-01-01T14:47:54-06:00] EPG URL: http://0.0.0.0:6077/epg.xml
```