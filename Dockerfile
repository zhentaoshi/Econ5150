# Use the official Jupyter R-notebook image which comes with R, Jupyter, and essential tools.
# This image provides a pre-configured environment for running Jupyter Notebooks with an R kernel.
FROM quay.io/jupyter/r-notebook:latest

# Install R packages required for slides_09_optimization.ipynb
# We use mamba (a faster drop-in replacement for conda) to install pre-compiled binaries
# which handles system dependencies (like libnlopt-dev) automatically.
# Packages: magrittr, numDeriv, nloptr, optimx, CVXR
RUN mamba install --yes \
    'r-magrittr' \
    'r-numderiv' \
    'r-nloptr' \
    'r-optimx' \
    'r-cvxr' \
    'r-mcmc' \
    'r-languageserver' \
    && mamba clean --all -f -y

# The base image sets up the user "jovyan" and the entrypoint "start-notebook.sh" automatically.
# Workdir is /home/jovyan/work by default.
#
# To run this container and mount your current directory:
#   docker run -p 8888:8888 -v "${PWD}:/home/jovyan/work" <image_name>
