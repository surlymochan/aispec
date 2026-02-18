# Agent 必读（aispec 采用方）

本仓库采用 **aispec** 约定。请按以下顺序阅读并遵守。

1. **权威约定**：[.aispec/spec/CONVENTIONS.md](.aispec/spec/CONVENTIONS.md)
   - 工作流：/mrd、/merge 及中间环节的输入、输出与交付物。
   - 迭代结构：MRD、PRD、DESIGN、README、可选 tasks；REVIEW、TEST 置于当前迭代目录。
   - PRD、DESIGN 须**先多询问、澄清再落笔**，不得凭假设编写。

2. **模板**：见 .aispec/spec/templates/（proposal 供 /mrd、tasks 供 /design 之后使用）。

3. **校验**：可选运行 `npx aispec-cli verify`；若仓库有验收脚本，合并前须执行通过。

有歧义以 **CONVENTIONS** 为准。
