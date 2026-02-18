# aispec 变更总结与收敛（通用部分）

本文档汇总**工作流、项目结构、部署与文档**方面的通用变更。执行时以 **project/soul/WORKFLOW.md、soul/RULE.md** 及各项目 README、spec 为准。

---

## 一、工作流（soul/WORKFLOW.md）

- **人仅有两个触发点**：**/mrd**、**/merge**。其余步骤（/opensp、/prd、/design、/coding、/review、/test、/deploy、/push、/check）默认随上述两指令自动串联或执行，也可由人单独触发。
- **/mrd 后自动链**：/opensp → /prd → /design → /coding → /review → /test → /deploy；关键 report（REVIEW、TEST）**放入当前迭代目录**。
- **/merge 后自动执行**：合并到 src+spec → 更新版本号 → /check → /push；可说「只合并不发布」以跳过 /push。
- **PRD、DESIGN**：Agent 须**先多询问、澄清再落笔**，不得凭假设编写；信息不足时列出待确认项请负责人补充。
- **工作流与 / 指令**仅在 **soul/WORKFLOW.md** 中定义；project/README 不重复流程细节，仅要求 Agent 必读 WORKFLOW 并遵守 PRD/DESIGN 澄清要求。

---

## 二、项目结构（iteration + src + spec）

- 采用该结构的项目包含：
  - **iteration/**：各 SP 迭代开发；过程产出的 REVIEW、TEST 等报告置于**对应迭代目录**下。
  - **src/**：每次 /merge 后的**可部署、可运行**产物（代码、编排、配置模板等）；「全部部署」仅从 src/ 读取。
  - **spec/**：当前发布版本的**说明与报告**（MRD/PRD/DESIGN/TEST/REVIEW/README）；须在 spec/README.md 标注**当前发布版本号**。
- **src/spec 合并规则**（详见 WORKFLOW 第五节）：
  - **src**：应合并验收通过的代码与运行依赖配置；不应合并密钥、.env 真实值、临时/草稿、未验收内容。
  - **spec**：应合并已与负责人确认的 PRD/DESIGN/TEST/REVIEW 等合并视图；不应合并未确认草稿、敏感信息。
  - 出现**条款矛盾或多种合理解释**时，Agent 须列出矛盾点或选项并**寻求负责人决策**，不得自行择一。

---

## 三、部署（iteration+src+spec 项目）

- **全部部署**：仅从 **src+spec** 发布版本部署，由项目内 **scripts/deploy-from-src.sh**（或项目约定的等价脚本）执行，不跑迭代脚本链。
- **单迭代部署**：使用项目入口 **deploy.sh** 的对应选项（如 sp0216 / sp0217 / sp0218 / sp0221 等），执行该迭代目录内脚本，**优先读取已合并的 src 内容**；具体菜单与编号以各项目 deploy 为准，新增迭代时须同步更新 deploy 菜单。

---

## 四、全局 README 与 soul

- **project/README.md**：泛化表述，不绑定具体工程名；工作流与 / 指令仅指向 soul/WORKFLOW.md；强调 Agent 必读 WORKFLOW 及 PRD/DESIGN 多询问。
- **soul/PROGRESS.md**：各 public/private 项目与迭代的当前状态、部署与访问信息；迭代列表与状态由 Agent 同步维护。

---

## 五、收敛结论

- 以上为通用约定；后续执行以 **soul/WORKFLOW.md、soul/RULE.md** 及各项目 README、spec 为准。
- 若后续有新的结构或工作流约定，应更新 soul/WORKFLOW、RULE 或本文档，并注明版本/日期。
