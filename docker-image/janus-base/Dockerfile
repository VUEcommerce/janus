# adapted from https://github.com/atyenoria/janus-webrtc-gateway-docker

FROM buildpack-deps:stretch

RUN sed -i 's/archive.ubuntu.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/*

# janus dependencies for REST support for janus API, websocket for janus api, cmake for websocket, libcurl for TURN REST
RUN apt-get -y update && apt-get install -y \
    apt-utils \
    libjansson-dev \
    libconfig-dev \
    libnice-dev \
    libssl-dev \
    openssh-server \
    libsofia-sip-ua-dev \
    libglib2.0-dev \
    libopus-dev \
    libmicrohttpd-dev \
    libcurl4-openssl-dev \
    pkg-config \
    gengetopt \
    automake \
    wget \
    git \
    cmake \
    sudo \
    build-essential \
    libtool 

# bingcheng: libsrtp >= 1.5.0
RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz && \
    tar xfv v2.2.0.tar.gz &&  cd libsrtp-2.2.0 &&  \
    ./configure --prefix=/usr --enable-openssl && \
    make shared_library && sudo make install

# bingcheng: libsocket installation
# See https://github.com/meetecho/janus-gateway/issues/732 re: LWS_MAX_SMP
RUN git clone https://libwebsockets.org/repo/libwebsockets && \
    cd libwebsockets && \
    git checkout v2.4-stable && \
    mkdir build && cd build && \
    cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. && \
    make && sudo make install

# 8 March, 2019 1 commit 67807a17ce983a860804d7732aaf7d2fb56150ba
RUN apt-get remove -y libnice-dev libnice10 && \
    echo "deb http://deb.debian.org/debian  stretch-backports main" >> /etc/apt/sources.list && \
    apt-get  update && \
    apt-get install -y gtk-doc-tools libgnutls28-dev -t stretch-backports  && \
    git clone https://gitlab.freedesktop.org/libnice/libnice.git && \
    cd libnice && \
    git checkout 67807a17ce983a860804d7732aaf7d2fb56150ba && \
    bash autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install