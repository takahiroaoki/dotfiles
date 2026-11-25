# friction

- 記録日: 2026-11-26
- 資材断面: `785aca5b6a8e8dcece4a2112ef1839a8dd3630a1`

## 事象一覧

- **[制約・環境]**
  - 事象: `~/dotfiles/agent/opencode.jsonc` の権限変更直後に `/reload` を挟まず `checker` に新権限前提の直接読み取り検証を委譲し、`Permission denied: external_directory` で FAIL・再検証になった。
  - 原因と対策案: シンボリックリンク実体側（`~/dotfiles/agent/`）の編集では OpenCode の自動リロードが発火しないケースがあるため、権限設定変更後に新権限を前提とした実動作検証を行う場合は先にユーザーへ `/reload` を依頼する手順にする。
