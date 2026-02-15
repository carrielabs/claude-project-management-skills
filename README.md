# Claude Project Management Skills

> Professional documentation and code structure enforcement skills for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-blue.svg)](https://github.com/anthropics/claude-code)

## 📖 Overview

A collection of Claude Code skills designed to maintain clean, organized, and professional project structures across development sessions. These skills automatically enforce documentation standards and code organization rules, preventing the chaos that often occurs when working with AI assistants across multiple sessions.

## 🎯 Problems These Skills Solve

### Without These Skills
- 📄 Documentation scattered everywhere with inconsistent naming
- 🗂️ Can't find yesterday's work log or test results
- 💾 Old code files mixed with new implementations
- 🔄 Each AI session creates documents differently
- ❌ Accidentally modifying deprecated code
- 📅 No clear version history or change tracking

### With These Skills
- ✅ Automatic daily work logs with standardized naming (`YYYY-MM-DD-work-log.md`)
- ✅ Clear separation of active, deprecated, and experimental code
- ✅ Consistent documentation structure across all sessions
- ✅ Automatic session start/end procedures
- ✅ Prevention of accidental modifications to old code
- ✅ Complete change tracking and decision records

## 📦 Included Skills

### Core Skills (v1.0)

#### 1. Documentation Enforcer v2
Automatically manages project documentation with strict naming conventions and templates.

**Features:**
- Auto-creates daily work logs at session start
- Enforces `YYYY-MM-DD-description.md` naming format
- Provides standardized templates for different document types
- Updates progress tracking at session end
- Maintains cross-session memory through structured logs
- **v2 New**: Prevents isolated document creation
- **v2 New**: Forces document linking to main documents
- **v2 New**: Automatic consistency checking

**Use Cases:**
- Long-term projects with daily development
- Teams using multiple AI tools (Claude, Cursor, etc.)
- Projects requiring detailed change tracking
- Non-technical stakeholders needing clear progress reports

#### 2. Code Structure Enforcer
Prevents code chaos by enforcing clear file naming and organization rules.

**Features:**
- Clear naming conventions for active/deprecated/experimental code
- Automatic deprecation workflow with reason tracking
- Prevention of accidental old code modifications
- Version management for A/B testing scenarios
- Standardized file header comments

**Use Cases:**
- Refactoring projects with multiple implementation attempts
- Experimental feature development
- Legacy code migration
- Projects with frequent algorithm changes

---

### Advanced Skills (v2.0) 🆕

#### 3. Requirement Sync Manager
Enforces Single Source of Truth for requirements - prevents PRD fragmentation.

**Features:**
- Detects requirement changes automatically
- Forces updates to PRD-主文档.md (main PRD document)
- Creates change records with version history
- Notifies test-case-sync-engine automatically
- Prevents isolated requirement documents

**Use Cases:**
- Projects with evolving requirements
- Bug fixes that change original behavior
- Feature additions and modifications
- Teams struggling with scattered requirement docs

**Why You Need This:**
- Prevents "requirement document chaos" where changes are recorded in random files
- Ensures all team members see the same requirements
- Automatically links requirements to test cases

#### 4. Test Case Sync Engine
Automatically generates and syncs test cases based on requirement changes.

**Features:**
- Three-layer test case generation:
  - Layer 1: PRD-based initial test cases
  - Layer 2: Code-change-based regression tests
  - Layer 3: Bug-fix-based defensive tests
- Automatic linking to PRD requirements
- Maintains test-cases-master.json
- Supports parallel test execution

**Use Cases:**
- Projects with 40+ manual test scripts
- Teams struggling with test case maintenance
- Requirement changes that need immediate test coverage
- Automated testing pipelines

**Why You Need This:**
- Eliminates manual test case creation
- Ensures every requirement has corresponding tests
- Automatically updates tests when requirements change

#### 5. Test Automation Engine
Intelligent test automation engine that replaces manual test scripts.

**Features:**
- Smart test identification based on code changes
- Parallel test execution (configurable max workers)
- Automatic report generation with performance comparison
- Retry logic for flaky tests (AI extraction, network calls)
- Snapshot-based performance tracking

**Use Cases:**
- Projects with 40+ individual test scripts
- Teams needing faster test execution
- CI/CD pipelines requiring intelligent test selection
- Performance regression detection

**Why You Need This:**
- Replaces 40+ scripts with unified engine
- Runs only relevant tests based on code changes
- Automatic performance comparison with baselines

#### 6. Database Health Monitor
Automated database maintenance and health monitoring.

**Features:**
- Weekly automatic health checks
- Automatic cleanup of 30-day-old records
- Performance monitoring and alerts
- Integration with existing maintenance scripts
- Scheduled execution support

**Use Cases:**
- Projects with growing database records
- Teams forgetting to run maintenance scripts
- Production databases needing regular cleanup
- Performance degradation prevention

**Why You Need This:**
- Prevents database bloat automatically
- No more manual maintenance reminders
- Catches performance issues early

## 🚀 Quick Start

### Installation

#### Option 1: Using Installation Script (Recommended)

```bash
# Clone this repository
git clone https://github.com/carrielabs/claude-project-management-skills.git
cd claude-project-management-skills

# Install all skills globally
./install.sh --global --all

# Or install specific skills
./install.sh --global requirement-sync-manager test-case-sync-engine

# Or install to project
./install.sh --project documentation-enforcer
```

#### Option 2: Manual Installation

**Install Single Skill:**
```bash
# Global installation (available in all projects)
curl -o ~/.claude/skills/requirement-sync-manager.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/requirement-sync-manager/SKILL.md

# Project installation (only in current project)
mkdir -p .claude/skills
curl -o .claude/skills/requirement-sync-manager.md \
  https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills/requirement-sync-manager/SKILL.md
```

**Install All Skills:**
```bash
# Clone and copy all
git clone https://github.com/carrielabs/claude-project-management-skills.git
cp claude-project-management-skills/skills/*/SKILL.md ~/.claude/skills/
```

### Setup

1. **Create project documentation structure:**
   ```bash
   mkdir -p docs/{需求文档,架构设计,开发日志,测试文档,问题排查,项目管理}
   touch docs/项目管理/{progress.md,task_plan.md,findings.md}
   ```

2. **Create test structure** (for testing skills):
   ```bash
   mkdir -p tests/{test-cases,test-engine,test-data,snapshots}
   ```

3. **Add to your CLAUDE.md** (optional but recommended):
   ```markdown
   ## 📝 Documentation Rules
   See `.claude/skills/documentation-enforcer.md` for complete documentation standards.

   ## 📋 Requirement Management
   See `.claude/skills/requirement-sync-manager.md` for requirement sync rules.
   ```

### Usage

Once installed, these skills work automatically:

**At Session Start:**
- Claude reads your project context
- Checks if today's work log exists
- Creates it if missing
- Asks for today's goals

**During Development:**
- Enforces naming conventions for new documents
- Prevents modification of deprecated code
- Guides proper file organization

**At Session End:**
- Updates today's work log
- Updates progress tracking
- Records important findings
- Plans next steps

## 📋 Documentation Structure

After installation, your `docs/` folder will follow this structure:

```
docs/
├── 架构设计/              # Architecture & Design
│   ├── system-design-v2.0.md
│   └── ADR-001-matching-algorithm.md
├── 开发日志/              # Development Logs
│   ├── 2026-02-15-work-log.md
│   ├── 2026-02-14-work-log.md
│   └── 2026-02.md         # Monthly changelog
├── 测试文档/              # Test Documentation
│   ├── 2026-02-15-algorithm-test.md
│   └── 2026-02-14-e2e-test.md
├── 问题排查/              # Troubleshooting
│   ├── scoring-issue-2026-02-14.md
│   └── api-error-analysis-2026-02-15.md
├── progress.md            # Session history (newest first)
├── task_plan.md           # Task tracking
└── findings.md            # Problems & solutions
```

## 💾 Code Structure

Your code will be organized with clear version indicators:

```
lib/
├── matching/
│   ├── matcher.ts                    # ✅ Current active
│   ├── score_calculator.ts           # ✅ Current active
│   ├── _experimental_ai_matcher.ts   # 🧪 Testing
│   └── _deprecated/                  # 🗑️ Old code
│       ├── README.md                 # Deprecation reasons
│       └── _deprecated_2026-02-15_old_matcher.ts
```

## 📚 Examples

### Example 1: Daily Work Log

```markdown
# 2026-02-15 Work Log

**Date**: 2026-02-15
**Session Time**: 09:00 - 12:00

## 📋 Today's Goals
- [x] Refactor matching algorithm
- [x] Add unit tests
- [ ] Deploy to staging

## ✅ Completed Work

### 1. Refactored Matching Algorithm
**Time**: 09:00 - 11:00
**Description**: Improved accuracy from 85% to 95%
**Modified Files**:
- `lib/matching/matcher.ts` - Complete rewrite
- `lib/matching/score_calculator.ts` - Updated scoring logic

## 🧪 Test Results
- Unit tests: ✅ 45/45 passed
- Integration tests: ✅ 12/12 passed

## 🐛 Issues Encountered
None

## 📝 Tomorrow's Plan
- [ ] Deploy to staging
- [ ] Monitor performance metrics
```

### Example 2: Deprecating Old Code

```bash
# Old matcher is being replaced
mv lib/matching/old_matcher.ts \
   lib/matching/_deprecated/_deprecated_2026-02-15_old_matcher.ts

# Document why it was deprecated
echo "## _deprecated_2026-02-15_old_matcher.ts
**Deprecated**: 2026-02-15
**Reason**: Accuracy only 85%, new version achieves 95%
**Replacement**: matcher.ts
**Docs**: docs/架构设计/ADR-005-matching-refactor.md" \
> lib/matching/_deprecated/README.md
```

## 🎨 Customization

### Adapting to Your Language

The default folder names are in Chinese. To use English:

1. Edit the skill files:
   ```bash
   # In documentation-enforcer.md, replace:
   docs/开发日志/ → docs/dev-logs/
   docs/架构设计/ → docs/architecture/
   docs/测试文档/ → docs/tests/
   docs/问题排查/ → docs/troubleshooting/
   ```

2. Update your folder structure accordingly

### Adapting to Your Workflow

Both skills are highly customizable. Edit the `.md` files to:
- Change naming conventions
- Modify templates
- Add/remove document types
- Adjust automation rules

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Test your changes in a real project
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by real-world pain points in long-term AI-assisted development
- Built for the [Claude Code](https://github.com/anthropics/claude-code) ecosystem
- Thanks to the Anthropic team for creating such a powerful tool

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/shaobaolu/claude-project-management-skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/shaobaolu/claude-project-management-skills/discussions)

## 🔗 Related Resources

- [Claude Code Documentation](https://github.com/anthropics/claude-code)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)
- [Awesome Claude Skills](https://github.com/ComposioHQ/awesome-claude-skills)

---

**Made with ❤️ for developers tired of documentation chaos**
