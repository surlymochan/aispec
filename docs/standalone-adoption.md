# aispec 独立采用指南

在**任意仓库**中使用 aispec，无需 clone 本仓库。任选以下方式之一。

---

## 方式一：CLI 初始化（推荐）

在目标仓库根目录执行（当前未上架 npm，任选其一）：

```bash
# 从本机 aispec 仓库路径（将 /path/to/aispec-private 换成实际路径）
node /path/to/aispec-private/cli/bin/aispec.js init

# 或从 GitHub（需仓库已 push 到 GitHub）
npx github:surlymochan/aispec#main init
```

将创建：

- **.aispec/spec/CONVENTIONS.md**：精简版约定（工作流、迭代结构、模板路径）
- **.aispec/spec/templates/**：proposal.md、tasks.md
- 可选 **AGENTS.md**（项目根）：Agent 必读说明，指向 .aispec/spec/CONVENTIONS.md

之后可运行 `aispec verify`（或同上 `node ... verify` / `npx ... verify`）校验约定与模板是否就绪。  
完整安装方式见 [cli-install.md](cli-install.md)。

---

## 方式二：手动复制

1. 从本仓库复制以下内容到目标仓库：
   - **spec/CONVENTIONS.md** → 目标仓库 **.aispec/spec/CONVENTIONS.md**（或 `docs/aispec/CONVENTIONS.md`）
   - **spec/templates/** → 目标仓库 **.aispec/spec/templates/**（或 `docs/aispec/templates/`）
2. 在目标仓库 **README.md** 或 **AGENTS.md** 中增加：
   - 「本仓库采用 aispec 约定。Agent 必读：**.aispec/spec/CONVENTIONS.md**（或你放置的路径）。」
3. 可选：复制 **spec/templates/AGENTS.md** 为项目根 **AGENTS.md**，按需修改路径。

---

## 采用后如何使用

- **人**：按 CONVENTIONS 触发 /mrd、/merge（或口头/文档等价）。
- **Agent**：必读 CONVENTIONS；按环节执行 /opensp、/prd、/design、/coding、/review、/test；REVIEW、TEST 置于当前迭代目录；合并时反哺 PRD/DESIGN。
- **迭代目录**：在目标仓库中自定路径（如 `iteration/`、`.aispec/iteration/`），在 CONVENTIONS 或 README 中注明即可。
- **校验**：`npx aispec-cli verify`（若已用 CLI init）或自写脚本检查 CONVENTIONS 与模板存在性。

---

## 与「带业务项目 aispec.md 的工作区」的区别

| 项目 | 独立仓库采用 | 带业务项目的工作区（如 project） |
|------|----------------|--------------------------------|
| 约定来源 | .aispec/spec/ 或 docs/aispec/ | 通常为本仓库 spec/ 或工作区内 aispec 的 spec/ |
| PROGRESS / 项目专属规则 | 不需要 | 业务项目/aispec.md（项目专属与 PROGRESS 统一维护） |
| 入口 | 该仓库 README 或 AGENTS.md | project/README + aispec.md |

CONVENTIONS 第五节已说明：业务项目 aispec.md 为**可选**，仅在使用「含项目专属定制」的工作区时适用。
