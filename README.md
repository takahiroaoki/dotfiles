# dotfiles

dotfiles for my own.

This project includes the following procedures.

- Installing GUI tools like `Chrome`, `VSCode`, `Docker Desktop`, etc.
- Mac OS Settings
- CLI tool settings like `git`, `mise`, `vscode`, etc.

These settings above are managed through `mise`.

## requirements

- Apple Silicon Mac

## setup

```
# install git, curl
$ xcode-select --install

# git clone
$ cd && git clone https://github.com/takahiroaoki/dotfiles.git

# install mise
$ curl -fsSL https://mise.run | sh

# bootstrap
$ cd ~/dotfiles
$ ~/.local/bin/mise trust
$ ~/.local/bin/mise bootstrap

# bootstrap for personal use
$ ~/.local/bin/mise -E optional bootstrap

# to use ai agent via api
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
