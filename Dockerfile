# Base docker image
FROM debian:jessie
MAINTAINER Christophe Boucharlat <christophe.boucharlat@gmail.com>

# Telegram Version 0.8.4

RUN apt-get update && apt-get install -y \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    gconf2 \
    wget \
    --no-install-recommends 

RUN wget https://tdesktop.com/linux -O /tmp/telegram-latest.tar.xz && \
    cd /tmp/ && \
    tar xvfJ /tmp/telegram-latest.tar.xz && \
    mv /tmp/Telegram/Telegram /usr/bin/Telegram && \
    rm -rf /tmp/{telegram-latest.tar.xz,Telegram}

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun x11vnc
CMD ["/usr/bin/Telegram"]
