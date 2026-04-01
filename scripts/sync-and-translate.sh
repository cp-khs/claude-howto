#!/usr/bin/env bash
# sync-and-translate.sh
# upstream 변경사항을 감지하고, 변경된 .md 파일을 Claude Code로 번역합니다.
#
# 사용법:
#   ./scripts/sync-and-translate.sh          # 변경 파일 확인만
#   ./scripts/sync-and-translate.sh --apply  # 번역까지 자동 실행

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APPLY_MODE=false
if [[ "${1:-}" == "--apply" ]]; then
  APPLY_MODE=true
fi

cd "$REPO_ROOT"

# ─── 1. upstream 최신화 ───────────────────────────────────────────────────────
echo "▶ upstream 변경사항 가져오는 중..."
git fetch upstream --quiet

# ─── 2. main 브랜치와 upstream/main 차이 확인 ───────────────────────────────
BEHIND=$(git rev-list main..upstream/main --count)

if [[ "$BEHIND" -eq 0 ]]; then
  echo "✅ upstream과 동일합니다. 번역 업데이트 불필요."
  exit 0
fi

echo "ℹ  upstream이 ${BEHIND}개 커밋 앞서 있습니다."

# ─── 3. 변경된 .md 파일 목록 추출 ────────────────────────────────────────────
CHANGED_MD=$(git diff main..upstream/main --name-only -- "*.md" \
  | grep -v "README.backup.md" \
  | grep -v "CHANGELOG.md" \
  | grep -v "RELEASE_NOTES.md" \
  | grep -v "SECURITY.md" \
  | grep -v "CODE_OF_CONDUCT.md" \
  | grep -v "prompts/" \
  || true)

if [[ -z "$CHANGED_MD" ]]; then
  echo "ℹ  .md 파일 변경 없음 (코드/설정만 변경됨). main만 동기화합니다."
  git checkout main
  git merge upstream/main
  git push origin main
  git checkout korean
  git merge main --no-edit
  echo "✅ main 동기화 완료."
  exit 0
fi

# ─── 4. 변경 파일 목록 출력 ──────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
echo "  번역 업데이트가 필요한 파일 목록"
echo "═══════════════════════════════════════════"
echo "$CHANGED_MD" | while read -r f; do
  echo "  • $f"
done
echo ""
echo "총 $(echo "$CHANGED_MD" | wc -l | tr -d ' ')개 파일"
echo ""

if [[ "$APPLY_MODE" == false ]]; then
  echo "번역을 실행하려면: ./scripts/sync-and-translate.sh --apply"
  exit 0
fi

# ─── 5. uncommitted 변경사항 처리 ────────────────────────────────────────────
if ! git diff --quiet || ! git diff --cached --quiet; then
  DIRTY_FILES=$(git diff --name-only; git diff --cached --name-only)
  echo ""
  echo "⚠️  커밋되지 않은 변경사항이 있습니다:"
  echo "$DIRTY_FILES" | while read -r f; do echo "  • $f"; done
  echo ""
  echo "▶ 변경사항을 자동으로 커밋합니다..."
  git add -A
  git commit -m "docs(ko): 미커밋 번역 파일 정리

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"
  git push origin korean
  echo "✅ 미커밋 파일 커밋 완료."
fi

# ─── 6. main 동기화 ──────────────────────────────────────────────────────────
echo "▶ main 브랜치를 upstream/main으로 동기화..."
git checkout main
git merge upstream/main --no-edit
git push origin main
echo "✅ main 동기화 완료."

# ─── 7. korean 브랜치로 전환 및 main 머지 ────────────────────────────────────
git checkout korean
echo "▶ korean 브랜치에 main 변경사항 머지..."
git merge main --no-edit || {
  echo ""
  echo "⚠️  머지 충돌이 발생했습니다. 수동으로 해결 후 다시 실행하세요."
  echo "   충돌 파일: $(git diff --name-only --diff-filter=U)"
  exit 1
}

# ─── 8. 변경된 파일 번역 실행 ────────────────────────────────────────────────
echo ""
echo "▶ Claude Code로 번역 시작..."

FILE_LIST=$(echo "$CHANGED_MD" | tr '\n' ' ')

TRANSLATE_PROMPT="다음 파일들을 한국어로 번역하세요.
번역 규칙: 기술 용어(Claude Code, MCP, Hooks, Skills, Subagents 등) 원어 유지, YAML frontmatter 변경 금지, 코드 블록 내 코드 번역 금지, 마크다운 구조 유지.
번역 대상 파일: ${FILE_LIST}
각 파일을 Read로 읽고 Write로 동일 경로에 저장하세요."

claude -p --allowedTools "Read,Write" "$TRANSLATE_PROMPT" || {
  echo ""
  echo "⚠️  Claude Code 자동 번역 실패. 수동으로 번역하세요."
  echo "   변경 파일 목록이 /tmp/changed_md.txt에 저장됐습니다."
  echo "$CHANGED_MD" > /tmp/changed_md.txt
  exit 1
}

# ─── 9. 커밋 및 push ─────────────────────────────────────────────────────────
if ! git diff --quiet; then
  git add -A
  git commit -m "docs(ko): upstream 변경사항 한국어 번역 반영

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"
  git push origin korean
  echo ""
  echo "✅ 번역 업데이트 완료. korean 브랜치가 최신 상태입니다."
else
  echo ""
  echo "ℹ  번역 변경사항 없음 (이미 최신 상태)."
fi
