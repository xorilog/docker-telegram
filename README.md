# docker-telegram
Dockerfile for a Telegram gui client
A Docker image that start a fresh telegram client.

## Usage
To spawn a new instance of Telegram:

```
docker run -it --name telegram -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v /dev/snd:/dev/snd --privileged xorilog/telegram
```
## Issues
* You have to log out Telegram to close the docker container.

## FAQ
### QXcbConnection: Could not connect to display unix:0
```shell
xhost +
```
do not forget to remove it after start or usage (`xhost -`)  


Thanks to [Telegram](https://telegram.org/) for their great app !
