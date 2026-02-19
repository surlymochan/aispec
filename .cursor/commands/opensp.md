# /opensp — 打开迭代

**指令**：基于 MRD（或等价需求）创建迭代目录、落盘 MRD、更新项目入口（PROGRESS）。

**输入**：MRD 或等价需求（可已有 MRD.md）。  
**输出**：迭代目录 `iteration/SP0xxx/`、MRD 落盘、项目 README 或 aispec.md（PROGRESS）更新。

**执行步骤**：
1. 确定迭代编号（项目约定：SP-YYYYMMDD 或 SP0xxx）。
2. 创建 `iteration/SP0xxx/`，若已有 MRD 内容则写入 `MRD.md`，否则可复制 spec/templates/proposal.md 后填写并重命名/整理为 MRD.md。
3. 创建该迭代的 README.md（目标、状态、交付摘要）。
4. 在项目 README 或工作区 aispec-pm.md / aispec.md 的 PROGRESS 中新增该 SP，状态标为「规划中」或「进行中」。

**权威**：aispec spec/CONVENTIONS.md 第一、八节（8.1 表格 /opensp）。
