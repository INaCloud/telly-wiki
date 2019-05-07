If Plex reports an error about "unable to tune channels", it's often one of a small number of problems.

When Plex tunes a channel, what happens in the usual case [FFMpeg buffering *NOT* enabled] is that Plex loads the telly URL for the channel [something like `http://192.168.1.10:6077/auto/v10000`], then telly redirects Plex to the provider's stream URL [`http://vapi.vaders.tv/play/40663.ts?token=BLAHBLAHBLAH`].  After this, telly is no longer involved.  Plex attempts to retrieve the video data and play it.  Failures to tune usually mean one of two things:

1. Plex can't load the provider URL.

Perhaps the provider is blocking connections from that machine, or your credentials are incorrect, or your account is expired, or there's an outage [provider or stream], or the provider no longer offers the stream.

Check the [[FAQ]] for a way to check if this is the case.

2. The stream is in a format not compatible with Plex.

Plex is able to play `.ts` streams.  Most likely, any other stream type [a common one is `.m3u8`] will fail.  Typically, you can force `.ts` streams by adding `&format=ts` or `&output=ts` to your M3U URL. [i.e. `http://iptv-area-51.tv:2095/get.php?username=FOO&password=BAR&type=m3u_plus&output=ts`, `http://api.vaders.tv/vget?username=FOO&password=BAR&format=ts"
`]

Another way to work around the second case is to enable FFMpeg in your setup [1.1 and above].  When FFMpeg is enabled, telly retrieves the stream and then converts it on the fly to a format which Plex accepts.  This eliminates the redirects and ensures that Plex gets a stream that it can play.

### But it works with VLC!

Some things that can cause telly to fail while VLC works.
* Different networks: Often, VLC is being run on your home network and Plex/telly are in a remote datacenter.  It's unlikely that the provider is blocking connections from some home network, but many providers block connections from various data centers
* Special characters in the URL: We saw a case where a user had a `%` in their password.  VLC on Windows encoded that so the URL worked, but VLC on Mac OS X and telly on the remote machine didn't, which resulted in an incomplete URL being loaded, which resulted in the "Unauthorized" message from the provider.
