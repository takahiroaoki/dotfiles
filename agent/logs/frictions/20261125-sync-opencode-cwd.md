# friction

- 記録日: 2026-11-25
- 資材断面: `4b8da89bde4f4d1495ce1faccc2531bfda998baa`

## 事象一覧

- **[制約・環境]**
  - 事象: `checker` へ `script/sync_opencode` のリポジトリ外ディレクトリからの実行検証を委譲したところ、`agent/opencode.jsonc` の `external_directory: deny` により拒否され、該当パターンの検証が未実施のまま WARN となった。
  - 原因と対策案: `<env>` に記載された一時ディレクトリでも `opencode.jsonc` の `external_directory: deny` が優先されるため、必要な一時ディレクトリのみ許可するか、検証設計時にリポジトリ内サブディレクトリからの絶対パス実行で代替する運用を徹底する。
