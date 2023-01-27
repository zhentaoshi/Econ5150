FROM ztshi/econ_data_sci:latest 
# tag “lastest”. updated on 2023-1-24

# copy the contents in the repo to HOME folder
# according to 
# https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# RUN git clone https://github.com/zhentaoshi/Econ5150
