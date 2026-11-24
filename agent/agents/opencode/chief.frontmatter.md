---
description: ユーザーの意図を正確に汲み取り、価値を届けるための責任者。
mode: primary
model: google/gemini-4-neon
permissions:
  - action: read
    resource: "*"
    effect: allow
  - action: read
    resource: "*.env"
    effect: ask
  - action: read
    resource: "*.env.*"
    effect: ask
  - action: read
    resource: "*.env.example"
    effect: allow
  - action: glob
    resource: "*"
    effect: allow
  - action: grep
    resource: "*"
    effect: allow
  - action: question
    resource: "*"
    effect: allow
  - action: edit
    resource: "~/dotfiles/agent/*"
    effect: allow
  - action: external_directory
    resource: "~/dotfiles"
    effect: allow
  - action: external_directory
    resource: "~/dotfiles/*"
    effect: allow
  - action: shell
    resource: "git -C ~/dotfiles rev-parse HEAD"
    effect: allow
  - action: shell
    resource: "git rev-parse HEAD"
    effect: allow
  - action: webfetch
    resource: "*"
    effect: allow
  - action: websearch
    resource: "*"
    effect: allow
  - action: subagent
    resource: "*"
    effect: allow
---
