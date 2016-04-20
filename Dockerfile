# Base docker image
FROM ubuntu
MAINTAINER Christophe Boucharlat <christophe.boucharlat@gmail.com>

# Telegram Version 0.9.44

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
    --no-install-recommends 

RUN wget https://tdesktop.com/linux/tsetup.0.9.44.tar.xz -O /tmp/telegram.tar.xz && \
    cd /tmp/ && \
    tar xvfJ /tmp/telegram.tar.xz && \
    mv /tmp/Telegram/Telegram /usr/bin/Telegram && \
    rm -rf /tmp/{telegram.tar.xz,Telegram}

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y gcc-4.9 g++-4.9 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4


ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun x11vnc
CMD ["/usr/bin/Telegram"]
