FROM gcr.io/ris-registry-shared/rstudio:4.1.2

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libfontconfig1-dev libssl-dev libxml2-dev

# Get and install system dependencies
RUN R -e 'install.packages(c("dplyr", "uwot", "here", "tidymodels", "embed", "readr", "stringr", "bundle"), repos = "http://cran.us.r-project.org")'

RUN mkdir /home/Model

COPY --chmod=701 Model/UMAP_bmp_results_20230208 /home/Model

