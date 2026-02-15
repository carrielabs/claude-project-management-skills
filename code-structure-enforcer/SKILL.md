# Code Structure Enforcer

> Prevent code chaos with clear file naming and organization rules

## Description

Enforces clear code file organization to prevent confusion between active, deprecated, and experimental code. Stops AI from accidentally modifying old implementations when new versions exist.

**Key Features:**
- Clear naming conventions for active/deprecated/experimental code
- Automatic deprecation workflow with reason tracking
- Prevention of accidental old code modifications
- Version management for A/B testing scenarios
- Standardized file header comments

**Best For:**
- Refactoring projects with multiple implementation attempts
- Experimental feature development
- Legacy code migration
- Projects with frequent algorithm changes

---

## Core Rules

### Rule 1: File Naming Conventions

#### Active Files (Currently in use)
**Format**: `feature_name.ts` or `feature_name_v2.ts`

**Examples**:
- ✅ `matcher.ts` - Current matcher
- ✅ `skill_matcher_v2.ts` - Version 2 skill matcher (current)
- ✅ `score_calculator.ts` - Score calculator

#### Deprecated Files (No longer used)
**Format**: `_deprecated_YYYY-MM-DD_original_name.ts`

**Examples**:
- ✅ `_deprecated_2026-02-10_old_matcher.ts`
- ✅ `_deprecated_2026-01-15_skill_matcher_v1.ts`

#### Experimental Files (Testing new approaches)
**Format**: `_experimental_feature_name.ts`

**Examples**:
- ✅ `_experimental_ai_matcher.ts`
- ✅ `_experimental_graph_matcher.ts`

---

### Rule 2: Directory Structure

#### Core Business Logic
**Location**: `lib/`

```
lib/
├── matching/              # Matching algorithms (core)
│   ├── matcher.ts        # Main matcher (active)
│   ├── score_calculator.ts
│   ├── skill_matcher.ts
│   └── _deprecated/      # Deprecated code
│       ├── _deprecated_2026-02-10_old_matcher.ts
│       └── README.md     # Explains why deprecated
├── ai/                   # AI extraction logic (core)
│   ├── extractor.ts
│   └── _deprecated/
└── utils/                # Utility functions
    ├── text_processor.ts
    └── _deprecated/
```

#### API Routes
**Location**: `app/api/` or `src/api/`

```
app/api/
├── jobs/
│   ├── match/
│   │   └── route.ts      # Current match API
│   ├── extract/
│   │   └── route.ts
│   └── _deprecated/
│       └── _deprecated_2026-02-10_old_match_route.ts
└── resume/
    ├── generate/
    │   └── route.ts
    └── _deprecated/
```

#### Components
**Location**: `components/`

```
components/
├── MatchResult.tsx       # Current match result component
├── ScoreDisplay.tsx
└── _deprecated/
    └── _deprecated_2026-02-10_OldMatchResult.tsx
```

---

### Rule 3: Deprecation Workflow

#### Step 1: Mark as Deprecated

When replacing old code:

1. **Rename old file**
   ```bash
   # Old file
   lib/matching/old_matcher.ts

   # Rename to
   lib/matching/_deprecated_2026-02-15_old_matcher.ts
   ```

2. **Move to _deprecated folder**
   ```bash
   mkdir -p lib/matching/_deprecated
   mv lib/matching/_deprecated_2026-02-15_old_matcher.ts lib/matching/_deprecated/
   ```

3. **Create README.md explanation**
   ```markdown
   # Deprecated Code Explanation

   ## _deprecated_2026-02-15_old_matcher.ts

   **Deprecated**: 2026-02-15
   **Reason**: Scoring logic inaccurate, 30% false match rate
   **Replacement**: Use `matcher.ts` (new version)
   **Related Docs**: docs/architecture/ADR-005-matching-refactor.md
   ```

#### Step 2: Update Import References

```typescript
// ❌ Wrong: Still referencing old file
import { match } from './old_matcher'

// ✅ Correct: Reference new file
import { match } from './matcher'
```

#### Step 3: Document the Change

Record in `docs/dev-logs/YYYY-MM-DD-work-log.md`:
```markdown
## Code Changes
- Deprecated `lib/matching/old_matcher.ts`
- Added `lib/matching/matcher.ts`
- Reason: Scoring logic refactor
```

---

### Rule 4: Experimental Code Workflow

#### Creating Experimental Code

```bash
# Create experimental file
lib/matching/_experimental_ai_matcher.ts
```

#### Experiment Succeeds → Promote to Active

