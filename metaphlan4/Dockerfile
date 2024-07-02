FROM ubuntu:20.04

#machine initialization
RUN apt-get update
RUN apt-get update
RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev bzip2 openjdk-11-jre samtools -y
RUN apt install r-base -y

# Use the base image for MetaPhlAn
FROM fpant/metaphlan411

# Install initial CRAN packages including devtools
RUN R -e 'install.packages(c("optparse", "ape", "rjson", "compositions", "vegan", "devtools", "usethis"), repos="http://cran.us.r-project.org")'

# Verify that devtools is installed and load it
RUN R -e 'library(devtools)'

# Install a specific version of rbiom using devtools
RUN R -e 'devtools::install_version("rbiom", version = "1.0.3", repos = "http://cran.us.r-project.org")'

# Install BiocManager if not already installed
RUN R -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos="http://cran.us.r-project.org")'

# Install Bioconductor packages
RUN R -e 'BiocManager::install(c("phyloseq", "microbiome"), update = TRUE, ask = FALSE)'



WORKDIR /

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


WORKDIR /

COPY ./scripts /scripts