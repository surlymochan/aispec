# /mrd — 需求落盘

**指令**：将负责人需求（口述或文档）整理为当前迭代的 MRD，落盘为 MRD.md。

**输入**：负责人需求（口述或文档）。  
**输出**：需求方向或 MRD 内容，落盘至**当前迭代目录**的 `MRD.md`。

**执行步骤**：
1. 确认当前迭代目录（如 `iteration/SP0xxx/`）；若无则先与负责人确认迭代编号或执行 /opensp。
2. 根据需求整理：背景与目标、范围、交付物、验收标准、依赖与约束（参见 spec/templates/proposal.md）。
3. 将整理结果写入当前迭代的 `MRD.md`。
4. 后续可链式触发：/opensp（若未建目录）→ /prd → /design → …

**权威**：aispec spec/CONVENTIONS.md 第一、八节（8.1 表格 /mrd）。
