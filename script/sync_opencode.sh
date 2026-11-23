#!/bin/sh

# agent の本文と対応する frontmatter を連結し、OpenCode 用の agent 定義ファイルを作成する。

set -eu

opencode="agent/agents/opencode"
dist="$opencode/dist"
tmp_dist=$(mktemp -d "$opencode/.dist.XXXXXX")
trap 'rm -rf "$tmp_dist"' EXIT HUP INT TERM

for body in agent/agents/*.body.md; do
    name=${body##*/}
    name=${name%.body.md}
    frontmatter="$opencode/$name.frontmatter.md"
    output="$tmp_dist/$name.md"

    if [ -f "$frontmatter" ]; then
        cat "$frontmatter" "$body" > "$output"
        echo "Generated $output"
    else
        echo "Skip $name: missing $frontmatter"
    fi
done

rm -rf "$dist"
mv "$tmp_dist" "$dist"
trap - EXIT HUP INT TERM
