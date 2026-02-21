# aispec 变更总结与收敛（通用部分）

本文档汇总**工作流、项目结构、部署与文档**方面的通用变更。**合理情况下，project 整体按 aispec 要求管理；有歧义以本 spec（aispec）为准。**

### CONVENTIONS 与业务项目 aispec.md、README 的关系

| 文档/目录 | 角色 | 与 CONVENTIONS 的关系 |
|-----------|------|------------------------|
| **aispec/spec**（本 CONVENTIONS 等） | **最权威**：工作流、结构、约定的规范定义与仲裁；变更经 SP 迭代后合并到 spec | 本文件即权威来源之一；project 及各子项目均应按 aispec 要求管理。 |
| **业务项目/aispec.md** | **aispec 约定放置**：该业务项目对 aispec 的特殊定制（目录、密钥、GitHub、Git 身份等）与 PROGRESS 进展；通用内容在 spec | 不重复 CONVENTIONS；有歧义以 **aispec/spec** 为准。 |
| **工作区 README**（如 project/README.md） | **工作区入口**：Agent 必读、指向 aispec 与业务项目 aispec.md | 要求遵守 aispec 与业务项目 aispec.md；**权威在 aispec/spec**。 |
| **本仓库 README.md** | **aispec 仓库入口**：定位、目录、版本与采用方式 | 指向 **spec/**（含本 CONVENTIONS）；CONVENTIONS 为 spec 发布内容与权威定义的一部分。 |

总结：**aispec/spec = 最权威，project 按 aispec 要求管理；所有业务项目对 aispec 的特殊定制与 PROGRESS 进展，统一在业务项目的 aispec.md 下维护；有歧义以本 CONVENTIONS 为准。**

---

## 零、Spec 严格程度与问题规模

- **默认：Spec-first**。先有 MRD/PRD/DESIGN，再实现；单次迭代验收后文档保留于迭代目录与 spec，供追溯。
- **核心能力：Spec-anchored**。合并后 PRD/DESIGN 仍为事实参考；实现若有偏差，须在合并时反哺更新该迭代的 PRD/DESIGN。
- **按问题规模**：小改动（修 bug、配置、文案、依赖升级等）可不走完整 /mrd 链；新能力或行为变更须走完整迭代流程（/mrd → … → /merge）。
- **新建项目/迭代**：当用户**未主动触发 /mrd** 而 Agent 又**必须新建项目或新建迭代**时，Agent 须**主动基于上下文锁定需求、生成 MRD.md，并触发之后完整流程**（/opensp → /prd → /design → …）；生成 MRD 过程中有不确定处**优先与用户澄清**。**不允许有跳出工作流之外的逻辑实现和文件改动**（即不得在无 MRD/PRD/DESIGN 的前提下直接落实现代码或改库结构）。

---

## 一、工作流（/mrd、/merge、/public、/push）

- **人仅有四个触发点**：**/mrd**、**/merge**、**/public**、**/push**。顺序为 mrd → merge → public → push；其余步骤默认随上述指令自动串联或由人单独触发。
- **/mrd 后自动链**：/opensp → /prd → /design → /coding → /review → /test → /deploy；关键 report（REVIEW、TEST）**放入当前迭代目录**。
- **/mrd 后的默认行为**：用户仅触发 **/mrd** 时，Agent **默认接续执行** /prd → /design → /coding → /review → /test（必要时 /deploy），直至该链完成或用户明确暂停；不得在完成 MRD 后无故停止，除非负责人要求仅产出 MRD。
- **/merge 后自动执行**（到此为止，不自动 /public、/push）：质量门（若有验收脚本须通过）→ 合并到 src+spec → 更新版本号 → 合并时反哺 PRD/DESIGN/README → **自 merge 后版本的自动检查**（如验收脚本或约定脚本对合并后 spec/src 的校验）。
- **/public**（**脚本全自动**）：脱敏检查 → 同步到 public/aispec → **在 public 内运行测试** → git add & commit；**不执行 git push**。确保脱敏后最终呈现的 public 项目通过测试并已本地 commit，最后由人工执行 /push 更保险。
- **/push**（**仅人工触发**）：在 /public 完成后，由人在发布目录内执行 git push。**仅此一步为人工**，避免误推。
- **脱敏（/public 必过）**：脚本会自动检查拟发布内容（本机路径、硬编码 Token 等）；未通过则中止并提示。日常须保持 private 拟发布内容已脱敏（密钥、.env、本机路径等仅占位符或约定描述）。
- **public 内测试**：同步到 public 后，脚本会在 **public/aispec** 内运行约定测试（默认 `node cli/bin/aispec.js verify`）；未通过则中止，不 commit、不 push，确保脱敏后最终呈现的项目可通过测试。
- **PRD、DESIGN**：Agent 须**先多询问、澄清再落笔**，不得凭假设编写；信息不足时列出待确认项请负责人补充。
- **发布检查清单（/check）**：由 **/public 脚本**自动执行（脱敏检查 + 同步 + 测试 + 本地 commit）；**/push** 由人工执行，推送前可在 public/aispec 内自行复核。

