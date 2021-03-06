FROM alpine:3.12
MAINTAINER Ta-To

ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"
COPY run.sh /root/run.sh
WORKDIR /srv

# REFS
# https://hub.docker.com/r/thawk/neovim/dockerfile

# python3-dev, py3-pip for deoplete
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    git \
    curl \
    automake \
    cmake \
    make \
    libtool \
    musl-dev\
    zlib-dev \
    unzip \
    openssl \
    autoconf \
    libintl \
    gettext-dev \
    gcc \
    g++ \
    byobu \
    sudo \
    bash \
    ripgrep \
    python3-dev \
    py3-pip
RUN rm -rf /var/cache/apk/*

# nvim.appimage がうまく動作しないためビルドする
# neovim v5が正式リリース後はheadである必要はなくなる(はず
RUN git clone https://github.com/neovim/neovim.git \
  && cd neovim \
  && make CMAKE_BUILD_TYPE=Release \
  && make install \
  && cd ../ \
  && rm -rf neovim

# for deoplete
RUN pip3 install pynvim
