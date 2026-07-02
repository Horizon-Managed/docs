# NEXOS CORE documentation — project instructions

Public product documentation for **NEXOS CORE** (by Horizon Managed Services),
built on [Mintlify](https://mintlify.com) and deployed to
**https://docs.horizonmanaged.com**.

- Pages are MDX files with YAML frontmatter. Configuration lives in `docs.json`.
- The source code being documented lives in a **separate** repo, `Horizon-Managed/nexusos-psa`
  (and the agent in `Horizon-Managed/nexusrmm-agent`). Always verify technical
  claims against that code — do not document behavior you haven't confirmed.
- For Mintlify product knowledge (components, config, writing standards), install
  the Mintlify skill: `npx skills add https://mintlify.com/docs`. The Mintlify MCP
  servers (`https://mcp.mintlify.com`, `https://www.mintlify.com/docs/mcp`) are
  also available.

## Local preview (do this before every PR)

Mintlify's per-PR preview deploys are **capped on our current plan** and often
skip, so **local preview is the reliable "verify before it's public" step.**

The Mintlify CLI needs an **LTS Node (≤ 24)** — the block is Node 25+. You only
need this on a machine where you want to preview/validate locally; editing and
pushing branches need nothing.

### macOS — use `make`

If your default `node` is 26 (e.g. GitNexus machines), install the keg-only
`node@22` once — it does **not** change your default `node` or affect GitNexus:

```bash
brew install node@22   # only if `node --version` is 25+ or missing
make preview           # live preview at http://localhost:3000
make check             # build + broken-link validation — run before every PR
```

`make` auto-detects `node@22` (Apple Silicon or Intel) and falls back to your
PATH `node` if it's already ≤ 24. `make node-info` shows which it picked.

### Windows — no `make`, run `npx` directly

Install Node **LTS** (not "Current"), then run the CLI directly in PowerShell —
no PATH prefix, because LTS is your default:

```powershell
winget install OpenJS.NodeJS.LTS   # once
npx mint@latest dev                # live preview at http://localhost:3000
npx mint@latest broken-links       # build + link validation — run before every PR
```

`broken-links` compiles every page, so a clean run confirms all MDX renders and
all internal links resolve. Run it (via `make check` or `npx`) before any PR.

> This local tooling is **dev-only** and does not affect GitHub PR checks — the
> only PR check is Mintlify's cloud preview build, which is unrelated to `make`.

## Deploy model — `main` is production

- Pushing to `main` **auto-deploys to the live public domain**. There is **no
  dev/prod split** — `main` *is* production.
- So: **never commit to `main` directly.** Branch, open a PR, verify locally
  (above) or via the PR's Mintlify preview if one builds, then merge. Merging =
  live.

## Structure

Navigation (`docs.json`) has three tabs:

- **Overview** — business-voice landing (`index.mdx`) + `quickstart.mdx`.
- **Platform reference** — feature docs, grouped by area (Helpdesk, Workflow
  studio, RMM, Distributors). New feature pages go here.
- **Changelog** — dated release notes under `changelog/`.

When you add a page, add it to the correct group in `docs.json`. When several
PRs each edit `docs.json` navigation, they conflict — stack or rebase them
sequentially rather than branching them all off `main`.

## Where new content comes from

- Mintlify's **Agent** may auto-draft an "update from code changes" PR when
  `nexusos-psa` merges a feature. It's a **trial feature and unreliable** — do
  not assume it fired. If a draft exists, **review it for accuracy against the
  code** (AI drafts repeat already-fixed details) before merging.
- If no draft exists for a user-facing change, write the page by hand under
  **Platform reference**. Documenting user-facing work is part of
  definition-of-done (see `nexusos-psa/CLAUDE.md` → "Product documentation").

## Terminology

- The product is **NEXOS CORE** (two words, all caps). Brand owner: **Horizon
  Managed Services**.
- `NexusOS PSA` is the internal platform/repo name — fine in **Platform
  reference** pages, but the **Overview** landing uses the business-voice brand
  ("NEXOS CORE"), not "PSA".

## Style preferences

- Active voice, second person ("you").
- One idea per sentence.
- Sentence case for headings.
- Bold for UI elements: click **Settings**.
- Code formatting for file names, commands, paths, and code references.

## Content boundaries

- **Overview / landing** follows the brand voice — business and outcomes, *not*
  an IT/security tool (per `nexusos-psa/branding/BRAND_GUIDELINES.md`).
- **Platform reference** documents how features actually work (helpdesk, RMM,
  billing, etc.) — accurate and functional, verified against the code.
- Do **not** document internal-only plumbing, secrets, tenant internals, or
  anything not customer-facing.
