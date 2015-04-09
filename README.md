# docker-telegram
Dockerfile for a Telegram gui client
A Docker image that start a fresh telegram client.

## Usage
To spawn a new instance of Telegram:

```
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v /dev/snd:/dev/snd --privileged xorilog/telegram
```
## Issues
* You have to log out Telegram to close the docker container.

Thanks to [Telegram](https://telegram.org/) for their great app !
