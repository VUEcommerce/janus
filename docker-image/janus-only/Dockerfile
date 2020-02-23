# adapted from https://github.com/atyenoria/janus-webrtc-gateway-docker

### WARNING ###
### Edit below and choose a base image to build from
FROM janus:base

# tag v0.8.1 https://github.com/meetecho/janus-gateway/commit/1e6ac78842ba76613ea0991dda7b1e28078507be
RUN cd / && git clone https://github.com/meetecho/janus-gateway.git && cd /janus-gateway && \
    sh autogen.sh &&  \
    git checkout origin/master && git reset --hard 1e6ac78842ba76613ea0991dda7b1e28078507be && ./configure \ 
    --disable-rabbitmq \
    --disable-mqtt \
    --disable-unix-sockets \
    --disable-data-channel \
    --enable-plugin-echotest \
    --enable-plugin-recordplay \
    --enable-plugin-sip \
    --enable-plugin-videocall \
    --enable-plugin-audiobridge \
    --enable-plugin-nosip \
    --enable-all-handlers && \
    make && make install && make configs && ldconfig

CMD janus

# RUN apt-get -y install iperf iperf3
# RUN git clone https://github.com/HewlettPackard/netperf.git && \
#     cd netperf && \
#     bash autogen.sh && \
#     ./configure && \
#     make && \
#     make install
