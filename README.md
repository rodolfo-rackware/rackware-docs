# RackWare documents

Customer-facing guides for RackWare RMM, written in Markdown and versioned with git.
PDF and Word files are generated automatically, so the Markdown is the only source to edit.

## Documents

| Document | Source | Current version |
|---|---|---|
| RackWare RMM 7.7 – Getting Started Guide (deploy, migrate, DR) | [docs/getting-started/getting-started.md](docs/getting-started/getting-started.md) | 1.2 |

Copy-and-paste commands for the Getting Started Guide: [docs/getting-started/commands.txt](docs/getting-started/commands.txt)

## Repository layout

```
docs/<name>/<name>.md      the document (GitHub-flavored Markdown)
docs/<name>/images/        its screenshots
docs/<name>/CHANGELOG.md   what changed in each version
build/build.sh             builds output/<name>.pdf and .docx with pandoc + weasyprint
build/pdf.css              PDF look and feel
.github/workflows/         builds the files on GitHub and creates releases
```

## Editing

Edit the Markdown (for example with Claude Code), commit, and push. Boxes use GitHub alert syntax:

```markdown
> [!TIP]
> Helpful advice.

> [!WARNING]
> Important – read before continuing.
```

## Building locally (WSL / Linux)

```bash
sudo apt install -y pandoc weasyprint     # once
bash build/build.sh                        # all documents
bash build/build.sh docs/getting-started   # one document
```

Files appear in `output/` (ignored by git).

## Publishing a version

1. Update the version in the document and add an entry to its `CHANGELOG.md`.
2. Commit and push.
3. Tag and push the tag – GitHub builds the files and creates a Release with the PDF and DOCX attached:

```bash
git tag getting-started-v1.3 && git push origin getting-started-v1.3
```

Every push to `main` also builds the files; download them from the workflow run (Actions → Build documents → Artifacts).
