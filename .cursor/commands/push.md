# /push — 人工推送

**指令**：在 /public 完成后，由**人**在发布目录内执行 git push。仅此一步为人工，避免误推。

**输入**：/public 已完成（发布目录已 commit）。  
**输出**：发布目录已推送到约定远程（如 origin main）。

**执行步骤**：
1. 确认 /public 已执行且发布目录内已有本地 commit。
2. 由人在该发布目录内执行：`git push origin <branch>`（分支名以项目或 aispec.md 约定为准）。
3. 若项目约定 Git 身份（如 surlymochan / surlymo@apache.org），确保 push 前该目录或全局已配置对应 user.name / user.email。

**权威**：aispec spec/CONVENTIONS.md 第一节；业务项目 aispec.md 2.4（Git 操作身份）。
