# SP0002 MRD：aispec 组件化能力 —— 基于 OpenSpec 的 spec 驱动编程支持

本迭代参考 **OpenSpec**（Fission-AI，spec-driven development for AI coding assistants），在**不改变 project 现有管理权威（soul）**的前提下，于 **private/aispec-private** 内抽取并落盘一套**组件化能力**，用于支持本工作区的 **spec 驱动编程**。

---

## 参考：OpenSpec 要点

- **理念**：先对齐 spec、再写代码（agree before you build）；轻量、迭代、适配既有代码库（brownfield）。
- **结构**：变更以独立目录承载（如 `changes/<name>/`），内含 proposal、specs、design、tasks；有「当前权威 spec」与「变更提案」的区分；支持归档与审计。
- **流程**：创建变更 → 生成/迭代规划文档（proposal、specs、design、tasks）→ 按任务实现 → 完成后归档并更新权威 spec。
- **与 AI 协作**：通过约定好的 artifact（proposal、specs、design、tasks）与 AI 对齐，减少需求散落在对话中的问题。

---

## 需求要点

1. **对齐现有管理方式**  
   - 权威仍在 **soul**（RULE、WORKFLOW、PROGRESS）；aispec 不替代 soul，只在其下增加「spec 驱动」的**可复用组件与约定**。  
   - 与现有 **/mrd、/merge** 及 **iteration + spec（+ src）** 结构兼容：新能力应可被现有 SP 流程与合并规则使用或引用。

2. **抽取并定义 aispec 的组件化能力**  
   - 在 aispec 内以**可复用、可引用**的方式定义一组能力，用于支撑 spec 驱动编程，例如：  
     - **Spec 文档结构与模板**：如「当前权威 spec」的目录与文件约定、单次变更的提案结构（含 proposal / 需求与场景 / design / tasks 等）。  
     - **变更（Delta）语义**：对「新增 / 修改 / 删除」的表述约定，便于在 spec 与实现间一致地描述变更。  
     - **与工作流衔接**：如何与 /mrd、/opensp、/prd、/design、/merge 等步骤对应；何时视为「变更提案已定稿」、何时合并回权威 spec。  
     - **可被业务项目或 Agent 引用的片段**：如模板、检查清单、术语表，供 openclaw-cn-private 等业务项目或 Agent 直接引用，保证 spec 风格一致。

3. **产出形态**  
   - 上述能力以 **spec 内文档与约定** 为主（aispec 无 src，故不产出可执行代码）；可包含：  
     - spec 目录下新增或修订的说明文档（如「Spec 驱动编程约定」「变更提案结构」「Delta 语义」等）；  
     - 可选：模板或示例（如 Markdown 模板、示例变更目录结构），便于新 SP 或新项目复用。  
   - 本迭代产出的 PRD/DESIGN/README 等按既有流程置于 **iteration/SP0002/**，验收后合并到 **spec/** 并更新 spec 版本号。

4. **不做的范围**  
   - 不引入与 soul 冲突的流程或权限约定。  
   - 不要求全工作区强制使用 OpenSpec 工具或 CLI；仅借鉴其概念并在 project 现有结构下落地为「aispec 的组件化能力」。

---

## 预期成果

- 一套在 **aispec/spec** 中可查阅、可引用的 **spec 驱动编程** 约定与组件（结构、模板、Delta 语义、与 /mrd、/merge 的衔接）。  
- 业务项目（如 openclaw-cn-private）或 Agent 可按需引用这些约定，实现「先 spec 后实现」的协作方式，并与现有 iteration + spec（+ src）及 soul 权威保持一致。

由负责人通过 **/mrd** 触发本需求；Agent 创建本迭代目录并落盘本 MRD，后续按 soul/WORKFLOW 执行 /prd → /design → … → 验收后 **/merge** 合并到 spec。