---

## 二、项目结构（iteration + src + spec）

- **iteration/**：各 SP 迭代开发；过程产出的 REVIEW、TEST 等报告置于**对应迭代目录**下。
- **src/**：每次 /merge 后的**可部署、可运行**产物；「全部部署」仅从 src/ 读取。
- **spec/**：当前发布版本的说明与报告；须在 spec/README.md 标注**当前发布版本号**。
- **迭代（SP）命名规范（通用）**：**SP-YYYYMMDD** 或项目既有风格（如 SP0xxx）；同日期多条可加序号 **SP-YYYYMMDD-序号**。各项目 iteration 命名风格在该项目 README 或 **aispec.md**（PROGRESS）中注明。
- **SP 与主文件隔离**：在 SP 内容被 **/merge** 之前，**不得污染项目主文件**（src/、spec/、根目录发布物）；**所有变更须控制在该 SP 目录之内**；**/merge 之后**方可与主文件（src/spec）合并。
- **迭代与项目状态**：各迭代及项目在 **aispec-pm.md** 或项目 README 中须**明确标注状态**，例如：**规划中** | **进行中** | **已合并**（或等价表述），便于 Agent 与人工一致认知。
- **private 先于 public**：**所有项目默认必须先有 private 项目，后有 public 项目**；**public 项目应由执行 /public 命令后产生**，不得在未走完工作流（/merge 等）前于 public 下新建或维护该目录。
- **src/spec 合并规则**：src 应合并验收通过的代码与运行依赖配置，不应合并密钥、.env 真实值、临时/草稿；spec 应合并已与负责人确认的 PRD/DESIGN/TEST/REVIEW，不应合并未确认草稿、敏感信息。**合并时反哺**：实现与 PRD/DESIGN 有偏差时以实现为准更新迭代内文档再合并到 spec。出现条款矛盾时 Agent 须列出选项并**寻求负责人决策**。

---

## 三、密钥与配置、发布（通用约定）

- **密钥**：所有敏感信息**仅**放在工作区约定的密钥目录（如 `private/keys/`）下，按项目分子目录；**禁止**在代码或 public 中硬编码密钥；文档中仅用占位符。
- **发布**：从 private 脱敏后放入 public，推送到约定远程；发布前必过 /check（脱敏检查、可选在 public 内运行测试）。具体步骤与脚本由项目或工作区约定（如 /public、/push 见相关文档）。

---

## 四、部署（iteration+src+spec 项目）

- **全部部署**：仅从 **src+spec** 发布版本部署，由项目内约定脚本执行。
- **单迭代部署**：使用项目入口 deploy 的对应选项，执行该迭代目录内脚本，**优先读取已合并的 src 内容**；新增迭代时须同步更新 deploy 菜单。

---

## 五、工作区与独立仓库（业务项目 aispec.md 为可选）

- **通用内容**均在 **本 CONVENTIONS** 中定义，任意采用 aispec 的仓库均以本文档为准。

### 5.1 独立仓库采用（无 aispec.md）

