# Release Notes v2.0.0

**Release Date**: 2026-02-15
**Type**: Major Release
**Status**: Stable

---

## 🎉 What's New in v2.0

This is a **major release** introducing 5 new advanced Skills focused on **testing automation** and **requirement management**. These Skills solve critical problems in long-term AI-assisted development projects.

---

## 🆕 New Skills (5)

### 1. Requirement Sync Manager (8.9K)
**Problem Solved**: PRD fragmentation - AI creates new requirement documents instead of updating the main PRD.

**Features**:
- ✅ Enforces Single Source of Truth for requirements
- ✅ Detects requirement changes automatically
- ✅ Forces updates to PRD-主文档.md
- ✅ Creates change records with version history
- ✅ Notifies test-case-sync-engine automatically

**Use Case**:
```
User reports bug → AI fixes it → requirement-sync-manager detects behavior change
→ Forces PRD update → Creates change record → Notifies test engine
```

---

### 2. Test Case Sync Engine (8.0K)
**Problem Solved**: Manual test case creation - developers forget to write tests for new requirements.

**Features**:
- ✅ Three-layer automatic test case generation:
  - Layer 1: PRD-based initial test cases
  - Layer 2: Code-change-based regression tests
  - Layer 3: Bug-fix-based defensive tests
- ✅ Automatic linking to PRD requirements
- ✅ Maintains test-cases-master.json
- ✅ JSON format for easy maintenance

**Use Case**:
```
PRD updated → test-case-sync-engine triggered → Generates test cases
→ Links to requirements → Updates test-cases-master.json
```

---

### 3. Test Automation Engine (11K)
**Problem Solved**: 40+ individual test scripts are hard to maintain and slow to run.

**Features**:
- ✅ Smart test identification based on code changes
- ✅ Parallel test execution (configurable max workers)
- ✅ Automatic report generation with performance comparison
- ✅ Retry logic for flaky tests
- ✅ Snapshot-based performance tracking

**Use Case**:
```
Code changed in lib/matching/ → test-automation-engine identifies relevant tests
→ Runs tests in parallel → Generates report → Compares with baseline
```

---

### 4. Database Health Monitor (9.4K)
**Problem Solved**: Database records accumulate, performance degrades, manual cleanup forgotten.

**Features**:
- ✅ Weekly automatic health checks
- ✅ Automatic cleanup of 30-day-old records
- ✅ Performance monitoring and alerts
- ✅ Integration with existing maintenance scripts
- ✅ Scheduled execution support

**Use Case**:
```
Weekly trigger → database-health-monitor runs checks → Cleans old records
→ Monitors performance → Generates health report
```

---

### 5. Documentation Enforcer v2 (15K) - Upgraded
**What's New in v2**:
- ✅ Prevents isolated document creation
- ✅ Forces document linking to main documents
- ✅ Automatic consistency checking
- ✅ Collaboration with requirement-sync-manager

**New Features**:
```markdown
AI wants to create new document → documentation-enforcer-v2 intercepts
→ Checks document type → Calls appropriate Skill → Ensures proper linking
```

---

## 🔄 Skill Coordination

These Skills work together as a system:

```
requirement-sync-manager → test-case-sync-engine → test-automation-engine
         ↓                           ↓                        ↓
   PRD updated              Test cases generated        Tests executed
         ↓                           ↓                        ↓
documentation-enforcer-v2 ← Ensures consistency → database-health-monitor
```

---

## 📊 Impact

### Before v2.0
- ❌ Requirements scattered across multiple documents
- ❌ Manual test case creation (often forgotten)
- ❌ 40+ test scripts to maintain individually
- ❌ Database cleanup done manually (often forgotten)
- ❌ No automatic consistency checking

### After v2.0
- ✅ Single Source of Truth for requirements (PRD-主文档.md)
- ✅ Automatic test case generation from requirements
- ✅ Unified test engine with intelligent execution
- ✅ Automatic database maintenance
- ✅ Automatic consistency checking across all documents

---

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/carrielabs/claude-project-management-skills.git

# Copy all Skills to your project
mkdir -p your-project/.claude/skills
cp claude-project-management-skills/*.md your-project/.claude/skills/

# Or install globally
cp claude-project-management-skills/*.md ~/.claude/skills/
```

### Configuration

1. **Create test configuration** (for test automation):
   ```bash
   mkdir -p tests/test-cases tests/test-engine tests/test-data tests/snapshots
   ```

2. **Create test-config.json**:
   ```json
   {
     "version": "1.0",
     "autoGenerateTestCases": true,
     "requireUserApproval": true,
     "parallelExecution": true,
     "maxParallelTests": 5
   }
   ```

3. **Create PRD document** (for requirement sync):
   ```bash
   mkdir -p docs/需求文档
   # Create docs/需求文档/PRD-主文档.md
   ```

---

## 📋 Migration Guide

### From v1.0 to v2.0

**No Breaking Changes** - v2.0 is fully backward compatible with v1.0.

**New Skills are Optional** - You can use only the Skills you need:
- Use `requirement-sync-manager` if you have requirement fragmentation issues
- Use `test-case-sync-engine` + `test-automation-engine` if you have testing issues
- Use `database-health-monitor` if you have database maintenance issues

**Recommended Setup**:
1. Keep using `documentation-enforcer` and `code-structure-enforcer` (v1.0)
2. Add `requirement-sync-manager` if you manage requirements
3. Add testing Skills if you have 10+ test scripts
4. Add `database-health-monitor` if you have a database

---

## 🐛 Bug Fixes

- Fixed: documentation-enforcer now properly handles Chinese folder names
- Fixed: Path references updated to work with non-numbered folder structure

---

## 📚 Documentation

- Updated README.md with all 6 Skills
- Added detailed use cases for each Skill
- Added Skill coordination diagram
- Added migration guide

---

## 🙏 Acknowledgments

These Skills were developed based on real-world pain points encountered in a production job-matching system project:
- **PRD fragmentation**: AI kept creating new requirement docs instead of updating the main one
- **Test maintenance**: 40+ test scripts became unmaintainable
- **Database bloat**: Match records accumulated to 1000+ entries
- **Requirement-test sync**: Requirements changed but tests didn't update

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/carrielabs/claude-project-management-skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/carrielabs/claude-project-management-skills/discussions)

---

## 🔗 Links

- **Repository**: https://github.com/carrielabs/claude-project-management-skills
- **v1.0.0 Release**: [Release Notes](RELEASE_NOTES_v1.0.0.md)
- **Installation Guide**: [INSTALLATION.md](INSTALLATION.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)

---

**Made with ❤️ for developers building complex AI-assisted projects**
