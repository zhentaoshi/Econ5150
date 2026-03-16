#!/usr/bin/env bash
set -euo pipefail

model="${1:?usage: pull-model.sh <model>}"
ollama_url="http://${OLLAMA_HOST:-127.0.0.1:11434}"
home_dir="/home/${NB_USER:-jovyan}"

mkdir -p "${home_dir}/.ollama" "${OLLAMA_MODELS:-${home_dir}/.ollama/models}"
chown -R "${NB_UID:-1000}:${NB_GID:-100}" "${home_dir}/.ollama"

su -s /bin/bash "${NB_USER:-jovyan}" -c "
  set -euo pipefail
  export HOME='${home_dir}'
  export OLLAMA_HOST='${OLLAMA_HOST:-127.0.0.1:11434}'
  export OLLAMA_MODELS='${OLLAMA_MODELS:-${home_dir}/.ollama/models}'

  ollama serve >/tmp/ollama-build.log 2>&1 &
  ollama_pid=\$!

  cleanup() {
    kill \$ollama_pid >/dev/null 2>&1 || true
    wait \$ollama_pid >/dev/null 2>&1 || true
  }

  trap cleanup EXIT

  for attempt in {1..60}; do
    if curl -fsS '${ollama_url}/api/tags' >/dev/null; then
      break
    fi
    sleep 1
  done

  curl -fsS '${ollama_url}/api/tags' >/dev/null
  ollama pull '${model}'
  ollama list | grep -F '${model}'
"
