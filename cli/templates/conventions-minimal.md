# aispec 约定（精简版）

本文件为 **aispec init** 生成的精简版。完整约定见 [aispec 仓库 spec/CONVENTIONS.md](https://github.com/surlymochan/aispec/blob/main/spec/CONVENTIONS.md)。

**权威**：本 CONVENTIONS；有歧义以本文档为准。独立仓库采用时无需业务项目 aispec.md。

---

## 零、Spec 严格程度与问题规模

- 默认 Spec-first；合并时反哺 PRD/DESIGN。小改动可不走完整 /mrd 链；新能力须走完整迭代（/mrd → … → /merge）。

---

## 一、工作流（/mrd 与 /merge）

- **人仅有四个触发点**：**/mrd**、**/merge**、**/public**、**/push**（顺序：mrd → merge → public → push）。
- /mrd 后自动链：/opensp → /prd → /design → /coding → /review → /test → /deploy；REVIEW、TEST 放入当前迭代目录。
- /merge 后自动执行（不自动 /public、/push）：质量门 → 合并到 src+spec → 更新版本号 → 反哺 PRD/DESIGN/README → 自 merge 后版本的自动检查。
- /public 脚本全自动：脱敏检查 → 同步到 public → 在 public 内测试 → git add & commit（不 push）。
- /push 仅人工触发：在 /public 完成后，于 public/aispec 内执行 git push。
- PRD、DESIGN 须先多询问、澄清再落笔。

---

## 二、项目结构（iteration + src + spec）

- iteration/：各 SP 迭代；REVIEW、TEST 置于对应迭代目录。src/：可部署产物。spec/：当前发布说明；须在 spec/README.md 标注版本号。
- 迭代命名：SP-YYYYMMDD 或项目既有风格。合并时反哺；出现矛盾须寻求负责人决策。

---

## 五、独立仓库采用

- 约定与模板置于 .aispec/spec/；Agent 必读 .aispec/spec/CONVENTIONS.md；可选 `npx aispec-cli verify` 校验。

---

## 六、迭代目录与文档

- 迭代内建议：MRD.md、PRD.md、DESIGN.md、README.md、可选 tasks.md；REVIEW、TEST 置于该迭代目录。

---

## 八、Spec 驱动编程（/mrd～/merge 输入输出与约定）

### 8.1 各环节输入、输出与交付物

| 环节 | 输入 | 输出 / 交付物 | 交付物放置位置 |
|------|------|----------------|----------------|
| **/mrd** | 负责人需求 | 需求或 MRD 内容 | 当前迭代 MRD.md |
| **/opensp** | MRD | 迭代目录、MRD 落盘 | iteration/SP0xxx/ |
| **/prd** | MRD + 澄清 | PRD.md | 当前迭代目录 |
| **/design** | PRD | DESIGN.md、可选 tasks.md | 当前迭代目录 |
| **/coding** | DESIGN、tasks | 实现产物 | 当前迭代或 src |
| **/review** | 实现与 PRD/DESIGN | REVIEW 报告 | 当前迭代目录 |
| **/test** | 实现与验收标准 | TEST 报告 | 当前迭代目录 |
| **/deploy** | src 或迭代产物 | 部署结果 | 迭代 README 或报告 |
| **/merge** | 验收通过、确认 | 合并到 src+spec、版本号更新 | spec/、src/ |

### 8.2 变更提案结构

- 迭代目录：MRD、PRD、DESIGN、README、可选 tasks；REVIEW、TEST 置于当前迭代目录。

### 8.3 Delta 语义（可选）

- 可显式标注 ADDED、MODIFIED、REMOVED。

### 8.4 模板与验收

- 模板见 .aispec/spec/templates/（proposal 供 /mrd、tasks 供 /design 之后）。若迭代有验收脚本，/merge 前须通过。
