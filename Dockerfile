FROM ztshi/econ_data_sci:latest 
# tag “lastest”. updated on 2023-1-24


#########
# the following is copied from
# https://github.com/binder-examples/minimal-dockerfile/blob/master/Dockerfile

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

WORKDIR ${HOME}
USER ${USER}

