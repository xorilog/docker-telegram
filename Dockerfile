# Gathering of binary
FROM debian:stretch-slim as downloader

ARG telegram_version=""
ARG http_proxy=""
ARG https_proxy=""
ARG apt_sources="http://deb.debian.org"

RUN sed -i "s@http://deb.debian.org@$apt_sources@g" /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    apt-utils \
    software-properties-common \
    wget \
    xz-utils \
    curl \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Telegram Version 4.6.5
RUN env \
      http_proxy=$http_proxy \
      https_proxy=$https_proxy \
      wget https://updates.tdesktop.com/tlinux/tsetup."${telegram_version:-$(curl \
        -sXGET \
        --head https://telegram.org/dl/desktop/linux \
        | grep location \
        | cut -d '/' -f 5 \
        |cut -d '.' -f 2-4 \
      )}".tar.xz \
      -O /tmp/telegram.tar.xz \
    && cd /tmp/ \
    && tar xvfJ /tmp/telegram.tar.xz \
    && mv /tmp/Telegram/Telegram /usr/bin/Telegram \
    && rm -rf /tmp/{telegram.tar.xz,Telegram}

# Base docker image
FROM debian:stretch
LABEL maintainer "Christophe Boucharlat <christophe.boucharlat@gmail.com>"
LABEL org.opencontainers.image.source https://github.com/xorilog/docker-telegram

# Make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& usermod -a -G audio,video user

ARG http_proxy=""
ARG https_proxy=""
ARG apt_sources="http://deb.debian.org"

# Install required deps
RUN sed -i "s@http://deb.debian.org@$apt_sources@g" /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    libpulse0 \
    gconf2 \
    libdrm2 \
    libgtk-3-0 \
    libice6 \
    libsm6 \
    libegl1-mesa-dev \
    libgl1-mesa-glx \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=downloader --chown=user /usr/bin/Telegram /home/user/Telegram

WORKDIR $HOME
USER user

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun Telegram
CMD ["/home/user/Telegram"]
