FROM opencpu/base
RUN R -e 'install.packages("PLCOm2012")'
RUN R -e 'remotes::install_github("resplab/plcom2012Prism")'
RUN echo "opencpu:opencpu" | chpasswd