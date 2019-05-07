Plex has a limit of 420 channels on a tuner, above which it starts to behave badly.  If you start telly with a channel list that exceeds 420 channels, telly will quit rather than take the chance of bad behavior.

Of course, most IPTV accounts come with far more than 420 channels, which means you need to prune your channel list somehow for telly 1.0 and 1.1.

Telly 1.5 avoids this by requiring you to add channels to a lineup rather than filtering them out.  It reads your video providers' list of channels and then you add them one by one to a lineup.

There are a variety of ways to do this, some free, some paid.  Inclusion here should not be interpreted as an endorsement.

### websites

There are at least several websites that allow one to upload [or retrieve] an m3u from an iptv provider and edit it.  Two that have been used by members of the telly community are:

[EPG for IPTV](http://iptv-epg.com)

[X•tream Editor](http://xtream-editor.com)

Both of these provide EPG data as well, and both cost money.  They each have different subscription levels, but about $20/year is in the ballpark.

Both of these provide an URL to retrieve the edited m3u, or you can retrieve and save the file.

### standalone editing programs

A web search turns up many programs that allow one to edit m3u playlists; it seems most are for Windows.

### hand-editing

An m3u file just a text file, and can be edited in any text editor.

### telly filtering

Of course, telly 1.0 and 1.1 provide [[filtering|Running Telly: Filtering]].

### bouquet editing at provider

Some providers allow one to edit the list of channels [usually it's by group] that are included in one's M3U file.

Vader [via website], Area51 [via APK], and Iris [via website for some users] are some that allow this.

### custom scripting or software

There are lots of [m3u editing projects](https://github.com/search?utf8=✓&q=m3u+editor&ref=simplesearch) on github.

One that's been used a lot in the telly community is [m3u-epg-editor](https://github.com/jjssoftware/m3u-epg-editor).

[haxcop](https://github.com/haxcop/AutomatedHMS) and [chazlarson](https://github.com/chazlarson/autotelly) have published wrapper scripts for m3u-epg-editor.
