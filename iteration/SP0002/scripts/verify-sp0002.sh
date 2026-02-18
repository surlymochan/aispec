#!/usr/bin/env bash
# SP0002 验收脚本：检查 Spec 驱动编程约定与模板已就绪
# 可从 project 根 或 private/aispec-private 执行；任一项失败退出非 0

set -e

# 解析 aispec 根目录（private/aispec-private）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AISPEC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CONVENTIONS="$AISPEC_ROOT/spec/CONVENTIONS.md"
TEMPLATES_DIR="$AISPEC_ROOT/spec/templates"
PROPOSAL="$TEMPLATES_DIR/proposal.md"
TASKS="$TEMPLATES_DIR/tasks.md"

FAIL=0

# 1. 主约定文档存在且含第六节与工作流关键字
if [[ ! -f "$CONVENTIONS" ]]; then
  echo "FAIL: CONVENTIONS.md 不存在: $CONVENTIONS"
  FAIL=1
else
  if ! grep -q -E 'Spec 驱动编程|六、' "$CONVENTIONS" || ! grep -q '/mrd\|/merge' "$CONVENTIONS"; then
    echo "FAIL: CONVENTIONS.md 中未找到第六节或 /mrd、/merge 等工作流描述"
    FAIL=1
  fi
fi

# 2. 必备模板存在
for f in "$PROPOSAL" "$TASKS"; do
  if [[ ! -f "$f" ]]; then
    echo "FAIL: 模板不存在: $f"
    FAIL=1
  fi
done

# 3. 各环节声明：至少 7 个环节在 CONVENTIONS 中有描述
if [[ -f "$CONVENTIONS" ]]; then
  COUNT=0
  for kw in /mrd /opensp /prd /design /review /test /merge; do
    if grep -q "$kw" "$CONVENTIONS"; then
      ((COUNT++)) || true
    fi
  done
  if [[ "$COUNT" -lt 7 ]]; then
    echo "FAIL: CONVENTIONS 中至少需 7 个环节（/mrd、/opensp、/prd、/design、/review、/test、/merge）的 I/O 或交付物描述，当前匹配: $COUNT"
    FAIL=1
  fi
fi

if [[ $FAIL -eq 1 ]]; then
  exit 1
fi
echo "OK: SP0002 验收通过（CONVENTIONS Spec 驱动编程章节、模板、环节声明）"
exit 0
