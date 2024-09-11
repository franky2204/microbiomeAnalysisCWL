FROM staphb/trimmomatic:0.39

LABEL maintainer="pandafake589@gmail.com"

RUN apt-get update && \
    apt-get install -y \
    wget \
    gcc \
    make \
    build-essential \
    unzip \
    && apt-get clean
WORKDIR /
RUN mkdir TRF
COPY trf409.linux64 ./TRF/

WORKDIR /TRF
RUN chmod +x trf409.linux64

WORKDIR /
