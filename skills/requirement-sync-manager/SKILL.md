---
name: requirement-sync-manager
description: Enforces Single Source of Truth for requirements. When detecting requirement changes, bug fixes, or feature additions, forces updates to PRD-主文档.md instead of creating isolated documents. Automatically creates change records, updates test cases, and maintains changelog. Triggers when user reports bugs, requests features, or modifies requirements.
---

# Requirement Sync Manager

> 需求同步管理器 - 强制执行"单一真相源"原则

## 核心原则

**Single Source of Truth (单一真相源)**:
- 只有一个 PRD 主文档：`docs/01-需求文档/PRD-主文档.md`
- 所有需求变更必须更新主文档
- 禁止创建孤立的需求文档

---

## 触发条件

当检测到以下情况时自动触发：

1. **需求变更**
   - 用户说："需要修改需求"
   - 用户说："这个功能要改成..."
   - 用户说："增加新功能..."

2. **Bug 修复导致需求变更**
   - Bug 修复改变了原有行为
   - Bug 修复增加了新的验收标准
   - 例如："禁用软技能匹配"（改变了原有的匹配逻辑）

3. **功能优化导致需求变更**
   - 性能优化改变了响应时间要求
   - UI 优化改变了交互方式
   - 算法优化改变了匹配规则

---

## 执行流程

### 步骤 1: 检测需求变更

**自动分析**：
```
用户输入
  ↓
分析是否涉及需求变更
  ├─ 是 → 继续步骤 2
  └─ 否 → 正常处理
```

**判断标准**：
- 改变了功能行为？
- 增加了新的验收标准？
- 修改了性能要求？
- 改变了用户体验？

如果任何一个为"是"，则属于需求变更。

---

### 步骤 2: 提示用户确认

**提示模板**：
```
🔔 检测到需求变更

变更类型：[Bug 修复 / 功能优化 / 新增功能]
影响范围：[匹配算法 / AI 提取 / UI 展示 / 性能]

需要更新 PRD-主文档.md 吗？

选项：
1. ✅ 是，更新主文档（推荐）
2. ❌ 否，这不是需求变更
3. ⏸️ 稍后处理
```

---

### 步骤 3: 执行同步操作

**如果用户选择"是"，自动执行**：

#### 3.1 更新 PRD-主文档.md

**操作**：
1. 读取 `docs/01-需求文档/PRD-主文档.md`
2. 找到相关功能章节
3. 更新需求描述
4. 增加版本号（v2.0 → v2.1）
5. 添加变更历史记录

**更新格式**：
```markdown
### X. [功能名称] [vX.X] ⚠️ 最近变更

**需求描述**：
~~旧需求描述~~ (已废弃 vX.X)
新需求描述

**变更原因**：
[详细说明为什么要变更]

**验收标准**：
- [ ] 新标准 1
- [ ] 新标准 2

**测试用例**：
- TEST-XXX (新增)

**变更历史**：
- vX.X (YYYY-MM-DD): 变更描述 → [详情](需求变更历史/YYYY-MM-DD-变更标题.md)
```

#### 3.2 创建变更记录

**文件位置**：`docs/01-需求文档/需求变更历史/YYYY-MM-DD-变更标题.md`

**文件内容**：
```markdown
# 需求变更记录：[变更标题]

**变更日期**: YYYY-MM-DD
**变更类型**: [Bug 修复 / 功能优化 / 新增功能]
**影响范围**: [匹配算法 / AI 提取 / UI 展示]
**PRD 版本**: vX.X → vX.X

---

## 变更背景

### 问题描述
[为什么需要这个变更？]

### 根本原因
[问题的根本原因是什么？]

---

## 变更内容

### 旧需求
[原来的需求是什么？]

### 新需求
[现在的需求是什么？]

### 差异对比
| 维度 | 旧需求 | 新需求 |
|------|--------|--------|
| 功能行为 | ... | ... |
| 验收标准 | ... | ... |
| 性能要求 | ... | ... |

---

## 影响分析

### 代码变更
- 修改文件：`lib/matching/code_matcher.ts`
- 变更行数：+50 -20

### 测试用例变更
- 新增测试用例：TEST-101, TEST-102, TEST-103
- 废弃测试用例：无

### 文档变更
- 更新 PRD-主文档.md (v2.0 → v2.1)
- 更新 test-cases-master.json

---

## 验证结果

### 测试结果
- ✅ 所有测试通过
- ✅ 性能符合要求
- ✅ 无回归问题

### 上线时间
YYYY-MM-DD HH:mm

---

## 相关链接

- PRD 主文档：[docs/01-需求文档/PRD-主文档.md](../PRD-主文档.md#功能章节)
- 问题记录：[docs/findings.md](../../findings.md#YYYY-MM-DD)
- 测试用例：[tests/test-cases/xxx.json](../../../tests/test-cases/xxx.json)
```

#### 3.3 通知 test-case-sync-engine

**自动触发**：
```
需求变更完成
  ↓
通知 test-case-sync-engine
  ↓
自动生成/更新测试用例
```

#### 3.4 更新 changelog.md

**文件位置**：`docs/04-变更日志/changelog.md`

