#!/bin/sh

# GitHub Codespaces で開発に利用するツール群の設定スクリプト

set -eu

if [ "${CODESPACES:-}" != "true" ]; then
  echo "This installer is intended for GitHub Codespaces only; skipping." >&2
  exit 1
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_dir=$(CDPATH= cd -- "$script_dir/.." && pwd)

link_file() {
  source=$1
  destination=$2

  if [ -e "$destination" ] && [ ! -L "$destination" ]; then
    echo "Skip existing non-symlink: $destination" >&2
    return 0
  fi
  if [ -L "$destination" ]; then
    if [ "$(readlink "$destination")" = "$source" ]; then
      return 0
    fi
    rm "$destination"
  fi
  ln -s "$source" "$destination"
}

mkdir -p "$HOME/.config/git"

# git
link_file "$repo_dir/git/ignore" "$HOME/.config/git/ignore"
link_file "$repo_dir/git/gitconfig_shared" "$HOME/.gitconfig_shared"

# Add the shared config to the user's existing global config without replacing it.
if ! git config --global --get-all include.path 2>/dev/null |
  awk -v home="$HOME" '$0 == home "/.gitconfig_shared" || $0 == "~/.gitconfig_shared" { found = 1 } END { exit !found }'; then
  git config --global --add include.path "$HOME/.gitconfig_shared"
fi

# Generate agent definitions before linking the OpenCode configuration.
(cd "$repo_dir" && sh "$repo_dir/script/sync_opencode.sh")

mkdir -p "$HOME/.config/opencode"
link_file "$repo_dir/agent/agents/opencode/dist" "$HOME/.config/opencode/agents"
link_file "$repo_dir/agent/commands" "$HOME/.config/opencode/commands"
link_file "$repo_dir/agent/logs" "$HOME/.config/opencode/logs"
link_file "$repo_dir/agent/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
link_file "$repo_dir/agent/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"

# Codespaces images provide Node.js. Do not install another runtime (or depend on mise).
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "Node.js and npm are required in the Codespaces image." >&2
  exit 1
fi

# Keep this aligned with mise.optional.toml, while installing directly with npm.
npm install --global @opencode/cli@2.2.7
