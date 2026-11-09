# dotfiles

dotfiles for my own.

This project includes the following settings.

- [git](./git/)
- [mise](./mise/)
- [vscode](./vscode/)

These settings are managed through mise itself.

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
