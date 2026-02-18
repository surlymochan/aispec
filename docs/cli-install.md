# aispec CLI 安装与使用

当前 **未发布到 npm**，已 push 到 GitHub 时可用以下方式。

---

## 本地安装（本工作区推荐）：npm link

若你正在 **project** 下开发（已有 `private/aispec-private`），在终端执行：

```bash
cd /path/to/project/private/aispec-private
npm link
```

执行后，本机即可在任意目录使用 `aispec` 命令：

```bash
aispec init        # 在当前目录初始化 .aispec/spec/ 与模板
aispec verify      # 校验约定与模板是否就绪
```

或使用 package 脚本（在 `private/aispec-private` 目录下）：

```bash
npm run link
```

若 `aispec` 仍找不到，检查 Node/npm 全局路径（`npm config get prefix`），确保该路径下的 `bin` 已加入环境变量 PATH。

---

## 快捷安装：从 GitHub 全局安装

在终端执行**一条命令**，即可在任意目录使用 `aispec`：

```bash
npm install -g git+https://github.com/surlymochan/aispec.git
```

安装后直接使用：

```bash
aispec init        # 在当前目录初始化 .aispec/spec/ 与模板
aispec verify      # 校验约定与模板是否就绪
```

更新到最新版本时再次执行上述 `npm install -g` 即可。

---

## 方式二：每次用 npx 从 GitHub 运行（不全局安装）

在**要初始化的目标仓库根目录**执行：

```bash
npx git+https://github.com/surlymochan/aispec.git init
npx git+https://github.com/surlymochan/aispec.git verify
```

或使用 GitHub 简写（部分 npm 版本支持）：

```bash
npx github:surlymochan/aispec#main init
npx github:surlymochan/aispec#main verify
```

---

## 方式三：从本机 aispec 仓库路径运行

若本机已有 aispec 仓库（如 `private/aispec-private` 或 clone 的 `aispec`），在**要初始化的目标仓库根目录**执行：

```bash
node /path/to/aispec/cli/bin/aispec.js init
node /path/to/aispec/cli/bin/aispec.js verify
```

例如 project 结构下：

```bash
# 在目标仓库根目录执行，将 /path/to/project 换成你的 project 根路径
node /path/to/project/private/aispec-private/cli/bin/aispec.js init
node /path/to/project/private/aispec-private/cli/bin/aispec.js verify
```

---

## 方式四：本机全局可用命令（别名或软链，无 GitHub 时）

在 shell 配置（如 `~/.zshrc`）里添加：

```bash
alias aispec='node /path/to/project/private/aispec-private/cli/bin/aispec.js'
```

或为可执行并加入 PATH（二选一）：

```bash
# 复制到本地 bin（需先 chmod +x）
cp /path/to/project/private/aispec-private/cli/bin/aispec.js ~/bin/aispec
chmod +x ~/bin/aispec
# 确保 ~/bin 在 PATH 中
```

之后在任意目录可执行：

```bash
aispec init
aispec verify
```

---

## 命令说明

| 命令 | 说明 |
|------|------|
| `aispec init` | 在当前目录创建 `.aispec/spec/`、`.aispec/spec/templates/` 及可选 `AGENTS.md` |
| `aispec init --no-agents` | 同上，但不创建 `AGENTS.md` |
| `aispec verify` | 校验当前目录下 `.aispec/spec/` 或 `spec/` 的约定与模板是否就绪 |

---

## 若日后发布到 npm

发布后可直接：

```bash
npm install -g aispec-cli
aispec init
aispec verify
```

或 `npx aispec-cli init`。详见 [publishing-npm.md](publishing-npm.md)。
