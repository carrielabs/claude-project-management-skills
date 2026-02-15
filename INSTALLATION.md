# Installation Guide

> Step-by-step guide to install and configure these skills in your project

## Prerequisites

- Claude Code CLI installed
- A project with Git initialized
- Basic understanding of your project structure

---

## Installation Steps

### Step 1: Copy Skills to Your Project

```bash
# Clone this repository
git clone https://github.com/shaobaolu/claude-project-management-skills.git

# Navigate to your project
cd /path/to/your-project

# Create skills directory if it doesn't exist
mkdir -p .claude/skills

# Copy the skills
cp claude-project-management-skills/documentation-enforcer/SKILL.md \
   .claude/skills/documentation-enforcer.md

cp claude-project-management-skills/code-structure-enforcer/SKILL.md \
   .claude/skills/code-structure-enforcer.md
```

### Step 2: Create Documentation Structure

```bash
# Create documentation folders
mkdir -p docs/{architecture,dev-logs,tests,troubleshooting}

# Create tracking files
touch docs/progress.md
touch docs/task_plan.md
touch docs/findings.md
touch docs/README.md
```

### Step 3: Initialize Tracking Files

**docs/progress.md**:
```markdown
# Project Progress

> Session history (newest first)

---

## 2026-02-15 10:00 - Initial Setup

### Completed
- Installed Documentation Enforcer skill
- Installed Code Structure Enforcer skill
- Created documentation structure

### Next Steps
- Start first development session
```

**docs/task_plan.md**:
```markdown
# Task Plan

> Current tasks and their status

## Active Tasks

- [ ] #1: Set up project documentation
- [ ] #2: Configure development environment

## Completed Tasks

None yet
```

**docs/findings.md**:
```markdown
# Findings

> Important discoveries, problems, and solutions

---

No findings yet.
```

### Step 4: (Optional) Add to CLAUDE.md

If you have a `.claude/CLAUDE.md` file, add these sections:

```markdown
## 📝 Documentation Rules

See `.claude/skills/documentation-enforcer.md` for complete documentation standards.

## 💾 Code Structure Rules

See `.claude/skills/code-structure-enforcer.md` for code organization standards.
```

If you don't have a `CLAUDE.md`, you can copy the example:

```bash
cp claude-project-management-skills/examples/CLAUDE.md.example \
   .claude/CLAUDE.md
```

### Step 5: Verify Installation

Start a new Claude Code session:

```bash
claude
```

Claude should automatically:
1. Read the skills
2. Check if today's work log exists
3. Create it if missing
4. Ask for today's goals

---

## Customization

### Changing Folder Names

If you prefer English folder names, edit the skill files:

**In `documentation-enforcer.md`**, replace:
```
docs/开发日志/ → docs/dev-logs/
docs/架构设计/ → docs/architecture/
docs/测试文档/ → docs/tests/
docs/问题排查/ → docs/troubleshooting/
```

**Then create the folders**:
```bash
mkdir -p docs/{architecture,dev-logs,tests,troubleshooting}
```

### Changing Naming Conventions

Edit the skill files to change date formats or naming patterns:

```markdown
# Default
YYYY-MM-DD-description.md

# European format
DD-MM-YYYY-description.md

# US format
MM-DD-YYYY-description.md

# Compact
YYYYMMDD-description.md
```

### Language Adaptation

The skills are written in English but can be adapted to any language. Simply translate the skill files while keeping the structure intact.

---

## Verification Checklist

After installation, verify:

- [ ] `.claude/skills/documentation-enforcer.md` exists
- [ ] `.claude/skills/code-structure-enforcer.md` exists
- [ ] `docs/` folder structure created
- [ ] `docs/progress.md` initialized
- [ ] `docs/task_plan.md` initialized
- [ ] `docs/findings.md` initialized
- [ ] Claude Code reads skills at session start
- [ ] Today's work log auto-created

---

## Troubleshooting

### Skills Not Being Read

**Problem**: Claude doesn't seem to follow the skills

**Solutions**:
1. Check file location: Must be in `.claude/skills/`
2. Check file extension: Must be `.md`
3. Restart Claude Code session
4. Verify `CLAUDE.md` references the skills (optional but helpful)

### Work Log Not Auto-Created

**Problem**: Daily work log not created automatically

**Solutions**:
1. Check `docs/dev-logs/` folder exists
2. Manually remind Claude: "Create today's work log"
3. Check skill file for correct folder path

### Wrong Folder Names

**Problem**: Skills reference Chinese folder names but you want English

**Solutions**:
1. Edit skill files to change folder names
2. Create folders with your preferred names
3. Update all references consistently

---

## Next Steps

After installation:

1. **Start your first session**
   ```bash
   claude
   ```

2. **Set today's goals**
   - Claude will ask for your goals
   - List 2-3 specific tasks

3. **Work normally**
   - Claude will follow the skills automatically
   - Documentation will be created with correct naming
   - Code changes will follow structure rules

4. **End session**
   - Claude will update all tracking documents
   - Review today's work log

---

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/shaobaolu/claude-project-management-skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/shaobaolu/claude-project-management-skills/discussions)
- **Examples**: See `examples/` folder

---

**Installation complete!** 🎉

Your project now has automated documentation management and code structure enforcement.
