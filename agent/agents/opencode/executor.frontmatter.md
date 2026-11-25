---
description: 各種タスクの遂行を正確かつ安全に行うエージェント。
mode: subagent
model: openai/gpt-6-luna
permissions:
  - action: edit
    resource: "*"
    effect: allow
  - action: edit
    resource: "~/dotfiles/agent/*"
    effect: ask
  - action: edit
    resource: "~/dotfiles/agent/logs/*"
    effect: allow
  - action: shell
    resource: "*"
    effect: ask
---
