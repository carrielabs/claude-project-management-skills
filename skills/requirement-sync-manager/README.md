# Requirement Sync Manager

> Enforces Single Source of Truth for requirements - prevents PRD fragmentation

## 📖 Overview

Requirement Sync Manager automatically detects requirement changes and forces updates to the main PRD document, preventing the chaos of scattered requirement documents.

## 🎯 Problem Solved

**The Problem**: AI creates new requirement documents instead of updating the main PRD when requirements change.

**Example**:
```
User reports bug → AI fixes it → Creates "bug-fix-notes.md"
Result: Requirements scattered across multiple files ❌
```

**With This Skill**:
```
User reports bug → AI fixes it → requirement-sync-manager detects change
→ Forces PRD update → Creates change record → Links to main PRD ✅
```

## ✅ Features

- Detects requirement changes automatically
- Forces updates to PRD-主文档.md (main PRD)
- Creates change records with version history
- Notifies test-case-sync-engine automatically
- Prevents isolated requirement documents

## 🚀 Installation

### Quick Install (Global)
```bash
curl -o ~/.claude/skills/requirement-sync-manager.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/requirement-sync-manager/SKILL.md
```

### Project-Specific Install
```bash
mkdir -p .claude/skills
curl -o .claude/skills/requirement-sync-manager.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/requirement-sync-manager/SKILL.md
```

## 📋 Usage

### Automatic Trigger

The skill automatically triggers when:
- User reports a bug that changes behavior
- User requests a feature addition
- User modifies existing requirements
- AI detects behavior changes in code

### Workflow

```
1. Detects requirement change
   ↓
2. Prompts user for confirmation
   ↓
3. Updates PRD-主文档.md
   ↓
4. Creates change record in 需求变更历史/
   ↓
5. Notifies test-case-sync-engine
   ↓
6. Updates changelog.md
```

## 📁 Required Structure

```
docs/
└── 需求文档/
    ├── PRD-主文档.md           # Main PRD (Single Source of Truth)
    └── 需求变更历史/            # Change history
        └── YYYY-MM-DD-变更标题.md
```

## 🔧 Configuration

Create `.claude/config/requirement-sync.json`:

```json
{
  "mode": "prompt",
  "strictMode": true,
  "autoNotifyTestSync": true,
  "requireChangeReason": true,
  "prdPath": "docs/需求文档/PRD-主文档.md",
  "changeHistoryPath": "docs/需求文档/需求变更历史/",
  "changelogPath": "docs/变更日志/changelog.md"
}
```

## 📚 Example

### Before (Without Skill)
```
docs/
├── requirements.md
├── bug-fix-notes.md
├── feature-ideas.md
└── changes-2026-02-15.md
```
❌ Requirements scattered everywhere!

### After (With Skill)
```
docs/
└── 需求文档/
    ├── PRD-主文档.md           # ✅ Single Source of Truth
    └── 需求变更历史/
        └── 2026-02-15-禁用软技能匹配.md
```
✅ All requirements in one place!

## 🤝 Integration

Works with:
- **documentation-enforcer-v2** - Prevents isolated documents
- **test-case-sync-engine** - Auto-generates tests for requirement changes

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/carrielabs/claude-project-management-skills/issues)
- **Main Repository**: [claude-project-management-skills](https://github.com/carrielabs/claude-project-management-skills)

## 📄 License

MIT License

---

**Version**: 1.0.0
**Last Updated**: 2026-02-15
**Compatibility**: Claude Code 2.0+