- 若**仅**在单个仓库内使用 aispec（无「业务项目 + aispec.md」结构）：将本 CONVENTIONS 与 **spec/templates/** 复制到该仓库的 **.aispec/spec/**（或 `docs/aispec/`），并在仓库 README 或 **AGENTS.md** 中注明「Agent 必读 .aispec/spec/CONVENTIONS.md」。
- 可选使用 **aispec CLI**：`npx aispec-cli init` 初始化；`npx aispec-cli verify` 校验约定与模板是否就绪。
- 迭代目录可置于该仓库内任意约定路径（如 `iteration/`、`.aispec/iteration/`），在 CONVENTIONS 或 README 中注明即可。

### 5.2 带业务项目的工作区（可选）

- 当 aispec 用于**含多个项目或需项目专属定制的工作区**时，约定：**所有业务项目对 aispec 的特殊定制（如目录结构、密钥路径、GitHub 对应、Git 身份）以及 PROGRESS 进展，统一在该业务项目的 aispec.md 下维护**。
  - **业务项目/aispec.md**：可含「工作流指向（CONVENTIONS）」「本项目专属规则」「PROGRESS 进展」等节；由 Agent 同步维护 PROGRESS。
  - **project/README.md**（或工作区入口）：必读顺序：README → aispec/spec → 业务项目 aispec.md（若存在）。
- 若不使用业务项目 aispec.md，忽略本节即可。

---

## 六、迭代目录与文档、审查报告（通用）

- 迭代目录内建议包含：**MRD.md**、**PRD.md**、**DESIGN.md**、**README.md**、可选 **tasks.md**；REVIEW、TEST 置于**该迭代目录下**。**MRD** 由负责人编写或口述；**PRD、DESIGN、README** 由 Agent 根据 MRD 与澄清创建并维护。PRD 验收标准尽量可验证；若有自动化验收脚本须在迭代 README 中注明执行方式。
- **审查报告**：每次审查在工作区约定目录（如 `review/`）下建 `reporter-YYYY-MM-DD-HH-MM/` 子目录，内含 **review-report.md**（审查结论）与 **optimization-conclusion.md**（优化结论）；后者须在负责人确认落地且 Agent 执行完成后才填写「已落实」记录，不得在审查完成时自动标为已落实。

---

## 七、收敛结论

- 以上为通用约定；后续执行以 **本 spec（aispec/spec/CONVENTIONS 等）** 及业务项目 **aispec.md**（PROGRESS、项目专属规则）、各项目 README 为准；**有歧义以 aispec 为准**。
- 若后续有新的结构或工作流约定，应更新**本 CONVENTIONS**（或经 SP 合并到 spec），并注明版本/日期。

---

## 八、Spec 驱动编程（/mrd～/merge 输入输出与约定）

本节为 **spec 驱动编程** 的组件化约定：各环节**输入、输出与交付物**、迭代**变更提案结构**、**Delta 语义**及**模板与验收**。以**本 CONVENTIONS** 为准，便于 Agent 与业务项目开箱即用。

### 8.1 各环节输入、输出与交付物

| 环节 | 输入 | 输出 / 交付物 | 交付物放置位置 |
|------|------|----------------|----------------|
| **/mrd** | 负责人需求（口述或文档） | 需求方向或 MRD 内容 | 由 Agent 整理后落盘至当前迭代 MRD.md；**完成后默认接续** /prd → /design → … → /test |
| **/opensp** | MRD（或等价需求） | 迭代目录、MRD 落盘、项目入口更新 | iteration/SP0xxx/；项目 README 或 aispec.md（PROGRESS） |
| **/prd** | MRD + 澄清结果 | PRD.md | 当前迭代目录 iteration/SP0xxx/PRD.md |
| **/design** | PRD | DESIGN.md、可选 tasks.md | 当前迭代目录 |
| **/coding** | DESIGN、tasks.md | 代码与配置等实现产物 | 当前迭代目录或 src（按项目约定） |
| **/review** | 实现与 PRD/DESIGN | **REVIEW 报告** | **当前迭代目录**（如 REVIEW.md） |
| **/test** | 实现与验收标准 | **TEST 报告** | **当前迭代目录**（如 TEST.md） |
| **/deploy** | src 或迭代产物、部署脚本 | 部署结果与验证结论 | 可记录于迭代 README 或单独报告 |
| **/merge** | 验收通过、负责人确认 | 合并到 src+spec、版本号更新、反哺 PRD/DESIGN/README、自 merge 后版本的自动检查 | spec/、src/（若有）；质量门：验收脚本通过 |
| **/public** | 人触发 | 脱敏检查 → 同步到发布目录 → 在发布目录内测试 → git add & commit（不 push） | 由工作区或维护流程约定执行；测试未通过则不 commit |
| **/push** | 人触发 | 在发布目录内执行 git push（仅此一步人工，更保险） | 由维护者按约定执行 |

- **REVIEW** 在 **/review** 环节生成，**TEST** 在 **/test** 环节生成，二者均置于**当前迭代目录**，便于追溯与合并时引用。
- **发布流程**：**/mrd** → **/merge** → **/public**（脚本准备并本地 commit）→ **/push**（人工执行 git push）；/public 与 /push 分离，最后一步推送由人执行更保险。

### 8.2 变更提案结构（迭代目录）

- 单次迭代（SP）目录内建议包含：**MRD.md**、**PRD.md**、**DESIGN.md**、**README.md**、可选 **tasks.md**；过程产出的 **REVIEW.md**、**TEST.md** 等置于**当前迭代目录**。
- 与 OpenSpec 的对应（仅说明）：OpenSpec proposal → 本工作区 **/mrd 环节**（proposal 模板填写的迭代意图落盘为 MRD.md）；OpenSpec specs/design/tasks → 本工作区 DESIGN+tasks.md；归档 → 本工作区 /merge 后合并到 spec/。不引入额外 phase gate，保持迭代级、轻量。

### 8.3 Delta 语义（可选表述）

- 描述变更时，可显式标注 **ADDED**、**MODIFIED**、**REMOVED**（大小写不限），便于 spec 与实现一致、合并时反哺与审计。
- 示例：「**ADDED**：xxx 功能」「**MODIFIED**：yyy 接口」「**REMOVED**：zzz 配置」。不强制每处都标，推荐在 PRD/DESIGN/REVIEW 中选用。

### 8.4 模板与验收

- **模板**：见 **spec/templates/**，至少包含 **proposal.md**（迭代意图）、**tasks.md**（实现任务清单）。
  - **proposal.md** 供 **/mrd 环节**使用：复制到当前迭代目录后填写「目标、范围、验收」等，整理后落盘为 **MRD.md**；/prd 则基于 MRD + 澄清单独产出 PRD.md。
  - **tasks.md** 供 **/design 之后**使用：复制到当前迭代目录后按 DESIGN 拆解为可执行任务清单。
- **验收**：若迭代约定自动化验收脚本（见该迭代 README），/merge 前须执行并通过，否则不得合并。
