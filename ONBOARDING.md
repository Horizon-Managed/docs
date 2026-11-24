# NEXOS CORE docs — contributor onboarding

The public product docs for **NEXOS CORE** (by Horizon Managed Services). Built
on [Mintlify](https://mintlify.com), deployed to **https://docs.horizonmanaged.com**.
This repo is **separate** from `nexusos-psa` (the source code) and `nexusrmm-agent`.

Read **`AGENTS.md`** for the full conventions — this file is just "get running."

---

## 1. Access

You need GitHub access to `Horizon-Managed/docs` — the same org access and
`gh`/git credentials you already use for `nexusos-psa`. Nothing new.

## 2. One-time setup

The only thing to install is an **LTS Node (≤ 24)** for the Mintlify CLI — and
only on a machine where you want to **preview/validate locally**. Editing and
pushing branches need nothing extra.

### macOS (Apple Silicon or Intel)

```bash
gh repo clone Horizon-Managed/docs
cd docs
node --version            # need ≤ 24
brew install node@22      # ONLY if node is 25+ or missing (keg-only — does NOT
                          # change your default node or affect GitNexus)
make node-info            # confirms which Node the CLI will use
```

### Windows

```powershell
gh repo clone Horizon-Managed/docs
cd docs
winget install OpenJS.NodeJS.LTS   # if node is missing or 25+; then open a fresh terminal
node --version                     # must be ≤ 24 ("LTS", not "Current")
```

Windows has no `make` — use the `npx` commands directly (below).

## 3. Everyday workflow

**Never commit to `main`** — always branch + PR.

```bash
git checkout -b docs/<short-description>
# ...edit .mdx pages / docs.json...
```

Preview and validate before opening a PR:

| | Preview (localhost:3000) | Build + link check (must be clean) |
|---|---|---|
| **macOS** | `make preview` | `make check` |
| **Windows** | `npx mint@latest dev` | `npx mint@latest broken-links` |

Then push and open a PR against `main`:

```bash
git push -u origin docs/<short-description>
gh pr create --base main --title "..." --body "..."
```

## 4. Deploy

Merging to `main` publishes to **https://docs.horizonmanaged.com** via Mintlify.
Always verify locally (`make check` / `npx … broken-links`) and on the PR's
Mintlify preview before merging.

> A dev/staging gate mirroring the app's DEV server is being set up for docs;
> this file will be updated with the promote flow once it lands.

## 5. Where content comes from

- Mintlify's **Agent** may auto-draft an "update from code changes" PR when a
  `nexusos-psa` feature merges. It's a **trial feature and unreliable** — if a
  draft exists, **review it against the actual code** (AI drafts repeat
  already-fixed details) before merging. Otherwise write the page by hand under
  the **Platform reference** tab.
- These docs are separate from the in-repo docs in `nexusos-psa` (changelog,
  INVENTORY, GitNexus wiki), which stay mandatory on every code PR.

## 6. Using Claude Code in this repo

Claude Code auto-loads `AGENTS.md` — follow it. Verify any technical claim
against the `nexusos-psa` / `nexusrmm-agent` source; don't invent behavior.
Don't change CI config — the local tooling here (`make`, `npx mint`) is dev-only
and does not affect GitHub PR checks.
