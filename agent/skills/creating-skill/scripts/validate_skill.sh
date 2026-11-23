#!/bin/sh
# Validate the corresponding YAML frontmatter subset (top-level single-line
# scalars and >, >-, |, |- block scalars); this is not a complete YAML parser.
# 重複キー検査の対象は `name` / `description` / `compatibility` のみ。
set -eu

errors=0
warnings=0
err() { printf 'ERROR: %s\n' "$1"; errors=$((errors + 1)); }
warn() { printf 'WARN: %s\n' "$1"; warnings=$((warnings + 1)); }

if [ "$#" -ne 1 ]; then
  printf 'Usage: sh scripts/validate_skill.sh <skill-dir>\n' >&2
  exit 2
fi
case "$1" in /) dir=/ ;; *) dir=${1%/} ;; esac
file=$dir/SKILL.md
[ -d "$dir" ] || err "skill directory not found: $dir"
[ -f "$file" ] || err "SKILL.md not found: $file"
if [ "$errors" -gt 0 ]; then exit 1; fi

tmp=${TMPDIR:-/private/var/folders/jp/bwp_qh2n5ms7bbn70rdjljlw0000gn/T/opencode}/validate-skill.$$
mkdir "$tmp"
trap 'rm -rf "$tmp"' 0 1 2 3 15
clean=$tmp/clean
awk '{ sub(/\r$/, ""); print }' "$file" > "$clean"

# Parse only the supported top-level subset. Values are written separately so
# block scalars can retain embedded newlines without an ad-hoc escaping format.
awk -v out="$tmp" '
function trim(s) { sub(/^[[:space:]]+/, "", s); sub(/[[:space:]]+$/, "", s); return s }
function scalar(s, q) {
  s=trim(s); q=substr(s,1,1)
  if ((q=="\"" || q=="\x27") && substr(s,length(s),1)==q && length(s)>=2)
    s=substr(s,2,length(s)-2)
  return s
}
function fail(s) { print s > (out "/errors") }
function save(k,v) { print v > (out "/" k); close(out "/" k) }
NR==1 { if ($0 !~ /^---/) fail("frontmatter must start on line 1 with ---"); inside=1; next }
inside && $0=="---" { closed=1; inside=0; next }
inside {
  if ($0 ~ /^[^[:space:]][^:]*:/) {
    if (active) { block[active]=0; active="" }
    key=$0; sub(/:.*/, "", key); rest=$0; sub(/^[^:]*:/, "", rest); rest=trim(rest)
    if (key=="name" || key=="description" || key=="compatibility") {
      if (seen[key]++) fail(key " is duplicated")
      if (rest==">" || rest==">-" || rest=="|" || rest=="|-") {
        block[key]=1; active=key; kind[key]=rest; val[key]=""; have[key]=1; next
      }
      save(key, scalar(rest)); have[key]=1; next
    }
    next
  }
  if (active && ($0 ~ /^[[:space:]]/ || $0=="")) {
    line=$0; sub(/^[[:space:]]+/, "", line)
    if (kind[active] ~ /^>/) {
      if (line!="") { if (val[active]!="") val[active] = val[active] " "; val[active]=val[active] line }
      else val[active]=val[active] "\n"
    } else val[active] = val[active] line "\n"
    next
  }
  if ($0 ~ /^[^[:space:]]/) { block[active]=0; active="" }
}
END {
  if (!closed) fail("frontmatter closing --- not found")
  for (k in block) if (block[k]) {
    v=val[k]; if (kind[k]==">-" || kind[k]=="|-") sub(/\n$/, "", v)
    save(k,v)
  }
}' "$clean"

if [ -f "$tmp/errors" ]; then while IFS= read -r message; do err "$message"; done < "$tmp/errors"; fi
name=$(cat "$tmp/name" 2>/dev/null || true)
desc=$(cat "$tmp/description" 2>/dev/null || true)
comp=$(cat "$tmp/compatibility" 2>/dev/null || true)
[ -n "$name" ] || err 'name is missing or empty'
if [ -n "$name" ]; then
  n=$(printf '%s' "$name" | wc -m | tr -d ' '); [ "$n" -le 64 ] || err 'name exceeds 64 characters'
  printf '%s\n' "$name" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$' || err 'name does not match kebab-case'
  [ "$name" = "$(basename "$dir")" ] || err 'name does not match parent directory name'
fi
[ -n "$desc" ] || err 'description is missing or empty'
d=$(printf '%s' "$desc" | wc -m | tr -d ' '); [ "$d" -le 1024 ] || err 'description exceeds 1024 characters'
if [ -n "$comp" ]; then c=$(printf '%s' "$comp" | wc -m | tr -d ' '); [ "$c" -le 500 ] || err 'compatibility exceeds 500 characters'; fi

lines=$(wc -l < "$clean" | tr -d ' '); [ "$lines" -le 500 ] || warn "SKILL.md has $lines lines (over 500)"

# Remove fenced code blocks before extracting bounded relative references.
awk 'BEGIN { body=0; fence=0; delimiters=0 } { if (!body && $0=="---") { delimiters++; if (delimiters==2) body=1; next } if (body && $0 ~ /^[[:space:]]*(```|~~~)/) { fence=!fence; next } if (body && !fence) print }' "$clean" > "$tmp/body"
refs=$(grep -Eo '(^|[^[:alnum:]_./:-])(references|assets|scripts)/[A-Za-z0-9_./*<>-]+' "$tmp/body" | sed -E 's/^[^A-Za-z0-9_./*-]//' | sed -E 's/[.,)\]};:!?`]+$//' | sort -u || true)
for ref in $refs; do
  case "$ref" in
    ..|../*|*/../*|*/..) err "path traversal not allowed in reference: $ref"; continue ;;
    *'<'*|*'>'*|*'*'*|*'...'*) continue ;;
  esac
  [ -f "$dir/$ref" ] || err "referenced file not found: $ref"
done

printf 'Summary: %s error(s), %s warning(s)\n' "$errors" "$warnings"
[ "$errors" -eq 0 ]
