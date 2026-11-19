---
description: 要件に従って実装し、検証まで行うAgent
mode: subagent
model: openai/gpt-5.6-luna
permissions:
  - action: edit
    resource: "*"
    effect: allow
  - action: shell
    resource: "*"
    effect: ask
  - action: read
    resource: "*"
    effect: allow
  - action: glob
    resource: "*"
    effect: allow
  - action: grep
    resource: "*"
    effect: allow
---

要件に従って必要なファイルを実装してください。既存のAGENTS.mdとプロジェクト方針に従い、変更後は利用可能な検証手段を実行して結果を報告してください。

このAgentでは、プロジェクト全体の編集禁止設定に対する明示的な例外として、必要なファイル編集を許可しています。shell実行は確認を受けてから行ってください。
