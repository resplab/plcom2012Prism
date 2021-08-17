FROM opencpu/base
RUN R -e 'remotes::install_github("resplab/PLCOm2012")'
RUN R -e 'remotes::install_github("resplab/plcom2012Prism")'
RUN echo "opencpu:opencpu" | chpasswd
