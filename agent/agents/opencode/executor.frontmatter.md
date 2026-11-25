---
description: 各種タスクの遂行を正確かつ安全に行うエージェント。
mode: subagent
model: openai/gpt-5.6-luna
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
    effect: deny
  - action: edit
    resource: "*"
    effect: allow
  - action: external_directory
    resource: "~/dotfiles/*"
    effect: allow
  - action: webfetch
    resource: "*"
    effect: deny
  - action: websearch
    resource: "*"
    effect: deny
  - action: subagent
    resource: "*"
    effect: deny
---
