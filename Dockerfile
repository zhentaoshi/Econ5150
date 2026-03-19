# Use the official Jupyter R-notebook image which comes with R, Jupyter, and essential tools.
# This image provides a pre-configured environment for running Jupyter Notebooks with an R kernel.
FROM quay.io/jupyter/r-notebook:ubuntu-24.04

# Install R packages used in the course plus Node.js for CLI tooling.
RUN mamba install --yes \
    'r-magrittr' \
    'r-numderiv' \
    'r-nloptr' \
    'r-optimx' \
    'r-cvxr' \
    'r-mcmc' \
    'r-languageserver' \
    'nodejs>=22.16' \
    && mamba clean --all -f -y
    
# The base image sets up the user "jovyan" and the entrypoint "start-notebook.sh" automatically.
# Workdir is /home/jovyan/work by default.
#
# To run this container and mount your current directory:
#   docker run -p 8888:8888 -v "${PWD}:/home/jovyan/work" <image_name>
