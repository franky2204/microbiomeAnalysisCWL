FROM r-base

#"optparse", "ape", "rbiom", "compositions", "BiocManager"
# Install R packages
# Install required R packages from CRAN
RUN R -e 'install.packages("optparse", repos = "https://cloud.r-project.org")'
RUN R -e 'install.packages("ape", repos = "https://cloud.r-project.org")'
RUN R -e 'install.packages("rbiom", repos = "https://cloud.r-project.org")'
RUN R -e 'install.packages("compositions", repos = "https://cloud.r-project.org")'
RUN R -e 'install.packages("BiocManager", repos = "https://cloud.r-project.org")'

# Install the Bioconductor package
RUN R -e 'BiocManager::install("microbiome")'
