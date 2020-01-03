FROM openfaas/classic-watchdog:0.18.1 as watchdog

# FROM ubuntu:latest
FROM alpine:3.10

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog


# RUN apt update
# RUN apt install -y \
#           clang \
#           python3-pip \
#           git \
#           llvm
# RUN pip3 install nose pyelftools parcon
# WORKDIR /home/app
RUN apk update
RUN apk add clang
RUN apk add git
RUN apk add llvm
RUN apk add make
RUN apk add gcc
RUN apk add libc-dev

RUN git clone https://github.com/iovisor/ubpf.git
WORKDIR ubpf
RUN make -C vm

COPY ./function/Function.c ./Function.c
RUN  clang -O2 -emit-llvm -c Function.c -o - | llc -march=bpf -filetype=obj -o Function.o

# Add non root user
# Create a non-root user
RUN addgroup --system app \
    && adduser --system --ingroup app app

RUN chown app:app -R /home/app
USER app

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="/home/app/ubpf/vm/test /home/app/ubpf/Function.o"
# Set to true to see request in function logs
ENV write_debug="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog