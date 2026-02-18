# aispec 与 OpenSpec 对比及开源准备

本文档对比 **OpenSpec**（Fission-AI）与当前 **aispec**，并列出 aispec 达到**可开源水平**仍需的准备。供后续迭代（如 SP0003）规划用。

---

## 一、OpenSpec 概览（开源形态）

| 维度 | OpenSpec 现状 |
|------|----------------|
| **定位** | 轻量 spec-driven 框架，与 20+ AI 编码助手集成；Agree before you build。 |
| **交付形态** | **npm 包** `@fission-ai/openspec` + **CLI**（`openspec init` / `update` / `list` / `validate` / `view`）+ **Slash 命令**（`/opsx:new`、`/opsx:ff`、`/opsx:apply`、`/opsx:archive` 等）。 |
| **仓库结构** | `openspec/specs/`（权威 spec，按 domain）、`openspec/changes/<name>/`（proposal、design、tasks、specs/ 增量）；归档后移至 `changes/archive/`。 |
| **Delta 语义** | **正式**：spec 内 `## ADDED/MODIFIED/REMOVED Requirements`，archive 时**自动合并**到 `specs/`。 |
| **文档** | 独立站点 openspec.dev；仓库内 docs/（getting-started, concepts, commands, workflows, CLI, supported-tools, customization）。 |
| **规范与可扩展** | **Schema**（YAML）定义 artifact 类型与依赖；支持自定义 schema。 |
| **开源标配** | LICENSE（MIT）、CONTRIBUTING、MAINTAINERS.md、CHANGELOG、AGENTS.md；Telemetry 可关。 |
| **社区** | Discord、GitHub stars/forks、多工具支持列表。 |

---

## 二、aispec 当前形态

