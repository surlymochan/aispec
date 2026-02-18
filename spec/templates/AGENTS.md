# Agent 必读（aispec 采用方）

本仓库采用 **aispec** 约定。请按以下顺序阅读并遵守。

1. **权威约定**：[.aispec/spec/CONVENTIONS.md](.aispec/spec/CONVENTIONS.md)（若约定放在其他路径，以仓库 README 注明为准）
   - 工作流：/mrd、/merge 及中间环节（/opensp、/prd、/design、/coding、/review、/test）的输入、输出与交付物。
   - 迭代结构：MRD、PRD、DESIGN、README、可选 tasks；REVIEW、TEST 置于当前迭代目录。
   - PRD、DESIGN 须**先多询问、澄清再落笔**，不得凭假设编写。

2. **模板**：见 .aispec/spec/templates/（proposal 供 /mrd、tasks 供 /design 之后使用）。

3. **校验**：若仓库提供验收脚本或 `npx aispec-cli verify`，合并前须执行通过。

有歧义以 **CONVENTIONS** 为准；若 CONVENTIONS 路径与本文件不同，以仓库根 README 或本文件中的链接为准。
