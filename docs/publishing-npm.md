# 发布 aispec-cli 到 npm 的准备

**当前约定**：不发布到 npm，仅通过 GitHub 仓库 [surlymochan/aispec](https://github.com/surlymochan/aispec) 使用；CLI 可通过 `npx` 从 GitHub 或本地路径运行。若日后需发布到 npm，可按下列步骤准备。

---

## 1. npm 账号与登录

- 若没有 npm 账号：在 [npmjs.com](https://www.npmjs.com/signup) 注册。
- 在终端登录：
  ```bash
  npm login
  ```
  按提示输入 Username、Password、Email、OTP（若开启双因素）。

---

## 2. 包名是否可用

- 当前包名为 **aispec-cli**。若已被占用，需改用 **scoped 包**（推荐）：
  - 在 `cli/package.json` 中将 `"name": "aispec-cli"` 改为 `"name": "@你的npm用户名/aispec-cli"`（例如 `@surlymochan/aispec-cli`）。
  - 使用 scoped 包时，用户安装为：`npm install -g @你的npm用户名/aispec-cli`，命令仍为 `aispec`（由 bin 决定）。
- 检查包名是否已被占用：
  ```bash
  npm view aispec-cli
  # 若返回 404 表示未被占用；否则会显示已有包信息
  ```

---

## 3. 修改仓库中的占位内容

在 **cli/package.json** 中：

- 将 **repository.url** 改为你的实际仓库地址，例如：
  `"url": "https://github.com/surlymochan/aispec.git"`（或你的 org/用户名）。

在 **cli/templates/conventions-minimal.md** 中：

- 将「完整约定见 … your-org/aispec …」的链接改为实际仓库 URL，便于用户查看完整 CONVENTIONS。

---

## 4. 确认要发布的文件

`package.json` 中已设置 `"files": ["bin", "lib", "templates"]`，发布时只会包含这三类文件。可本地检查：

```bash
cd cli
npm pack --dry-run
```

会列出将被打包的文件，确认无多余或遗漏。

---

## 5. 发布命令

在 **cli** 目录下执行：

```bash
cd cli   # 在 aispec 仓库根下进入 cli/
npm publish
```

若使用 **scoped 包**且首次发布，默认会作为私有包，需公开时加：

```bash
npm publish --access public
```

---

## 6. 发布后

- 用户安装：`npm install -g aispec-cli` 或 `npx aispec-cli init`。
- 更新版本：修改 `cli/package.json` 的 `version`，再执行 `npm publish`。
- 建议在仓库 README 或 docs 中注明 npm 包名与安装方式。

---

## 简要清单

| 步骤 | 操作 |
|------|------|
| 1 | 注册/登录 npm：`npm login` |
| 2 | 确认包名：`npm view aispec-cli`；若占用则改用 `@用户名/aispec-cli` |
| 3 | 修改 cli/package.json 的 repository.url |
| 4 | 修改 cli/templates/conventions-minimal.md 中的仓库链接 |
| 5 | （可选）`npm pack --dry-run` 检查打包内容 |
| 6 | `cd cli && npm publish`（scoped 且需公开时加 `--access public`） |
