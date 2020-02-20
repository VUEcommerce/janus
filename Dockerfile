# adapted from https://github.com/atyenoria/janus-webrtc-gateway-docker

FROM buildpack-deps:stretch

RUN sed -i 's/archive.ubuntu.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/*

# janus dependencies for REST support for janus API, websocket for janus api, cmake for websocket, libcurl for TURN REST
RUN apt-get -y update && apt-get install -y libmicrohttpd-dev \
    libjansson-dev \
    libconfig-dev \
    libnice-dev \
    libssl-dev \
    openssh-server \
    libsrtp-dev \
    libmicrohttpd-dev \
    libwebsockets-dev \
    libcurl3 \
    wget \
    git \
    cmake \
    sudo \
    build-essential \
    libtool 


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

#coturn
RUN COTURN="4.5.0.8" && wget https://github.com/coturn/coturn/archive/$COTURN.tar.gz && \
    tar xzvf $COTURN.tar.gz && \
    cd coturn-$COTURN && \
    ./configure && \
    make && make install


# tag v0.8.1 https://github.com/meetecho/janus-gateway/commit/1e6ac78842ba76613ea0991dda7b1e28078507be
RUN cd / && git clone https://github.com/meetecho/janus-gateway.git && cd /janus-gateway && \
    sh autogen.sh &&  \
    git checkout origin/master && git reset --hard 1e6ac78842ba76613ea0991dda7b1e28078507be && \ 
    --disable-rabbitmq \
    --disable-mqtt \
    --disable-unix-sockets \
    --enable-dtls-settimeout \
    --enable-plugin-echotest \
    --enable-plugin-recordplay \
    --enable-plugin-sip \
    --enable-plugin-videocall \
    --enable-plugin-audiobridge \
    --enable-plugin-nosip \
    --enable-all-handlers && \
    make && make install && make configs && ldconfig

CMD nginx

# RUN apt-get -y install iperf iperf3
# RUN git clone https://github.com/HewlettPackard/netperf.git && \
#     cd netperf && \
#     bash autogen.sh && \
#     ./configure && \
#     make && \
#     make install
