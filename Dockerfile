FROM --platform=amd64 ubuntu:latest

LABEL maintainer "https://github.com/michaelgranado"

USER root
WORKDIR /root

RUN apt-get update -y && \
    apt-get install -y bash-completion command-not-found tmux screen && \ 
    apt-get install -y make wget vim nano emacs git default-jre default-jdk && \
    ln -s /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /lib/ld-linux.so.2 && \
    dpkg --add-architecture i386 && apt update && apt install -y libc6:i386 && apt-get clean -qy

SHELL ["/bin/bash","-c"]
COPY mips-x86.linux-xgcc/ mips-x86.linux-xgcc/
RUN echo 'PS1="\[\033[35m\]\t \[\033[32m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] # "' >> /root/.bashrc && \
    echo 'export PATH=~/mips-x86.linux-xgcc${PATH:+:${PATH}}' >> /root/.bashrc && \
    echo 'export ARCHDIR=/root/mips-x86.linux-xgcc' >> /root/.bashrc && \
    echo 'alias nachos=../bin/nachos' >> /root/.bashrc
