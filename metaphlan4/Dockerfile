FROM rocker/r-ubuntu:22.04

#machine initialization
RUN apt-get update
RUN apt-get update
RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev bzip2 openjdk-11-jre samtools -y
RUN apt install r-base -y
#python3 installation
RUN apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y
COPY ./Python-3.11.2.tar.xz /tmp/Python-3.11.2.tar.xz
RUN tar -xf /tmp/Python-3.11.2.tar.xz

WORKDIR /
#bowtie2 install 
RUN  apt-get update
RUN  apt-get install -y bowtie2

WORKDIR /Python-3.11.2
RUN ./configure --enable-optimizations
RUN make install

WORKDIR /
RUN pip3 install numpy
RUN pip3 install biopython
RUN pip3 install biom-format
RUN pip3 install h5py
RUN pip3 install metaphlan==4.1.1

# Copy and install R packages
COPY compress /compress/
RUN for pkg in /compress/*.tar.gz; do R -e "install.packages('$pkg', repos = NULL, type = 'source')"; done

WORKDIR /

WORKDIR /

COPY ./scripts /scripts