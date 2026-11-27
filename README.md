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

# bootstrap
# profile: `personal` | `work` | `codespaces`
$ sh ./dotfiles/scripts/setup ${profile}

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
$ sh ./scripts/sync_opencode
```
