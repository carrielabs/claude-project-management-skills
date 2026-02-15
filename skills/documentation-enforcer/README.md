# Documentation Enforcer v2

> Automatic documentation management with strict naming conventions and cross-session memory

## 📖 Overview

Documentation Enforcer automatically manages project documentation, enforces naming standards, and maintains cross-session memory. Version 2 adds isolation prevention and automatic consistency checking.

## 🎯 Problems Solved

- ❌ Documentation scattered everywhere with inconsistent naming
- ❌ Can't find yesterday's work log or test results
- ❌ Each AI session creates documents differently
- ❌ Isolated documents not linked to main documents
- ❌ No consistency checking across documents

## ✅ Features

### Core Features (v1.0)
- Auto-creates daily work logs at session start
- Enforces `YYYY-MM-DD-description.md` naming format
- Provides standardized templates for different document types
- Updates progress tracking at session end
- Maintains cross-session memory through structured logs

### New in v2.0
- **Prevents isolated document creation** - Forces linking to main documents
- **Automatic consistency checking** - Detects orphaned documents
- **Skill coordination** - Works with requirement-sync-manager and test-case-sync-engine

## 🚀 Installation

### Quick Install (Global)
```bash
curl -o ~/.claude/skills/documentation-enforcer.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/documentation-enforcer/SKILL.md
```

### Project-Specific Install
```bash
mkdir -p .claude/skills
curl -o .claude/skills/documentation-enforcer.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/documentation-enforcer/SKILL.md
```

### Manual Install
1. Download [SKILL.md](SKILL.md)
2. Copy to `~/.claude/skills/documentation-enforcer.md` (global) or `.claude/skills/documentation-enforcer.md` (project)

## 📋 Usage

### Automatic Execution

**At Session Start:**
- Reads project context (progress.md, task_plan.md, findings.md)
- Checks if today's work log exists
- Creates it if missing
- Asks for today's goals

**During Development:**
- Enforces naming conventions for new documents
- Prevents creation of isolated documents
- Guides proper file organization

**At Session End:**
- Updates today's work log
- Updates progress tracking
- Records important findings
- Plans next steps

### Manual Trigger

If AI doesn't auto-execute, you can trigger it:
```
"Check documentation structure"
"Create today's work log"
"Update progress"
```

## 📁 Document Structure

After installation, your `docs/` folder will follow this structure:

```
docs/
├── 需求文档/              # Requirements
├── 架构设计/              # Architecture
├── 开发日志/              # Development Logs
│   ├── 2026-02-15-工作日志.md
│   └── 2026-02-14-工作日志.md
├── 测试文档/              # Test Documentation
├── 问题排查/              # Troubleshooting
└── 项目管理/              # Project Management
    ├── progress.md
    ├── task_plan.md
    └── findings.md
```

## 🔧 Configuration

Add to your `.claude/CLAUDE.md` for automatic execution:

```markdown
## 📝 会话开始时必须执行（Documentation Enforcer）

**每次会话开始时，AI 必须自动执行以下步骤**:

1. 读取上下文 (progress.md, task_plan.md, findings.md)
2. 检查/创建今天的工作日志
3. 向用户确认今天的工作目标
```

## 📚 Examples

### Example: Daily Work Log

```markdown
# 2026-02-15 工作日志

**日期**: 2026-02-15
**会话时间**: 09:00 - 12:00

## 📋 今日目标
- [x] 重构匹配算法
- [x] 添加单元测试
- [ ] 部署到测试环境

## ✅ 完成的工作

### 1. 重构匹配算法
**时间**: 09:00 - 11:00
**描述**: 提升准确率从 85% 到 95%
**修改文件**:
- `lib/matching/matcher.ts` - 完全重写
- `lib/matching/score_calculator.ts` - 更新评分逻辑

## 🧪 测试记录
- 单元测试: ✅ 45/45 通过
- 集成测试: ✅ 12/12 通过

## 📝 明天计划
- [ ] 部署到测试环境
- [ ] 监控性能指标
```

## 🤝 Integration

Works seamlessly with:
- **requirement-sync-manager** - Prevents isolated requirement documents
- **test-case-sync-engine** - Ensures test documentation is linked
- **code-structure-enforcer** - Coordinates code and doc organization

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/carrielabs/claude-project-management-skills/issues)
- **Main Repository**: [claude-project-management-skills](https://github.com/carrielabs/claude-project-management-skills)

## 📄 License

MIT License - See [LICENSE](../../LICENSE) for details

---

**Version**: 2.0.0
**Last Updated**: 2026-02-15
**Compatibility**: Claude Code 2.0+
