# dotfiles

dotfiles for my own.

This project includes the following procedures.

- Installing GUI tools like `Chrome`, `VSCode`, `Docker Desktop`, etc.
- Mac OS Settings
- CLI tool settings like `git`, `mise`, `vscode`, etc.

These settings above are managed through `mise`.

## setup

```
# install git, curl
$ xcode-select --install

# git clone
$ mkdir -p ~/workspace
$ git clone https://github.com/takahiroaoki/dotfiles.git ~/workspace/dotfiles

# install mise
$ curl -fsSL https://mise.run | sh

# bootstrap
$ cd ~/workspace/dotfiles
$ ~/.local/bin/mise trust
$ ~/.local/bin/mise bootstrap
```
