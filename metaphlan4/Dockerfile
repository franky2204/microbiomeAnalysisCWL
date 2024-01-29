FROM ubuntu:20.04

#machine initialization
RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev -y

WORKDIR /
#python3 installation
RUN apt-get update
RUN apt-get install build-essential libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y
COPY ./Python-3.11.2.tar.xz /tmp/Python-3.11.2.tar.xz
RUN tar -xf /tmp/Python-3.11.2.tar.xz

WORKDIR /
#bowtie2 install 
RUN sudo apt-get update
RUN sudo apt-get install bowtie2

WORKDIR /
RUN pip3 install numpy
RUN pip3 install biopython

WORKDIR /Python-3.11.2
RUN ./configure --enable-optimizations
RUN make install

WORKDIR /
#metaphlan installation
RUN apt-get update
RUN pip3 install metaphlan