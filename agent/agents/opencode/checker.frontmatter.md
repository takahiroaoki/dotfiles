---
description: 結果の検証、および高リスク操作の事前監査を行い、バグや事故を未然に防ぐエージェント。
mode: subagent
model: openai/gpt-5.6-luna
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
    effect: deny
  - action: websearch
    resource: "*"
    effect: deny
  - action: subagent
    resource: "*"
    effect: deny
---
