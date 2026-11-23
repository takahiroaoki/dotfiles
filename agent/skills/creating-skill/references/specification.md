# Agent Skills と OpenCode V2 仕様

## 共通の構成

スキルは `<skill-name>/SKILL.md` を必須とし、必要に応じて `references/`（読む資料）、`assets/`（テンプレート・素材）、`scripts/`（反復処理）を同階層に置く。`SKILL.md` から参照するのは原則1階層までとする。

## Agent Skills 標準（agentskills.io）

| フィールド | 標準上の扱い | 注意 |
| --- | --- | --- |
| `name` | 必須。ID | ディレクトリ名と一致、kebab-case |
| `description` | 必須。発動説明 | 何をいつ使うかを具体化 |
| `license` | 任意 | ライセンス名またはファイル |
| `compatibility` | 任意 | 環境条件。500文字以内を目安 |
| `metadata` | 任意 | 文字列キー／値の追加情報 |
| `allowed-tools` | Experimental（実装依存） | 利用許可ツールの指定。移植性に注意 |

`name` は `^[a-z0-9]+(-[a-z0-9]+)*$`、1〜64文字、ディレクトリ名と一致させる。ファイル名は大文字の `SKILL.md` とする。メタデータは約100 tokens、本文は500行未満・5000 tokens未満を目安にし、詳細は Progressive Disclosure で分離する。

## OpenCode V2（opencode.ai/docs/skills）

| フィールド／機能 | OpenCode V2 での扱い | 注意 |
| --- | --- | --- |
| `name` / `description` | 発見・候補化に使用 | スキルの識別と発動条件を明確にする |
| `license` / `compatibility` / `metadata` | 任意のメタデータ | 標準との互換性を保つ |
| `allowed-tools` | 未解釈 | OpenCode では `opencode.jsonc` や agent frontmatter の `permissions` で制御する |
| `skill` 権限 | `allow` / `ask` / `deny` | ファイル変更・コマンド実行の権限とは別に扱う |

### OpenCode V2 固有の frontmatter 制御

- `metadata.opencode/autoinvoke: false` は自動呼出しを抑止する。
- `disable-model-invocation: true` はモデルによる自動呼出しを抑止する。
- 両方を指定した場合は `metadata.opencode/autoinvoke` が優先される。

これらは OpenCode 固有のため、移植性重視のスキルでは原則使わない。使う場合は依存先と効果を明記する。

## OpenCode V2 の発見パス優先順位

同名スキルは、番号が大きい後勝ちで優先される。

1. 組み込み
2. `.claude/skills`（グローバル → プロジェクト）
3. `.agents/skills`（グローバル → プロジェクト）
4. `~/.config/opencode/skills`
5. プロジェクト `.opencode/skills`（ルート → カレント）
6. `opencode.jsonc` の `skills` 配列

発見後はメタデータで候補化され、必要時に `SKILL.md` と条件付き資料がロードされる。変更は自動リロード対象で、必要なら `/reload` で再読み込みする。
