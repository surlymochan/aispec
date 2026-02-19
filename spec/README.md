# aispec 当前发布版本

- **版本**：0.4.0（SP0004 合并）
- **说明**：工作区 AI 规范与变更收敛的通用部分；**权威在 aispec/spec**；业务项目 aispec.md 为可选；独立仓库可采用；CLI（init/verify）；**.cursor/commands/** 提供 12 个 aispec 指令文档供 Cursor 触发。

---

## 本版本内容

| 文档 | 说明 |
|------|------|
| [README.md](./README.md) | 本文件：版本与总览 |
| [CONVENTIONS.md](./CONVENTIONS.md) | 工作流、项目结构、部署、业务项目 aispec.md 约定、Spec 驱动编程（环节 I/O、模板、验收） |
| [templates/proposal.md](./templates/proposal.md) | 迭代意图模板（供 /mrd 使用） |
| [templates/tasks.md](./templates/tasks.md) | 实现任务清单模板 |
| [templates/AGENTS.md](./templates/AGENTS.md) | Agent 必读模板（独立采用时可放入项目根） |
| **Cursor commands** | 本仓库 `.cursor/commands/` 提供与 CONVENTIONS 一致的 12 个指令文档（/mrd、/opensp、/prd、/design、/coding、/review、/test、/deploy、/merge、/public、/push、/check）；采用 aispec 的工作区可将该目录复制到工作区根 `.cursor/commands/`，以便在 Cursor 中通过命令面板触发。 |

---

**迭代历史**：SP0001、SP0002、SP0003（开源准备 + CLI）、**SP0004**（Cursor commands 支持）已合并。后续变更以迭代形式开展，验收后合并到本 spec 并更新版本号。
