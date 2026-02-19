# /review — 审查报告

**指令**：对照实现与 PRD/DESIGN 产出 REVIEW 报告，置于当前迭代目录。

**输入**：实现产物与 PRD、DESIGN。  
**输出**：当前迭代目录下的 `REVIEW.md`。

**执行步骤**：
1. 阅读当前迭代的 PRD.md、DESIGN.md 与实现内容。
2. 对照检查：实现是否满足 PRD 验收、是否与 DESIGN 一致；列出问题与优化建议。
3. 将审查结论写入当前迭代的 `REVIEW.md`。
4. 若有必须落实的修改，先完成再进入 /test 或 /merge。

**权威**：aispec spec/CONVENTIONS.md 第八节（8.1 表格 /review；REVIEW 置于当前迭代目录）。
