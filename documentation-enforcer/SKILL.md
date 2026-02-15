# Documentation Enforcer

> Automatic documentation management with strict naming conventions and templates

## Description

Enforces consistent documentation standards across AI sessions, preventing the chaos that occurs when multiple conversations create documents with different naming conventions and structures.

**Key Features:**
- Auto-creates daily work logs at session start
- Enforces `YYYY-MM-DD-description.md` naming format
- Provides standardized templates for work logs, tests, and architecture docs
- Updates progress tracking at session end
- Maintains cross-session memory through structured logs

**Best For:**
- Long-term projects with daily development
- Teams using multiple AI tools
- Projects requiring detailed change tracking
- Non-technical stakeholders needing clear progress reports

---

## Core Rules

### Rule 1: Session Start Procedure

**Every session start, AI must:**

1. **Read recent progress**
   ```bash
   # Read these files to understand context
   - docs/progress.md
   - docs/task_plan.md
   - docs/findings.md
   ```

2. **Check if today's work log exists**
   ```bash
   # Check for file
   docs/dev-logs/YYYY-MM-DD-work-log.md

   # If not exists, create immediately
   ```

3. **Confirm today's goals with user**
   ```
   What are today's goals?
   - [ ] Goal 1
   - [ ] Goal 2
   ```

---

### Rule 2: Session End Procedure

**Before session ends, AI must:**

1. **Update today's work log**
   - Completed work
   - Modified files
   - Issues encountered
   - Test results
   - Tomorrow's plan

2. **Update progress.md**
   ```markdown
   # Add new entry at the top
   ## YYYY-MM-DD HH:mm - Session Summary

   ### Completed
   - Work 1
   - Work 2

   ### Next Steps
   - Plan 1
   ```

3. **Update task_plan.md**
   - Mark completed tasks as [completed]
   - Add newly discovered tasks

4. **Update findings.md if important discoveries**
   ```markdown
   ## YYYY-MM-DD - Issue Title

   ### Description
   [Description]

   ### Root Cause
   [Cause]

   ### Solution
   [Solution]
   ```

---

### Rule 3: File Naming Conventions

#### Development Logs
**Location**: `docs/dev-logs/`

**Format**: `YYYY-MM-DD-work-log.md`

**Examples**:
- ✅ `2026-02-15-work-log.md`
- ❌ `work-log_2026-02-15.md`
- ❌ `work-log.md`

#### Test Documentation
**Location**: `docs/tests/`

**Format**: `YYYY-MM-DD-test-name.md`

**Examples**:
- ✅ `2026-02-15-algorithm-test.md`
- ✅ `2026-02-15-e2e-test-results.md`
- ❌ `test_results.md`

#### Architecture Documents
**Location**: `docs/architecture/`

**Format**: `topic-version.md` or `ADR-NNN-title.md`

**Examples**:
- ✅ `matching-system-v2.0.md`
- ✅ `ADR-001-matching-algorithm.md`
- ❌ `architecture.md`

#### Troubleshooting Documents
**Location**: `docs/troubleshooting/`

**Format**: `issue-description-YYYY-MM-DD.md`

**Examples**:
- ✅ `scoring-logic-issue-2026-02-14.md`
- ✅ `api-error-analysis-2026-02-15.md`
- ❌ `bug_fix.md`

---

### Rule 4: Forbidden Operations

#### ❌ Absolutely Forbidden

1. **Creating documents in root directory**
   ```
   ❌ /project-root/work-log.md
   ✅ /project-root/docs/dev-logs/2026-02-15-work-log.md
   ```

2. **Using non-standard naming**
   ```
   ❌ test.md
   ❌ new_document.md
   ❌ temp_notes.md
   ❌ document1.md
   ```

3. **Creating duplicate documents**
   ```
   ❌ Both work-log.md and work_log.md exist
   ❌ Both test_results.md and test-results.md exist
   ```

4. **Creating documents in wrong location**
   ```
   ❌ Test docs in architecture/
   ❌ Work logs in tests/
   ```

---

### Rule 5: Document Content Standards

#### Required Metadata

```markdown
# Document Title

**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD
**Author**: Claude Code
**Status**: [Draft/In Progress/Completed/Archived]

---

[Document content]
```

#### Work Log Template

```markdown
# YYYY-MM-DD Work Log

**Date**: YYYY-MM-DD
**Session Time**: HH:mm - HH:mm

---

## 📋 Today's Goals

- [ ] Goal 1
- [ ] Goal 2
- [ ] Goal 3

---

## ✅ Completed Work

### 1. Work Item 1
**Time**: HH:mm - HH:mm
**Description**: [Detailed description]
**Modified Files**:
- `file/path` - Change description

### 2. Work Item 2
**Time**: HH:mm - HH:mm
**Description**: [Detailed description]

---

## 🧪 Test Results

### Test 1: [Test Name]
**Time**: HH:mm
**Result**: ✅ Passed / ❌ Failed
**Details**: [Test details]

---

## 🐛 Issues Encountered

### Issue 1: [Issue Title]
**Discovered**: HH:mm
**Description**: [Description]
**Root Cause**: [Cause]
**Solution**: [Solution]
**Resolved**: HH:mm
**Status**: ✅ Resolved / 🔄 In Progress / ⏸️ Pending

---

## 💡 Important Findings

- Finding 1
- Finding 2

---

## 📊 Technical Decisions

### Decision 1: [Decision Title]
**Context**: [Why this decision was needed]
**Options**:
- Option A: [Pros/Cons]
- Option B: [Pros/Cons]
**Final Decision**: [Chosen approach]
**Rationale**: [Why this approach]

---

## 📝 Tomorrow's Plan

- [ ] Plan 1
- [ ] Plan 2
- [ ] Plan 3

---

## 📎 Related Documents

- [Related Doc 1](path)
- [Related Doc 2](path)
```

