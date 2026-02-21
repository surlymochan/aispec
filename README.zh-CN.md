# aispec — 轻量级「约定优先」的 spec 驱动协作

**aispec** 是一套约定优先、零依赖的 spec 驱动工作流：先约定**做什么**（MRD → PRD → DESIGN），再写代码。仅用 Markdown 与模板；可选 CLI 做初始化和校验。适用于任意仓库，无绑定。

[English](README.md)

---

## 什么是 aispec？

- **Spec 优先**：MRD（需求意图）→ PRD（需求规格）→ DESIGN（技术方案）→ 编码 → 评审 → 测试 → 合并。规范与产出都在仓库内，上下文可追溯。
- **约定优于工具**：一份 [CONVENTIONS.md](spec/CONVENTIONS.md) 定义工作流、结构与交付物。复制 `spec/` 或执行 `aispec init` 即可；无运行时依赖。
- **便于 Agent**：清晰的触发点（/mrd、/merge 等）与交付物位置，方便 AI 助手与人工按同一流程协作。

---

## 快速开始

**方式一 — CLI（推荐）**

```bash
npm install -g git+https://github.com/surlymochan/aispec.git
cd 你的项目
aispec init
aispec verify
```

会在当前仓库创建 `.aispec/spec/`（CONVENTIONS + 模板）及可选的根目录 `AGENTS.md`。更多安装方式见 [docs/cli-install.md](docs/cli-install.md)。

**方式二 — 手动**

将本仓库的 `spec/CONVENTIONS.md` 与 `spec/templates/` 复制到你的仓库（如 `.aispec/spec/` 或 `docs/aispec/`），并在 README 或 AGENTS.md 中注明「Agent 必读 .aispec/spec/CONVENTIONS.md」。

**方式三 — Cursor 指令（v0.4.0+）**

将本仓库的 `.cursor/commands/` 复制到工作区根目录 `.cursor/commands/`，即可在 Cursor 命令面板中执行 `/mrd`、`/merge`、`/public` 等。各指令文件**仅引用** [spec/CONVENTIONS.md](spec/CONVENTIONS.md)，不重复条文；见 [.cursor/commands/README.md](.cursor/commands/README.md)。

---

## 示例：业务项目如何使用 aispec

### 1. 采用后的目录结构

一个使用 aispec 的产品仓库可以是这样（最简）：

```
my-service/
├── README.md
├── .aispec/
│   └── spec/
│       ├── CONVENTIONS.md    # 工作流与结构（或指向共享 spec）
│       └── templates/        # proposal.md、tasks.md、AGENTS.md
├── iteration/                # 可选：按变更建目录
│   └── SP-20250201/
│       ├── MRD.md
│       ├── PRD.md
│       ├── DESIGN.md
│       └── README.md
├── spec/                     # 当前发布版 spec（/merge 后）
│   └── README.md             # 版本与范围
└── src/
```

仅独立采用、暂无迭代时：保留 `.aispec/spec/` + 你的代码即可；CONVENTIONS 仍定义日后做 /mrd～/merge 时的约定。

### 2. 各指令怎么用（工作流示例）

| 触发 | 含义 | 示例 / 产出 |
|------|------|-------------|
| **/mrd** | 落盘需求意图 | 在 `iteration/SP-20250201/` 下建 MRD.md（目标、范围、验收标准）。 |
| **/prd** | 从 MRD 产出需求规格 | Agent 在同目录写 PRD.md；先与负责人澄清再落笔。 |
| **/design** | 从 PRD 产出技术方案 | Agent 在同目录写 DESIGN.md（及可选 tasks.md）。 |
| **/coding** | 按 DESIGN/tasks 实现 | 代码与配置放在 iteration 或 `src/`，按项目约定。 |
| **/review** | 对照 PRD/DESIGN 评审 | 在同目录产出 REVIEW.md。 |
| **/test** | 按验收标准测试 | 在同目录产出 TEST.md。 |
| **/merge** | 合并到主 spec/代码库 | 将验收通过内容合并到 `spec/`（及 `src/`）；更新 spec/README.md 版本；若实现与 PRD/DESIGN 有偏差则反哺更新。 |
| **/public**、**/push** | 对外发布（如 GitHub） | 仅在工作区使用「private → public」流程时；见 CONVENTIONS。 |

**串联示例（概念）：**

```text
/mrd    → 建 iteration/SP-20250201/，写 MRD.md（如「新增导出 API」）。
/prd    → 写 PRD.md（需求与验收标准）。
/design → 写 DESIGN.md、tasks.md。
/coding → 实现；代码放入 src/ 或约定位置。
/review → 写 REVIEW.md；按意见修改。
/test   → 写 TEST.md；跑验收。
/merge  → 合并到 spec/ 与 src/；更新 spec/README.md 版本。
```

输入输出、模板与质量门详见 [spec/CONVENTIONS.md](spec/CONVENTIONS.md)。

---

## 本仓库说明

- **spec/** — 权威工作流与结构：[CONVENTIONS.md](spec/CONVENTIONS.md)、[spec/README.md](spec/README.md)（版本）与 [templates/](spec/templates/)。
- **cli/** — 可选 [aispec CLI](cli/README.md)：`init`、`verify`。
- **docs/** — [CLI 安装](docs/cli-install.md)、[独立采用](docs/standalone-adoption.md)、[与 OpenSpec 对比](docs/openspec-comparison-and-open-source-readiness.md)。

**在本仓库或包含它的工作区内协作时**：先读 [spec/CONVENTIONS.md](spec/CONVENTIONS.md)。若工作区根目录有 **aispec.md**，其中为项目专属规则与 PROGRESS；CONVENTIONS 仍为唯一权威。

---

## 与 OpenSpec 的对比

| | OpenSpec | aispec |
|---|----------|--------|
| **重心** | spec 驱动框架 + CLI + 斜杠命令 | 约定 + 模板 + 可选 CLI |
| **安装** | npm 包 | 复制 spec 或 `aispec init`；无运行时依赖 |
| **产出** | proposal、design、tasks、spec 增量 | MRD、PRD、DESIGN、tasks；合并时反哺 spec |
| **权威** | Schema + specs/ | 一份 CONVENTIONS + spec/ |

更完整对比见 [docs/openspec-comparison-and-open-source-readiness.md](docs/openspec-comparison-and-open-source-readiness.md)。

---

## 文档索引

| 文档 | 用途 |
|------|------|
| [README.md](README.md) | English |
| [spec/CONVENTIONS.md](spec/CONVENTIONS.md) | 工作流、结构、交付物、模板 |
| [spec/README.md](spec/README.md) | 当前发布版本与内容 |
| [spec/templates/](spec/templates/) | proposal、tasks、AGENTS 模板 |
| [cli/README.md](cli/README.md) | CLI 使用说明（init、verify） |
| [docs/cli-install.md](docs/cli-install.md) | CLI 安装与运行 |
| [docs/standalone-adoption.md](docs/standalone-adoption.md) | 在任意仓库采用 aispec |
| [CHANGELOG.md](CHANGELOG.md) | 发布与迭代历史 |

---

## 许可与贡献

- **许可**：[MIT](LICENSE)
- **贡献**：[CONTRIBUTING.md](CONTRIBUTING.md)

未上架 npm；从 GitHub 使用：`npm install -g git+https://github.com/surlymochan/aispec.git`，或 clone 本仓库后在仓库根执行 `npm run link`。
