# friction

- 記録日: 2026-11-25
- 資材断面: `80e78648c684e0ea4e0d830df8856125598bdb45`

## 事象一覧

- **[確認不足]**
  - 事象: `executor.frontmatter.md` と `checker.frontmatter.md` の内容を混同し、`checker` に `external_directory: "~/dotfiles/*"` が許可済みだと誤って説明したため、後の権限調整時に訂正が必要になった。
  - 原因と対策案: 複数エージェントの設定ファイルをまとめて読んだ後に権限可否を断定するときは、対象エージェントの該当設定を個別に再確認してから回答する。
