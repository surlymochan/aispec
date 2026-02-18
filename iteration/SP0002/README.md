# SP0002：aispec 组件化能力（spec 驱动编程支持）

本迭代参考 **OpenSpec**，在保持 soul 权威与现有 /mrd、/merge 流程的前提下，于 aispec 内抽取并落盘一套**组件化能力**，用于支持工作区的 spec 驱动编程。

- **MRD**：[MRD.md](MRD.md)
- **PRD**：[PRD.md](PRD.md)
- **DESIGN**：[DESIGN.md](DESIGN.md)
- **tasks**：[tasks.md](tasks.md)
- **状态**：已完成，已合并到 spec（v0.2.0）

**验收**：本迭代提供自动化验收脚本，执行通过方可 /merge。
- **脚本路径**：`iteration/SP0002/scripts/verify-sp0002.sh`
- **执行方式**（任选其一）：
  - 从 **project 根**：`bash private/aispec-private/iteration/SP0002/scripts/verify-sp0002.sh`
  - 从 **private/aispec-private**：`bash iteration/SP0002/scripts/verify-sp0002.sh`

后续 /coding 按 tasks.md 与 DESIGN 执行；REVIEW、TEST 产出于本目录，验收后合并到 **spec/** 并更新 spec 版本号。
