FROM ubuntu:20.04
MAINTAINER sandrogepiro.contaldo@unito.it

#machine initialization
RUN apt-get update
RUN apt-get update
RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev bzip2 -y

#python3 installation
RUN apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y
COPY ./Python-3.11.2.tar.xz /tmp/Python-3.11.2.tar.xz
RUN tar -xf /tmp/Python-3.11.2.tar.xz

WORKDIR /Python-3.11.2
RUN ./configure --enable-optimizations
RUN make install

WORKDIR /

#bwa installation
COPY bwa-0.7.17.tar.bz2 /tmp
WORKDIR /tmp

RUN tar -vxjf bwa-0.7.17.tar.bz2

WORKDIR /tmp/bwa-0.7.17
RUN make
RUN cp bwa /usr/local/bin

WORKDIR /

#samtools installation
COPY samtools-1.17.tar.bz2 /tmp
WORKDIR /tmp

RUN tar -vxjf samtools-1.17.tar.bz2

WORKDIR /tmp/samtools-1.17
RUN ./configure
RUN make
RUN make install

ENV PATH="${PATH}:/tmp/samtools-1.18/bin"

WORKDIR /

COPY ./scripts /scripts
