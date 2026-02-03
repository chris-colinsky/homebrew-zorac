# Homebrew Tap for Zorac

Homebrew formulae for [Zorac](https://github.com/chris-colinsky/zorac) - a self-hosted local LLM chat client for vLLM inference servers.

## Installation

```bash
brew tap chris-colinsky/zorac
brew install zorac
```

## Usage

After installation, run:

```bash
zorac
```

On first run, Zorac will guide you through configuring your vLLM server connection.

## Upgrade

```bash
brew upgrade zorac
```

## Uninstall

```bash
brew uninstall zorac
brew untap chris-colinsky/zorac  # optional: remove the tap
```

## About Zorac

Zorac is a terminal-based ChatGPT alternative that runs powerful AI models locally on consumer hardware (RTX 4090/3090/3080). Features include:

- Rich terminal UI with streaming responses
- Persistent conversation sessions
- Automatic context management and summarization
- Zero ongoing costs - runs entirely on your hardware

For full documentation, configuration options, and vLLM server setup, visit the [main repository](https://github.com/chris-colinsky/zorac).

## Alternative Installation Methods

Zorac is also available via:

```bash
# pip
pip install zorac

# pipx (recommended for CLI tools)
pipx install zorac

# uv
uv tool install zorac
```

## License

MIT License - see the [main repository](https://github.com/chris-colinsky/zorac) for details.
