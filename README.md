# aispec — Lightweight spec-driven conventions for AI and teams

**aispec** is a convention-first, zero-dependency spec-driven workflow: agree on **what to build** (MRD → PRD → DESIGN) before coding. Use Markdown and templates only; optional CLI for init and verify. Fits any repo; no lock-in.

[中文说明](README.zh-CN.md)

---

## What is aispec?

- **Spec-first**: MRD (idea) → PRD (requirements) → DESIGN (technical plan) → code → review → test → merge. Specs live in the repo; context persists.
- **Convention over tooling**: One [CONVENTIONS.md](spec/CONVENTIONS.md) defines workflow, structure, and deliverables. Copy `spec/` or run `aispec init`; no runtime dependency.
- **Agent-friendly**: Clear slash-style triggers (/mrd, /merge, etc.) and deliverable locations so AI assistants can follow the same flow as humans.

---

## Quick start

**Option A — CLI (recommended)**

```bash
npm install -g git+https://github.com/surlymochan/aispec.git
cd your-project
aispec init
aispec verify
```

This creates `.aispec/spec/` (CONVENTIONS + templates) and optional root `AGENTS.md`. See [docs/cli-install.md](docs/cli-install.md) for more install options.

**Option B — Manual**

Copy this repo’s `spec/CONVENTIONS.md` and `spec/templates/` into your repo (e.g. `.aispec/spec/` or `docs/aispec/`). In README or AGENTS.md add: “Agent must read .aispec/spec/CONVENTIONS.md”.

---

## Demo: How a project uses aispec

### 1. Directory after adoption

A product repo using aispec might look like this (minimal):

```
my-service/
├── README.md
├── .aispec/
│   └── spec/
│       ├── CONVENTIONS.md    # workflow, structure (or link to shared spec)
│       └── templates/        # proposal.md, tasks.md, AGENTS.md
├── iteration/                # optional: per-change folders
│   └── SP-20250201/
│       ├── MRD.md
│       ├── PRD.md
│       ├── DESIGN.md
│       └── README.md
├── spec/                     # current released spec (after /merge)
│   └── README.md             # version, scope
└── src/
```

Standalone repo (no iteration): only `.aispec/spec/` + your code; CONVENTIONS still define how to run /mrd → /merge when you add iterations later.

### 2. Using the commands (workflow in practice)

| Trigger | What happens | Example / artifact |
|--------|----------------|---------------------|
| **/mrd** | Capture idea or request | Create `iteration/SP-20250201/MRD.md` (goal, scope, success criteria). |
| **/prd** | Turn MRD into requirements | Agent writes `PRD.md` in same iteration dir; clarify with stakeholder first. |
| **/design** | Technical design from PRD | Agent writes `DESIGN.md` (and optional `tasks.md`) in same dir. |
| **/coding** | Implement from DESIGN/tasks | Code and config under iteration or `src/` per project rule. |
| **/review** | Review vs PRD/DESIGN | Produce `REVIEW.md` in iteration dir. |
| **/test** | Validate against acceptance | Produce `TEST.md` in iteration dir. |
| **/merge** | Ship to main spec/codebase | Merge approved work into `spec/` (and `src/` if any); bump version in `spec/README.md`; update PRD/DESIGN if implementation diverged. |
| **/public**, **/push** | Publish (e.g. to GitHub) | Only if your workspace uses a “private → public” flow; see CONVENTIONS. |

**Example sequence (conceptual):**

```text
/mrd          → Create iteration/SP-20250201/, add MRD.md (e.g. “Add export API”).
/prd          → Add PRD.md (requirements, acceptance criteria).
/design       → Add DESIGN.md and tasks.md.
/coding       → Implement; put code under src/ or iteration as agreed.
/review       → Add REVIEW.md; address comments.
/test         → Add TEST.md; run acceptance checks.
/merge        → Merge to spec/ and src/; update spec/README.md version.
```

Details (inputs/outputs, templates, quality gates) are in [spec/CONVENTIONS.md](spec/CONVENTIONS.md).

---

## This repository

- **spec/** — Authoritative workflow and structure: [CONVENTIONS.md](spec/CONVENTIONS.md), [spec/README.md](spec/README.md) (version), and [templates/](spec/templates/).
- **cli/** — Optional [aispec CLI](cli/README.md): `init`, `verify`.
- **docs/** — [CLI install](docs/cli-install.md), [standalone adoption](docs/standalone-adoption.md), [OpenSpec comparison](docs/openspec-comparison-and-open-source-readiness.md).

**When working in this repo (or a workspace that contains it):** Read [spec/CONVENTIONS.md](spec/CONVENTIONS.md) first. If your workspace has a root **aispec.md**, it holds project-specific rules and PROGRESS; CONVENTIONS stay the single source of truth.

---

## Comparison with OpenSpec

| | OpenSpec | aispec |
|---|----------|--------|
| **Focus** | Spec-driven framework + CLI + slash commands | Conventions + templates + optional CLI |
| **Install** | npm package | Copy spec or `aispec init`; no runtime dep |
| **Artifacts** | proposal, design, tasks, spec deltas | MRD, PRD, DESIGN, tasks; merge back into spec |
| **Authority** | Schema + specs/ | One CONVENTIONS + spec/ |

See [docs/openspec-comparison-and-open-source-readiness.md](docs/openspec-comparison-and-open-source-readiness.md) for a fuller comparison.

---

## Docs index

| Doc | Purpose |
|-----|---------|
| [README.zh-CN.md](README.zh-CN.md) | 中文说明 |
| [spec/CONVENTIONS.md](spec/CONVENTIONS.md) | Workflow, structure, deliverables, templates |
| [spec/README.md](spec/README.md) | Current release version and contents |
| [spec/templates/](spec/templates/) | proposal, tasks, AGENTS templates |
| [cli/README.md](cli/README.md) | CLI usage (init, verify) |
| [docs/cli-install.md](docs/cli-install.md) | Install and run the CLI |
| [docs/standalone-adoption.md](docs/standalone-adoption.md) | Adopt aispec in any repo |
| [CHANGELOG.md](CHANGELOG.md) | Release and iteration history |

---

## License and contributing

- **License**: [MIT](LICENSE)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)

Not published on npm; use from GitHub: `npm install -g git+https://github.com/surlymochan/aispec.git` or clone and `npm run link` in this repo.
