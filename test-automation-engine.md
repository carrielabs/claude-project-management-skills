---
name: test-automation-engine
description: Intelligent test automation engine that identifies relevant tests based on code changes, executes tests in parallel, generates detailed reports, and records results to docs/. Triggers after code modifications, integrates with test-case-sync-engine, and supports 40+ existing test scripts migration to unified test cases.
---

# Test Automation Engine

> 测试自动化引擎 - 智能识别、并行执行、自动报告

## 🎯 核心功能

1. **智能识别需要运行的测试**
2. **并行执行测试**
3. **生成详细测试报告**
4. **自动记录到 docs/04-测试文档/**

---

## 触发条件

### 自动触发

1. **代码修改后**
   - 修改 `lib/matching/` → 运行匹配算法测试
   - 修改 `lib/ai/` → 运行 AI 提取测试
   - 修改 `app/api/` → 运行 API 集成测试
   - 修改 `components/` → 运行 UI 测试

2. **health-checker 调用**
   - 代码变更后自动触发
   - 运行相关测试套件

3. **Git commit 前**
   - 自动运行受影响的测试
   - 测试通过才允许提交

### 手动触发

用户可以手动请求：
- "运行所有测试"
- "运行匹配算法测试"
- "测试这个功能"

---

## 执行流程

### 步骤 1: 智能识别测试范围

**分析代码变更**：
```
检测修改的文件
  ↓
分析影响范围
  ├─ lib/matching/ → 匹配算法测试
  ├─ lib/ai/ → AI 提取测试
  ├─ app/api/ → API 测试
  └─ components/ → UI 测试
  ↓
读取 test-cases-master.json
  ↓
筛选相关测试用例
```

**影响范围映射**：
```json
{
  "lib/matching/": ["MATCH", "REGRESSION"],
  "lib/ai/": ["AI", "REGRESSION"],
  "app/api/": ["API", "E2E"],
  "components/": ["UI", "E2E"]
}
```

---

### 步骤 2: 并行执行测试

**执行策略**：
```
独立测试 → 并行执行
依赖测试 → 顺序执行
```

**执行流程**：
```
读取测试用例
  ↓
分组（独立 vs 依赖）
  ↓
并行执行独立测试
  ├─ 匹配算法测试 (并行)
  ├─ AI 提取测试 (并行)
  └─ JD 解析测试 (并行)
  ↓
顺序执行依赖测试
  ├─ 集成测试
  └─ E2E 测试
  ↓
收集测试结果
```

**测试引擎**：
```typescript
// tests/test-engine/runner.ts
async function runTests(testCases: TestCase[]) {
  const independent = testCases.filter(t => !t.dependencies);
  const dependent = testCases.filter(t => t.dependencies);
  
  // 并行执行独立测试
  const independentResults = await Promise.all(
    independent.map(tc => executeTest(tc))
  );
  
  // 顺序执行依赖测试
  const dependentResults = [];
  for (const tc of dependent) {
    const result = await executeTest(tc);
    dependentResults.push(result);
  }
  
  return [...independentResults, ...dependentResults];
}
```

---

### 步骤 3: 生成测试报告

**报告格式**：
```markdown
# YYYY-MM-DD 自动化测试报告

**测试时间**: YYYY-MM-DD HH:mm:ss
**触发原因**: 代码变更 (lib/matching/code_matcher.ts)
**测试范围**: 匹配算法、回归测试
**执行时长**: 2m 34s

---

## 📊 测试摘要

| 指标 | 数值 |
|------|------|
| 总测试用例 | 150 |
| 通过 | 145 (96.7%) ✅ |
| 失败 | 5 (3.3%) ❌ |
| 跳过 | 0 |
| 执行时间 | 2m 34s |

---

## ✅ 通过的测试套件

### 匹配算法测试 (48/50)
- ✅ MATCH-001: 精确匹配测试
- ✅ MATCH-002: 模糊匹配测试
- ✅ MATCH-003: 同义词匹配测试
- ... (45 more)

### AI 提取测试 (30/30)
- ✅ AI-001: 技能提取测试
- ✅ AI-002: 经验提取测试
- ... (28 more)

---

## ❌ 失败的测试用例

### MATCH-042: 复合技能匹配
**优先级**: P0 (高)
**失败原因**: 匹配率低于预期

**详细信息**:
- 预期: 匹配率 >= 80%
- 实际: 匹配率 65%
- 输入: JD 要求 "React + TypeScript 开发经验"
- 输出: 只匹配到 React，未匹配 TypeScript

**根本原因**:
AI 提取过度抽象，将 "React + TypeScript" 抽象为 "前端开发"

**建议修复**:
调整 `lib/ai/super_extractor.ts` 的抽象级别，保留具体技术栈名称

**相关文件**:
- lib/matching/code_matcher.ts:245
- lib/ai/super_extractor.ts:168

---

## 📈 性能对比

| 测试项 | 本次 | 上次 | 变化 |
|--------|------|------|------|
| 匹配算法 | 125ms | 110ms | +15ms ⚠️ |
| AI 提取 | 850ms | 900ms | -50ms ✅ |
| JD 解析 | 45ms | 45ms | 0ms |

**性能分析**:
- 匹配算法变慢 15ms，可能是新增的软技能过滤逻辑导致
- AI 提取变快 50ms，优化生效 ✅

---

## 🔄 回归测试结果

| 测试用例 | 状态 | 说明 |
|---------|------|------|
| BUG-001 | ✅ | 专业能力非空验证通过 |
| BUG-002 | ✅ | 软技能过滤验证通过 |
| BUG-003 | ✅ | AI 提取不过度抽象验证通过 |

---

## 💡 建议

### 立即修复 (P0)
1. 修复 MATCH-042: 复合技能匹配问题
2. 调查匹配算法性能下降原因

### 后续优化 (P1)
1. 增加复合技能的测试用例
2. 优化匹配算法性能

---

## 📎 相关链接

- 测试用例库: [test-cases-master.json](../../../tests/test-cases/test-cases-master.json)
- 代码变更: [code_matcher.ts](../../../lib/matching/code_matcher.ts)
- 问题记录: [findings.md](../../findings.md)
```

---

### 步骤 4: 记录测试结果

**自动保存报告**：
```
生成测试报告
  ↓
保存到 docs/04-测试文档/YYYY-MM-DD-自动化测试报告.md
  ↓
更新 docs/progress.md
  ↓
如果有失败测试 → 更新 docs/findings.md
```

---

## 测试引擎架构

### 目录结构

```
tests/
├── test-cases/
│   ├── test-cases-master.json      # 测试用例主索引
│   ├── matching-algorithm.json     # 匹配算法测试用例
│   ├── ai-extraction.json          # AI 提取测试用例
│   └── e2e-scenarios.json          # E2E 测试用例
├── test-engine/
│   ├── runner.ts                   # 测试运行器
│   ├── matcher-tester.ts           # 匹配算法测试器
│   ├── ai-tester.ts                # AI 提取测试器
│   ├── api-tester.ts               # API 测试器
│   ├── ui-tester.ts                # UI 测试器
│   └── reporter.ts                 # 报告生成器
├── test-data/
│   ├── sample-resumes/             # 测试简历
│   └── sample-jds/                 # 测试 JD
└── test-config.json                # 测试配置
```

### 核心组件

#### 1. runner.ts - 测试运行器

```typescript
interface TestRunner {
  // 智能识别测试范围
  identifyTests(changedFiles: string[]): TestCase[];
  
  // 并行执行测试
  runTests(testCases: TestCase[]): Promise<TestResult[]>;
  
  // 生成报告
  generateReport(results: TestResult[]): string;
  
  // 保存报告
  saveReport(report: string): void;
}
```

#### 2. matcher-tester.ts - 匹配算法测试器

```typescript
interface MatcherTester {
  // 执行匹配测试
  testMatching(testCase: TestCase): TestResult;
  
  // 验证匹配率
  verifyMatchRate(actual: number, expected: string): boolean;
  
  // 验证匹配技能
  verifyMatchedSkills(actual: string[], expected: string[]): boolean;
}
```

#### 3. reporter.ts - 报告生成器

```typescript
interface Reporter {
  // 生成 Markdown 报告
  generateMarkdown(results: TestResult[]): string;
  
  // 生成 JSON 报告
  generateJSON(results: TestResult[]): object;
  
  // 对比历史性能
  comparePerformance(current: TestResult[], previous: TestResult[]): PerformanceComparison;
}
```

---

## 迁移现有测试脚本

### 迁移策略

**现状**: 40+ 个独立测试脚本
**目标**: 统一的测试用例 + 通用测试引擎

**迁移步骤**:
```
1. 分析现有测试脚本
   ↓
2. 提取测试逻辑和测试数据
   ↓
3. 将测试数据转换为 JSON 格式
   ↓
4. 将测试逻辑整合到测试引擎
   ↓
5. 验证迁移后的测试结果
   ↓
6. 逐步废弃旧脚本
```

**迁移示例**:

**旧脚本** (`scripts/run_10jd_test.ts`):
```typescript
// 硬编码的测试数据和逻辑
const testCases = [
  { jd: "...", resume: "...", expected: 0.8 },
  // ... 更多测试用例
];

for (const tc of testCases) {
  const result = await runMatching(tc.jd, tc.resume);
  console.log(result.matchRate >= tc.expected ? "PASS" : "FAIL");
}
```

**新方式** (测试用例 + 测试引擎):

**测试用例** (`tests/test-cases/matching-algorithm.json`):
```json
{
  "testSuite": "匹配算法测试",
  "testCases": [
    {
      "id": "MATCH-001",
      "input": { "jd": "...", "resume": "..." },
      "expected": { "matchRate": ">= 80%" }
    }
  ]
}
```

**测试引擎** (`tests/test-engine/runner.ts`):
```typescript
const testCases = loadTestCases("matching-algorithm.json");
const results = await runTests(testCases);
generateReport(results);
```

---

## 智能重试机制

### AI 相关测试的不稳定性

**问题**: AI 提取结果可能不稳定

**解决方案**: 智能重试
```
执行 AI 提取测试
  ↓
失败？
  ├─ 是 → 重试 (最多 3 次)
  │   ↓
  │   仍失败？
  │   ├─ 是 → 标记为"不稳定测试"
  │   └─ 否 → 标记为"通过"
  └─ 否 → 标记为"通过"
```

**配置**:
```json
{
  "retryConfig": {
    "maxRetries": 3,
    "retryDelay": 1000,
    "retryOnCategories": ["ai-extraction"]
  }
}
```

---

## 快照对比

### 保存历史测试结果

**目的**: 对比性能变化、发现回归问题

**快照格式**:
```json
{
  "timestamp": "2026-02-15T12:00:00Z",
  "gitCommit": "abc123",
  "testResults": {
    "totalTests": 150,
    "passed": 145,
    "failed": 5,
    "performance": {
      "matching": 125,
      "aiExtraction": 850
    }
  }
}
```

**对比逻辑**:
```
读取当前测试结果
  ↓
读取上次快照
  ↓
对比性能变化
  ├─ 变慢 > 10% → 警告
  ├─ 变快 > 10% → 标记优化
  └─ 变化 < 10% → 正常
  ↓
生成对比报告
```

---

## 与其他 Skills 的协作

### 1. test-case-sync-engine
- 读取测试用例库
- 执行测试用例

### 2. health-checker
- 代码变更后自动触发
- 运行相关测试

### 3. systematic-debugging
- 测试失败时自动触发
- 协助定位问题

### 4. documentation-enforcer-v2
- 自动保存测试报告
- 维护文档规范

---

## 配置选项

**配置文件**: `tests/test-config.json`

```json
{
  "parallelExecution": true,
  "maxParallelTests": 5,
  "retryConfig": {
    "enabled": true,
    "maxRetries": 3,
    "retryDelay": 1000
  },
  "reportConfig": {
    "format": "markdown",
    "savePath": "docs/04-测试文档/",
    "includePerformanceComparison": true
  },
  "snapshotConfig": {
    "enabled": true,
    "savePath": "tests/snapshots/"
  }
}
```

---

## 使用示例

### 示例 1: 代码变更触发

```
修改 lib/matching/code_matcher.ts
  ↓
test-automation-engine 自动触发
  ↓
识别需要运行的测试: 匹配算法、回归测试
  ↓
并行执行 50 个测试用例
  ↓
生成测试报告
  ↓
保存到 docs/04-测试文档/2026-02-15-自动化测试报告.md
  ↓
通知用户: "测试完成，145/150 通过"
```

### 示例 2: 手动触发

```
用户: "运行所有测试"
  ↓
test-automation-engine 执行
  ↓
读取 test-cases-master.json (150 个测试用例)
  ↓
并行执行所有测试
  ↓
生成完整测试报告
  ↓
通知用户: "所有测试完成，查看报告"
```

---

**Skill Version**: v1.0
**Created**: 2026-02-15
**Compatibility**: Claude Code 2.0+
