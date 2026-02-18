# aispec /public 与 /push 检查清单与执行步骤

按 CONVENTIONS：发布流程为 **mrd → merge → public → push**。/public 环节只做「脱敏检查、同步、在 public 内测试、git commit」，**不执行 git push**；最后一步 **git push 由人工执行 /push**，整体更保险。

---

## 一、/public（在 project 根执行）

在 **project 根目录**执行：

```bash
bash private/aispec-private/scripts/push-to-public.sh
```

脚本将依次完成：

| 步骤 | 说明 |
|------|------|
| 1. 脱敏检查 | 自动检查本机路径（/Users/、/home/）、疑似硬编码密钥/Token；未通过则中止并提示 |
| 2. 准备 public/aispec | 若无则 clone；若有则 fetch，确保分支就绪 |
| 3. 同步 | rsync 将 private/aispec-private 同步到 public/aispec（排除 .git、node_modules、.env、keys） |
| 4. **在 public 内运行测试** | 在 public/aispec 内执行约定测试（默认 `node cli/bin/aispec.js verify`）；**未通过则中止**，不 commit，确保脱敏后最终呈现的项目可通过测试 |
| 5. git add & commit | 测试通过后，在 public/aispec 内自动 git add、commit；**不执行 git push** |

无变更时会输出「无变更，未创建 commit」并正常退出。脚本结束后会提示执行 /push。

---

## 二、/push（人工执行，在 /public 完成后）

/public 完成后，由**人工**执行以下任一方式完成最后推送：

**方式 A（推荐）**：在 project 根执行

```bash
bash private/aispec-private/scripts/do-push.sh
```

**方式 B**：进入 public/aispec 后手动 push

```bash
cd public/aispec
git push origin main
```

（分支名以工作区 aispec.md 或环境变量 `AISPEC_PUSH_BRANCH` 为准，默认 main。）

---

## 三、可配置项（可选）

| 环境变量 | 含义 | 默认 |
|----------|------|------|
| `AISPEC_PUSH_REMOTE` | public/aispec 的远程仓库 URL | https://github.com/surlymochan/aispec.git |
| `AISPEC_PUSH_BRANCH` | 推送分支名 | main |
| `AISPEC_PUSH_TEST_CMD` | 在 public/aispec 内运行的自定义测试命令（替代默认 verify） | 无则使用 `node cli/bin/aispec.js verify` |
| `AISPEC_PUSH_SKIP_TEST` | 设为非空则跳过「在 public 内运行测试」步骤 | 不设则必须通过测试才 commit |

示例：

```bash
AISPEC_PUSH_BRANCH=master bash private/aispec-private/scripts/push-to-public.sh
# 使用自定义测试：
AISPEC_PUSH_TEST_CMD="npm run test" bash private/aispec-private/scripts/push-to-public.sh
```

---

## 四、脱敏约定（/public 脚本会检查）

脚本自动检查以下内容，**未通过会直接失败**，需在 private/aispec-private 内修正后再执行：

| 检查项 | 要求 |
|--------|------|
| 本机路径 | 代码/配置中不得包含 /Users/xxx、/home/xxx 等真实路径 |
| 硬编码密钥 | 不得出现 API_KEY=、TOKEN=、SECRET=、PASSWORD= 等带长真实值的赋值 |
| .env / keys | 脚本已通过 rsync 排除 .env、.env.*、**/keys/**，不会同步到 public |

文档中约定性提及「keys」「token」等词、或占位符，不会触发检查。

---

## 五、小结

| 环节 | 执行内容 | 是否人工 |
|------|----------|----------|
| **/public** | 脱敏检查 → 同步 → 在 public 内测试 → git add & commit | 脚本全自动（在 project 根执行 push-to-public.sh） |
| **/push** | 在 public/aispec 内 git push | **人工执行**（do-push.sh 或手动 push） |

- 流程顺序：**mrd → merge → public → push**；/public 只做到 commit，最后推送由人执行更保险。
- 脱敏或测试未通过时，按提示修改后重新执行 /public。
- Git 身份按工作区 aispec.md 中约定使用（如 surlymochan / surlymo@apache.org），需在本地已配置好。
