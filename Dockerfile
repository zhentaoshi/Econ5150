# Use the official Jupyter R-notebook image which comes with R, Jupyter, and essential tools.
# This image provides a pre-configured environment for running Jupyter Notebooks with an R kernel.
FROM quay.io/jupyter/r-notebook:ubuntu-24.04


### This is a block for Ollama
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ARG OLLAMA_MODEL=qwen3.5:0.8b

# ENV OLLAMA_HOST=127.0.0.1:11434 \
#     OLLAMA_MODELS=/home/jovyan/.ollama/models \
#     OLLAMA_API_KEY=ollama-local \
#     OPENCLAW_CONFIG_PATH=/home/jovyan/.config/openclaw/config.json5

# USER root
###############################


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


 
### This is a block for Ollama   
# Install Ollama and the requested CLIs.


# RUN curl -fsSL https://ollama.com/install.sh | sh \
#     && npm install --global opencode-ai openclaw \
#     && command -v ollama \
#     && command -v opencode \
#     && command -v openclaw \
#     && npm cache clean --force

# RUN mkdir -p /home/jovyan/.ollama/models /home/jovyan/.config/openclaw /usr/local/bin/start-notebook.d \
#     && chown -R ${NB_UID}:${NB_GID} /home/jovyan/.ollama /home/jovyan/.config

# COPY ollama/pull-model.sh /usr/local/bin/pull-ollama-model.sh
# COPY ollama/start-ollama.sh /usr/local/bin/start-notebook.d/50-start-ollama.sh

# RUN chmod +x /usr/local/bin/pull-ollama-model.sh /usr/local/bin/start-notebook.d/50-start-ollama.sh \
#     && /usr/local/bin/pull-ollama-model.sh "${OLLAMA_MODEL}" \
#     && su -s /bin/bash "${NB_USER}" -c "export HOME=/home/${NB_USER}; export PATH=/opt/conda/bin:/usr/local/bin:/usr/bin:/bin; export OPENCLAW_CONFIG_PATH=${OPENCLAW_CONFIG_PATH}; openclaw config set agents.defaults.model.primary 'ollama/${OLLAMA_MODEL}'"

# USER ${NB_UID}



# The base image sets up the user "jovyan" and the entrypoint "start-notebook.sh" automatically.
# Workdir is /home/jovyan/work by default.
#
# To run this container and mount your current directory:
#   docker run -p 8888:8888 -v "${PWD}:/home/jovyan/work" <image_name>