**添加记录**：
```markdown
## YYYY-MM-DD - [变更标题]

**类型**: 需求变更
**版本**: vX.X
**影响**: [匹配算法 / AI 提取 / UI 展示]

**变更内容**：
- 变更描述

**相关文档**：
- [需求变更记录](../01-需求文档/需求变更历史/YYYY-MM-DD-变更标题.md)
- [PRD 主文档](../01-需求文档/PRD-主文档.md)
```

---

### 步骤 4: 验证同步完成

**检查清单**：
- [ ] PRD-主文档.md 已更新
- [ ] 版本号已递增
- [ ] 变更记录已创建
- [ ] changelog.md 已更新
- [ ] test-case-sync-engine 已通知

**完成提示**：
```
✅ 需求同步完成

已更新：
- PRD-主文档.md (v2.0 → v2.1)
- 需求变更历史/YYYY-MM-DD-变更标题.md
- changelog.md

下一步：
- test-case-sync-engine 将自动生成测试用例
- 请查看 PRD-主文档.md 确认变更
```

---

## 禁止操作

### ❌ 绝对禁止

1. **创建孤立的需求文档**
   ```
   ❌ docs/新需求-禁用软技能.md
   ✅ 更新 docs/01-需求文档/PRD-主文档.md
   ```

2. **在其他位置记录需求变更**
   ```
   ❌ docs/问题排查/需求变更.md
   ✅ docs/01-需求文档/需求变更历史/
   ```

3. **跳过 PRD 主文档更新**
   ```
   ❌ 只创建变更记录，不更新主文档
   ✅ 必须同时更新主文档和创建变更记录
   ```

---

## 特殊情况处理

### 情况 1: PRD-主文档.md 不存在

**处理方式**：
```
1. 提示用户："PRD-主文档.md 不存在，需要创建吗？"
2. 如果用户同意，使用 doc-coauthoring Skill 创建
3. 创建完成后，继续需求同步流程
```

### 情况 2: 用户坚持创建新文档

**处理方式**：
```
1. 警告用户："这会违反单一真相源原则"
2. 说明后果："可能导致文档不一致、测试用例混乱"
3. 建议："强烈建议更新 PRD-主文档.md"
4. 如果用户仍坚持，记录警告到 docs/findings.md
```

### 情况 3: 变更太小，不值得更新 PRD

**判断标准**：
- 只是修复拼写错误？
- 只是调整日志输出？
- 只是代码重构，不改变行为？

**处理方式**：
```
如果确实不涉及需求变更，允许跳过 PRD 更新
但必须在 changelog.md 中记录为"技术变更"
```

---

## 与其他 Skills 的协作

### 1. doc-coauthoring
- 创建 PRD-主文档.md 时使用
- 提供结构化的文档创建流程

### 2. test-case-sync-engine
- 需求变更后自动通知
- 自动生成/更新测试用例

### 3. documentation-enforcer-v2
- 共同执行文档规范
- 防止创建孤立文档

### 4. change-impact-analyzer
- 分析需求变更的影响范围
- 评估风险等级

---

## 使用示例

### 示例 1: Bug 修复导致需求变更

**用户输入**：
```
"修复了一个 Bug：专业能力显示 0 项。
原因是软技能污染了专业能力列表。
解决方案：禁用软技能匹配。"
```

**Skill 执行**：
```
1. 检测到需求变更（改变了匹配行为）
2. 提示用户确认
3. 用户确认后：
   - 更新 PRD-主文档.md (v2.0 → v2.1)
   - 创建 需求变更历史/2026-02-15-禁用软技能匹配.md
   - 更新 changelog.md
   - 通知 test-case-sync-engine
4. 完成提示
```

### 示例 2: 新增功能

**用户输入**：
```
"需要增加一个新功能：匹配度百分比显示"
```

**Skill 执行**：
```
1. 检测到新增功能
2. 提示用户确认
3. 用户确认后：
   - 在 PRD-主文档.md 中添加新章节
   - 创建 需求变更历史/2026-02-15-匹配度百分比.md
   - 更新 changelog.md
   - 通知 test-case-sync-engine
4. 完成提示
```

---

## 配置选项

### 自动化级别

**Level 1: 提示模式（默认）**
- 检测到需求变更时提示用户
- 用户确认后执行

**Level 2: 自动模式**
- 检测到需求变更自动执行
- 执行后通知用户

**Level 3: 严格模式**
- 强制所有变更都更新 PRD
- 不允许跳过

### 配置文件

**位置**：`.claude/config/requirement-sync.json`

```json
{
  "mode": "prompt",
  "strictMode": true,
  "autoNotifyTestSync": true,
  "requireChangeReason": true,
  "prdPath": "docs/01-需求文档/PRD-主文档.md",
  "changeHistoryPath": "docs/01-需求文档/需求变更历史/",
  "changelogPath": "docs/04-变更日志/changelog.md"
}
```

---

## 执行优先级

**P0 (必须执行)**:
1. 检测需求变更
2. 提示用户确认
3. 更新 PRD-主文档.md

**P1 (强烈推荐)**:
1. 创建变更记录
2. 更新 changelog.md
3. 通知 test-case-sync-engine

**P2 (建议)**:
1. 验证同步完成
2. 生成变更报告

---

**Skill Version**: v1.0
**Created**: 2026-02-15
**Last Updated**: 2026-02-15
**Compatibility**: Claude Code 2.0+
