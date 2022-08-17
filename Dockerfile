# Inheritance
FROM bioconductor/bioconductor_docker:devel

# flowcyto packages
RUN R -e 'BiocManager::install("CytoML")'
RUN R -e 'install.packages("languageserver")'
RUN R -e 'install.packages("httpgd")'
