FROM gcr.io/ris-registry-shared/rstudio:4.1.2

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libfontconfig1-dev libssl-dev libxml2-dev

# Get and install system dependencies
RUN R -e 'install.packages(c("dplyr", "uwot", "tidymodels", "embed", "readr", "stringr", "bundle"), repos = "http://cran.us.r-project.org")'

RUN mkdir Code
RUN mkdir Model
RUN mkdir Data

COPY Code/applyUMAP.R Code/applyUMAP.R
COPY Model/UMAP_bmp_results_20230208 Model/
COPY Data/input_file.tsv Data/

WORKDIR Code/

RUN Rscript applyUMAP.R 
