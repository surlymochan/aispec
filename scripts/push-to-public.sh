#!/usr/bin/env bash
# /public：脱敏检查 → 同步到 public/aispec → 在 public 内运行测试 → git add & commit（不 push）
# 在 **project 根目录**执行：bash private/aispec-private/scripts/push-to-public.sh
# 最后一步 git push 由人工执行 /push（见 docs/push-checklist-and-steps.md）。

set -e
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$PROJECT_ROOT"
AISPEC_PRIVATE="private/aispec-private"
PUBLIC_AISPEC="public/aispec"
REMOTE_URL="${AISPEC_PUSH_REMOTE:-https://github.com/surlymochan/aispec.git}"
BRANCH="${AISPEC_PUSH_BRANCH:-main}"

echo ">>> /public 开始（脱敏检查 → 同步 → 测试 → git commit，不 push）"

# --- 1. 自动脱敏检查（约定必过，否则退出）---
echo ">>> [1/5] 脱敏检查..."
CHECK_DIR="$AISPEC_PRIVATE"
FAIL=0
# 禁止：本机路径
if grep -rE '/Users/[a-zA-Z0-9_-]+/|/home/[a-zA-Z0-9_-]+/' "$CHECK_DIR" --include='*.ts' --include='*.js' --include='*.json' --include='*.yaml' --include='*.yml' --include='*.sh' 2>/dev/null | grep -v '.git' | head -1 | grep -q .; then
  echo ">>> 脱敏检查失败：发现本机路径（/Users/ 或 /home/），请去除后再 /push。"
  exit 1
fi
# 禁止：疑似密钥赋值（长 token）
if grep -rE '(API_KEY|TOKEN|SECRET|PASSWORD)\s*=\s*['\''\"][^'\''\"]{15,}['\''\"]' "$CHECK_DIR" --include='*.ts' --include='*.js' --include='*.json' --include='*.env' 2>/dev/null | grep -v '.git' | head -1 | grep -q .; then
  echo ">>> 脱敏检查失败：发现疑似硬编码密钥/Token，请去除或改为占位符后再 /push。"
  exit 1
fi
echo ">>> 脱敏检查通过。"

# --- 2. 确保 public/aispec 存在（clone 或已有 .git）---
echo ">>> [2/5] 准备 public/aispec..."
mkdir -p public
if [[ ! -d "$PUBLIC_AISPEC/.git" ]]; then
  if [[ -d "$PUBLIC_AISPEC" ]]; then
    echo ">>> public/aispec 已存在但无 .git，将同步内容到该目录（后续需手动 init 或 clone）。"
  else
    git clone "$REMOTE_URL" "$PUBLIC_AISPEC" 2>/dev/null || true
    [[ ! -d "$PUBLIC_AISPEC" ]] && mkdir -p "$PUBLIC_AISPEC"
  fi
fi
if [[ -d "$PUBLIC_AISPEC/.git" ]]; then
  (cd "$PUBLIC_AISPEC" && git fetch origin 2>/dev/null; git checkout "$BRANCH" 2>/dev/null || git checkout -b "$BRANCH" 2>/dev/null || true)
fi

# --- 3. 同步（排除 .git、node_modules、.env、keys）---
echo ">>> [3/5] 同步 $AISPEC_PRIVATE -> $PUBLIC_AISPEC ..."
rsync -av --exclude='.git' --exclude='node_modules' --exclude='.DS_Store' \
  --exclude='.env' --exclude='.env.*' --exclude='**/keys/**' \
  "$AISPEC_PRIVATE/" "$PUBLIC_AISPEC/"

# --- 4. 在 public/aispec 内运行测试（脱敏后最终呈现须通过）---
if [[ -n "${AISPEC_PUSH_SKIP_TEST:-}" ]]; then
  echo ">>> [4/5] 已设置 AISPEC_PUSH_SKIP_TEST，跳过测试。"
else
  echo ">>> [4/5] 在 public/aispec 内运行测试..."
  if [[ -n "${AISPEC_PUSH_TEST_CMD:-}" ]]; then
    (cd "$PUBLIC_AISPEC" && eval "$AISPEC_PUSH_TEST_CMD") || { echo ">>> 测试未通过，已中止 push。"; exit 1; }
  elif [[ -f "$PUBLIC_AISPEC/cli/bin/aispec.js" ]]; then
    (cd "$PUBLIC_AISPEC" && node cli/bin/aispec.js verify) || { echo ">>> 测试未通过（aispec verify 失败），已中止 push。"; exit 1; }
  else
    echo ">>> 未发现 cli/bin/aispec.js，跳过默认校验；可设置 AISPEC_PUSH_TEST_CMD 自定义测试命令。"
  fi
fi

# --- 5. 在 public/aispec 内 git add & commit（不 push，由人工 /push）---
if [[ ! -d "$PUBLIC_AISPEC/.git" ]]; then
  echo ">>> public/aispec 无 .git，已同步内容；请在该目录内 git init 并添加远程后，再执行本脚本。"
  exit 0
fi
echo ">>> [5/5] git add / commit（不执行 push）..."
VERSION=""
if [[ -f "$PUBLIC_AISPEC/spec/README.md" ]]; then
  VERSION=$(grep -E '^\s*\*\*版本\*\*' "$PUBLIC_AISPEC/spec/README.md" | sed -E 's/.*([0-9]+\.[0-9]+\.[0-9]+).*/\1/' | head -1)
fi
COMMIT_MSG="chore: sync from private/aispec-private${VERSION:+ (v${VERSION})}"
(cd "$PUBLIC_AISPEC" && git add -A && git status --short)
if (cd "$PUBLIC_AISPEC" && git diff --staged --quiet); then
  echo ">>> 无变更，未创建 commit。"
  echo ">>> /public 完成。若需推送到远程，请执行 /push（见下方）。"
  exit 0
fi
(cd "$PUBLIC_AISPEC" && git commit -m "$COMMIT_MSG")
echo ""
echo ">>> /public 完成。推送由人工执行 /push："
echo "    bash private/aispec-private/scripts/do-push.sh"
echo "    或在 public/aispec 内执行：git push origin $BRANCH"
echo ""
