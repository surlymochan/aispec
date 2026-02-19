# /public — 同步到发布目录（不 push）

**指令**：脱敏检查 → 同步到发布目录（如 public/aispec）→ 在发布目录内运行测试 → git add & commit；**不执行 git push**。

**输入**：人触发（在 /merge 完成后）。  
**输出**：发布目录已更新并通过测试、已本地 commit；最后一步推送由人执行 /push。

**执行步骤**：
1. 脱敏检查：检查拟发布内容无本机路径、硬编码密钥/Token；未通过则中止并提示。
2. 同步：将 private 侧约定目录（如 private/aispec-private）同步到 public 对应目录（如 public/aispec），排除 iteration、.git、node_modules、.env、keys 等。
3. 在发布目录内运行约定测试（如 `node cli/bin/aispec.js verify`）；未通过则中止，不 commit。
4. 测试通过后在该发布目录内 git add & commit；不执行 git push。完成后提示执行 /push。

**权威**：aispec spec/CONVENTIONS.md 第一节；工作区 push-checklist-and-steps.md（若存在）。
