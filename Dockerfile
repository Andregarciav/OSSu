FROM openfaas/classic-watchdog:0.18.1 as watchdog

#procurar uma imagem melhor
FROM ubuntu:16.04
#alpine não tem apt-get
#FROM alpine:3.10

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog

# Dependencies
#RUN apk update
#RUN apk upgrade
# RUN apk search autoreconf
#RUN apk add autoconf2.13-2.13-r0
#RUN apk add git
#RUN apk add autoconf automake libtool curl make g++ unzip
# RUN apt add pkg-config

# # Dependencies
 RUN apt-get update
 RUN apt-get upgrade -y
 RUN apt-get install dh-autoreconf -y
 RUN apt-get install git -y
 RUN apt-get install autoconf automake libtool curl make g++ unzip -y
 RUN apt install pkg-config

# Clone protobuf
RUN git clone https://github.com/protocolbuffers/protobuf.git

WORKDIR /protobuf

RUN git submodule update --init --recursive

# install and configure protobuf
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make check
RUN make install
RUN ldconfig
RUN ./configure --prefix=/usr
RUN pkg-config --cflags protobuf

WORKDIR /

# Clone protoc
RUN git clone https://github.com/protobuf-c/protobuf-c.git
WORKDIR /protobuf-c

# Install and configure protoc
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN apt-get install clang-3.9 -y
RUN apt-get install libc6-dev-i386 -y

WORKDIR /home/app


RUN git clone https://github.com/UofG-netlab/BPFabric.git


WORKDIR /

# RUN cp -r /usr/include/x86_64-linux-gnu/asm /usr/include/
# RUN cp -r /usr/include/x86_64-linux-gnu/sys /usr/include/
# RUN cp -r /usr/include/x86_64-linux-gnu/bits /usr/include/
# RUN cp -r /usr/include/x86_64-linux-gnu/gnu /usr/include/
# RUN ln -s asm-generic asm
#RUN ln -s /usr/include/x86_64-linux-gnu/ /usr/include/


WORKDIR /home/app/BPFabric
RUN make
