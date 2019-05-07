Telly 1.1 will read in the EPG from your provider, then filter it to match your channel list.

When you add the DVR and Telly EPG to plex, all channels with EPG will automatically match and life is easy.

Sometimes, however, this matching doesn't seem to work the way one would expect.

### How does telly match Channel and EPG?

Here's an example from Iris:

The channel entry from the m3u file [some linefeeds have been added to improve readability]:
```
#EXTINF:-1 tvg-id="hbo.us" 
  tvg-name="USA: HBO HD" 
  tvg-logo="https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/HBO_logo.svg/330px-HBO_logo.svg.png" 
  group-title="VIP USA ENTERTAINMENT",USA: HBO HD
http://irislinks.net:83/11111111/22222222/308876
```
The EPG XML file contains two sections: "channel" and "programme".  For a given channel there will be one "channel" and many "programme" entries.  Again, a sample from Iris:

The channel entry:
```
<channel id="hbo.us">
  <display-name>HBO</display-name>
  <icon src="http://picon.helixhosting.ninja/1672.png" />
</channel>
```
And a few programmes:
```
<programme start="20181231203500 +0000" stop="20181231223500 +0000" channel="hbo.us" >
  <title>Justice League (2017)</title>
  <desc>In the wake ...</desc>
</programme>
<programme start="20181231223500 +0000" stop="20190101010000 +0000" channel="hbo.us" >
  <title>Kingsman: The Golden Circle (2017)</title>
  <desc>Kingsman is faced ...</desc>
</programme>
<programme start="20190101010000 +0000" stop="20190101025000 +0000" channel="hbo.us" >
  <title>Rampage (2018)</title>
  <desc>Scientist David Okoye ...</desc>
</programme>
```
You can see that the common thread here is the `tvg-id`: "hbo.us".  It ties programmes to channels in the EPG, then EPG channels to stream channels from EPG to M3U.  

M3U `tvg-id="hbo.us"` matches EPG `channel="hbo.us"`.

### Why is my EPG empty?

Recently we worked with a user who had channels in the lineup, but the Telly EPG was empty even though the EPG file contained data for that channel.  Here's why:

M3U Channel:
```
#EXTINF:-1 tvg-name="ESPNNews" 
  tvg-logo="http://guide.smoothstreams.tv/assets/images/channels/1.png" 
  tvg-id="1.smoothstreams.tv" 
  channel-id="1",ESPNNews
rtmp://deu.smoothstreams.tv:3625/view247?wmsAuthSign=LONG_TOKEN.stream
```

Note the tvg-id: `tvg-id="1.smoothstreams.tv"`

EPG XML:

Channel:
```
<channel id="I207.59976.zap2it.com">
  <display-name lang="en">ESPNNews</display-name>
  <icon src="http://speed.guide.smoothstreams.tv/assets/images/channels/1.png"/>
</channel>
```

Programmes:
```
<programme channel="I207.59976.zap2it.com" start="20190216000000 +0000" stop="20190216020000 +0000">
  <title lang="us">NCAAB: Harvard at Princeton</title>
  <sub-title lang="us"/>
  <desc lang="us"/>
  <category lang="us">Sports</category>
  <episode-num system="dd_progid">305458</episode-num>
</programme>
<programme channel="I207.59976.zap2it.com" start="20190215110000 +0000" stop="20190215150000 +0000">
  <title lang="us">Golic and Wingo</title>
  <sub-title lang="us"/>
  <desc lang="us">Mike Golic and Trey Wingo discuss ...  </desc>
  <category lang="us">Sports</category>
  <episode-num system="dd_progid">305679</episode-num>
</programme>
<programme channel="I207.59976.zap2it.com" start="20190216193000 +0000" stop="20190216213000 +0000">
  <title lang="us">Pro 14: Cardiff Blues v Glasgow Warriors</title>
  <sub-title lang="us"/>
  <desc lang="us"/>
  <category lang="us">Sports</category>
  <episode-num system="dd_progid">305293</episode-num>
</programme>
```
In the EPG XML, that same channel is IDed as `id="I207.59976.zap2it.com"`.

There is a link between "channel" and "programme" within the EPG, but there is nothing to tie the M3U channel to the EPG channel.  

M3U `tvg-id="1.smoothstreams.tv"` DOES NOT MATCH EPG `id="I207.59976.zap2it.com"`.

This isn't something telly can reasonably do anything about. If you find yourself in this situation, you will likely have to use the provider EPG directly in Plex and manually match channels.

Telly 1.5 addresses this by allowing you to manually select which EPG channel goes with which video stream.