---
description: 意思決定に直結する正確な情報を収集・整理して報告するエージェント。
mode: subagent
model: openai/gpt-5.6-luna
permissions:
  - action: webfetch
    resource: "*"
    effect: allow
  - action: websearch
    resource: "*"
    effect: allow
---
