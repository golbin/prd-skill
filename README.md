# PRD Skill

Evidence-backed living PRD generation skill for Codex agents.

This repository packages the `prd` skill under `skills/prd/` so it can be
installed from GitHub with Codex's skill installer.

## Install

In Codex, ask:

```text
Use $skill-installer to install https://github.com/golbin/prd-skill/tree/main/skills/prd
```

Or run the installer script directly:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo golbin/prd-skill \
  --path skills/prd
```

After installation, restart Codex so the new skill is picked up.

## One-Line Install

For machines with `bash`, `curl`, and `tar`:

```bash
curl -fsSL https://raw.githubusercontent.com/golbin/prd-skill/main/install.sh | bash
```

## Usage

Invoke it in Codex with `$prd`, for example:

```text
Use $prd to create an evidence-backed PRD for this feature.
```

The skill creates or updates markdown PRD files under `tasks/`, including phase
files when the plan is large enough to split.
