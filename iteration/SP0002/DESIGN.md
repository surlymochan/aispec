# SP0002 DESIGN：aispec 组件化能力（spec 驱动编程支持）

基于 [PRD.md](PRD.md) 的技术方案。验收后合并到 spec/。

---

## 一、主约定文档选型

- **选型**：**(a) 在 CONVENTIONS.md 中新增章节**，不新增独立文件。
- **理由**：与「统一成一份文件、减少重复与矛盾」一致；CONVENTIONS 已是 spec 的通用约定入口，扩展后仍单一入口、易引用。
- **做法**：在现有 **spec/CONVENTIONS.md** 末尾增加 **「六、Spec 驱动编程（/mrd～/merge 输入输出与约定）」**，内含：
  - 从 /mrd 到 /merge 的**各环节输入、输出与交付物**（表格形式，见下 1.1）；
  - **变更提案结构**（迭代目录内 MRD/PRD/DESIGN/README、tasks、REVIEW/TEST 等）（见下 二）；
  - **Delta 语义**（ADDED/MODIFIED/REMOVED 的书写约定）（见下 三）；
  - **模板与验收**：模板所在路径（spec/templates/）、验收脚本路径与执行方式（见下 四、五）。
- **与现有章节关系**：一～五节保持不变；第六节为新增，不改写前五节内容，仅追加。

---

## 二、各环节输入 / 输出与交付物（写入 CONVENTIONS 第六节）

以下表格将写入 **CONVENTIONS.md 第六节**，作为「工作流完整且声明清晰」的交付内容。

| 环节 | 输入 | 输出 / 交付物 | 交付物放置位置 |
|------|------|----------------|----------------|
| **/mrd** | 负责人需求（口述或文档） | 需求方向或 MRD 内容 | 由 Agent 整理后落盘至当前迭代 MRD.md |
| **/opensp** | MRD（或等价需求） | 迭代目录、MRD 落盘、项目入口更新（如 deploy 菜单 / PROGRESS） | iteration/SP0xxx/；项目 README 或 soul/PROGRESS |
| **/prd** | MRD + 澄清结果 | PRD.md | 当前迭代目录 iteration/SP0xxx/PRD.md |
| **/design** | PRD | DESIGN.md、可选 tasks.md | 当前迭代目录 |
| **/coding** | DESIGN、tasks.md | 代码与配置等实现产物 | 当前迭代目录或 src（按项目约定） |
| **/review** | 实现与 PRD/DESIGN | **REVIEW 报告** | **当前迭代目录**（如 REVIEW.md） |
| **/test** | 实现与验收标准 | **TEST 报告** | **当前迭代目录**（如 TEST.md） |
| **/deploy** | src 或迭代产物、部署脚本 | 部署结果与验证结论 | 可记录于迭代 README 或单独报告 |
| **/merge** | 验收通过、负责人确认 | 合并到 src+spec、版本号更新、可选 /check、/push | spec/、src/（若有）；质量门：验收脚本通过 |

- REVIEW、TEST 在 **/review、/test** 环节生成，交付物置于**当前迭代目录**；在 CONVENTIONS 第六节中明确写出，满足 PRD「工作流中声明每环节输入输出与交付物」的要求。

---

## 三、变更提案结构（写入 CONVENTIONS 第六节）

