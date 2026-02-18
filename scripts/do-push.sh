#!/usr/bin/env bash
# /push：仅在 public/aispec 内执行 git push（由人工触发，在 /public 完成后执行）
# 在 **project 根目录**执行：bash private/aispec-private/scripts/do-push.sh

set -e
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$PROJECT_ROOT"
PUBLIC_AISPEC="public/aispec"
BRANCH="${AISPEC_PUSH_BRANCH:-main}"

if [[ ! -d "$PUBLIC_AISPEC/.git" ]]; then
  echo ">>> public/aispec 无 .git，请先执行 /public（push-to-public.sh）。"
  exit 1
fi
echo ">>> /push：在 public/aispec 内执行 git push origin $BRANCH ..."
(cd "$PUBLIC_AISPEC" && git push origin "$BRANCH")
echo ">>> /push 完成。"
