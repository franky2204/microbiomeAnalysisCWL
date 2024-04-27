FROM ubuntu:20.04
LABEL maintainer="sandrogepiro.contaldo@unito.it"

#machine initialization
RUN apt-get update && \
    apt-get install -y \
    gcc \
    make \
    libbz2-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    liblzma-dev \
    bzip2 \
    g++ \
    rsync \
    libsqlite3-dev \
    bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY findFiles.sh \
    findFilesNew.sh \
    sendFiles.sh \
    findBowtie.sh \
    sendBowtie.sh ./
 