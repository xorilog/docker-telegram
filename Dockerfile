# Base docker image
FROM debian:jessie
MAINTAINER Christophe Boucharlat <christophe.boucharlat@gmail.com>

# Telegram Version 0.9.56

RUN apt-get update && apt-get install -y \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    gconf2 \
    wget \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN wget https://tdesktop.com/linux/tsetup.0.9.56.tar.xz -O /tmp/telegram.tar.xz && \
    cd /tmp/ && \
    tar xvfJ /tmp/telegram.tar.xz && \
    mv /tmp/Telegram/Telegram /usr/bin/Telegram && \
    rm -rf /tmp/{telegram.tar.xz,Telegram} && \
    rm /etc/fonts/conf.d/10-scale-bitmap-fonts.conf && \
    fc-cache -fv

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun Telegram
CMD ["/usr/bin/Telegram"]
