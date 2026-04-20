# Agent Skills

Reusable agent skills for Codex and other Agent Skills compatible tools.

Skills are packaged under `skills/<skill-name>/` so this repository can hold
multiple installable skills.

## Available Skills

- `prd`: Create or update evidence-backed living PRDs and phase execution files
  under `tasks/`.
- `review-implementation`: Review code against markdown requirements/spec docs,
  identify gaps and risks, and apply focused fixes.

## Install

### skills.sh / `npx skills`

Install globally for Codex:

```bash
npx skills add https://github.com/golbin/agent-skills/tree/main/skills/prd \
  -g \
  -a codex \
  -y
npx skills add https://github.com/golbin/agent-skills/tree/main/skills/review-implementation \
  -g \
  -a codex \
  -y
```

Or install from the repository and select a skill:

```bash
npx skills add golbin/agent-skills --skill prd -g -a codex -y
npx skills add golbin/agent-skills --skill review-implementation -g -a codex -y
```

List available skills in this repository:

```bash
npx skills add golbin/agent-skills --list
```

### GitHub CLI `gh skill`

Requires GitHub CLI 2.90.0 or newer.

```bash
gh skill install golbin/agent-skills prd --agent codex --scope user
gh skill install golbin/agent-skills review-implementation --agent codex --scope user
```

The alias form also works on supported GitHub CLI versions:

```bash
gh skills add golbin/agent-skills prd --agent codex --scope user
gh skills add golbin/agent-skills review-implementation --agent codex --scope user
```

Preview before installing:

```bash
gh skill preview golbin/agent-skills prd
gh skill preview golbin/agent-skills review-implementation
```

### Codex Skill Installer

In Codex, ask:

```text
Use $skill-installer to install https://github.com/golbin/agent-skills/tree/main/skills/prd
Use $skill-installer to install https://github.com/golbin/agent-skills/tree/main/skills/review-implementation
```

Or run the installer script directly:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo golbin/agent-skills \
  --path skills/prd
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo golbin/agent-skills \
  --path skills/review-implementation
```

After installation, restart Codex so the new skill is picked up.

### Shell Installer

For machines with `bash`, `curl`, and `tar`:

```bash
curl -fsSL https://raw.githubusercontent.com/golbin/agent-skills/main/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/golbin/agent-skills/main/install.sh \
  | SKILL_PATH=skills/review-implementation SKILL_NAME=review-implementation bash
```

## Usage

Invoke skills in Codex by name, for example:

```text
Use $prd to create an evidence-backed PRD for this feature.
Use $review-implementation to review this implementation against tasks/prd-example.md.
```

The `prd` skill creates or updates markdown PRD files under `tasks/`, including
phase files when the plan is large enough to split. The `review-implementation`
skill reviews code against markdown requirements/spec docs and applies focused
fixes.