```bash
# 1. Deprecate old code
mv lib/matching/matcher.ts lib/matching/_deprecated/
mv lib/matching/_deprecated/matcher.ts lib/matching/_deprecated/_deprecated_2026-02-15_matcher.ts

# 2. Promote experimental code
mv lib/matching/_experimental_ai_matcher.ts lib/matching/matcher.ts
```

#### Experiment Fails → Mark as Deprecated

```bash
mv lib/matching/_experimental_ai_matcher.ts lib/matching/_deprecated/
mv lib/matching/_deprecated/_experimental_ai_matcher.ts lib/matching/_deprecated/_deprecated_2026-02-15_experimental_ai_matcher.ts
```

---

### Rule 5: Version Management

#### Maintaining Multiple Versions

For A/B testing or gradual rollout:

```
lib/matching/
├── matcher_v1.ts         # Stable version (production)
├── matcher_v2.ts         # New version (testing)
└── matcher.ts            # Current default (points to v1 or v2)
```

**matcher.ts** content:
```typescript
// Current version: v2
// To switch versions, just change this line
export * from './matcher_v2'

// Version history:
// - v1: 2026-01-01 - Basic matching algorithm
// - v2: 2026-02-15 - Enhanced matching algorithm (current)
```

---

## AI Execution Flow

### Before Modifying Code

```
1. Confirm file is current version
   - Check if filename has _deprecated or _experimental prefix
   - Check if in _deprecated/ folder
   - If unsure, ask user

2. If replacing old code
   - Mark old code as _deprecated
   - Move to _deprecated/ folder
   - Create/update _deprecated/README.md
   - Record in work log

3. If creating experimental code
   - Use _experimental_ prefix
   - Don't delete existing code
   - Document experiment purpose and expected results

4. Update all import references
   - Search all places referencing old file
   - Update to new file path
   - Run tests to ensure nothing missed
```

### When Creating New Features

```
1. Determine file location
   - Core algorithms → lib/matching/ or lib/ai/
   - API routes → app/api/
   - UI components → components/

2. Use clear file names
   - Describe functionality, don't use new_, old_, temp_ prefixes
   - If multiple versions, use _v1, _v2 suffixes

3. If experimental feature
   - Use _experimental_ prefix
   - Add comment at top explaining experiment purpose
```

### Cleaning Deprecated Code

```
Periodically check _deprecated/ folders:

1. Deprecated code older than 30 days
   - Confirm no references exist
   - Confirm complete replacement exists
   - Safe to delete

2. Before deletion
   - Check Git history is complete
   - Confirm documentation records deprecation reason
   - Ask user for confirmation
```

---

## Forbidden Operations

### ❌ Absolutely Forbidden

1. **Directly deleting old code without marking deprecated**
   ```bash
   ❌ rm lib/matching/old_matcher.ts
   ✅ mv lib/matching/old_matcher.ts lib/matching/_deprecated/_deprecated_2026-02-15_old_matcher.ts
   ```

2. **Using ambiguous file names**
   ```bash
   ❌ lib/matching/new_matcher.ts
   ❌ lib/matching/matcher_new.ts
   ❌ lib/matching/matcher_temp.ts
   ❌ lib/matching/matcher_backup.ts

   ✅ lib/matching/matcher.ts
   ✅ lib/matching/matcher_v2.ts
   ✅ lib/matching/_experimental_ai_matcher.ts
   ```

3. **Modifying code in _deprecated/ folders**
   ```
   ❌ Modifying deprecated code
   ✅ If need reference, copy out and recreate
   ```

4. **Not documenting deprecation reason**
   ```
   ❌ Just moving to _deprecated/ folder
   ✅ Must record reason in _deprecated/README.md
   ```

---

## File Header Comment Standards

### Active Files

```typescript
/**
 * Matching Algorithm Core Module
 *
 * @version v2.0
 * @since 2026-02-15
 * @description Intelligent matching based on semantic similarity
 *
 * Version History:
 * - v1.0 (2026-01-01): Basic keyword matching
 * - v2.0 (2026-02-15): Added semantic understanding and context analysis
 *
 * Related Docs:
 * - docs/architecture/ADR-005-matching-refactor.md
 * - docs/tests/2026-02-15-matching-test.md
 */
```

### Deprecated Files

```typescript
/**
 * ⚠️ DEPRECATED - DO NOT USE
 *
 * @deprecated 2026-02-15
 * @reason Scoring logic inaccurate, 30% false match rate
 * @replacement Use matcher.ts instead
 * @see docs/architecture/ADR-005-matching-refactor.md
 */
```

### Experimental Files

```typescript
/**
 * 🧪 EXPERIMENTAL - Testing in progress
 *
 * @experimental
 * @since 2026-02-15
 * @purpose Test AI-based automatic matching algorithm
 * @expected Improve match accuracy to 95%
 * @status In progress
 *
 * Test Plan:
 * - [ ] Unit tests
 * - [ ] Integration tests
 * - [ ] A/B testing comparison
 */
```

