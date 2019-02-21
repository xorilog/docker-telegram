# Gathering of binary
FROM debian:jessie-slim as downloader

RUN apt-get update && apt-get install -y \
    apt-utils \
    software-properties-common \
    wget \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Telegram Version 1.9.8
RUN wget https://updates.tdesktop.com/tlinux/tsetup.1.9.8.tar.xz -O /tmp/telegram.tar.xz \
    && cd /tmp/ \
    && tar xvfJ /tmp/telegram.tar.xz \
    && mv /tmp/Telegram/Telegram /usr/bin/Telegram \
    && rm -rf /tmp/{telegram.tar.xz,Telegram}

# Base docker image
FROM debian:stretch
LABEL maintainer "Christophe Boucharlat <christophe.boucharlat@gmail.com>"

# Make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& usermod -a -G audio,video user

# Install required deps
RUN apt-get update && apt-get install -y \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    libasound2 \
    gconf2 \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Telegram Version 1.9.8
COPY --from=downloader /usr/bin/Telegram /usr/bin/Telegram

WORKDIR $HOME
USER user

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun Telegram
CMD ["/usr/bin/Telegram"]
