#!/bin/sh

export MY_DIR=$(pwd)

docker rm --force telly-test

docker run -d \
  --name='telly-test' \
  -e TZ="America/Chicago" \
  -p '6077:6077/tcp' \
  -v ${MY_DIR}/telly.config.toml:/etc/telly/telly.config.toml \
  --restart unless-stopped \
  tellytv/telly:dev-ffmpeg

docker logs -f telly-test