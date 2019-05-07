Once `telly` is running, you can add it to Plex. **Plex Live TV/DVR requires Plex Pass at the time of writing**

Overview:
1. [Add the virtual tuner to Plex](https://github.com/tellytv/telly/wiki/Adding-Telly-to-Plex/#add-the-virtual-tuner-to-plex).

2. [Configure EPG (Electronic Program Guide)](https://github.com/tellytv/telly/wiki/Adding-Telly-to-Plex/#configure-epg); your choices are:

   2a. [XMLTV guide](https://github.com/tellytv/telly/wiki/Adding-Telly-to-Plex/#xmltv-epg)

   2b. [Plex' built-in guide](https://github.com/tellytv/telly/wiki/Adding-Telly-to-Plex/#plex-built-in-epg)

You will find details on both EPG sources below.

# Add the virtual tuner to Plex

Navigate to `app.plex.tv` and make sure you're logged in. Go to Settings -> Server -> Live TV & DVR

[[/images/plex/plex-00-add-dvr.png|add dvr]]


Click 'SET UP PLEX DVR'. The virtual tuner should show up automatically.  If it doesn't, click "Don't see your HDHomeRun device..." to add it manually - enter `TELLY_IP:TELLY_PORT`

>NOTE: the image below shows port 6079.  The default is 6077.  You should enter whatever you have telly configured to use.

[[/images/plex/plex-01-dvr-address.png|dvr address]]

Plex will find your device (in some cases it continues to load but the "CONTINUE" button becomes orange, i.e. clickable. Click it).

Note: when you enter the address manually, the DVR will likely NOT show up.  You will notice that the "Continue" button will become clickable, however.  Don't worry about the missing tuner image if the button is clickable.

Select the country in the bottom left and ensure Plex has found the channels. Depending on the version of `telly` and how you have it configured, the channels may start at 10000. Click "CONTINUE".

[[/images/plex/plex-02-dvr-setup-01.png|dvr channels]]

# Configure EPG

For EPG, you have two options.  Plex' built-in EPG and XMLTV EPG.  Most likely you will want to use XMLTV.

NOTE: Plex only allows a single source of EPG for all your tuners.  The most common place this shows up is users who have a physical HDHomerun with an antenna and an IPTV account they're using with telly.  Complain to Plex about that.  The absolute easiest way to get around this is to stand up two plex servers, one for the HDHomerun, one for telly.  Lacking that, you'll need to get the additional channels into your telly EPG somehow, or add a few extra channels to telly's list to use for mapping purposes.  The guide will be wrong, but you'll be able to tune the channels.

## XMLTV EPG

You may have an XMLTV EPG source.  This source could be:
* telly itself [version 1.1 and up publish EPG]
* a website like iptv-epg.com
* your iptv provider
* something else entirely

If you're using XMLTV EPG, its is *STRONGLY RECOMMENDED* that you use telly's own EPG [which of course implies that telly 1.1 is also *STRONGLY RECOMMENDED*].  If you do so, the EPG will contain only those channels that are in your lineup, and in all likelihood all the channels will automatically match.  Channels that don't automatically match have no EPG and won't work with Plex anyway.  Plex *requires* EPG to show a channel in the grid.

If you use any other XML EPG, you'll *most likely* have to match all the channels manually as described n the next section.

In the initial EPG setup, click that orange text "Have an XMLTV guide..."

[[/images/plex/plex-03-dvr-setup-ZIP-01.png|EPG start]]


Enter the source for your EPG.  This can be an URL or a file path.  Click "CONTINUE":

[[/images/plex/plex-04-dvr-setup-XML-01.png|entered URL]]


Plex will load the channels...

[[/images/plex/plex-04-dvr-setup-XML-02.png|Loading]]


...and then present you with a list.  You may have to do the same matching here as described above.  In this case, I'm using telly-supplied EPG, so the channels automatically match.  Click "CONTINUE":

[[/images/plex/plex-04-dvr-setup-XML-03.png|channels]]

## Plex' built-in EPG

If you want to use Plex' built-in EPG, all your channels have to be in the same geo area, because you will have to choose a Post/ZIP code and a TV provider.

To be clear, if you are in the US and your channel list contains channels from, say, the UK and the US, you CANNOT use Plex' built-in EPG, as there is no US TV provider that carries Channel 4, BBC One, Sky Sports or the like.

Enter your Post/ZIP code and click "CONTINUE":

[[/images/plex/plex-03-dvr-setup-ZIP-02.png|Entering ZIP]]


Telly will search for TV providers in your area:

[[/images/plex/plex-03-dvr-setup-ZIP-03.png|Waiting]]


Choose a provider that matches your channel list most closely and click "CONTINUE":

[[/images/plex/plex-03-dvr-setup-ZIP-04.png|TV provider]]


Plex shows your channels and its best guess as to the corresponding EPG channel.  You'll note that in this case all three are totally wrong.  Channels Plex couldn't even come up with a guess for are unchecked by default.

[[/images/plex/plex-03-dvr-setup-ZIP-05.png|Matching 01]]


You'll need to choose the correct EPG channel for any that matched incorrectly or not at all.

[[/images/plex/plex-03-dvr-setup-ZIP-06.png|choosing]]


This is probably going to be a long irksome process.

Be diligent and take it slow.  If you assign the same EPG to two channels, Plex will throw an error to that effect when you try to continue but it will not identify the duplicate.  In a list of 300 channels, that's a drag.

This situation can be helped by setting channel numbers in your M3U to match an existing TV provider like DirectTV Minneapolis or whatever.  In that case, the channels will automatch.

Once all the channels are matched correctly, click "CONTINUE":

[[/images/plex/plex-03-dvr-setup-ZIP-07.png|Matching done]]

## Guide

With either EPG source, Plex will now load the guide data.  Click "VIEW GUIDE":

[[/images/plex/plex-04-dvr-setup-XML-04.png|Loading guide]]


You can view the guide on the main dashboard screen right away.  It will fill in over time.

Depending on the source for EPG, you will see "Powered by XMLTV":

[[/images/plex/plex-04-dvr-setup-XML-05.png|Powered by XMLTV]]


or "Powered by Gracenote®"

[[/images/plex/plex-03-dvr-setup-ZIP-08.png|Powered by Gracenote®]]


Once that is done, you might need to restart Plex so the telly tuner is not marked as dead.  _**Generally, when you make any changes to your telly configuration, it is safest to restart Plex.**_

You're done! Enjoy using `telly`. :-)

## EPG tidbits

Some things we've found that may be of use:

* Plex requires particular information in the EPG to discern between movies and TV shows.  Some EPG does not provide those details, and Plex shows everything as a movie.  This is an issue between Plex and the EPG; telly is limited in its ability to address this.  Research is ongoing on ways to address this is future versions of telly; the solution will probably require a paid subscription to Schedules Direct, a source of EPG data.
* Vader seem to have habit of including incorrect data in their EPG, notably in the date field where they put in things like "1999|2001" or random bits of text.  Fixes have been put in for some of these, but new cases may still come up.  This is Vader's problem, and telly can try to mask it, but as Vader finds new ways to break EPG, telly will need to adapt.  We can't predict capricious breakage.