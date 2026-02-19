# /design — 技术方案

**指令**：基于 PRD 产出 DESIGN.md 与可选 tasks.md。

**输入**：PRD。  
**输出**：当前迭代目录下的 `DESIGN.md`、可选 `tasks.md`。

**执行步骤**：
1. 阅读当前迭代的 PRD.md。
2. 编写 DESIGN.md：产出位置与合并策略、技术方案要点、文档/配置清单、与 spec 的引用关系等。
3. 可选：复制 spec/templates/tasks.md 到当前迭代目录，按 DESIGN 拆解为可执行任务清单。
4. 后续可触发 /coding。

**权威**：aispec spec/CONVENTIONS.md 第八节（8.1 /design、8.2 变更提案结构、8.4 模板）。
