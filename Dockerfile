FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM alpine:3.10

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

# Dependencies
RUN apk update
RUN apk upgrade
RUN apk add git
RUN apk add musl
RUN apk add pkgconfig
RUN apk add autoconf automake libtool curl make g++ unzip
# RUN apk add clang-3.9
# RUN apk add libc6-dev-i386

#Clone protobuf
RUN git clone https://github.com/protocolbuffers/protobuf.git
WORKDIR /protobuf
RUN git submodule update --init --recursive
#install
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make check
RUN make install
RUN apk update
RUN apk upgrade
RUN ldconfig
RUN ./configure --prefix=/usr
RUN pkg-config --cflags protobuf
WORKDIR /

#cloneprotoc
RUN git clone https://github.com/protobuf-c/protobuf-c.git
WORKDIR /protobuf-c
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

# BPFabric
WORKDIR /home/app
RUN git clone https://github.com/UofG-netlab/BPFabric.git
WORKDIR /home/app/BPFabric
RUN make
