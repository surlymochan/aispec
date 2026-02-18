# aispec CLI

在任意仓库中初始化与校验 aispec 约定与模板。

## 安装与运行（已 push GitHub，未上架 npm）

**快捷安装**（推荐）：

```bash
npm install -g git+https://github.com/surlymochan/aispec.git
```

之后在任意目录执行 `aispec init`、`aispec verify`。更多方式（npx、本机路径、alias）见 [docs/cli-install.md](../docs/cli-install.md)。

## 命令

| 命令 | 说明 |
|------|------|
| **aispec init** | 在当前目录创建 `.aispec/spec/`（CONVENTIONS 精简版）、`.aispec/spec/templates/`（proposal、tasks），以及可选的根目录 `AGENTS.md`。若已存在则跳过。 |
| **aispec init --no-agents** | 同上，但不创建 `AGENTS.md`。 |
| **aispec verify** | 校验 `.aispec/spec/` 或 `spec/` 下 CONVENTIONS.md 存在且含工作流与环节描述，且必备模板（proposal.md、tasks.md）存在。通过时 exit 0，否则 1。 |

## 从本仓库开发

在 aispec 仓库根或 cli 目录下：

```bash
cd cli
node bin/aispec.js init    # 在临时目录测试
node bin/aispec.js verify
```

**发布到 npm**：见 [docs/publishing-npm.md](../docs/publishing-npm.md)。发布前请将 `templates/conventions-minimal.md` 与 `package.json` 中的仓库地址替换为实际 URL。
