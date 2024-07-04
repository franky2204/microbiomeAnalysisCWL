FROM rocker/r-ubuntu:22.04

# Copy and install R packages
COPY compress /compress/
RUN for pkg in /compress/*.tar.gz; do R -e "install.packages('$pkg', repos = NULL, type = 'source')"; done

WORKDIR /