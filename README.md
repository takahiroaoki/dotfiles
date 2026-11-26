# dotfiles

dotfiles for my own.

This project includes the following procedures.

- Installing GUI tools like `Chrome`, `VSCode`, `Docker Desktop`, etc.
- Mac OS Settings
- CLI tool settings like `git`, `mise`, `vscode`, etc.

These settings above are managed through `mise`.

## options

| environment | packages / tools |
| --- | --- |
| Apple Silicon Mac | `chrome`, `docker`, `git`, `go`, `macos`, `macos.*`, `node`, `nordvpn`, `obsidian`, `opencode`, `vscode` |
| GitHub Codespaces / Linux Server | `git`, `go`, `node`, `opencode` |

## setup for Mac

```
# install git, curl
$ xcode-select --install

# git clone
$ cd && git clone https://github.com/takahiroaoki/dotfiles.git

# override .miserc.toml to customize which tools you use
$ cd ~/dotfiles
$ cp .miserc.toml .miserc.local.toml && vim .miserc.local.toml

# install mise
$ curl -fsSL https://mise.run | sh

# bootstrap
$ ~/.local/bin/mise trust
$ ~/.local/bin/mise bootstrap

# to use AI agent via api
$ echo 'export GEMINI_API_KEY=YOUR_API_KEY' >> ~/.zshrc
$ echo 'export ANTHROPIC_API_KEY=YOUR_API_KEY' >> ~/.zshrc
$ echo 'export OPENAI_API_KEY=YOUR_API_KEY' >> ~/.zshrc
```

## maintenance

### VSCode

```
# After installing new extensions
$ mise run lst_exts

# When updating extensions
$ mise run upd_exts
```

### OpenCode

```
# After update prompts or frontmatters
$ sh ./script/sync_opencode
```

## GitHub Codespaces

To use this repository in GitHub Codespaces, add `GEMINI_API_KEY` to Codespaces' Secrets so it is available as an environment variable for OpenCode.

Then, execute the following commands.
```
$ cd && git clone https://github.com/takahiroaoki/dotfiles.git && cd dotfiles
$ sh ./script/codespaces
```
