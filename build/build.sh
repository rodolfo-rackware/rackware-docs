#!/usr/bin/env bash
# Build PDF and DOCX for one or more documents.
#
#   bash build/build.sh                      # build every document under docs/
#   bash build/build.sh docs/getting-started # build one document
#
# Each document lives in docs/<name>/<name>.md with its images next to it.
# Output goes to output/<name>.pdf, output/<name>.docx (and an HTML preview).
# Requires: pandoc 3.x and weasyprint.
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$(pwd)"
mkdir -p output

docs=("$@")
if [ ${#docs[@]} -eq 0 ]; then docs=(docs/*/); fi

for d in "${docs[@]}"; do
  d="${d%/}"; name="$(basename "$d")"; md="$d/$name.md"
  if [ ! -f "$md" ]; then echo "skip $d (no $name.md)"; continue; fi
  echo "building $name ..."
  ref=()
  [ -f "$ROOT/build/reference.docx" ] && ref=(--reference-doc="$ROOT/build/reference.docx")
  meta=()
  [ -f "$d/metadata.yaml" ] && meta=(--metadata-file="$ROOT/$d/metadata.yaml")
  (
    cd "$d"
    # The cover at the top of the .md is for GitHub; PDF/DOCX use metadata.yaml for the title page.
    body="$(mktemp --suffix=.md -p .)"
    if grep -q '<!-- end-cover -->' "$name.md"; then
      awk 'f; /<!-- end-cover -->/{f=1}' "$name.md" > "$body"
    else
      cp "$name.md" "$body"
    fi
    pandoc "$body" -f gfm -t docx --toc --toc-depth=2 --resource-path=. "${meta[@]}" "${ref[@]}" \
      --metadata toc-title="Contents" -o "$ROOT/output/$name.docx"
    pandoc "$body" -f gfm -t html5 --standalone --toc --toc-depth=2 --embed-resources \
      --css="$ROOT/build/pdf.css" "${meta[@]}" --metadata toc-title="Contents" \
      -o "$ROOT/output/$name.html"
    rm -f "$body"
  )
  weasyprint "$ROOT/output/$name.html" "$ROOT/output/$name.pdf"
  echo "  -> output/$name.pdf, output/$name.docx"
done
