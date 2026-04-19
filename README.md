# PRD Skill

Evidence-backed living PRD generation skill for Codex agents.

This repository packages the `prd` skill under `skills/prd/` so it can be
installed from GitHub with `npx skills`, `gh skill`, or Codex's built-in skill
installer.

## Install

### skills.sh / `npx skills`

Install globally for Codex:

```bash
npx skills add https://github.com/golbin/prd-skill/tree/main/skills/prd \
  -g \
  -a codex \
  -y
```

Or install from the repository and select the `prd` skill:

```bash
npx skills add golbin/prd-skill --skill prd -g -a codex -y
```

List available skills in this repository:

```bash
npx skills add golbin/prd-skill --list
```

### GitHub CLI `gh skill`

Requires GitHub CLI 2.90.0 or newer.

```bash
gh skill install golbin/prd-skill prd --agent codex --scope user
```

The alias form also works on supported GitHub CLI versions:

```bash
gh skills add golbin/prd-skill prd --agent codex --scope user
```

Preview before installing:

```bash
gh skill preview golbin/prd-skill prd
```

### Codex Skill Installer

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

### Shell Installer

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
