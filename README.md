# docker-telegram
A Docker image that start a fresh telegram client. 

[![Circle CI](https://circleci.com/gh/xorilog/docker-telegram.svg?style=shield)](https://circleci.com/gh/xorilog/docker-telegram)  
[![Image Layers](https://images.microbadger.com/badges/image/xorilog/telegram.svg)](https://microbadger.com/images/xorilog/telegram)   


## Usage
To spawn a new instance of Telegram:

```shell
docker run --rm -it --name telegram \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -e DISPLAY=unix$DISPLAY \
       --device /dev/snd \
       -v /etc/localtime:/etc/localtime:ro \
       -v <Your_storage_dir>/.TelegramDesktop:/root/.local/share/TelegramDesktop/ \
       xorilog/telegram
```
## Issues
* You have to log out Telegram to close the docker container.  


## FAQ
### Docker <1.8
Before Docker 1.8 you need to replace `--device /dev/snd` by `-v /dev/snd:/dev/snd --privileged`.  


### QXcbConnection: Could not connect to display unix:0
```shell
xhost +
```
do not forget to remove it after start or usage (`xhost -`)  
The previous command is to be run on a linux machine. But Mac users, I have a special surprise for you. You can also do fun hacks with X11. Details are described [here](https://github.com/docker/docker/issues/8710).
[This may be more convenient to read](https://gist.github.com/netgusto/931085fc3673b69dd15a1763784307c5)

Thanks to [Telegram](https://telegram.org/) for their great app !
