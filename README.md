# aispec：工作区 AI 规范与变更收敛

aispec 是一套**轻量、约定优先**的 spec 驱动编程规范：工作流、项目结构、迭代与合并约定均以 **spec/CONVENTIONS** 为准，可与现有 /mrd～/merge 流程无缝衔接。**零依赖**：仅 Markdown 与模板即可使用；可选 **CLI**（`aispec init`、`aispec verify`）快速初始化与校验。**CLI 快捷安装**（已 push GitHub、未上架 npm）：`npm install -g git+https://github.com/surlymochan/aispec.git`，详见 [docs/cli-install.md](docs/cli-install.md)。

- **本仓库**：在 project 下承载规范定义与变更收敛；**aispec/spec 为最权威**；按 **iteration + spec** 做 SP 管理。
- **独立采用**：任意仓库可通过「复制 spec + 模板」或 **`npx aispec-cli init`** 采用 aispec，无需 clone 本仓库；见下「独立采用」与 [docs/standalone-adoption.md](docs/standalone-adoption.md)。
- **与 OpenSpec**：理念相近（先 spec 后实现）；aispec 无安装、无 API、以约定与模板为主；详见 [docs/openspec-comparison-and-open-source-readiness.md](docs/openspec-comparison-and-open-source-readiness.md)。

---

## 【Agent 必读】与本仓库协作时

1. **先看权威约定**：**[spec/CONVENTIONS.md](spec/CONVENTIONS.md)**（工作流、结构、约定）；有歧义以本 spec 为准。
2. **再看当前发布版本**：**[spec/README.md](spec/README.md)**（版本号与总览）。
3. **项目根入口**（可选）：[aispec.md](../../aispec.md)（本工作区对 aispec 的定制与 PROGRESS，与 spec 对齐）。
4. **具体迭代**：当前任务若属某 SP，仅加载 **该迭代目录**（如 `iteration/SP0xxx/`）的 MRD/PRD/DESIGN/README，避免无关迭代占满 context。
5. **PRD、DESIGN**：与 project 一致，Agent 须**先多询问、澄清再落笔**，不得凭假设编写。

---

## 目录结构

本仓库采用 **iteration + spec**，并包含可选 **cli/**（aispec CLI）：

```
aispec/
├── README.md           # 本文件：项目定位、独立采用、SP 管理
├── LICENSE             # MIT
├── CONTRIBUTING.md     # 贡献指南
├── CHANGELOG.md        # 根级入口：当前发布见 spec/，历史迭代见 iteration/
├── iteration/          # 各 SP 迭代（MRD、PRD、DESIGN、README 等）
├── spec/               # 当前发布版本（版本号、CONVENTIONS、templates）
│   ├── README.md
│   ├── CONVENTIONS.md
│   └── templates/      # proposal.md、tasks.md、AGENTS.md 等
├── cli/                # aispec CLI（init、verify），见 cli/README.md
└── docs/               # 扩展说明与独立采用指南
```

- **迭代开发**：新约定或变更以 **/mrd** 开新 SP（如 SP0002），按 [CONVENTIONS](spec/CONVENTIONS.md) 执行 /prd → /design → … → 验收后 **/merge** 合并到 **spec/** 并更新 spec/README 版本号。
- **合并规则**：/merge 时更新 **spec/** 及 **cli/**（若有）。**发布**：mrd → merge → **/public** → **/push**。/public 在 project 根执行 `bash private/aispec-private/scripts/push-to-public.sh`（脱敏检查、同步、测试、本地 commit，不 push）；/push 由人工执行 `bash private/aispec-private/scripts/do-push.sh` 或到 public/aispec 内 git push。详见 [docs/push-checklist-and-steps.md](docs/push-checklist-and-steps.md)。

---

## 独立采用（任意仓库使用 aispec）

无需 clone 本仓库，任选其一：

1. **CLI 初始化**（推荐）：先安装 `npm install -g git+https://github.com/surlymochan/aispec.git`，在目标仓库根目录执行 `aispec init`；或将 `node /path/to/aispec-private/cli/bin/aispec.js init` 换成本机路径。将创建 `.aispec/spec/`、`.aispec/spec/templates/` 及可选 `AGENTS.md`。详见 [docs/cli-install.md](docs/cli-install.md)。
2. **手动复制**：将本仓库的 `spec/CONVENTIONS.md`、`spec/templates/` 复制到目标仓库的 `.aispec/spec/` 或 `docs/aispec/`，并在 README 或 AGENTS.md 中注明「Agent 必读 .aispec/spec/CONVENTIONS.md」。

采用后：Agent 或人按 CONVENTIONS 执行 /mrd～/merge；可选运行 `aispec verify`（或同上路径/ npx 方式）校验约定与模板是否就绪。详见 [docs/standalone-adoption.md](docs/standalone-adoption.md)。

---

## 迭代列表（SP 管理）

| SP     | 说明               | 状态     |
|--------|--------------------|----------|
| SP0001 | 初始变更收敛       | 已完成，已合并到 spec |
| SP0002 | aispec 组件化能力（参考 OpenSpec，spec 驱动编程支持） | 已完成，已合并到 spec |
| SP0003 | 开源准备 + aispec CLI（LICENSE、CONTRIBUTING、独立采用、init/verify）+ 目录 aispec-private | 已完成，已合并到 spec |

后续新增迭代须同步更新上表与工作区 **aispec.md** 中 PROGRESS 的 aispec 条目（若本仓库处于带业务项目 aispec.md 的工作区内）。

---

## 文档索引

| 文件 | 用途 |
|------|------|
| **README.md** | 本文件：项目定位、目录结构、SP 管理 |
| **CHANGELOG.md** | 根级：指向当前发布（spec/）与历史迭代（iteration/） |
| **spec/README.md** | 当前发布版本号与总览 |
| **spec/CONVENTIONS.md** | 通用约定汇总（工作流、结构、部署；业务项目 aispec.md 为可选） |
| **spec/templates/** | proposal、tasks、AGENTS 等模板 |
| **cli/** | [aispec CLI](cli/README.md)（init、verify） |
| **iteration/SP0xxx/** | 各 SP 的 MRD、PRD、DESIGN、README、CHANGELOG 等 |
| **docs/** | [CLI 安装与使用](docs/cli-install.md)、[独立采用指南](docs/standalone-adoption.md)、[OpenSpec 对比与开源准备](docs/openspec-comparison-and-open-source-readiness.md)、[发布 npm 准备](docs/publishing-npm.md) |

---

## 与 project、soul 的关系

- **aispec/spec**：工作流、结构、约定的**最权威**定义；通用内容均在此，project 整体按 aispec 要求管理。
- **业务项目/aispec.md**（本工作区为 project/aispec.md）：**统一维护**该业务项目对 aispec 的特殊定制（目录、密钥、GitHub、Git 身份等）与 **PROGRESS** 进展；通用内容在 spec，不重复。有歧义以 **aispec/spec** 为准。
