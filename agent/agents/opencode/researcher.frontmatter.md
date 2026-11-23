---
description: 意思決定に直結する正確な情報を収集・整理して報告するエージェント。
mode: subagent
model: google/gemini-flash-lite-latest
permissions:
  - action: read
    resource: "*"
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
    effect: deny
  - action: webfetch
    resource: "*"
    effect: allow
  - action: websearch
    resource: "*"
    effect: allow
  - action: subagent
    resource: "*"
    effect: deny
---
