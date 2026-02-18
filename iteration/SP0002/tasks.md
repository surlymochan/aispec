# SP0002 实现任务清单

按 [DESIGN.md](DESIGN.md) 第八节顺序执行。

| 序号 | 任务 | 验收要点 |
|------|------|----------|
| 1 | 在 spec/CONVENTIONS.md 末尾新增第六节「Spec 驱动编程」 | 含工作流 I/O 表（/mrd～/merge）、变更提案结构、Delta 语义、模板路径与验收说明；与现有一～五节无冲突 |
| 2 | 新建 spec/templates/ 并添加 proposal.md、tasks.md | 两文件存在；内容为占位 + 简要说明，复制即可用于新迭代 |
| 3 | 新建 iteration/SP0002/scripts/verify-sp0002.sh | 检查 CONVENTIONS 第六节存在、两模板存在、各环节 I/O 已声明；可执行且退出码正确 |
| 4 | 更新 iteration/SP0002/README.md | 注明验收脚本路径与执行方式（从 project 根或从 aispec 执行） |
| 5 | 自测：运行验收脚本通过 | 脚本 exit 0；阅读 CONVENTIONS 第六节 + 模板可跑通理解 |