#### Test Document Template

```markdown
# YYYY-MM-DD [Test Name]

**Test Date**: YYYY-MM-DD
**Tester**: Claude Code
**Test Type**: [Unit/Integration/E2E/Performance]
**Status**: ✅ Passed / ❌ Failed / 🔄 In Progress

---

## Test Objective

[Describe what this test validates]

---

## Test Environment

- **Node Version**: vX.X.X
- **Database**: [Database info]
- **Test Data**: [Test data description]

---

## Test Cases

### Case 1: [Case Name]
**Input**: [Input data]
**Expected Output**: [Expected result]
**Actual Output**: [Actual result]
**Status**: ✅ Passed / ❌ Failed

### Case 2: [Case Name]
[Same as above]

---

## Test Results Summary

| Test Item | Status | Notes |
|-----------|--------|-------|
| Test 1    | ✅     | -     |
| Test 2    | ❌     | [Issue description] |

---

## Issues Found

### Issue 1: [Issue Title]
**Severity**: 🔴 High / 🟡 Medium / 🟢 Low
**Description**: [Description]
**Reproduction Steps**: [Steps]
**Solution**: [Solution]

---

## Improvement Suggestions

- Suggestion 1
- Suggestion 2

---

## Related Documents

- [Related Doc 1](path)
```

---

## AI Execution Flow

### At Session Start

```
1. Read docs/progress.md
2. Read docs/task_plan.md
3. Read docs/findings.md
4. Check if today's work log exists
   - If not, create docs/dev-logs/YYYY-MM-DD-work-log.md
5. Confirm today's goals with user
```

### When Creating Documents

```
1. Determine document type (work log/test/architecture/troubleshooting)
2. Determine location (corresponding docs/ subfolder)
3. Use standard naming format
4. Use corresponding template
5. Fill in metadata (date, author, status)
```

### At Session End

```
1. Update today's work log
   - Completed work
   - Modified files
   - Issues encountered
   - Test results
   - Tomorrow's plan
2. Update docs/progress.md (add new entry at top)
3. Update docs/task_plan.md (update task status)
4. If important findings, update docs/findings.md
5. Remind user to check today's work log
```

---

## Document Structure Overview

```
docs/
├── README.md                    # Documentation navigation
├── architecture/                # Architecture, design, ADRs
│   ├── [topic]-v[version].md
│   ├── ADR-NNN-[title].md
│   └── [topic]-YYYY-MM-DD.md
├── dev-logs/                    # Daily work logs, changelogs
│   ├── YYYY-MM-DD-work-log.md  # Must use date naming
│   ├── YYYY-MM.md              # Monthly changelog
│   └── ...
├── tests/                       # Test records
│   ├── YYYY-MM-DD-[test-name].md
│   └── ...
├── troubleshooting/             # Problem analysis, guides
│   ├── [issue]-YYYY-MM-DD.md
│   └── ...
├── findings.md                  # Problems & solutions summary
├── progress.md                  # Session history (newest first)
└── task_plan.md                 # Task tracking
```

---

## Common Errors and Corrections

### Error 1: Creating documents in root

```
❌ Wrong:
/project-root/work-log.md

✅ Correct:
/project-root/docs/dev-logs/2026-02-15-work-log.md
```

### Error 2: Non-standard naming

```
❌ Wrong:
test.md
new_document.md
temp_notes.md

✅ Correct:
2026-02-15-algorithm-test.md
2026-02-15-work-log.md
scoring-system-2026-02-14.md
```

### Error 3: Wrong location

```
❌ Wrong:
docs/architecture/2026-02-15-test-results.md

✅ Correct:
docs/tests/2026-02-15-test-results.md
```

### Error 4: Not updating work log

```
❌ Wrong:
Session ends without updating today's work log

✅ Correct:
Must update docs/dev-logs/YYYY-MM-DD-work-log.md before session ends
```

---

## Execution Priority

### P0 (Must Execute)
1. Read context at session start
2. Check/create today's work log at session start
3. Update today's work log at session end
4. All documents must use standard naming
5. All documents must be in correct location

### P1 (Strongly Recommended)
1. Update progress.md at session end
2. Update task_plan.md at session end
3. Update findings.md for important discoveries
4. Use document templates

### P2 (Recommended)
1. Include complete metadata in documents
2. Periodically archive old documents

---

## Customization

### Folder Names

Default folder names can be customized. Edit these paths throughout the skill:

```
docs/dev-logs/       → Your preferred name
docs/architecture/   → Your preferred name
docs/tests/          → Your preferred name
docs/troubleshooting/ → Your preferred name
```

### Templates

All templates can be customized to match your team's needs. Modify the template sections above.

### Naming Conventions

The `YYYY-MM-DD` format is recommended but can be changed to:
- `DD-MM-YYYY` (European format)
- `MM-DD-YYYY` (US format)
- `YYYYMMDD` (Compact format)

---

## Related Skills

- `code-structure-enforcer` - Code file organization
- `requirement-clarifier` - Requirements analysis
- `health-checker` - System health validation

---

**Skill Version**: v1.0
**Created**: 2026-02-15
**Last Updated**: 2026-02-15
**Compatibility**: Claude Code 2.0+
