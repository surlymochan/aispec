# /merge — 合并到 src+spec

**指令**：验收通过、负责人确认后，将当前迭代合并到 src+spec、更新版本号、反哺 PRD/DESIGN/README，并执行自 merge 后版本的自动检查。

**输入**：验收通过、负责人确认。  
**输出**：spec/、src/（若有）更新；版本号在 spec/README.md 更新；质量门（若有验收脚本须通过）。

**执行步骤**：
1. 确认 REVIEW、TEST 已就绪且验收通过；若有验收脚本须执行并通过。
2. 将当前迭代的代码/配置合并到 **src/**，将已确认的 PRD/DESIGN/TEST/REVIEW 等合并到 **spec/**；实现与 PRD/DESIGN 有偏差时以实现为准反哺迭代内文档再合并。
3. 在 spec/README.md 中更新**当前发布版本号**。
4. 运行项目约定的「自 merge 后版本的自动检查」（若有）。不执行 /public、/push；可说「只合并不发布」跳过发布。

**权威**：aispec spec/CONVENTIONS.md 第一、二、八节（8.1 表格 /merge；src/spec 合并规则）。
