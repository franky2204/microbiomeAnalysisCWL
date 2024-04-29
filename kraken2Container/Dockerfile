FROM ubuntu:20.04
MAINTAINER sandrogepiro.contaldo@unito.it

#machine initialization
RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev -y

#kraken2 installation
COPY ./kraken2-2.1.2 /tmp/kraken2

WORKDIR /tmp/kraken2
RUN bash /tmp/kraken2/install_kraken2.sh /kraken2
ENV PATH="${PATH}:/kraken2"

#braken installation
#COPY ./braken in some folder
#RUN BASH 

WORKDIR /

#python3 installation
RUN apt-get update
RUN apt-get install build-essential libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y
COPY ./Python-3.11.2.tar.xz /tmp/Python-3.11.2.tar.xz
RUN tar -xf /tmp/Python-3.11.2.tar.xz

WORKDIR /Python-3.11.2
RUN ./configure --enable-optimizations
RUN make install

WORKDIR /

RUN pip3 install kraken-biom
RUN pip3 install scikit-bio==0.5.8

COPY getOTU.py .
COPY countTotalOTU.py .
COPY kraken2.sh .
COPY computeAlpha.py .
