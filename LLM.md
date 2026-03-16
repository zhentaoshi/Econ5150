# Large Language Models


## Demo

The current container is configured based on Ubuntu 24.04s

## Ollama

* Install `ollama`
```
curl -fsSL https://ollama.com/install.sh | sh
```

`ollama` provides [many choices of LLMs](https://ollama.com/search) 

```
ollama serve
ollama run qwen3.5:0.8b
```
This is a local service. We can now start a dialogue with this LLM.

* Install `opencode`, an AI agent.
```
curl -fsSL https://opencode.ai/install | bash
```
`opencode` is an interface. We need an LLM as workhorse.
You can choose either `qwen3.5:0.8b` or `MiniMax M2.5 Free`.

Try a prompt: "`install openclaw`".

```
openclaw --version
```
Set the model as `ollama:qwen3.5:0.8b`
```
openclaw agent --local
ollama launch openclaw
```

* Load 

The current status of large language models as on **2026-03-07**.

With a laptop of reasonable configuration, it is possible to host a LLM locally.

## Servers

* `LM Studio` provides a graphic interface. The LLMs can be used as a chatbot.
* `ollama` can host as a **server** for LLMs. The LLMs run at the background, and we can use agent to access them.

## Agent interfaces

For local laptop, `Opencode` is the best interface as an agent. `Opencode` also provides a free `kimi-2.5-free` as a backend. This `kimi` is on internet, but it is completely free and do not need an account at all.

My laptop is too slow to make any local agent useful, because an agent takes a long time to think. It takes about 3 minutes to answer a trivial question like "How are you?".

### Other agents 

`codex` is for OpenAI, `claude code` is for Anthropic, and `qwen` is for Alibaba. Although they can be supported by LLMs from other labs, it is a bit awkward to do so.

## CLI

It is much easier to install the CLI programs in Windows's WSL, the embedded Linux system. However, WSL may not be able to utilize all the computational resources of a laptop.

## Real Use

For any realistic use, we cannot count on a laptop. We either use the cluster in the department, or use the online version of full strength.
