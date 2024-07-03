FROM r-base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libbz2-dev \
    liblzma-dev \
    libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages from CRAN
RUN R -e 'install.packages(c("optparse", "ape", "rbiom", "compositions", "BiocManager"), repos = "https://cloud.r-project.org")'

# Install the Bioconductor package 'microbiome'
RUN R -e 'BiocManager::install("microbiome")'
