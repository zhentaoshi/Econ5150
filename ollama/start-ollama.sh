#!/usr/bin/env bash

finish() {
  return 0 2>/dev/null || exit 0
}

export HOME="${HOME:-/home/jovyan}"
export OLLAMA_HOST="${OLLAMA_HOST:-127.0.0.1:11434}"
export OLLAMA_MODELS="${OLLAMA_MODELS:-${HOME}/.ollama/models}"

mkdir -p "${HOME}/.ollama" "${OLLAMA_MODELS}"

if curl -fsS "http://${OLLAMA_HOST}/api/tags" >/dev/null 2>&1; then
  finish
fi

nohup ollama serve >"${HOME}/.ollama/ollama.log" 2>&1 &

for attempt in {1..5}; do
  if curl -fsS "http://${OLLAMA_HOST}/api/tags" >/dev/null 2>&1; then
    finish
  fi
  sleep 1
done

echo "ollama is starting in the background; API not ready yet" >&2
finish
