# LLM Ollama OpenClaw Image

This project builds a Docker image on top of `ollama/ollama:0.18.0` with:

- `qwen3.5:0.8b` pulled into Ollama
- `opencode` installed from `opencode-ai`
- `openclaw` installed
- `ollama/qwen3.5:0.8b` set as the default OpenClaw model

## Build

```powershell
docker build -t llm-ollama-openclaw:test .
```

## Run

```powershell
docker run -d --name llm-ollama-openclaw -p 11434:11434 llm-ollama-openclaw:test
```

The container starts with Ollama serving on port `11434`.

## Verify

Check the installed tools:

```powershell
docker exec llm-ollama-openclaw bash -lc "opencode --version && openclaw --version"
```

Check the default OpenClaw model:

```powershell
docker exec llm-ollama-openclaw bash -lc "openclaw config get agents.defaults.model.primary"
```

Check the bundled Ollama model:

```powershell
docker exec llm-ollama-openclaw bash -lc "ollama list"
```

## Stop And Remove

```powershell
docker rm -f llm-ollama-openclaw
```
