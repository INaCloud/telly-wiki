# Docker tags

Just as there are several versions of telly in use during this tumultuous time, there are several different tags at Telly's docker hub page:
https://hub.docker.com/r/tellytv/telly/tags/

As of this writing on October 4, 2018, there are 6.  No doubt this will settle down sometime soon.

Of those six, there are four that are interesting.  The other two are older build artifacts.

## tellytv/telly:latest

This image is built from the master branch; this is currently 1.0.3

### `docker run`
```
docker run -d \
  --name='telly' \
  --net='bridge' \
  -e TZ="Europe/Amsterdam" \
  -e 'TELLY_IPTV_PLAYLIST'='/home/github/myiptv.m3u' \
  -e TELLY_IPTV_STREAMS=1 \
  -e TELLY_FILTER_REGEX='.*UK.*' \
  -p '6077:6077/tcp' \
  -v '/tmp/telly':'/tmp':'rw' \
  tellytv/telly --web.base-address=localhost:6077
```

### docker-compose
```
telly:
  image: tellytv/telly
  ports:
    - "6077:6077"
  environment:
    - TZ=Europe/Amsterdam
    - TELLY_IPTV_PLAYLIST=/home/github/myiptv.m3u
    - TELLY_FILTER_REGEX='.*UK.*'
    - TELLY_WEB_LISTEN_ADDRESS=telly:6077
    - TELLY_IPTV_STREAMS=1
    - TELLY_DISCOVERY_FRIENDLYNAME=Tuner1
    - TELLY_DISCOVERY_DEVICEID=12345678
  command: -base=telly:6077
  restart: unless-stopped
```


## tellytv/telly:dev
The standard docker image for the dev branch; currently 1.1.0.3 [1.1-Beta4]

## tellytv/telly:dev-ffmpeg
This docker image has ffmpeg preinstalled.  If you want to use the ffmpeg feature, use this image.  It may be safest to use this image generally, since it is not much larger than the standard image and allows you to turn the ffmpeg features on and off without requiring changes to your docker run command.

### `docker run`
```
docker run -d \
  --name='telly' \
  --net='bridge' \
  -e TZ="America/Chicago" \
  -p '6077:6077/tcp' \
  -v /host/path/to/telly.config.toml:/etc/telly/telly.config.toml \
  --restart unless-stopped \
  tellytv/telly:dev-ffmpeg
```

### docker-compose
```
telly:
  image: tellytv/telly:dev-ffmpeg
  ports:
    - "6077:6077"
  environment:
    - TZ=Europe/Amsterdam
  volumes:
    - /host/path/to/telly.config.toml:/etc/telly/telly.config.toml
  restart: unless-stopped
```

## tellytv/telly:v1.5.0

This tag is the unsupported alpha build of telly-TNG; the version with the web UI config.

This version is unsupported.  If you are unwilling to accept a significant chance of breakage, you should not be running this tag.  For that reason, there are no examples here.