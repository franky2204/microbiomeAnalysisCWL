FROM ubuntu:20.04
LABEL maintainer="sandrogepiro.contaldo@unito.it fpantini1997@gmail.com"

RUN apt-get update -y
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev bzip2 rustc -y

COPY findFiles.rs /rust/
RUN rustc /rust/findFiles.rs

COPY findFiles .
