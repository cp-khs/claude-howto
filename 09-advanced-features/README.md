<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# 고급 기능

계획 모드, 확장 사고, Auto Mode, 백그라운드 태스크, 권한 모드, Print Mode (비대화형), 세션 관리, 인터랙티브 기능, 채널, 음성 받아쓰기, 원격 제어, 웹 세션, 데스크탑 앱, 태스크 목록, 프롬프트 제안, Git Worktrees, 샌드박싱, 관리형 설정, 설정 구성을 포함한 Claude Code 고급 기능 종합 가이드입니다.

## 목차

1. [개요](#개요)
2. [계획 모드](#계획-모드)
3. [확장 사고](#확장-사고)
4. [Auto Mode](#auto-mode)
5. [백그라운드 태스크](#백그라운드-태스크)
6. [예약 태스크](#예약-태스크)
7. [권한 모드](#권한-모드)
8. [헤드리스 모드](#헤드리스-모드)
9. [세션 관리](#세션-관리)
10. [인터랙티브 기능](#인터랙티브-기능)
11. [음성 받아쓰기](#음성-받아쓰기)
12. [채널](#채널)
13. [Chrome 연동](#chrome-연동)
14. [원격 제어](#원격-제어)
15. [웹 세션](#웹-세션)
16. [데스크탑 앱](#데스크탑-앱)
17. [태스크 목록](#태스크-목록)
18. [프롬프트 제안](#프롬프트-제안)
19. [Git Worktrees](#git-worktrees)
20. [샌드박싱](#샌드박싱)
21. [관리형 설정 (엔터프라이즈)](#관리형-설정-엔터프라이즈)
22. [설정 구성](#설정-구성)
23. [모범 사례](#모범-사례)
24. [추가 자료](#추가-자료)

---

## 개요

Claude Code의 고급 기능은 계획, 추론, 자동화, 제어 메커니즘으로 핵심 기능을 확장합니다. 이 기능들은 복잡한 개발 작업, 코드 리뷰, 자동화, 다중 세션 관리를 위한 정교한 워크플로우를 가능하게 합니다.

**주요 고급 기능:**
- **계획 모드**: 코딩 전 상세한 구현 계획 수립
- **확장 사고**: 복잡한 문제에 대한 심층 추론
- **Auto Mode**: 백그라운드 안전 분류기가 실행 전 각 행동을 검토 (Research Preview)
- **백그라운드 태스크**: 대화를 막지 않고 오래 걸리는 작업 실행
- **권한 모드**: Claude가 할 수 있는 작업 제어 (`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`)
- **Print Mode**: 자동화 및 CI/CD를 위한 비대화형 Claude Code 실행 (`claude -p`)
- **세션 관리**: 여러 작업 세션 관리
- **인터랙티브 기능**: 키보드 단축키, 다중 줄 입력, 명령어 기록
- **음성 받아쓰기**: 20개 언어 STT 지원의 Push-to-talk 음성 입력
- **채널**: MCP 서버가 실행 중인 세션에 메시지 전송 (Research Preview)
- **원격 제어**: Claude.ai 또는 Claude 앱에서 Claude Code 제어
- **웹 세션**: claude.ai/code에서 브라우저로 Claude Code 실행
- **데스크탑 앱**: 시각적 diff 검토와 다중 세션을 위한 독립형 앱
- **태스크 목록**: 컨텍스트 압축을 넘어 지속되는 태스크 추적
- **프롬프트 제안**: 컨텍스트 기반의 스마트 명령어 제안
- **Git Worktrees**: 병렬 작업을 위한 격리된 worktree 브랜치
- **샌드박싱**: OS 수준의 파일시스템 및 네트워크 격리
- **관리형 설정**: plist, Registry, 관리형 파일을 통한 엔터프라이즈 배포
- **설정 구성**: JSON 설정 파일로 동작 커스터마이징

---

## 계획 모드

계획 모드를 사용하면 Claude가 복잡한 작업을 구현하기 전에 충분히 생각하여 검토하고 승인할 수 있는 상세한 계획을 만들 수 있습니다.

### 계획 모드란?

계획 모드는 두 단계 접근 방식입니다:
1. **계획 단계**: Claude가 작업을 분석하고 상세한 구현 계획 수립
2. **구현 단계**: 승인 후 Claude가 계획을 실행

### 계획 모드 사용 시기

✅ 계획 모드를 사용할 때:
- 복잡한 다중 파일 리팩터링
- 새 기능 구현
- 아키텍처 변경
- 데이터베이스 마이그레이션
- 주요 API 재설계

❌ 계획 모드를 사용하지 말아야 할 때:
- 단순 버그 수정
- 포맷 변경
- 단일 파일 편집
- 빠른 쿼리

### 계획 모드 활성화

**Slash Command**:
```bash
/plan 사용자 인증 시스템 구현
```

**CLI 플래그**:
```bash
claude --permission-mode plan
```

**기본값으로 설정**:
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

**키보드 단축키**:
- `Shift + Tab` - 권한 모드 전환 (plan 포함)
- `Alt + M` - 권한 모드 전환 (Windows/Linux)

### 계획 모드의 장점

- **구조화된 구현 접근**: 구현 단계의 상세한 분류
- **검토 및 승인**: 실행 전 계획 승인 또는 조정
- **위험 식별**: 구현 전 잠재적 문제 파악
- **명확한 단계**: 정돈된 구현 단계와 마일스톤

### 예시: 기능 구현

```
User: /plan 실시간 알림 시스템 추가

Claude: 실시간 알림 구현 계획을 수립하겠습니다.

## 구현 계획

### 1단계: 인프라 설정
1. WebSocket 라이브러리 설치 (socket.io)
2. WebSocket 서버 설정
3. 연결 관리 구성

### 2단계: 백엔드 구현
4. 알림 서비스 생성
5. 알림 큐 구현
6. 알림용 데이터베이스 스키마 추가
7. API 엔드포인트 생성

### 3단계: 프론트엔드 연동
8. WebSocket 클라이언트 설정
9. 알림 UI 컴포넌트 생성
10. 알림 상태 관리 구현
11. 알림 권한 추가

### 4단계: 테스트 & 배포
12. 단위 테스트 작성
13. 통합 테스트 작성
14. 문서 업데이트
15. 스테이징 환경에 배포

예상 소요 시간: 3-4시간
수정할 파일: 12개
새로 생성할 파일: 8개

진행하시겠습니까? (yes/no/계획 수정)

User: yes

Claude: [계획에 따라 구현 시작]
```

### 계획 수정

```
User: 계획 수정 - 큐는 지금은 건너뛰고 나중에 추가하겠습니다

Claude: 수정된 계획:
[큐가 제거된 수정된 계획 표시]

User: 좋아요, 진행해주세요

Claude: [수정된 계획 구현]
```

### 계획 모드 설정

계획 모드는 CLI 플래그 또는 Slash Command로 활성화합니다:

```bash
# CLI로 plan 모드 활성화
claude --permission-mode plan

# 또는 REPL 내에서 /plan Slash Command 사용
/plan 사용자 인증 시스템 구현
```

**계획을 위한 모델 별칭**: `opusplan`을 모델 별칭으로 사용하면 계획에는 Opus, 실행에는 Sonnet을 사용합니다:

```bash
claude --model opusplan "새 API를 설계하고 구현해주세요"
```

**외부에서 계획 편집**: `Ctrl+G`를 눌러 현재 계획을 외부 편집기에서 열어 상세하게 수정할 수 있습니다.

---

## 확장 사고

확장 사고를 사용하면 Claude가 해결책을 제공하기 전에 복잡한 문제를 더 오래 생각할 수 있습니다.

### 확장 사고란?

확장 사고는 Claude가 다음을 수행하는 의도적이고 단계적인 추론 과정입니다:
- 복잡한 문제 분해
- 여러 접근 방식 고려
- 장단점 평가
- 엣지 케이스 추론

### 확장 사고 활성화

**키보드 단축키**:
- `Option + T` (macOS) / `Alt + T` (Windows/Linux) - 확장 사고 토글

**자동 활성화**:
- 모든 모델에 기본 활성화 (Opus 4.6, Sonnet 4.6, Haiku 4.5)
- Opus 4.6: 노력 수준이 있는 적응형 추론: `low` (○), `medium` (◐), `high` (●), `max` (Opus 4.6 전용)
- 다른 모델: 최대 31,999 토큰의 고정 예산

**설정 방법**:
- 토글: `Alt+T` / `Option+T`, 또는 `/config`를 통해
- 추론 보기: `Ctrl+O` (상세 모드)
- 노력 수준 설정: `/effort` 명령어 또는 `--effort` 플래그

**커스텀 예산**:
```bash
export MAX_THINKING_TOKENS=1024
```

**노력 수준** (Opus 4.6 전용):
```bash
export CLAUDE_CODE_EFFORT_LEVEL=high   # low (○), medium (◐), high (●), 또는 max (Opus 4.6 전용)
```

**CLI 플래그**:
```bash
claude --effort high "복잡한 아키텍처 리뷰"
```

**Slash Command**:
```
/effort high
```

> **참고:** 프롬프트에 "ultrathink" 키워드를 사용하면 심층 추론 모드가 활성화됩니다. 노력 수준 `low`, `medium`, `high`, `max` (Opus 4.6 전용)는 Claude가 수행하는 추론의 양을 제어합니다.

### 확장 사고의 장점

- **심층 추론**: 복잡한 문제에 더 많은 시간을 할애하여 생각
- **더 나은 아키텍처 결정**: 포괄적인 평가로 정보에 기반한 선택
- **엣지 케이스 고려**: 잠재적 문제와 시나리오를 미리 생각
- **철저한 분석**: 복잡한 문제 해결에 대한 구조화된 접근

### 예시: 아키텍처 결정

```
User: /think 이커머스 플랫폼에 마이크로서비스를 써야 할까요, 모놀리스를 써야 할까요?

Claude: 이 아키텍처 결정을 신중하게 생각해보겠습니다...

<extended_thinking>
## 컨텍스트 분석
- 팀 규모: 개발자 5명
- 예상 트래픽: 초기 일일 사용자 10,000명
- 100,000명 이상으로 확장 필요
- DevOps 리소스 제한됨
- MVP까지 6개월 타임라인

## 접근 방식 1: 마이크로서비스
장점:
+ 독립적 확장
+ 기술 유연성
+ 팀 독립성
+ 장애 격리

단점:
- 운영 복잡성
- 네트워크 오버헤드
- 분산 추적 필요
- DevOps 전문성 요구
- 초기 개발 느림

## 접근 방식 2: 모놀리스
장점:
+ 단순한 배포
+ 빠른 초기 개발
+ 쉬운 디버깅
+ 낮은 운영 오버헤드
+ 단일 코드베이스

단점:
- 나중에 확장 어려움
- 전체 또는 없는 배포
- 기술 종속
- 강한 결합 가능성

## 결정 요소
1. 팀 규모 (5명) → 모놀리스 유리
2. DevOps 리소스 (제한적) → 모놀리스 유리
3. 타임라인 (6개월) → 모놀리스 유리
4. 미래 규모 (사용자 10만 명) → 모놀리스 + 캐싱으로 달성 가능
5. 복잡성 예산 → 제한적

## 권고 사항
**모듈식 모놀리스**로 시작:
- 단일 배포 단위
- 명확한 모듈 경계
- 모듈 간 깔끔한 인터페이스
- 필요 시 마이크로서비스로 추출 준비

이를 통해:
✓ 빠른 초기 개발
✓ 낮은 운영 복잡성
✓ 나중에 서비스 추출 옵션
✓ 명확한 아키텍처

마이그레이션 경로: 사용자 50,000명 이상 도달하거나 특정 모듈에 독립적 확장이 필요할 때 해당 모듈을 마이크로서비스로 추출합니다.
</extended_thinking>

**권고 사항**: 깔끔한 모듈 경계를 갖춘 모듈식 모놀리스 구현.

이 접근 방식은 현재 제약 조건 (팀 규모, 타임라인, DevOps 리소스)과 미래 확장성 요구를 균형 있게 처리합니다. 명확한 비즈니스 필요성이 생겼을 때 특정 모듈을 마이크로서비스로 마이그레이션할 수 있습니다.
```

### 확장 사고 설정

확장 사고는 환경 변수, 키보드 단축키, CLI 플래그로 제어합니다:

```bash
# 사고 토큰 예산 설정
export MAX_THINKING_TOKENS=16000

# 노력 수준 설정 (Opus 4.6 전용): low (○), medium (◐), high (●), 또는 max (Opus 4.6 전용)
export CLAUDE_CODE_EFFORT_LEVEL=high
```

세션 중 `Alt+T` / `Option+T`로 토글하거나, `/effort`로 노력 수준을 설정하거나, `/config`로 설정할 수 있습니다.

---

## Auto Mode

Auto Mode는 2026년 3월에 출시된 Research Preview 권한 모드로, 백그라운드 안전 분류기가 실행 전 각 행동을 검토합니다. Claude가 자율적으로 작업하면서 위험한 작업은 차단합니다.

### 요구 사항

- **플랜**: Team 플랜 (Enterprise 및 API는 순차적으로 제공)
- **모델**: Claude Sonnet 4.6 또는 Opus 4.6
- **분류기**: Claude Sonnet 4.6에서 실행 (추가 토큰 비용 발생)

### Auto Mode 활성화

```bash
# CLI 플래그로 auto mode 잠금 해제
claude --enable-auto-mode

# 그런 다음 REPL에서 Shift+Tab으로 전환
```

또는 기본 권한 모드로 설정:

```bash
claude --permission-mode auto
```

설정으로 지정:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 분류기 작동 방식

백그라운드 분류기는 다음 결정 순서에 따라 각 행동을 평가합니다:

1. **허용/거부 규칙** -- 명시적 권한 규칙을 먼저 확인
2. **읽기 전용/편집 자동 승인** -- 파일 읽기와 편집은 자동으로 통과
3. **분류기** -- 백그라운드 분류기가 행동 검토
4. **폴백** -- 연속 3회 또는 총 20회 차단 후 사용자에게 프롬프트로 폴백

### 기본 차단 행동

Auto Mode는 기본적으로 다음을 차단합니다:

| 차단 행동 | 예시 |
|----------------|---------|
| Pipe-to-shell 설치 | `curl \| bash` |
| 민감한 데이터 외부 전송 | 네트워크를 통한 API 키, 자격증명 |
| 프로덕션 배포 | 프로덕션을 대상으로 하는 배포 명령어 |
| 대량 삭제 | 대형 디렉토리에 `rm -rf` |
| IAM 변경 | 권한 및 역할 수정 |
| main에 강제 푸시 | `git push --force origin main` |

### 기본 허용 행동

| 허용 행동 | 예시 |
|----------------|---------|
| 로컬 파일 작업 | 프로젝트 파일 읽기, 쓰기, 편집 |
| 선언된 의존성 설치 | manifest에서 `npm install`, `pip install` |
| 읽기 전용 HTTP | 문서 가져오기 위한 `curl` |
| 현재 브랜치 푸시 | `git push origin feature-branch` |

### Auto Mode 설정

**기본 규칙을 JSON으로 출력**:
```bash
claude auto-mode defaults
```

**신뢰된 인프라 구성**: 엔터프라이즈 배포를 위한 `autoMode.environment` 관리형 설정을 통해. 관리자가 신뢰된 CI/CD 환경, 배포 대상, 인프라 패턴을 정의할 수 있습니다.

### 폴백 동작

분류기가 확신하지 못할 때, auto mode는 사용자에게 프롬프트로 폴백합니다:
- **연속 3회** 분류기 차단 후
- 세션에서 **총 20회** 분류기 차단 후

이를 통해 분류기가 행동을 자신 있게 승인할 수 없을 때 사용자가 항상 제어권을 유지합니다.

### Auto Mode 동등 권한 시드 (Team 플랜 불필요)

Team 플랜이 없거나 백그라운드 분류기 없이 더 간단한 접근 방식을 원한다면, 보수적인 안전 권한 규칙 기준으로 `~/.claude/settings.json`에 시드할 수 있습니다. 스크립트는 읽기 전용과 로컬 검사 규칙으로 시작하고, 편집, 테스트, 로컬 git 쓰기, 패키지 설치, GitHub 쓰기 작업은 원할 때만 선택적으로 추가할 수 있습니다.

**파일:** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# 추가될 내용 미리보기 (변경 없음)
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# 보수적 기준선 적용
python3 09-advanced-features/setup-auto-mode-permissions.py

# 필요할 때만 더 많은 기능 추가
python3 09-advanced-features/setup-auto-mode-permissions.py --include-edits --include-tests
python3 09-advanced-features/setup-auto-mode-permissions.py --include-git-write --include-packages
```

스크립트는 다음 카테고리의 규칙을 추가합니다:

| 카테고리 | 예시 |
|----------|---------|
| 핵심 읽기 전용 도구 | `Read(*)`, `Glob(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)`, `WebFetch(*)` |
| 로컬 검사 | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)`, `Bash(cat:*)` |
| 선택적 편집 | `Edit(*)`, `Write(*)`, `NotebookEdit(*)` |
| 선택적 테스트/빌드 | `Bash(pytest:*)`, `Bash(python3 -m pytest:*)`, `Bash(cargo test:*)` |
| 선택적 git 쓰기 | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git stash:*)` |
| Git (로컬 쓰기) | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)` |
| 패키지 관리자 | `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(cargo build:*)` |
| 빌드 & 테스트 | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| 일반 shell | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)`, `Bash(cp:*)`, `Bash(mv:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

위험한 작업 (`rm -rf`, `sudo`, 강제 푸시, `DROP TABLE`, `terraform destroy` 등)은 의도적으로 제외됩니다. 스크립트는 멱등성을 가집니다 — 두 번 실행해도 규칙이 중복되지 않습니다.

---

## 백그라운드 태스크

백그라운드 태스크를 사용하면 오래 걸리는 작업이 대화를 막지 않고 실행될 수 있습니다.

### 백그라운드 태스크란?

백그라운드 태스크는 사용자가 계속 작업하는 동안 비동기적으로 실행됩니다:
- 오래 걸리는 테스트 스위트
- 빌드 프로세스
- 데이터베이스 마이그레이션
- 배포 스크립트
- 분석 도구

**기본 사용법:**
```bash
User: 백그라운드에서 테스트 실행해줘

Claude: 태스크 bg-1234 시작

/task list           # 모든 태스크 표시
/task status bg-1234 # 진행 상황 확인
/task show bg-1234   # 출력 보기
/task cancel bg-1234 # 태스크 취소
```

### 백그라운드 태스크 시작

```
User: 전체 테스트 스위트를 백그라운드에서 실행해줘

Claude: 백그라운드에서 테스트 시작 중 (task-id: bg-1234)
테스트가 실행되는 동안 계속 작업할 수 있습니다.

[대화를 계속할 수 있음]

User: 그 사이에 auth 모듈 리팩터링 진행하자

Claude: [테스트가 백그라운드에서 실행되는 동안 auth 모듈 작업]

[나중에 테스트 완료 시]

Claude: 📢 백그라운드 태스크 bg-1234 완료:
✅ 245개 테스트 통과
❌ 3개 테스트 실패
결과 보기: /task show bg-1234
```

### 백그라운드 태스크 관리

**활성 태스크 목록**:
```
User: /task list

활성 백그라운드 태스크:
1. [bg-1234] 테스트 실행 중 (50% 완료, 2분 남음)
2. [bg-1235] Docker 이미지 빌드 중 (25% 완료, 8분 남음)
3. [bg-1236] 스테이징 배포 중 (90% 완료, 30초 남음)
```

**태스크 상태 확인**:
```
User: /task status bg-1234

태스크 bg-1234: 테스트 실행 중
상태: 진행 중
진행: 120/245 테스트 (49%)
시작: 2025-11-08 10:30:15
완료 예상: 2025-11-08 10:34:22
```

**태스크 출력 보기**:
```
User: /task show bg-1234

[테스트 실행의 실시간 출력 표시]
```

**태스크 취소**:
```
User: /task cancel bg-1234

백그라운드 태스크 bg-1234 취소됨
```

### 예시: 병렬 개발

```
User: 백그라운드에서 빌드 실행해줘

Claude: 빌드 시작 중... (task-id: bg-5001)

User: 린터도 백그라운드에서 실행해줘

Claude: 린터 시작 중... (task-id: bg-5002)

User: 그것들이 실행되는 동안 새 API 엔드포인트 구현하자

Claude: [빌드와 린터가 실행되는 동안 API 엔드포인트 구현]

[10분 후]

Claude: 📢 빌드 성공적으로 완료 (bg-5001)
📢 린터에서 12개 이슈 발견 (bg-5002)

User: 린터 이슈 보여줘

Claude: [bg-5002의 린터 출력 표시]
```

### 설정

```json
{
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5,
    "notifyOnCompletion": true,
    "autoCleanup": true,
    "logOutput": true
  }
}
```

---

## 예약 태스크

예약 태스크를 사용하면 반복 일정이나 일회성 알림으로 프롬프트를 자동으로 실행할 수 있습니다. 태스크는 세션 범위로 — Claude Code가 활성 상태인 동안 실행되며 세션이 종료될 때 삭제됩니다. v2.1.72+부터 사용 가능합니다.

### `/loop` 명령어

```bash
# 명시적 간격
/loop 5m 배포가 완료되었는지 확인해줘

# 자연어
/loop 30분마다 빌드 상태 확인해줘
```

표준 5필드 cron 표현식도 정확한 일정 지정에 지원됩니다.

### 일회성 알림

특정 시간에 한 번 발동하는 알림 설정:

```
오후 3시에 릴리즈 브랜치 푸시하라고 알려줘
45분 후에 통합 테스트 실행해줘
```

### 예약 태스크 관리

| 도구 | 설명 |
|------|-------------|
| `CronCreate` | 새 예약 태스크 생성 |
| `CronList` | 활성 예약 태스크 목록 |
| `CronDelete` | 예약 태스크 삭제 |

**제한 및 동작**:
- 세션당 최대 **50개의 예약 태스크**
- 세션 범위 — 세션이 종료될 때 삭제
- 반복 태스크는 **3일** 후 자동 만료
- Claude Code가 실행 중일 때만 태스크 발동 — 누락된 실행에 대한 보충 없음

### 동작 세부 사항

| 측면 | 세부 사항 |
|--------|--------|
| **반복 지터** | 간격의 최대 10% (최대 15분) |
| **일회성 지터** | :00/:30 경계에서 최대 90초 |
| **누락된 실행** | 보충 없음 — Claude Code가 실행 중이 아닌 경우 건너뜀 |
| **지속성** | 재시작 간에 지속되지 않음 |

### 클라우드 예약 태스크

Anthropic 인프라에서 실행되는 클라우드 예약 태스크를 생성하려면 `/schedule`을 사용합니다:

```
/schedule 매일 오전 9시에 테스트 스위트를 실행하고 실패 사항을 보고해줘
```

클라우드 예약 태스크는 재시작 간에 지속되며 Claude Code가 로컬에서 실행 중일 필요가 없습니다.

### 예약 태스크 비활성화

```bash
export CLAUDE_CODE_DISABLE_CRON=1
```

### 예시: 배포 모니터링

```
/loop 5m 스테이징 환경의 배포 상태를 확인해줘.
        배포가 성공했으면 알려주고 루프를 멈춰줘.
        실패했으면 오류 로그를 보여줘.
```

> **팁**: 예약 태스크는 세션 범위입니다. 재시작 후에도 지속되는 자동화에는 CI/CD 파이프라인, GitHub Actions, 또는 데스크탑 앱 예약 태스크를 사용하세요.

---

## 권한 모드

권한 모드는 Claude가 명시적 승인 없이 취할 수 있는 행동을 제어합니다.

### 사용 가능한 권한 모드

| 모드 | 동작 |
|---|---|
| `default` | 파일만 읽기; 다른 모든 행동에 대해 프롬프트 |
| `acceptEdits` | 파일 읽기 및 편집; 명령어에 대해 프롬프트 |
| `plan` | 파일만 읽기 (리서치 모드, 편집 없음) |
| `auto` | 백그라운드 안전 분류기 검사와 함께 모든 행동 (Research Preview) |
| `bypassPermissions` | 모든 행동, 권한 검사 없음 (위험) |
| `dontAsk` | 사전 승인된 도구만 실행; 다른 모든 것은 거부 |

CLI에서 `Shift+Tab`으로 모드를 전환합니다. `--permission-mode` 플래그 또는 `permissions.defaultMode` 설정으로 기본값을 지정합니다.

### 활성화 방법

**키보드 단축키**:
```bash
Shift + Tab  # 6가지 모드 모두 전환
```

**Slash Command**:
```bash
/plan                  # plan 모드 진입
```

**CLI 플래그**:
```bash
claude --permission-mode plan
claude --permission-mode auto
```

**설정**:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 권한 모드 예시

#### 기본 모드
Claude가 중요한 행동에 대해 확인을 요청합니다:

```
User: auth.ts의 버그 수정해줘

Claude: src/auth.ts를 수정하여 버그를 수정해야 합니다.
변경 사항은 비밀번호 검증 로직을 업데이트합니다.

이 변경을 승인하시겠습니까? (yes/no/show)
```

#### 계획 모드
실행 전 구현 계획 검토:

```
User: /plan 사용자 인증 시스템 구현

Claude: 인증 구현 계획을 수립하겠습니다.

## 구현 계획
[단계와 순서가 있는 상세 계획]

진행하시겠습니까? (yes/no/modify)
```

#### 편집 수락 모드
파일 수정을 자동으로 수락:

```
User: acceptEdits
User: auth.ts의 버그 수정해줘

Claude: [확인 없이 변경 진행]
```

### 사용 사례

**코드 리뷰**:
```
User: claude --permission-mode plan
User: 이 PR을 검토하고 개선 사항을 제안해줘

Claude: [코드 읽기, 피드백 제공, 수정 불가]
```

**페어 프로그래밍**:
```
User: claude --permission-mode default
User: 기능을 함께 구현하자

Claude: [각 변경 전 승인 요청]
```

**자동화된 태스크**:
```
User: claude --permission-mode acceptEdits
User: 코드베이스의 모든 lint 이슈 수정해줘

Claude: [확인 없이 파일 편집 자동 수락]
```

---

## 헤드리스 모드

Print Mode (`claude -p`)를 사용하면 Claude Code가 인터랙티브 입력 없이 실행되어 자동화와 CI/CD에 적합합니다. 이것은 이전의 `--headless` 플래그를 대체하는 비대화형 모드입니다.

### Print Mode란?

Print Mode는 다음을 가능하게 합니다:
- 자동화된 스크립트 실행
- CI/CD 연동
- 일괄 처리
- 예약 태스크

### Print Mode (비대화형) 실행

```bash
# 특정 태스크 실행
claude -p "모든 테스트 실행"

# 파이프된 내용 처리
cat error.log | claude -p "이 오류들을 분석해줘"

# CI/CD 연동 (GitHub Actions)
- name: AI 코드 리뷰
  run: claude -p "PR 검토"
```

### 추가 Print Mode 사용 예시

```bash
# 출력 캡처로 특정 태스크 실행
claude -p "모든 테스트를 실행하고 커버리지 리포트 생성"

# 구조화된 출력 사용
claude -p --output-format json "코드 품질 분석"

# stdin에서 입력 받기
echo "코드 품질 분석" | claude -p "설명해줘"
```

### 예시: CI/CD 연동

**GitHub Actions**:
```yaml
# .github/workflows/code-review.yml
name: AI 코드 리뷰

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Claude Code 설치
        run: npm install -g @anthropic-ai/claude-code

      - name: Claude Code 리뷰 실행
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p --output-format json \
            --max-turns 3 \
            "이 PR을 다음 항목에 대해 검토해줘:
            - 코드 품질 이슈
            - 보안 취약점
            - 성능 문제
            - 테스트 커버리지
            결과를 JSON으로 출력" > review.json

      - name: 리뷰 코멘트 게시
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: JSON.stringify(review, null, 2)
            });
```

### Print Mode 설정

Print Mode (`claude -p`)는 자동화를 위한 여러 플래그를 지원합니다:

```bash
# 자율 턴 수 제한
claude -p --max-turns 5 "이 모듈 리팩터링"

# 구조화된 JSON 출력
claude -p --output-format json "이 코드베이스 분석"

# 스키마 검증과 함께
claude -p --json-schema '{"type":"object","properties":{"issues":{"type":"array"}}}' \
  "이 코드에서 버그 찾기"

# 세션 지속성 비활성화
claude -p --no-session-persistence "일회성 분석"
```

---

## 세션 관리

여러 Claude Code 세션을 효과적으로 관리합니다.

### 세션 관리 명령어

| 명령어 | 설명 |
|---------|-------------|
| `/resume` | ID 또는 이름으로 대화 재개 |
| `/rename` | 현재 세션 이름 지정 |
| `/fork` | 현재 세션을 새 브랜치로 포크 |
| `claude -c` | 가장 최근 대화 계속하기 |
| `claude -r "session"` | 이름 또는 ID로 세션 재개 |

### 세션 재개

**마지막 대화 계속하기**:
```bash
claude -c
```

**이름이 지정된 세션 재개**:
```bash
claude -r "auth-refactor" "이 PR 마무리"
```

**현재 세션 이름 지정** (REPL 내에서):
```
/rename auth-refactor
```

### 세션 포크

원본을 잃지 않고 대안적 접근 방식을 시도하기 위해 세션 포크:

```
/fork
```

또는 CLI에서:
```bash
claude --resume auth-refactor --fork-session "OAuth 대신 시도"
```

### 세션 지속성

세션은 자동으로 저장되고 재개할 수 있습니다:

```bash
# 마지막 대화 계속하기
claude -c

# 이름 또는 ID로 특정 세션 재개
claude -r "auth-refactor"

# 실험을 위한 재개 및 포크
claude --resume auth-refactor --fork-session "대안적 접근"
```

---

## 인터랙티브 기능

### 키보드 단축키

Claude Code는 효율성을 위한 키보드 단축키를 지원합니다. 공식 문서의 전체 참조:

| 단축키 | 설명 |
|----------|-------------|
| `Ctrl+C` | 현재 입력/생성 취소 |
| `Ctrl+D` | Claude Code 종료 |
| `Ctrl+G` | 외부 편집기에서 계획 편집 |
| `Ctrl+L` | 터미널 화면 지우기 |
| `Ctrl+O` | 상세 출력 토글 (추론 보기) |
| `Ctrl+R` | 기록 역방향 검색 |
| `Ctrl+T` | 태스크 목록 보기 토글 |
| `Ctrl+B` | 실행 중인 태스크 백그라운드 전환 |
| `Esc+Esc` | 코드/대화 되돌리기 |
| `Shift+Tab` / `Alt+M` | 권한 모드 전환 |
| `Option+P` / `Alt+P` | 모델 전환 |
| `Option+T` / `Alt+T` | 확장 사고 토글 |

**줄 편집 (표준 readline 단축키):**

| 단축키 | 동작 |
|----------|--------|
| `Ctrl + A` | 줄 시작으로 이동 |
| `Ctrl + E` | 줄 끝으로 이동 |
| `Ctrl + K` | 줄 끝까지 잘라내기 |
| `Ctrl + U` | 줄 시작까지 잘라내기 |
| `Ctrl + W` | 이전 단어 삭제 |
| `Ctrl + Y` | 붙여넣기 (yank) |
| `Tab` | 자동 완성 |
| `↑ / ↓` | 명령어 기록 |

### 키바인딩 커스터마이징

`/keybindings`를 실행하면 편집을 위해 `~/.claude/keybindings.json`이 열립니다 (v2.1.18+).

**설정 형식**:

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+u": null,
        "ctrl+k ctrl+s": "chat:stash"
      }
    },
    {
      "context": "Confirmation",
      "bindings": {
        "ctrl+a": "confirmation:yes"
      }
    }
  ]
}
```

바인딩을 `null`로 설정하면 기본 단축키가 해제됩니다.

### 사용 가능한 컨텍스트

키바인딩은 특정 UI 컨텍스트로 범위가 지정됩니다:

| 컨텍스트 | 키 동작 |
|---------|-------------|
| **Chat** | `submit`, `cancel`, `cycleMode`, `modelPicker`, `thinkingToggle`, `undo`, `externalEditor`, `stash`, `imagePaste` |
| **Confirmation** | `yes`, `no`, `previous`, `next`, `nextField`, `cycleMode`, `toggleExplanation` |
| **Global** | `interrupt`, `exit`, `toggleTodos`, `toggleTranscript` |
| **Autocomplete** | `accept`, `dismiss`, `next`, `previous` |
| **HistorySearch** | `search`, `previous`, `next` |
| **Settings** | 컨텍스트별 설정 탐색 |
| **Tabs** | 탭 전환 및 관리 |
| **Help** | 도움말 패널 탐색 |

`Transcript`, `Task`, `ThemePicker`, `Attachments`, `Footer`, `MessageSelector`, `DiffDialog`, `ModelPicker`, `Select`를 포함하여 총 18개의 컨텍스트가 있습니다.

### 코드 지원

키바인딩은 코드 시퀀스 (다중 키 조합)를 지원합니다:

```
"ctrl+k ctrl+s"   → 두 키 시퀀스: ctrl+k를 누른 후 ctrl+s
"ctrl+shift+p"    → 동시 수정자 키
```

**키스트로크 구문**:
- **수정자**: `ctrl`, `alt` (또는 `opt`), `shift`, `meta` (또는 `cmd`)
- **대문자는 Shift를 의미**: `K`는 `shift+k`와 동일
- **특수 키**: `escape`, `enter`, `return`, `tab`, `space`, `backspace`, `delete`, 방향키

### 예약 및 충돌하는 키

| 키 | 상태 | 비고 |
|-----|--------|-------|
| `Ctrl+C` | 예약됨 | 재바인딩 불가 (인터럽트) |
| `Ctrl+D` | 예약됨 | 재바인딩 불가 (종료) |
| `Ctrl+B` | 터미널 충돌 | tmux 프리픽스 키 |
| `Ctrl+A` | 터미널 충돌 | GNU Screen 프리픽스 키 |
| `Ctrl+Z` | 터미널 충돌 | 프로세스 일시정지 |

> **팁**: 단축키가 작동하지 않으면 터미널 에뮬레이터 또는 멀티플렉서와의 충돌을 확인하세요.

### 탭 완성

Claude Code는 지능적인 탭 완성을 제공합니다:

```
User: /rew<TAB>
→ /rewind

User: /plu<TAB>
→ /plugin

User: /plugin <TAB>
→ /plugin install
→ /plugin enable
→ /plugin disable
```

### 명령어 기록

이전 명령어에 접근:

```
User: <↑>  # 이전 명령어
User: <↓>  # 다음 명령어
User: Ctrl+R  # 기록 검색

(역방향 검색)`test': 모든 테스트 실행
```

### 다중 줄 입력

복잡한 쿼리는 다중 줄 모드를 사용합니다:

```bash
User: \
> 긴 복잡한 프롬프트
> 여러 줄에 걸쳐
> \end
```

**예시:**

```
User: \
> 다음 요구사항을 갖춘
> 사용자 인증 시스템을 구현해줘:
> - JWT 토큰
> - 이메일 인증
> - 비밀번호 재설정
> - 2FA 지원
> \end

Claude: [다중 줄 요청 처리]
```

### 인라인 편집

전송 전 명령어 편집:

```
User: 프로덕션에 배포<Backspace><Backspace>...

[전송 전 직접 편집]
```

### Vim 모드

텍스트 편집을 위한 Vi/Vim 키바인딩 활성화:

**활성화**:
- `/vim` 명령어 또는 `/config`로 활성화
- `Esc`로 NORMAL 모드, `i/a/o`로 INSERT 모드 전환

**탐색 키**:
- `h` / `l` - 좌우 이동
- `j` / `k` - 상하 이동
- `w` / `b` / `e` - 단어 단위 이동
- `0` / `$` - 줄 시작/끝으로 이동
- `gg` / `G` - 텍스트 시작/끝으로 점프

**텍스트 오브젝트**:
- `iw` / `aw` - 단어 안쪽/바깥쪽
- `i"` / `a"` - 따옴표 문자열 안쪽/바깥쪽
- `i(` / `a(` - 괄호 안쪽/바깥쪽

### Bash 모드

`!` 접두사로 shell 명령어를 직접 실행:

```bash
! npm test
! git status
! cat src/index.js
```

컨텍스트를 전환하지 않고 빠른 명령어 실행에 사용합니다.

---

## 음성 받아쓰기

음성 받아쓰기는 Claude Code에 push-to-talk 음성 입력을 제공하여 입력하는 대신 말로 프롬프트를 할 수 있게 합니다.

### 음성 받아쓰기 활성화

```
/voice
```

### 기능

| 기능 | 설명 |
|---------|-------------|
| **Push-to-talk** | 키를 눌러 녹음, 놓으면 전송 |
| **20개 언어** | Speech-to-text가 20개 언어 지원 |
| **커스텀 키바인딩** | `/keybindings`로 push-to-talk 키 설정 |
| **계정 요구** | STT 처리를 위해 Claude.ai 계정 필요 |

### 설정

키바인딩 파일 (`/keybindings`)에서 push-to-talk 키바인딩을 커스터마이징합니다. 음성 받아쓰기는 speech-to-text 처리에 Claude.ai 계정을 사용합니다.

---

## 채널

채널 (Research Preview)은 MCP 서버가 실행 중인 Claude Code 세션에 메시지를 전송하여 외부 서비스와의 실시간 연동을 가능하게 합니다.

### 채널 구독

```bash
# 시작 시 채널 플러그인 구독
claude --channels discord,telegram
```

### 지원되는 연동

| 연동 | 설명 |
|-------------|-------------|
| **Discord** | 세션에서 Discord 메시지 수신 및 응답 |
| **Telegram** | 세션에서 Telegram 메시지 수신 및 응답 |

### 설정

엔터프라이즈 배포를 위한 **관리형 설정**:

```json
{
  "allowedChannelPlugins": ["discord", "telegram"]
}
```

`allowedChannelPlugins` 관리형 설정은 조직 전체에서 허용되는 채널 플러그인을 제어합니다.

### 작동 방식

1. MCP 서버가 외부 서비스에 연결하는 채널 플러그인으로 작동
2. 들어오는 메시지가 활성 Claude Code 세션으로 전송됨
3. Claude는 세션 컨텍스트 내에서 메시지를 읽고 응답 가능
4. 채널 플러그인은 `allowedChannelPlugins` 관리형 설정을 통해 승인되어야 함

---

## Chrome 연동

Chrome 연동은 Claude Code를 Chrome 또는 Microsoft Edge 브라우저에 연결하여 실시간 웹 자동화 및 디버깅을 가능하게 합니다. v2.0.73+부터 사용 가능한 베타 기능입니다 (Edge 지원은 v1.0.36+에 추가).

### Chrome 연동 활성화

**시작 시**:

```bash
claude --chrome      # Chrome 연결 활성화
claude --no-chrome   # Chrome 연결 비활성화
```

**세션 내에서**:

```
/chrome
```

"기본으로 활성화"를 선택하면 모든 미래 세션에 Chrome 연동이 활성화됩니다. Claude Code는 브라우저의 로그인 상태를 공유하므로 인증된 웹 앱과 상호작용할 수 있습니다.

### 기능

| 기능 | 설명 |
|------------|-------------|
| **실시간 디버깅** | 콘솔 로그 읽기, DOM 요소 검사, JavaScript 실시간 디버깅 |
| **디자인 검증** | 렌더링된 페이지를 디자인 목업과 비교 |
| **폼 검증** | 폼 제출, 입력 검증, 오류 처리 테스트 |
| **웹 앱 테스트** | 인증된 앱과 상호작용 (Gmail, Google Docs, Notion 등) |
| **데이터 추출** | 웹 페이지에서 콘텐츠 스크래핑 및 처리 |
| **세션 녹화** | 브라우저 상호작용을 GIF 파일로 녹화 |

### 사이트 수준 권한

Chrome 확장 프로그램이 사이트별 접근을 관리합니다. 확장 프로그램 팝업을 통해 언제든지 특정 사이트에 대한 접근을 허용하거나 취소할 수 있습니다. Claude Code는 명시적으로 허용한 사이트와만 상호작용합니다.

### 작동 방식

Claude Code는 보이는 창에서 브라우저를 제어합니다 — 실시간으로 행동을 볼 수 있습니다. 브라우저가 로그인 페이지나 CAPTCHA를 만나면 Claude가 멈추고 사용자가 수동으로 처리할 때까지 기다린 후 계속합니다.

### 알려진 제한 사항

- **브라우저 지원**: Chrome과 Edge만 — Brave, Arc 및 다른 Chromium 브라우저는 지원되지 않음
- **WSL**: Windows Subsystem for Linux에서 사용 불가
- **서드파티 프로바이더**: Bedrock, Vertex, Foundry API 프로바이더와는 지원되지 않음
- **서비스 워커 유휴**: 확장된 세션 중 Chrome 확장 서비스 워커가 유휴 상태가 될 수 있음

> **팁**: Chrome 연동은 베타 기능입니다. 브라우저 지원은 향후 릴리즈에서 확장될 수 있습니다.

---

## 원격 제어

원격 제어를 사용하면 로컬에서 실행 중인 Claude Code 세션을 전화기, 태블릿, 또는 모든 브라우저에서 계속할 수 있습니다. 로컬 세션은 사용자 기기에서 계속 실행됩니다 — 클라우드로 이동하는 것은 없습니다. Pro, Max, Team, Enterprise 플랜에서 사용 가능합니다 (v2.1.51+).

### 원격 제어 시작

**CLI에서**:

```bash
# 기본 세션 이름으로 시작
claude remote-control

# 커스텀 이름으로 시작
claude remote-control --name "Auth Refactor"
```

**세션 내에서**:

```
/remote-control
/remote-control "Auth Refactor"
```

**사용 가능한 플래그**:

| 플래그 | 설명 |
|------|-------------|
| `--name "title"` | 쉽게 식별하기 위한 커스텀 세션 제목 |
| `--verbose` | 상세 연결 로그 표시 |
| `--sandbox` | 파일시스템 및 네트워크 격리 활성화 |
| `--no-sandbox` | 샌드박싱 비활성화 (기본값) |

### 세션 연결

다른 기기에서 연결하는 세 가지 방법:

1. **세션 URL** — 세션이 시작될 때 터미널에 출력됩니다; 모든 브라우저에서 열기
2. **QR 코드** — 시작 후 `spacebar`를 눌러 스캔 가능한 QR 코드 표시
3. **이름으로 찾기** — claude.ai/code 또는 Claude 모바일 앱 (iOS/Android)에서 세션 탐색

### 보안

- 기기에 **인바운드 포트 없음**
- TLS를 통한 **아웃바운드 HTTPS만**
- **범위 지정 자격증명** — 여러 개의 단기 범위 지정 토큰
- **세션 격리** — 각 원격 세션은 독립적

### 원격 제어 vs 웹에서 Claude Code

| 측면 | 원격 제어 | 웹에서 Claude Code |
|--------|---------------|-------------------|
| **실행** | 사용자 기기에서 실행 | Anthropic 클라우드에서 실행 |
| **로컬 도구** | 로컬 MCP 서버, 파일, CLI에 완전한 접근 | 로컬 의존성 없음 |
| **사용 사례** | 다른 기기에서 로컬 작업 계속 | 모든 브라우저에서 새로 시작 |

### 제한 사항

- Claude Code 인스턴스당 하나의 원격 세션
- 호스트 기기에서 터미널이 열려 있어야 함
- 네트워크에 연결할 수 없는 경우 약 10분 후 세션 시간 초과

### 사용 사례

- 책상에서 떨어져 있는 동안 모바일 기기나 태블릿에서 Claude Code 제어
- 로컬 도구 실행을 유지하면서 더 풍부한 claude.ai UI 사용
- 전체 로컬 개발 환경으로 이동 중 빠른 코드 리뷰

---

## 웹 세션

웹 세션을 사용하면 claude.ai/code에서 브라우저로 직접 Claude Code를 실행하거나 CLI에서 웹 세션을 생성할 수 있습니다.

### 웹 세션 생성

```bash
# CLI에서 새 웹 세션 생성
claude --remote "새 API 엔드포인트 구현"
```

모든 브라우저에서 접근할 수 있는 claude.ai에서 Claude Code 세션이 시작됩니다.

### 웹 세션을 로컬에서 재개

웹에서 세션을 시작했고 로컬에서 계속하고 싶다면:

```bash
# 로컬 터미널에서 웹 세션 재개
claude --teleport
```

또는 인터랙티브 REPL 내에서:
```
/teleport
```

### 사용 사례

- 한 기기에서 시작하고 다른 기기에서 계속하기
- 팀원들과 세션 URL 공유
- 시각적 diff 검토를 위해 웹 UI를 사용한 후 실행을 위해 터미널로 전환

---

## 데스크탑 앱

Claude Code 데스크탑 앱은 시각적 diff 검토, 병렬 세션, 통합 커넥터를 갖춘 독립형 애플리케이션을 제공합니다. macOS 및 Windows에서 사용 가능합니다 (Pro, Max, Team, Enterprise 플랜).

### 설치

[claude.ai](https://claude.ai)에서 플랫폼에 맞게 다운로드:
- **macOS**: 유니버설 빌드 (Apple Silicon 및 Intel)
- **Windows**: x64 및 ARM64 설치 프로그램 사용 가능

설치 안내는 [데스크탑 빠른 시작](https://code.claude.com/docs/en/desktop-quickstart)을 참조하세요.

### CLI에서 핸드오프

현재 CLI 세션을 데스크탑 앱으로 전환:

```
/desktop
```

### 핵심 기능

| 기능 | 설명 |
|---------|-------------|
| **Diff 보기** | 인라인 코멘트를 통한 파일별 시각적 검토; Claude가 코멘트를 읽고 수정 |
| **앱 미리보기** | 실시간 검증을 위한 내장 브라우저로 개발 서버 자동 시작 |
| **PR 모니터링** | GitHub CLI 연동으로 CI 실패 자동 수정 및 확인 통과 시 자동 머지 |
| **병렬 세션** | Git worktree 격리를 통한 사이드바의 여러 세션 |
| **예약 태스크** | 앱이 열려 있는 동안 실행되는 반복 태스크 (시간별, 일별, 평일별, 주별) |
| **풍부한 렌더링** | 구문 강조를 통한 코드, 마크다운, 다이어그램 렌더링 |

### 앱 미리보기 설정

`.claude/launch.json`에서 개발 서버 동작 구성:

```json
{
  "command": "npm run dev",
  "port": 3000,
  "readyPattern": "ready on",
  "persistCookies": true
}
```

### 커넥터

더 풍부한 컨텍스트를 위해 외부 서비스 연결:

| 커넥터 | 기능 |
|-----------|------------|
| **GitHub** | PR 모니터링, 이슈 추적, 코드 리뷰 |
| **Slack** | 알림, 채널 컨텍스트 |
| **Linear** | 이슈 추적, 스프린트 관리 |
| **Notion** | 문서화, 지식베이스 접근 |
| **Asana** | 태스크 관리, 프로젝트 추적 |
| **Calendar** | 일정 인식, 미팅 컨텍스트 |

> **참고**: 커넥터는 원격 (클라우드) 세션에서 사용할 수 없습니다.

### 원격 및 SSH 세션

- **원격 세션**: Anthropic 클라우드 인프라에서 실행; 앱이 닫혀 있어도 계속됩니다. claude.ai/code 또는 Claude 모바일 앱에서 접근 가능
- **SSH 세션**: SSH를 통해 원격 기기에 연결하여 원격 파일시스템 및 도구에 완전한 접근. 원격 기기에 Claude Code가 설치되어 있어야 함

### 데스크탑에서 권한 모드

데스크탑 앱은 CLI와 동일한 4가지 권한 모드를 지원합니다:

| 모드 | 동작 |
|------|----------|
| **권한 묻기** (기본값) | 모든 편집 및 명령어 검토 및 승인 |
| **편집 자동 수락** | 파일 편집은 자동 승인; 명령어는 수동 승인 필요 |
| **계획 모드** | 변경 전 접근 방식 검토 |
| **권한 우회** | 자동 실행 (샌드박스 전용, 관리자 제어) |

### 엔터프라이즈 기능

- **관리 콘솔**: 조직의 Code 탭 접근 및 권한 설정 제어
- **MDM 배포**: macOS에서 MDM 또는 Windows에서 MSIX를 통해 배포
- **SSO 연동**: 조직 구성원에게 단일 로그인 요구
- **관리형 설정**: 팀 설정 및 모델 가용성 중앙 관리

---

## 태스크 목록

태스크 목록 기능은 컨텍스트 압축 (대화 기록이 컨텍스트 창에 맞게 잘릴 때)을 넘어 지속되는 태스크 추적을 제공합니다.

### 태스크 목록 토글

세션 중 `Ctrl+T`를 눌러 태스크 목록 보기를 켜거나 끕니다.

### 지속 태스크

태스크는 컨텍스트 압축을 넘어 지속되어, 대화 컨텍스트가 잘릴 때 오래 진행 중인 작업 항목이 손실되지 않도록 합니다. 이는 복잡한 다단계 구현에 특히 유용합니다.

### 이름이 지정된 태스크 디렉토리

`CLAUDE_CODE_TASK_LIST_ID` 환경 변수를 사용하여 세션 간에 공유되는 이름이 지정된 태스크 디렉토리를 생성합니다:

```bash
export CLAUDE_CODE_TASK_LIST_ID=my-project-sprint-3
```

이를 통해 여러 세션이 동일한 태스크 목록을 공유할 수 있어 팀 워크플로우나 다중 세션 프로젝트에 유용합니다.

---

## 프롬프트 제안

프롬프트 제안은 Git 기록과 현재 대화 컨텍스트를 기반으로 흐릿하게 표시되는 예제 명령어를 보여줍니다.

### 작동 방식

- 제안이 입력 프롬프트 아래에 흐릿한 텍스트로 나타남
- `Tab`을 눌러 제안 수락
- `Enter`를 눌러 수락하고 즉시 제출
- 제안은 Git 기록과 대화 상태를 기반으로 컨텍스트를 인식

### 프롬프트 제안 비활성화

```bash
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
```

---

## Git Worktrees

Git Worktrees를 사용하면 Claude Code를 격리된 worktree에서 시작하여 stash나 전환 없이 다른 브랜치에서 병렬 작업을 할 수 있습니다.

### Worktree에서 시작

```bash
# 격리된 worktree에서 Claude Code 시작
claude --worktree
# 또는
claude -w
```

### Worktree 위치

Worktree는 다음 위치에 생성됩니다:
```
<repo>/.claude/worktrees/<name>
```

### 모노레포를 위한 Sparse Checkout

`worktree.sparsePaths` 설정을 사용하여 모노레포에서 sparse-checkout을 수행하여 디스크 사용량과 클론 시간을 줄입니다:

```json
{
  "worktree": {
    "sparsePaths": ["packages/my-package", "shared/"]
  }
}
```

### Worktree 도구 및 Hooks

| 항목 | 설명 |
|------|-------------|
| `ExitWorktree` | 현재 worktree를 종료하고 정리하는 도구 |
| `WorktreeCreate` | worktree가 생성될 때 발동하는 Hook 이벤트 |
| `WorktreeRemove` | worktree가 제거될 때 발동하는 Hook 이벤트 |

### 자동 정리

Worktree에서 변경 사항이 없으면 세션이 종료될 때 자동으로 정리됩니다.

### 사용 사례

- main 브랜치에 영향을 주지 않고 기능 브랜치에서 작업
- 작업 디렉토리에 영향을 주지 않고 격리된 환경에서 테스트 실행
- 일회용 환경에서 실험적 변경 시도
- 더 빠른 시작을 위해 모노레포에서 특정 패키지 sparse-checkout

---

## 샌드박싱

샌드박싱은 Claude Code가 실행하는 Bash 명령어에 OS 수준의 파일시스템 및 네트워크 격리를 제공합니다. 이는 권한 규칙을 보완하며 추가적인 보안 계층을 제공합니다.

### 샌드박싱 활성화

**Slash Command**:
```
/sandbox
```

**CLI 플래그**:
```bash
claude --sandbox       # 샌드박싱 활성화
claude --no-sandbox    # 샌드박싱 비활성화
```

### 설정 항목

| 설정 | 설명 |
|---------|-------------|
| `sandbox.enabled` | 샌드박싱 활성화 또는 비활성화 |
| `sandbox.failIfUnavailable` | 샌드박싱을 활성화할 수 없으면 실패 |
| `sandbox.filesystem.allowWrite` | 쓰기 접근이 허용된 경로 |
| `sandbox.filesystem.allowRead` | 읽기 접근이 허용된 경로 |
| `sandbox.filesystem.denyRead` | 읽기 접근이 거부된 경로 |
| `sandbox.enableWeakerNetworkIsolation` | macOS에서 약한 네트워크 격리 활성화 |

### 예시 설정

```json
{
  "sandbox": {
    "enabled": true,
    "failIfUnavailable": true,
    "filesystem": {
      "allowWrite": ["/Users/me/project"],
      "allowRead": ["/Users/me/project", "/usr/local/lib"],
      "denyRead": ["/Users/me/.ssh", "/Users/me/.aws"]
    },
    "enableWeakerNetworkIsolation": true
  }
}
```

### 작동 방식

- Bash 명령어는 제한된 파일시스템 접근으로 샌드박스 환경에서 실행
- 의도하지 않은 외부 연결을 방지하기 위해 네트워크 접근 격리 가능
- 심층 방어를 위해 권한 규칙과 함께 작동
- macOS에서는 네트워크 제한을 위해 `sandbox.enableWeakerNetworkIsolation`을 사용 (macOS에서는 완전한 네트워크 격리 불가)

### 사용 사례

- 신뢰할 수 없거나 생성된 코드를 안전하게 실행
- 프로젝트 외부 파일의 우발적 수정 방지
- 자동화된 태스크 중 네트워크 접근 제한

---

## 관리형 설정 (엔터프라이즈)

관리형 설정을 사용하면 엔터프라이즈 관리자가 플랫폼 기본 관리 도구를 사용하여 조직 전체에 Claude Code 설정을 배포할 수 있습니다.

### 배포 방법

| 플랫폼 | 방법 | 버전 |
|----------|--------|-------|
| macOS | 관리형 plist 파일 (MDM) | v2.1.51+ |
| Windows | Windows 레지스트리 | v2.1.51+ |
| 크로스 플랫폼 | 관리형 설정 파일 | v2.1.51+ |
| 크로스 플랫폼 | 관리형 드롭인 (`managed-settings.d/` 디렉토리) | v2.1.83+ |

### 관리형 드롭인

v2.1.83부터 관리자는 `managed-settings.d/` 디렉토리에 여러 관리형 설정 파일을 배포할 수 있습니다. 파일은 알파벳 순서로 병합되어 팀 간 모듈식 설정을 허용합니다:

```
~/.claude/managed-settings.d/
  00-org-defaults.json
  10-team-policies.json
  20-project-overrides.json
```

### 사용 가능한 관리형 설정

| 설정 | 설명 |
|---------|-------------|
| `disableBypassPermissionsMode` | 사용자가 권한 우회 활성화를 못하게 함 |
| `availableModels` | 사용자가 선택할 수 있는 모델 제한 |
| `allowedChannelPlugins` | 허용되는 채널 플러그인 제어 |
| `autoMode.environment` | auto mode를 위한 신뢰된 인프라 구성 |
| 커스텀 정책 | 조직별 권한 및 도구 정책 |

### 예시: macOS Plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>disableBypassPermissionsMode</key>
  <true/>
  <key>availableModels</key>
  <array>
    <string>claude-sonnet-4-6</string>
    <string>claude-haiku-4-5</string>
  </array>
</dict>
</plist>
```

---

## 설정 구성

### 설정 파일 위치

1. **전역 설정**: `~/.claude/config.json`
2. **프로젝트 설정**: `./.claude/config.json`
3. **사용자 설정**: `~/.config/claude-code/settings.json`

### 전체 설정 예시

**핵심 고급 기능 설정:**

```json
{
  "permissions": {
    "mode": "default"
  },
  "hooks": {
    "PreToolUse:Edit": "eslint --fix ${file_path}",
    "PostToolUse:Write": "~/.claude/hooks/security-scan.sh"
  },
  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"]
      }
    }
  }
}
```

**확장 설정 예시:**

```json
{
  "permissions": {
    "mode": "default",
    "allowedTools": ["Bash(git log:*)", "Read"],
    "disallowedTools": ["Bash(rm -rf:*)"]
  },

  "hooks": {
    "PreToolUse": [{ "matcher": "Edit", "hooks": ["eslint --fix ${file_path}"] }],
    "PostToolUse": [{ "matcher": "Write", "hooks": ["~/.claude/hooks/security-scan.sh"] }],
    "Stop": [{ "hooks": ["~/.claude/hooks/notify.sh"] }]
  },

  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"],
        "env": {
          "GITHUB_TOKEN": "${GITHUB_TOKEN}"
        }
      }
    }
  }
}
```

### 환경 변수

환경 변수로 설정 재정의:

```bash
# 모델 선택
export ANTHROPIC_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6
export ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-haiku-4-5

# API 설정
export ANTHROPIC_API_KEY=sk-ant-...

# 사고 설정
export MAX_THINKING_TOKENS=16000
export CLAUDE_CODE_EFFORT_LEVEL=high

# 기능 토글
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=true
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=true
export CLAUDE_CODE_DISABLE_CRON=1
export CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS=true
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=true
export CLAUDE_CODE_DISABLE_1M_CONTEXT=true
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=true
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
export CLAUDE_CODE_ENABLE_TASKS=true
export CLAUDE_CODE_SIMPLE=true              # --bare 플래그로 설정됨

# MCP 설정
export MAX_MCP_OUTPUT_TOKENS=50000
export ENABLE_TOOL_SEARCH=true

# 태스크 관리
export CLAUDE_CODE_TASK_LIST_ID=my-project-tasks

# 에이전트 팀 (실험적)
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true

# Subagent 및 플러그인 설정
export CLAUDE_CODE_SUBAGENT_MODEL=sonnet
export CLAUDE_CODE_PLUGIN_SEED_DIR=./my-plugins
export CLAUDE_CODE_NEW_INIT=true

# 서브프로세스 및 스트리밍
export CLAUDE_CODE_SUBPROCESS_ENV_SCRUB="SECRET_KEY,DB_PASSWORD"
export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80
export CLAUDE_STREAM_IDLE_TIMEOUT_MS=30000
export ANTHROPIC_CUSTOM_MODEL_OPTION=my-custom-model
export SLASH_COMMAND_TOOL_CHAR_BUDGET=50000
```

### 설정 관리 명령어

```
User: /config
[인터랙티브 설정 메뉴 열기]
```

`/config` 명령어는 다음과 같은 설정을 토글하기 위한 인터랙티브 메뉴를 제공합니다:
- 확장 사고 켜기/끄기
- 상세 출력
- 권한 모드
- 모델 선택

### 프로젝트별 설정

프로젝트에 `.claude/config.json` 생성:

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": ["npm test && npm run lint"] }]
  },
  "permissions": {
    "mode": "default"
  },
  "mcp": {
    "servers": {
      "project-db": {
        "command": "mcp-postgres",
        "env": {
          "DATABASE_URL": "${PROJECT_DB_URL}"
        }
      }
    }
  }
}
```

---

## 모범 사례

### 계획 모드
- ✅ 복잡한 다단계 태스크에 사용
- ✅ 승인 전 계획 검토
- ✅ 필요 시 계획 수정
- ❌ 단순 태스크에는 사용하지 않기

### 확장 사고
- ✅ 아키텍처 결정에 사용
- ✅ 복잡한 문제 해결에 사용
- ✅ 사고 과정 검토
- ❌ 단순 쿼리에는 사용하지 않기

### 백그라운드 태스크
- ✅ 오래 걸리는 작업에 사용
- ✅ 태스크 진행 상황 모니터링
- ✅ 태스크 실패를 우아하게 처리
- ❌ 너무 많은 동시 태스크 시작하지 않기

### 권한
- ✅ 코드 리뷰에 `plan` 사용 (읽기 전용)
- ✅ 인터랙티브 개발에 `default` 사용
- ✅ 자동화 워크플로우에 `acceptEdits` 사용
- ✅ 안전 가드레일이 있는 자율 작업에 `auto` 사용
- ❌ 꼭 필요한 경우가 아니면 `bypassPermissions` 사용하지 않기

### 세션
- ✅ 다른 태스크에는 별도 세션 사용
- ✅ 중요한 세션 상태 저장
- ✅ 오래된 세션 정리
- ❌ 관련 없는 작업을 하나의 세션에 섞지 않기

---

## 추가 자료

Claude Code 및 관련 기능에 대한 자세한 정보:

- [공식 인터랙티브 모드 문서](https://code.claude.com/docs/en/interactive-mode)
- [공식 헤드리스 모드 문서](https://code.claude.com/docs/en/headless)
- [CLI 참조](https://code.claude.com/docs/en/cli-reference)
- [Checkpoints 가이드](../08-checkpoints/) - 세션 관리 및 되돌리기
- [Slash Commands](../01-slash-commands/) - 명령어 참조
- [Memory 가이드](../02-memory/) - 지속적 컨텍스트
- [Skills 가이드](../03-skills/) - 자율 기능
- [Subagents 가이드](../04-subagents/) - 위임된 태스크 실행
- [MCP 가이드](../05-mcp/) - 외부 데이터 접근
- [Hooks 가이드](../06-hooks/) - 이벤트 기반 자동화
- [Plugins 가이드](../07-plugins/) - 번들 확장
- [공식 예약 태스크 문서](https://code.claude.com/docs/en/scheduled-tasks)
- [공식 Chrome 연동 문서](https://code.claude.com/docs/en/chrome)
- [공식 원격 제어 문서](https://code.claude.com/docs/en/remote-control)
- [공식 키바인딩 문서](https://code.claude.com/docs/en/keybindings)
- [공식 데스크탑 앱 문서](https://code.claude.com/docs/en/desktop)
