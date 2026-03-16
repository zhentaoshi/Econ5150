# Large Language Models

LLM is not something mysterious. It is just a pre-trained model. A pre-trained OLS model is fully represented by the coefficient $\hat \beta$. With a new inquiry $x_{\mathrm{new}}$, it will return a $y_{\mathrm{new}} = x_{\mathrm{new}}'\hat \beta$. LLM calls its coefficient **weight**. You inquiry with a sentence (text), and it will return with some text too.
Texts are represented in latent spaces as numerical vectors, and the **transformer** is a structure to faciliate operations over these numerical vectors.

With a laptop of reasonable configuration, it is possible to host a LLM locally. 

## CLI

It is much easier to install the CLI programs in Windows's WSL, the embedded Linux system. However, WSL may not be able to utilize all the computational resources of a laptop. 

Alternative, we can use a virtual machine (VM). The current container is configured based on Ubuntu 24.04.

## Local service

`ollama` can host as a **server** for LLMs. The LLMs run at the background, and we can use agent to access them.


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


## Agent interfaces

`codex` is for OpenAI, `claude code` is for Anthropic, and `qwen` is for Alibaba. Although they can be supported by LLMs from other labs, it is a bit awkward to do so.

For a local laptop, `opencode` is the best interface as an agent. It provides a free `kimi-2.5-free` as a backend. This `kimi` is on internet, but it is completely free and do not need an account, registry, or API.

My laptop or virtual machine sis too slow to make any local agent useful.


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


## Openclaw

### Codespace

In the model setting, choose `ollama:qwen3.5:0.8b`.

```
openclaw onboard
openclaw gateway
openclaw tui
```

### Local VM
Set the model as `ollama:qwen3.5:0.8b`
```
openclaw agent --local
ollama launch openclaw
```

## Real Use

For any realistic use, we cannot count on a laptop. We either use the cluster in the department, or use the online version of full strength.

Here are some use cases.

* Install `r-base-code` into the system
* Write an R script of using Monte Carlo simulations to compute pi. Save it as `pi.R`. Run the script and report the result.