| 维度 | aispec 现状 |
|------|-------------|
| **定位** | 工作区级 AI 规范与变更收敛；**约定 + 模板**，无安装、无 CLI，与现有 /mrd～/merge 一致。 |
| **交付形态** | **仅文档与模板**：spec/CONVENTIONS.md、spec/templates/（proposal、tasks）；可选验收脚本（如 verify-sp0002.sh）。 |
| **仓库结构** | **iteration/SP0xxx/**（MRD、PRD、DESIGN、tasks、REVIEW、TEST）；**spec/**（CONVENTIONS、templates）；合并后迭代保留、spec 为发布视图。 |
| **Delta 语义** | **可选表述**：CONVENTIONS 中推荐 ADDED/MODIFIED/REMOVED 书写；**无自动合并**，依赖「合并时反哺」与人工/Agent 同步。 |
| **文档** | README、CONVENTIONS（单份）、CHANGELOG；无独立 getting-started/concepts/commands 分层。 |
| **规范与可扩展** | 无 schema 层；约定固定为 /mrd～/merge 与迭代目录结构。 |
| **开源标配** | **无** LICENSE、CONTRIBUTING、MAINTAINERS、CODE_OF_CONDUCT。 |
| **绑定** | 与「工作区 + 业务项目 aispec.md」可选相关（PROGRESS、项目专属规则）；独立仓库可仅采用 spec + 模板。 |

---

## 三、差异摘要

| 能力 | OpenSpec | aispec |
|------|----------|--------|
| 安装与入口 | npm install + openspec init | 无安装，复制/引用 spec 即可 |
| 与 AI 的触点 | Slash 命令 + 多工具 skills | Agent 必读 README/CONVENTIONS，无统一 slash |
| 变更结构 | changes/\<name\>/（proposal, design, tasks, specs/） | iteration/SP0xxx/（MRD, PRD, DESIGN, tasks） |
| 权威 spec | openspec/specs/ 按 domain | spec/CONVENTIONS + 各项目 spec/ |
| Delta 合并 | archive 时自动合并 delta → specs/ | 合并时反哺 PRD/DESIGN，无自动 delta 合并 |
| 校验 | openspec validate、openspec view | 迭代内验收脚本（如 verify-sp0002.sh） |
| 文档体系 | 多篇 docs + 官网 | 单份 CONVENTIONS + README |
| 开源法律与协作 | LICENSE、CONTRIBUTING、MAINTAINERS | 未具备 |

---

## 四、达到「可开源」水平：aispec 还需的准备

以下按**必要性**与**可选增强**分类，便于排优先级。

### 4.1 必要（法律与协作）

| 项 | 说明 |
|----|------|
| **LICENSE** | 选定许可证（如 MIT），在仓库根添加 LICENSE 文件。 |
| **CONTRIBUTING.md** | 说明如何贡献：PR 流程、分支约定、是否要求先有 MRD/PRD（与自身流程一致）。 |
| **README 开源版** | 面向「任意用户/仓库」的说明：aispec 是什么、与 OpenSpec 的差异、如何在自己的仓库中采用（见下 4.2）。 |

### 4.2 必要（可移植性）

| 项 | 说明 |
|----|------|
| **脱耦工作区** | CONVENTIONS 中「业务项目 aispec.md」为**可选**：带工作区时可放置 PROGRESS 与项目专属规则；独立仓库仅需 spec + 模板。 |
| **独立采用路径** | 文档化「仅用 aispec 约定」的用法：例如复制 `spec/CONVENTIONS.md` + `spec/templates/` 到目标仓库的 `.aispec/` 或 `docs/aispec/`；README 中注明「Agent 或人按 CONVENTIONS 执行」；无需 clone 整个 project。 |
| **AGENTS.md 模板** | 提供可放入任意仓库的 **AGENTS.md** 片段或模板，指向「采用 aispec 时 Agent 必读的约定与入口」（CONVENTIONS 或精简版 quick reference）。 |

### 4.3 推荐（文档与心智）

| 项 | 说明 |
|----|------|
| **Getting Started** | 单页或短文档：5 分钟内「在新仓库启用 aispec」的步骤（复制哪些文件、改哪些占位、如何跑第一轮 /mrd～/merge）。 |
| **Concepts** | 精简概念说明：权威在 spec、iteration 与 change 的对应、/mrd 与 /merge 的职责、Delta 为可选表述；与 OpenSpec 的 specs/changes 做一句话对比。 |
| **OpenSpec 对比** | 在 README 或单独 doc 中说明：何时选 aispec（零安装、约定即用、与既有流程融合）vs 何时选 OpenSpec（CLI、slash、多工具、自动 delta 合并）；不贬低、只区分场景。 |

### 4.4 可选（体验与一致性）

| 项 | 说明 |
|----|------|
| **MAINTAINERS / CODE_OF_CONDUCT** | 若希望吸引外部贡献，可加 MAINTAINERS.md、CODE_OF_CONDUCT.md。 |
| **通用验收脚本** | 将 verify-sp0002.sh 泛化为「校验任意仓库是否具备 CONVENTIONS + 模板 + 环节声明」的脚本，随仓库发布为可选 `scripts/verify-aispec.sh`。 |
| **design 模板** | spec/templates/ 中增加 **design.md** 模板（与 proposal、tasks 并列），便于与 OpenSpec 的 proposal→specs→design→tasks 更对齐。 |
| **Delta 合并说明** | 在 CONVENTIONS 中补充「若希望类似 OpenSpec 的 delta 合并」：可约定迭代内 specs/ 或 DESIGN 中写 ADDED/MODIFIED/REMOVED，合并时由 Agent 或人按节合并到目标 spec；不要求实现自动化工具。 |

### 4.5 明确不做（保持差异）

| 项 | 说明 |
|----|------|
| **不实现与 OpenSpec 的 1:1 兼容** | 不解析 OpenSpec 的 changes/ 或 schema；可做「从 OpenSpec 迁移到 aispec」的指引（人工或一次性脚本）。 |
| **不替代 OpenSpec** | 定位为「轻量、约定优先、可嵌入既有流程」的替代方案，而非 OpenSpec 的 fork。 |

**说明**：aispec 现提供可选 **CLI**（`aispec-cli`）：`init`、`verify`，便于独立仓库快速采用与校验；仍支持「仅复制 spec + 模板」的无安装方式。

---

## 五、建议的下一步（可拆为 SP）

1. **SP0003（建议）**：**开源基础** — 添加 LICENSE（MIT）、CONTRIBUTING.md、README 开源版（含「如何独立采用」与 OpenSpec 对比）；CONVENTIONS 中业务项目 aispec.md 为可选。
2. **后续**：Getting Started + Concepts 短文档；可选 AGENTS.md 模板与通用 verify 脚本；design 模板与 delta 合并说明。

完成 4.1 + 4.2 后，aispec 即可在**法律与可移植性**上达到可开源发布水平；4.3～4.4 提升采纳体验与一致性。