---

## Code Review Checklist

### Before Committing Code

- [ ] File names follow conventions (no new_, old_, temp_ prefixes)
- [ ] Deprecated code moved to _deprecated/ folder
- [ ] _deprecated/README.md updated
- [ ] All import references updated
- [ ] File header comments complete
- [ ] Work log records code changes
- [ ] Related documentation updated

---

## Directory Structure Overview

```
project-root/
├── lib/                          # Core business logic
│   ├── matching/                 # Matching algorithms
│   │   ├── matcher.ts           # ✅ Active
│   │   ├── score_calculator.ts  # ✅ Active
│   │   ├── _experimental_ai_matcher.ts  # 🧪 Experimental
│   │   └── _deprecated/         # 🗑️ Deprecated
│   │       ├── README.md
│   │       └── _deprecated_2026-02-15_old_matcher.ts
│   ├── ai/                      # AI extraction logic
│   │   ├── extractor.ts         # ✅ Active
│   │   └── _deprecated/
│   └── utils/                   # Utility functions
│       └── _deprecated/
├── app/                         # Application
│   ├── api/                     # API routes
│   │   ├── jobs/
│   │   │   ├── match/
│   │   │   │   └── route.ts    # ✅ Active
│   │   │   └── _deprecated/
│   │   └── resume/
│   │       └── _deprecated/
│   └── match/
│       └── page.tsx             # ✅ Active
├── components/                  # React components
│   ├── MatchResult.tsx          # ✅ Active
│   └── _deprecated/
└── docs/                        # Documentation
    └── architecture/
        └── ADR-005-matching-refactor.md
```

---

## Usage Examples

### Example 1: Replacing Old Matching Algorithm

```bash
# User need: Old matching algorithm inaccurate, needs refactor

# AI execution steps:

# 1. Mark old code as deprecated
mv lib/matching/matcher.ts lib/matching/_deprecated/_deprecated_2026-02-15_matcher.ts

# 2. Create _deprecated/README.md
cat > lib/matching/_deprecated/README.md << 'EOF'
# Deprecated Code Explanation

## _deprecated_2026-02-15_matcher.ts
**Deprecated**: 2026-02-15
**Reason**: Scoring logic inaccurate, 30% false match rate
**Replacement**: New matcher.ts (semantic similarity based)
**Related Docs**: docs/architecture/ADR-005-matching-refactor.md
EOF

# 3. Create new matcher
# [Create lib/matching/matcher.ts]

# 4. Update all import references
# [Search and update all references]

# 5. Record in work log
# [Update docs/dev-logs/2026-02-15-work-log.md]
```

### Example 2: Testing Experimental Feature

```bash
# User need: Want to test AI-based matching algorithm

# AI execution steps:

# 1. Create experimental file
# [Create lib/matching/_experimental_ai_matcher.ts]

# 2. Add header comment
/**
 * 🧪 EXPERIMENTAL - AI-driven matching algorithm
 *
 * @experimental
 * @since 2026-02-15
 * @purpose Test GPT-4 direct matching scoring
 * @expected Accuracy > 95%, but may have slower response time
 */

# 3. Don't modify existing matcher.ts
# Keep production environment stable

# 4. Create test file
# [Create test cases comparing both algorithms]

# 5. Record in work log
```

### Example 3: Cleaning Deprecated Code

```bash
# Regular maintenance: Clean deprecated code older than 30 days

# AI execution steps:

# 1. Check deprecated code
find . -name "_deprecated_*" -mtime +30

# 2. Confirm no references
grep -r "deprecated_2026-01-15_old_matcher" .

# 3. Ask user for confirmation
# "Found 30-day-old deprecated code, delete?"

# 4. Delete and record
rm lib/matching/_deprecated/_deprecated_2026-01-15_old_matcher.ts
# [Record in work log]
```

---

## Customization

### File Extensions

Default examples use TypeScript (`.ts`, `.tsx`). Adapt for your language:

```
Python:   .py
JavaScript: .js, .jsx
Java:     .java
Go:       .go
```

### Prefix Conventions

Default prefixes can be customized:

```
_deprecated_  → .old_, .backup_, etc.
_experimental_ → .test_, .wip_, etc.
```

Just ensure consistency across your project.

---

## Related Skills

- `documentation-enforcer` - Documentation management
- `requirement-clarifier` - Requirements analysis
- `health-checker` - System health validation

---

**Skill Version**: v1.0
**Created**: 2026-02-15
**Last Updated**: 2026-02-15
**Compatibility**: Claude Code 2.0+
