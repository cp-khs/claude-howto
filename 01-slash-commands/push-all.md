---
description: Stage all changes, create commit, and push to remote (use with caution)
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git diff:*), Bash(git log:*), Bash(git pull:*)
---

# 전체 커밋 및 푸시

⚠️ **주의**: 모든 변경 사항을 스테이징하고 커밋한 뒤 원격 저장소로 푸시합니다. 모든 변경 사항이 함께 포함되어도 문제없다고 확신할 때만 사용하세요.

## 워크플로우

### 1. 변경 사항 분석
병렬로 실행:
- `git status` — 수정/추가/삭제/미추적 파일 표시
- `git diff --stat` — 변경 통계 표시
- `git log -1 --oneline` — 메시지 스타일 참고를 위한 최근 커밋 표시

### 2. 안전 점검

**❌ 아래 항목 감지 시 중단 및 경고:**
- 시크릿: `.env*`, `*.key`, `*.pem`, `credentials.json`, `secrets.yaml`, `id_rsa`, `*.p12`, `*.pfx`, `*.cer`
- API 키: 실제 값이 포함된 `*_API_KEY`, `*_SECRET`, `*_TOKEN` 변수 (`your-api-key`, `xxx`, `placeholder` 등의 플레이스홀더 제외)
- 대용량 파일: Git LFS 없이 `>10MB`
- 빌드 아티팩트: `node_modules/`, `dist/`, `build/`, `__pycache__/`, `*.pyc`, `.venv/`
- 임시 파일: `.DS_Store`, `thumbs.db`, `*.swp`, `*.tmp`

**API 키 유효성 검사:**
수정된 파일에서 다음 패턴 확인:
```bash
OPENAI_API_KEY=sk-proj-xxxxx  # ❌ 실제 키 감지!
AWS_SECRET_KEY=AKIA...         # ❌ 실제 키 감지!
STRIPE_API_KEY=sk_live_...    # ❌ 실제 키 감지!

# ✅ 허용되는 플레이스홀더:
API_KEY=your-api-key-here
SECRET_KEY=placeholder
TOKEN=xxx
API_KEY=<your-key>
SECRET=${YOUR_SECRET}
```

**✅ 확인:**
- `.gitignore`가 올바르게 설정됨
- 병합 충돌 없음
- 올바른 브랜치 (main/master인 경우 경고)
- API 키가 플레이스홀더만 사용

### 3. 확인 요청

요약 내용 표시:
```
📊 변경 사항 요약:
- 수정된 파일 X개, 추가된 파일 Y개, 삭제된 파일 Z개
- 합계: +AAA 줄 추가, -BBB 줄 삭제

🔒 안전성: ✅ 시크릿 없음 | ✅ 대용량 파일 없음 | ⚠️ [경고 사항]
🌿 브랜치: [이름] → origin/[이름]

수행 내용: git add . → 커밋 → 푸시

계속하려면 'yes', 취소하려면 'no'를 입력하세요.
```

**명시적으로 "yes"를 받을 때까지 대기합니다.**

### 4. 실행 (확인 후)

순서대로 실행:
```bash
git add .
git status  # 스테이징 확인
```

### 5. 커밋 메시지 생성

변경 사항을 분석하여 conventional commit 형식으로 작성:

**형식:**
```
[type]: 간결한 요약 (최대 72자)

- 주요 변경 사항 1
- 주요 변경 사항 2
- 주요 변경 사항 3
```

**타입:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`

**예시:**
```
docs: Update concept README files with comprehensive documentation

- Add architecture diagrams and tables
- Include practical examples
- Expand best practices sections
```

### 6. 커밋 및 푸시

```bash
git commit -m "$(cat <<'EOF'
[생성된 커밋 메시지]
EOF
)"
git push  # 실패 시: git pull --rebase && git push
git log -1 --oneline --decorate  # 확인
```

### 7. 성공 확인

```
✅ 원격 저장소에 성공적으로 푸시되었습니다!

커밋: [해시] [메시지]
브랜치: [브랜치] → origin/[브랜치]
변경된 파일: X개 (+줄 추가, -줄 삭제)
```

## 오류 처리

- **git add 실패**: 권한 확인, 잠긴 파일 확인, 저장소 초기화 여부 확인
- **git commit 실패**: pre-commit 훅 수정, git 설정 확인 (user.name/email)
- **git push 실패**:
  - Non-fast-forward: `git pull --rebase && git push`
  - 원격 브랜치 없음: `git push -u origin [브랜치]`
  - 보호된 브랜치: PR 워크플로우 사용

## 적합한 사용 상황

✅ **적합:**
- 여러 파일에 걸친 문서 업데이트
- 테스트와 문서를 포함한 기능 구현
- 여러 파일에 걸친 버그 수정
- 프로젝트 전반의 포매팅/리팩토링
- 설정 변경

❌ **피해야 할 상황:**
- 어떤 것이 커밋되는지 불확실한 경우
- 시크릿/민감한 데이터 포함 시
- 리뷰 없이 보호된 브랜치에 push할 때
- 병합 충돌이 존재할 때
- 세분화된 커밋 이력이 필요할 때
- pre-commit 훅이 실패하는 경우

## 대안

세밀한 제어를 원한다면 다음을 제안합니다:
1. **선택적 스테이징**: 특정 파일 검토 후 스테이징
2. **인터랙티브 스테이징**: `git add -p`로 패치 단위 선택
3. **PR 워크플로우**: 브랜치 생성 → 푸시 → PR (`/pr` 명령어 사용)

**⚠️ 기억하세요**: 푸시 전에 항상 변경 사항을 검토하세요. 의심스러울 때는 개별 git 명령어를 사용하여 더 세밀하게 제어하세요.
