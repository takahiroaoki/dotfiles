---
description: ユーザーの意図を正確に汲み取り、価値を届けるための責任者。
mode: primary
model: openai/gpt-6-luna
permissions:
  - action: question
    resource: "*"
    effect: allow
  - action: external_directory
    resource: "~/dotfiles/*"
    effect: allow
  - action: shell
    resource: "git -C ~/dotfiles rev-parse HEAD"
    effect: allow
  - action: subagent
    resource: "researcher"
    effect: allow
  - action: subagent
    resource: "executor"
    effect: allow
  - action: subagent
    resource: "checker"
    effect: allow
---
