# SP0002 PRD：aispec 组件化能力（spec 驱动编程支持）

基于 [MRD.md](MRD.md) 与负责人澄清结果整理。验收通过后合并到 spec/ 并更新版本号。

---

## 一、目标与范围

- **目标**：在 **private/aispec-private** 内落盘一套**仅依赖约定与模板**即可使用的 spec 驱动编程能力，与 soul 权威及现有 /mrd～/merge 流程兼容，对外呈现**高度集成、开箱即用**（不引入 OpenSpec 等外部包或 CLI）。
- **范围**：
  - 约定与说明**统一纳入 spec 内一份主文档**（扩展现有 CONVENTIONS 或单份「Spec 驱动约定」），避免多文件重复、矛盾。
  - 提供**可直接复用的 Markdown 模板**（如 proposal、tasks 等），供迭代或业务项目引用。
  - **不**在本 SP 做 OpenSpec 场景的兼容/迁移；留作后续 TODO。

---

## 二、需求与优先级

- **优先级**：**C → A → B**（与工作流衔接优先，其次变更提案结构，再次 Delta 语义）；整体为**迭代级别**，减少不必要的繁琐环节（不对齐 OpenSpec 的 feature 级指令）。
- **C：与工作流衔接**
  - 明确从 **/mrd** 到 **/merge** 的完整链中，每一环节的**输入、输出与交付物**。
  - 要求：**REVIEW、TEST** 等报告在工作流进行中生成，并在约定中声明其所在环节及产出位置（如「REVIEW 在 /review 后产出，置于当前迭代目录」）。
- **A：变更提案结构**
  - 定义单次迭代（SP）的**提案结构**：如 MRD、PRD、DESIGN、README、可选 tasks.md；与 OpenSpec 的 proposal/specs/design/tasks 对应关系在约定中简要说明，但不引入多余步骤。
- **B：Delta 语义**
  - 约定对「**ADDED / MODIFIED / REMOVED**」的表述方式，便于在 spec 与实现间一致描述变更；可写在主约定文档中单独小节。

---

## 三、交付物（统一与模板）

| 交付物 | 说明 |
|--------|------|
| **主约定文档** | spec 内**一份**文档承载「Spec 驱动编程」约定：与 /mrd～/merge 的衔接、各环节输入/输出与交付物、变更提案结构、Delta 语义。与现有 CONVENTIONS 的关系二选一：**(a) 在 CONVENTIONS.md 中新增章节**，或 **(b) 单份新文档（如 spec/SPEC-DRIVEN.md）且 CONVENTIONS 仅引用不重复**。由 DESIGN 确定选型。 |
| **Markdown 模板** | 至少包含：**proposal**（或与 MRD/PRD 对应的迭代意图说明）、**tasks**（实现任务清单）。模板存放位置由 DESIGN 确定（如 spec/templates/ 或 spec 内附录）。 |
| **自动化验收脚本** | 本迭代**必须**提供验收脚本（如 `scripts/verify-sp0002.sh` 或项目内约定路径），用于检查：主约定文档存在、必备模板存在、主约定中声明了 /mrd～/merge 各环节的输入/输出。执行方式写入本迭代 README。 |

---

## 四、验收标准（可验证）

1. **约定可引用**：在 spec 中存在一份可被业务项目或 Agent 引用的「Spec 驱动编程」约定（主约定文档），且与现有 CONVENTIONS 无重复、冲突。
2. **工作流完整且声明清晰**：约定中明确写出从 /mrd 到 /merge 的完整流程，且**每一环节**均声明：**输入**、**输出/交付物**（含 REVIEW、TEST 等报告在何环节生成、放在何处）。
3. **模板可用**：至少提供 proposal（或等价的迭代意图）模板与 tasks 模板，复制即可用于新迭代。
4. **自动化验收**：迭代目录内或项目约定路径下存在验收脚本；运行脚本通过即视为「约定与模板就绪」的自动化检查通过；本迭代 README 中注明脚本路径与执行方式。
5. **开箱即用**：业务方或 Agent 仅通过「阅读 spec 约定 + 使用模板」即可按 spec 驱动方式跑通从 /mrd 到 /merge 的一轮，无需安装额外工具或依赖。

---

## 五、不做的范围（本 SP）

- 不引入 OpenSpec 的 npm 包或 CLI。
- 不实现与现有 OpenSpec 使用场景的兼容或迁移（留作后续 TODO）。
- 不新增与 soul 冲突的流程或权限约定。

---

## 六、依赖与约束

- **权威**：soul（RULE、WORKFLOW、PROGRESS）不变；aispec 仅在其下增加约定与模板。
- **兼容**：与现有 iteration + spec（+ src）及 /mrd、/merge 行为一致；不改变既有步骤顺序，仅做「输入/输出与交付物」的显式声明与可选模板化。

---

## 七、验收与合并

- 验收通过条件：满足第四节全部验收标准，且自动化验收脚本执行通过。
- 合并：将本迭代产出的主约定文档、模板及验收脚本（若可纳入 spec）合并到 **spec/**，更新 **spec/README.md** 版本号；PRD/DESIGN/README 等合并到 spec 的合并视图。aispec 无 src，故仅更新 spec。