- **迭代目录内建议文档**：MRD.md、PRD.md、DESIGN.md、README.md、可选 **tasks.md**；过程产出 **REVIEW.md**、**TEST.md** 等置于**当前迭代目录**。
- **与 OpenSpec 的对应**（仅说明，不引入多余步骤）：
  - OpenSpec proposal → 本工作区 **MRD + PRD**（迭代意图与需求）；
  - OpenSpec specs/design/tasks → 本工作区 **DESIGN + tasks.md**；
  - 归档与审计 → 本工作区 **/merge 后合并到 spec/**。
- 不新增「phase gate」或与 soul 不一致的步骤，保持迭代级、轻量。

---

## 四、Delta 语义（写入 CONVENTIONS 第六节）

- **约定**：在描述变更时，可显式标注 **ADDED**、**MODIFIED**、**REMOVED**（大小写不限），便于 spec 与实现一致、合并时反哺与审计。
- **写法示例**：在 PRD/DESIGN 或合并说明中写「**ADDED**：xxx 功能」「**MODIFIED**：yyy 接口」「**REMOVED**：zzz 配置」；可选在 REVIEW/TEST 中按此标注。
- 不强制每处都标；仅作为**可选、推荐**的表述方式，供 Agent 与负责人选用。

---

## 五、模板存放与命名

- **路径**：**spec/templates/**（合并后在 spec 下可被全工作区引用）。
- **必备模板**：
  - **spec/templates/proposal.md**：迭代意图说明（与 MRD/PRD 对应），含标题、背景、目标、范围、不做范围等占位节。
  - **spec/templates/tasks.md**：实现任务清单，含任务编号、描述、验收要点等占位。
- **使用方式**：业务项目或 Agent 从 `private/aispec-private/spec/templates/` 复制到当前迭代目录后填写；CONVENTIONS 第六节中注明「模板见 spec/templates/」。

---

## 六、自动化验收脚本

- **路径**：**iteration/SP0002/scripts/verify-sp0002.sh**（本迭代内）；合并后可复制为 **private/aispec-private/scripts/verify-spec-driven.sh** 作为长期验收脚本（可选，本 SP 仅交付迭代内脚本即可）。
- **执行方式**（写入本迭代 README）：
  - 从 **project 根**执行：`bash private/aispec-private/iteration/SP0002/scripts/verify-sp0002.sh`
  - 或从 **private/aispec-private** 执行：`bash iteration/SP0002/scripts/verify-sp0002.sh`
- **检查项**（脚本逻辑）：
  1. **主约定文档**：`private/aispec-private/spec/CONVENTIONS.md` 存在，且包含「Spec 驱动编程」或「六、」及「/mrd」「/merge」等关键字（即第六节已存在且含工作流描述）。
  2. **必备模板**：`private/aispec-private/spec/templates/proposal.md`、`private/aispec-private/spec/templates/tasks.md` 存在。
  3. **各环节声明**：CONVENTIONS.md 中能解析到至少 7 个环节（/mrd、/opensp、/prd、/design、/review、/test、/merge）的输入/输出或交付物描述（可通过 grep 关键字或表格行数做最小检查）。
- **退出码**：全部通过为 0，任一项失败为非 0 并输出失败项。

---

## 七、合并后 spec 结构（预期）

```
spec/
├── README.md           # 版本号与总览（更新）
├── CONVENTIONS.md      # 现有一～五 + 第六节 Spec 驱动编程（新增）
└── templates/          # 新增
    ├── proposal.md
    └── tasks.md
```

- 验收脚本在**本迭代**位于 `iteration/SP0002/scripts/verify-sp0002.sh`；合并时可将脚本内容复制到 `spec/` 或 `private/aispec-private/scripts/` 作为长期资产（由合并时决定，PRD 不强制脚本进 spec 目录）。

---

## 八、实现顺序（/coding 建议）

1. 在 **spec/CONVENTIONS.md** 末尾新增 **第六节**（工作流 I/O 表、变更提案结构、Delta 语义、模板路径与验收说明）。
2. 新建 **spec/templates/** 并添加 **proposal.md**、**tasks.md**（占位 + 简要说明）。
3. 新建 **iteration/SP0002/scripts/verify-sp0002.sh**，实现上述三项检查，可执行、退出码正确。
4. 更新 **iteration/SP0002/README.md**：注明验收脚本路径与执行方式。
5. 自测：运行验收脚本通过；阅读 CONVENTIONS 第六节 + 使用模板可理解「从 /mrd 到 /merge」的输入输出与交付物。

---

## 九、与 soul 的衔接

- 不修改 soul/WORKFLOW.md、soul/RULE.md 的条文；CONVENTIONS 第六节**引用**「以 soul/WORKFLOW 为准」，仅做输入/输出与交付物的**显式罗列**与模板/验收约定，避免与 soul 冲突。
