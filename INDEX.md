<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 예제 - 전체 인덱스

이 문서는 기능 유형별로 정리된 모든 예제 파일의 전체 인덱스입니다.

## 요약 통계

- **전체 파일 수**: 100개 이상
- **카테고리**: 10개 기능 카테고리
- **Plugins**: 3개 완성형 플러그인
- **Skills**: 6개 완성형 스킬
- **Hooks**: 8개 예제 훅
- **사용 준비 완료**: 모든 예제

---

## 01. Slash Commands (10개 파일)

일반적인 워크플로우를 위한 사용자 호출 단축키.

| File | Description | Use Case |
|------|-------------|----------|
| `optimize.md` | 코드 최적화 분석기 | 성능 문제 탐지 |
| `pr.md` | Pull request 준비 도구 | PR 워크플로우 자동화 |
| `generate-api-docs.md` | API 문서 생성기 | API 문서 자동 생성 |
| `commit.md` | 커밋 메시지 도우미 | 표준화된 커밋 작성 |
| `setup-ci-cd.md` | CI/CD 파이프라인 설정 | DevOps 자동화 |
| `push-all.md` | 모든 변경사항 push | 빠른 push 워크플로우 |
| `unit-test-expand.md` | 단위 테스트 커버리지 확장 | 테스트 자동화 |
| `doc-refactor.md` | 문서 리팩토링 | 문서 품질 개선 |
| `pr-slash-command.png` | 스크린샷 예시 | 시각적 참고 자료 |
| `README.md` | 문서 | 설정 및 사용 가이드 |

**설치 경로**: `.claude/commands/`

**사용법**: `/optimize`, `/pr`, `/generate-api-docs`, `/commit`, `/setup-ci-cd`, `/push-all`, `/unit-test-expand`, `/doc-refactor`

---

## 02. Memory (6개 파일)

지속적인 컨텍스트와 프로젝트 표준 관리.

| File | Description | Scope | Location |
|------|-------------|-------|----------|
| `project-CLAUDE.md` | 팀 프로젝트 표준 | 프로젝트 전체 | `./CLAUDE.md` |
| `directory-api-CLAUDE.md` | API 전용 규칙 | 디렉토리 | `./src/api/CLAUDE.md` |
| `personal-CLAUDE.md` | 개인 선호 설정 | 사용자 | `~/.claude/CLAUDE.md` |
| `memory-saved.png` | 스크린샷: memory 저장 | - | 시각적 참고 자료 |
| `memory-ask-claude.png` | 스크린샷: Claude에게 질문 | - | 시각적 참고 자료 |
| `README.md` | 문서 | - | 참고 자료 |

**설치 방법**: 적절한 위치에 복사

**사용법**: Claude가 자동으로 불러옴

---

## 03. Skills (28개 파일)

스크립트와 템플릿이 포함된 자동 호출 기능.

### Code Review Skill (5개 파일)
```
code-review/
├── SKILL.md                          # Skill 정의
├── scripts/
│   ├── analyze-metrics.py            # 코드 지표 분석기
│   └── compare-complexity.py         # 복잡도 비교 도구
└── templates/
    ├── review-checklist.md           # 리뷰 체크리스트
    └── finding-template.md           # 발견 사항 문서 템플릿
```

**목적**: 보안, 성능, 품질 분석을 포함한 종합적인 코드 리뷰

**자동 호출**: 코드 리뷰 시

---

### Brand Voice Skill (4개 파일)
```
brand-voice/
├── SKILL.md                          # Skill 정의
├── templates/
│   ├── email-template.txt            # 이메일 형식
│   └── social-post-template.txt      # 소셜 미디어 형식
└── tone-examples.md                  # 메시지 예시
```

**목적**: 커뮤니케이션에서 일관된 브랜드 보이스 유지

**자동 호출**: 마케팅 카피 작성 시

---

### Documentation Generator Skill (2개 파일)
```
doc-generator/
├── SKILL.md                          # Skill 정의
└── generate-docs.py                  # Python 문서 추출기
```

**목적**: 소스 코드로부터 종합적인 API 문서 생성

**자동 호출**: API 문서 생성/업데이트 시

---

### Refactor Skill (5개 파일)
```
refactor/
├── SKILL.md                          # Skill 정의
├── scripts/
│   ├── analyze-complexity.py         # 복잡도 분석기
│   └── detect-smells.py              # 코드 스멜 탐지기
├── references/
│   ├── code-smells.md                # 코드 스멜 카탈로그
│   └── refactoring-catalog.md        # 리팩토링 패턴 카탈로그
└── templates/
    └── refactoring-plan.md           # 리팩토링 계획 템플릿
```

**목적**: 복잡도 분석을 통한 체계적인 코드 리팩토링

**자동 호출**: 코드 리팩토링 시

---

### Claude MD Skill (1개 파일)
```
claude-md/
└── SKILL.md                          # Skill 정의
```

**목적**: CLAUDE.md 파일 관리 및 최적화

---

### Blog Draft Skill (3개 파일)
```
blog-draft/
├── SKILL.md                          # Skill 정의
└── templates/
    ├── draft-template.md             # 블로그 초안 템플릿
    └── outline-template.md           # 블로그 개요 템플릿
```

**목적**: 일관된 구조로 블로그 게시물 초안 작성

**추가 파일**: `README.md` - Skills 개요 및 사용 가이드

**설치 경로**: `~/.claude/skills/` 또는 `.claude/skills/`

---

## 04. Subagents (9개 파일)

커스텀 기능을 갖춘 전문화된 AI 어시스턴트.

| File | Description | Tools | Use Case |
|------|-------------|-------|----------|
| `code-reviewer.md` | 코드 품질 분석 | read, grep, diff, lint_runner | 종합적인 코드 리뷰 |
| `test-engineer.md` | 테스트 커버리지 분석 | read, write, bash, grep | 테스트 자동화 |
| `documentation-writer.md` | 문서 작성 | read, write, grep | 문서 생성 |
| `secure-reviewer.md` | 보안 리뷰 (읽기 전용) | read, grep | 보안 감사 |
| `implementation-agent.md` | 전체 구현 | read, write, bash, grep, edit, glob | 기능 개발 |
| `debugger.md` | 디버깅 전문가 | read, bash, grep | 버그 조사 |
| `data-scientist.md` | 데이터 분석 전문가 | read, write, bash | 데이터 워크플로우 |
| `clean-code-reviewer.md` | 클린 코드 표준 검토 | read, grep | 코드 품질 관리 |
| `README.md` | 문서 | - | 설정 및 사용 가이드 |

**설치 경로**: `.claude/agents/`

**사용법**: 메인 에이전트가 자동으로 위임

---

## 05. MCP Protocol (5개 파일)

외부 도구 및 API 통합.

| File | Description | Integrates With | Use Case |
|------|-------------|-----------------|----------|
| `github-mcp.json` | GitHub 통합 | GitHub API | PR/이슈 관리 |
| `database-mcp.json` | 데이터베이스 쿼리 | PostgreSQL/MySQL | 실시간 데이터 조회 |
| `filesystem-mcp.json` | 파일 작업 | 로컬 파일시스템 | 파일 관리 |
| `multi-mcp.json` | 다중 서버 | GitHub + DB + Slack | 전체 통합 구성 |
| `README.md` | 문서 | - | 설정 및 사용 가이드 |

**설치 경로**: `.mcp.json` (프로젝트 범위) 또는 `~/.claude.json` (사용자 범위)

**사용법**: `/mcp__github__list_prs` 등

---

## 06. Hooks (9개 파일)

자동으로 실행되는 이벤트 기반 자동화 스크립트.

| File | Description | Event | Use Case |
|------|-------------|-------|----------|
| `format-code.sh` | 코드 자동 포맷 | PreToolUse:Write | 코드 포맷팅 |
| `pre-commit.sh` | 커밋 전 테스트 실행 | PreToolUse:Bash | 테스트 자동화 |
| `security-scan.sh` | 보안 스캔 | PostToolUse:Write | 보안 검사 |
| `log-bash.sh` | bash 명령어 로깅 | PostToolUse:Bash | 명령어 기록 |
| `validate-prompt.sh` | 프롬프트 유효성 검사 | PreToolUse | 입력 검증 |
| `notify-team.sh` | 알림 발송 | Notification | 팀 알림 |
| `context-tracker.py` | 컨텍스트 창 사용량 추적 | PostToolUse | 컨텍스트 모니터링 |
| `context-tracker-tiktoken.py` | 토큰 기반 컨텍스트 추적 | PostToolUse | 정밀 토큰 카운팅 |
| `README.md` | 문서 | - | 설정 및 사용 가이드 |

**설치 경로**: `~/.claude/settings.json`에서 설정

**사용법**: settings에서 설정 후 자동 실행

**Hook 유형** (4가지 유형, 25개 이벤트):
- Tool Hooks: PreToolUse, PostToolUse, PostToolUseFailure, PermissionRequest
- Session Hooks: SessionStart, SessionEnd, Stop, StopFailure, SubagentStart, SubagentStop
- Task Hooks: UserPromptSubmit, TaskCompleted, TaskCreated, TeammateIdle
- Lifecycle Hooks: ConfigChange, CwdChanged, FileChanged, PreCompact, PostCompact, WorktreeCreate, WorktreeRemove, Notification, InstructionsLoaded, Elicitation, ElicitationResult

---

## 07. Plugins (3개 완성형 플러그인, 40개 파일)

기능들을 묶은 번들 컬렉션.

### PR Review Plugin (10개 파일)
```
pr-review/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── review-pr.md                  # 종합 리뷰
│   ├── check-security.md             # 보안 검사
│   └── check-tests.md                # 테스트 커버리지 검사
├── agents/
│   ├── security-reviewer.md          # 보안 전문 에이전트
│   ├── test-checker.md               # 테스트 전문 에이전트
│   └── performance-analyzer.md       # 성능 전문 에이전트
├── mcp/
│   └── github-config.json            # GitHub 통합 설정
├── hooks/
│   └── pre-review.js                 # 리뷰 전 유효성 검사
└── README.md                         # 플러그인 문서
```

**기능**: 보안 분석, 테스트 커버리지, 성능 영향 분석

**Commands**: `/review-pr`, `/check-security`, `/check-tests`

**설치**: `/plugin install pr-review`

---

### DevOps Automation Plugin (15개 파일)
```
devops-automation/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── deploy.md                     # 배포
│   ├── rollback.md                   # 롤백
│   ├── status.md                     # 시스템 상태 확인
│   └── incident.md                   # 장애 대응
├── agents/
│   ├── deployment-specialist.md      # 배포 전문 에이전트
│   ├── incident-commander.md         # 장애 대응 조율 에이전트
│   └── alert-analyzer.md             # 알림 분석 에이전트
├── mcp/
│   └── kubernetes-config.json        # Kubernetes 통합 설정
├── hooks/
│   ├── pre-deploy.js                 # 배포 전 검사
│   └── post-deploy.js                # 배포 후 작업
├── scripts/
│   ├── deploy.sh                     # 배포 자동화
│   ├── rollback.sh                   # 롤백 자동화
│   └── health-check.sh               # 헬스 체크
└── README.md                         # 플러그인 문서
```

**기능**: Kubernetes 배포, 롤백, 모니터링, 장애 대응

**Commands**: `/deploy`, `/rollback`, `/status`, `/incident`

**설치**: `/plugin install devops-automation`

---

### Documentation Plugin (14개 파일)
```
documentation/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── generate-api-docs.md          # API 문서 생성
│   ├── generate-readme.md            # README 생성
│   ├── sync-docs.md                  # 문서 동기화
│   └── validate-docs.md              # 문서 유효성 검사
├── agents/
│   ├── api-documenter.md             # API 문서 전문 에이전트
│   ├── code-commentator.md           # 코드 주석 전문 에이전트
│   └── example-generator.md          # 예제 생성 에이전트
├── mcp/
│   └── github-docs-config.json       # GitHub 통합 설정
├── templates/
│   ├── api-endpoint.md               # API 엔드포인트 템플릿
│   ├── function-docs.md              # 함수 문서 템플릿
│   └── adr-template.md               # ADR 템플릿
└── README.md                         # 플러그인 문서
```

**기능**: API 문서 생성, README 생성, 문서 동기화, 유효성 검사

**Commands**: `/generate-api-docs`, `/generate-readme`, `/sync-docs`, `/validate-docs`

**설치**: `/plugin install documentation`

**추가 파일**: `README.md` - Plugins 개요 및 사용 가이드

---

## 08. Checkpoints and Rewind (2개 파일)

대화 상태를 저장하고 다양한 접근 방식을 탐색.

| File | Description | Content |
|------|-------------|---------|
| `README.md` | 문서 | 종합적인 checkpoint 가이드 |
| `checkpoint-examples.md` | 실제 사용 예시 | 데이터베이스 마이그레이션, 성능 최적화, UI 반복, 디버깅 |
| | | |

**핵심 개념**:
- **Checkpoint**: 대화 상태의 스냅샷
- **Rewind**: 이전 checkpoint로 복귀
- **Branch Point**: 여러 접근 방식 탐색

**사용법**:
```
# Checkpoints는 모든 사용자 프롬프트와 함께 자동으로 생성됨
# 되돌리려면 Esc를 두 번 누르거나 아래 명령어 사용:
/rewind
# 이후 선택: 코드와 대화 복원, 대화만 복원,
# 코드만 복원, 여기서부터 요약, 또는 취소
```

**활용 사례**:
- 다양한 구현 방법 시도
- 실수 복구
- 안전한 실험
- 솔루션 비교
- A/B 테스트

---

## 09. Advanced Features (3개 파일)

복잡한 워크플로우를 위한 고급 기능.

| File | Description | Features |
|------|-------------|----------|
| `README.md` | 전체 가이드 | 모든 고급 기능 문서 |
| `config-examples.json` | 설정 예시 | 10가지 이상 사용 사례별 설정 |
| `planning-mode-examples.md` | Planning 예시 | REST API, 데이터베이스 마이그레이션, 리팩토링 |
| Scheduled Tasks | `/loop` 및 cron 도구를 활용한 반복 작업 | 자동화된 반복 워크플로우 |
| Chrome Integration | Headless Chromium을 통한 브라우저 자동화 | 웹 테스트 및 스크래핑 |
| Remote Control (expanded) | 연결 방법, 보안, 비교 표 | 원격 세션 관리 |
| Keyboard Customization | 커스텀 키바인딩, 코드 지원, 컨텍스트 설정 | 개인화된 단축키 |
| Desktop App (expanded) | 커넥터, launch.json, 엔터프라이즈 기능 | 데스크톱 통합 |
| | | |

**다루는 고급 기능**:

### Planning Mode
- 상세한 구현 계획 수립
- 소요 시간 추정 및 리스크 평가
- 체계적인 작업 분해

### Extended Thinking
- 복잡한 문제에 대한 심층 추론
- 아키텍처 결정 분석
- 트레이드오프 평가

### Background Tasks
- 블로킹 없는 장시간 작업 실행
- 병렬 개발 워크플로우
- 작업 관리 및 모니터링

### Permission Modes
- **default**: 위험한 작업에 대해 승인 요청
- **acceptEdits**: 파일 편집 자동 승인, 나머지는 확인 요청
- **plan**: 읽기 전용 분석, 수정 없음
- **auto**: 안전한 작업 자동 승인, 위험한 작업은 확인 요청
- **dontAsk**: 위험한 작업 외 모두 수락
- **bypassPermissions**: 모두 수락 (`--dangerously-skip-permissions` 필요)

### Headless Mode (`claude -p`)
- CI/CD 통합
- 자동화된 작업 실행
- 배치 처리

### Session Management
- 여러 작업 세션 관리
- 세션 전환 및 저장
- 세션 지속성

### Interactive Features
- 키보드 단축키
- 명령어 히스토리
- 탭 자동 완성
- 멀티라인 입력

### Configuration
- 종합적인 설정 관리
- 환경별 설정 구성
- 프로젝트별 커스터마이징

### Scheduled Tasks
- `/loop` 명령어를 활용한 반복 작업
- Cron 도구: CronCreate, CronList, CronDelete
- 자동화된 반복 워크플로우

### Chrome Integration
- Headless Chromium을 통한 브라우저 자동화
- 웹 테스트 및 스크래핑 기능
- 페이지 상호작용 및 데이터 추출

### Remote Control (expanded)
- 연결 방법 및 프로토콜
- 보안 고려사항 및 모범 사례
- 원격 접근 옵션 비교 표

### Keyboard Customization
- 커스텀 키바인딩 설정
- 다중 키 단축키를 위한 Chord 지원
- 컨텍스트 인식 키바인딩 활성화

### Desktop App (expanded)
- IDE 통합을 위한 커넥터
- launch.json 설정
- 엔터프라이즈 기능 및 배포

---

## 10. CLI Usage (1개 파일)

커맨드라인 인터페이스 사용 패턴 및 참고 자료.

| File | Description | Content |
|------|-------------|---------|
| `README.md` | CLI 문서 | 플래그, 옵션 및 사용 패턴 |

**주요 CLI 기능**:
- `claude` - 대화형 세션 시작
- `claude -p "prompt"` - Headless/비대화형 모드
- `claude web` - 웹 세션 실행
- `claude --model` - 모델 선택 (Sonnet 4.6, Opus 4.6)
- `claude --permission-mode` - 권한 모드 설정
- `claude --remote` - WebSocket을 통한 원격 제어 활성화

---

## 문서 파일 (13개 파일)

| File | Location | Description |
|------|----------|-------------|
| `README.md` | `/` | 예제 전체 개요 |
| `INDEX.md` | `/` | 이 전체 인덱스 |
| `QUICK_REFERENCE.md` | `/` | 빠른 참조 카드 |
| `README.md` | `/01-slash-commands/` | Slash commands 가이드 |
| `README.md` | `/02-memory/` | Memory 가이드 |
| `README.md` | `/03-skills/` | Skills 가이드 |
| `README.md` | `/04-subagents/` | Subagents 가이드 |
| `README.md` | `/05-mcp/` | MCP 가이드 |
| `README.md` | `/06-hooks/` | Hooks 가이드 |
| `README.md` | `/07-plugins/` | Plugins 가이드 |
| `README.md` | `/08-checkpoints/` | Checkpoints 가이드 |
| `README.md` | `/09-advanced-features/` | 고급 기능 가이드 |
| `README.md` | `/10-cli/` | CLI 가이드 |

---

## 전체 파일 트리

```
claude-howto/
├── README.md                                    # 메인 개요
├── INDEX.md                                     # 이 파일
├── QUICK_REFERENCE.md                           # 빠른 참조 카드
├── claude_concepts_guide.md                     # 원본 가이드
│
├── 01-slash-commands/                           # Slash Commands
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   ├── commit.md
│   ├── setup-ci-cd.md
│   ├── push-all.md
│   ├── unit-test-expand.md
│   ├── doc-refactor.md
│   ├── pr-slash-command.png
│   └── README.md
│
├── 02-memory/                                   # Memory
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   ├── memory-saved.png
│   ├── memory-ask-claude.png
│   └── README.md
│
├── 03-skills/                                   # Skills
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-metrics.py
│   │   │   └── compare-complexity.py
│   │   └── templates/
│   │       ├── review-checklist.md
│   │       └── finding-template.md
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   ├── templates/
│   │   │   ├── email-template.txt
│   │   │   └── social-post-template.txt
│   │   └── tone-examples.md
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   ├── refactor/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-complexity.py
│   │   │   └── detect-smells.py
│   │   ├── references/
│   │   │   ├── code-smells.md
│   │   │   └── refactoring-catalog.md
│   │   └── templates/
│   │       └── refactoring-plan.md
│   ├── claude-md/
│   │   └── SKILL.md
│   ├── blog-draft/
│   │   ├── SKILL.md
│   │   └── templates/
│   │       ├── draft-template.md
│   │       └── outline-template.md
│   └── README.md
│
├── 04-subagents/                                # Subagents
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   ├── debugger.md
│   ├── data-scientist.md
│   ├── clean-code-reviewer.md
│   └── README.md
│
├── 05-mcp/                                      # MCP Protocol
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
│
├── 06-hooks/                                    # Hooks
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   ├── context-tracker.py
│   ├── context-tracker-tiktoken.py
│   └── README.md
│
├── 07-plugins/                                  # Plugins
│   ├── pr-review/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── review-pr.md
│   │   │   ├── check-security.md
│   │   │   └── check-tests.md
│   │   ├── agents/
│   │   │   ├── security-reviewer.md
│   │   │   ├── test-checker.md
│   │   │   └── performance-analyzer.md
│   │   ├── mcp/
│   │   │   └── github-config.json
│   │   ├── hooks/
│   │   │   └── pre-review.js
│   │   └── README.md
│   ├── devops-automation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── deploy.md
│   │   │   ├── rollback.md
│   │   │   ├── status.md
│   │   │   └── incident.md
│   │   ├── agents/
│   │   │   ├── deployment-specialist.md
│   │   │   ├── incident-commander.md
│   │   │   └── alert-analyzer.md
│   │   ├── mcp/
│   │   │   └── kubernetes-config.json
│   │   ├── hooks/
│   │   │   ├── pre-deploy.js
│   │   │   └── post-deploy.js
│   │   ├── scripts/
│   │   │   ├── deploy.sh
│   │   │   ├── rollback.sh
│   │   │   └── health-check.sh
│   │   └── README.md
│   ├── documentation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── generate-api-docs.md
│   │   │   ├── generate-readme.md
│   │   │   ├── sync-docs.md
│   │   │   └── validate-docs.md
│   │   ├── agents/
│   │   │   ├── api-documenter.md
│   │   │   ├── code-commentator.md
│   │   │   └── example-generator.md
│   │   ├── mcp/
│   │   │   └── github-docs-config.json
│   │   ├── templates/
│   │   │   ├── api-endpoint.md
│   │   │   ├── function-docs.md
│   │   │   └── adr-template.md
│   │   └── README.md
│   └── README.md
│
├── 08-checkpoints/                              # Checkpoints
│   ├── checkpoint-examples.md
│   └── README.md
│
├── 09-advanced-features/                        # Advanced Features
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
│
└── 10-cli/                                      # CLI Usage
    └── README.md
```

---

## 사용 사례별 빠른 시작

### 코드 품질 및 리뷰
```bash
# slash command 설치
cp 01-slash-commands/optimize.md .claude/commands/

# subagent 설치
cp 04-subagents/code-reviewer.md .claude/agents/

# skill 설치
cp -r 03-skills/code-review ~/.claude/skills/

# 또는 완성형 plugin 설치
/plugin install pr-review
```

### DevOps 및 배포
```bash
# plugin 설치 (모든 것 포함)
/plugin install devops-automation
```

### 문서화
```bash
# slash command 설치
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# subagent 설치
cp 04-subagents/documentation-writer.md .claude/agents/

# skill 설치
cp -r 03-skills/doc-generator ~/.claude/skills/

# 또는 완성형 plugin 설치
/plugin install documentation
```

### 팀 표준
```bash
# 프로젝트 memory 설정
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 팀 표준에 맞게 편집
```

### 외부 통합
```bash
# 환경 변수 설정
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# MCP 설정 설치 (프로젝트 범위)
cp 05-mcp/multi-mcp.json .mcp.json
```

### 자동화 및 유효성 검사
```bash
# hooks 설치
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# settings에서 hooks 설정 (~/.claude/settings.json)
# 06-hooks/README.md 참고
```

### 안전한 실험
```bash
# Checkpoints는 모든 사용자 프롬프트와 함께 자동 생성됨
# 되돌리려면: Esc+Esc 또는 /rewind 사용
# 이후 rewind 메뉴에서 복원할 항목 선택

# 예시는 08-checkpoints/README.md 참고
```

### 고급 워크플로우
```bash
# 고급 기능 설정
# 09-advanced-features/config-examples.json 참고

# planning mode 사용
/plan Implement feature X

# permission mode 사용
claude --permission-mode plan          # 코드 리뷰용 (읽기 전용)
claude --permission-mode acceptEdits   # 편집 자동 승인
claude --permission-mode auto          # 안전한 작업 자동 승인

# CI/CD용 headless mode 실행
claude -p "Run tests and report results"

# 백그라운드 작업 실행
Run tests in background

# 전체 가이드는 09-advanced-features/README.md 참고
```

---

## 기능 커버리지 매트릭스

| Category | Commands | Agents | MCP | Hooks | Scripts | Templates | Docs | Images | Total |
|----------|----------|--------|-----|-------|---------|-----------|------|--------|-------|
| **01 Slash Commands** | 8 | - | - | - | - | - | 1 | 1 | **10** |
| **02 Memory** | - | - | - | - | - | 3 | 1 | 2 | **6** |
| **03 Skills** | - | - | - | - | 5 | 9 | 1 | - | **28** |
| **04 Subagents** | - | 8 | - | - | - | - | 1 | - | **9** |
| **05 MCP** | - | - | 4 | - | - | - | 1 | - | **5** |
| **06 Hooks** | - | - | - | 8 | - | - | 1 | - | **9** |
| **07 Plugins** | 11 | 9 | 3 | 3 | 3 | 3 | 4 | - | **40** |
| **08 Checkpoints** | - | - | - | - | - | - | 1 | 1 | **2** |
| **09 Advanced** | - | - | - | - | - | - | 1 | 2 | **3** |
| **10 CLI** | - | - | - | - | - | - | 1 | - | **1** |

---

## 학습 경로

### 입문 (1주차)
1. ✅ `README.md` 읽기
2. ✅ slash command 1~2개 설치
3. ✅ 프로젝트 memory 파일 생성
4. ✅ 기본 명령어 사용해보기

### 중급 (2~3주차)
1. ✅ GitHub MCP 설정
2. ✅ subagent 설치
3. ✅ 작업 위임 시도
4. ✅ skill 설치

### 고급 (4주차 이상)
1. ✅ 완성형 plugin 설치
2. ✅ 커스텀 slash command 생성
3. ✅ 커스텀 subagent 생성
4. ✅ 커스텀 skill 생성
5. ✅ 직접 plugin 만들기

### 전문가 (5주차 이상)
1. ✅ 자동화를 위한 hooks 설정
2. ✅ 실험을 위한 checkpoints 활용
3. ✅ planning mode 설정
4. ✅ permission mode 효과적으로 활용
5. ✅ CI/CD용 headless mode 설정
6. ✅ session management 마스터

---

## 키워드 검색

### 성능
- `01-slash-commands/optimize.md` - 성능 분석
- `04-subagents/code-reviewer.md` - 성능 리뷰
- `03-skills/code-review/` - 성능 지표
- `07-plugins/pr-review/agents/performance-analyzer.md` - 성능 전문 에이전트

### 보안
- `04-subagents/secure-reviewer.md` - 보안 리뷰
- `03-skills/code-review/` - 보안 분석
- `07-plugins/pr-review/` - 보안 검사

### 테스트
- `04-subagents/test-engineer.md` - 테스트 엔지니어
- `07-plugins/pr-review/commands/check-tests.md` - 테스트 커버리지

### 문서화
- `01-slash-commands/generate-api-docs.md` - API 문서 명령어
- `04-subagents/documentation-writer.md` - 문서 작성 에이전트
- `03-skills/doc-generator/` - 문서 생성 skill
- `07-plugins/documentation/` - 완성형 문서 plugin

### 배포
- `07-plugins/devops-automation/` - 완성형 DevOps 솔루션

### 자동화
- `06-hooks/` - 이벤트 기반 자동화
- `06-hooks/pre-commit.sh` - 커밋 전 자동화
- `06-hooks/format-code.sh` - 자동 포맷팅
- `09-advanced-features/` - CI/CD용 headless mode

### 유효성 검사
- `06-hooks/security-scan.sh` - 보안 유효성 검사
- `06-hooks/validate-prompt.sh` - 프롬프트 유효성 검사

### 실험
- `08-checkpoints/` - rewind를 활용한 안전한 실험
- `08-checkpoints/checkpoint-examples.md` - 실제 사용 예시

### 계획
- `09-advanced-features/planning-mode-examples.md` - Planning mode 예시
- `09-advanced-features/README.md` - Extended thinking

### 설정
- `09-advanced-features/config-examples.json` - 설정 예시

---

## 참고 사항

- 모든 예제는 즉시 사용 가능
- 자신의 요구에 맞게 수정하여 사용
- 예제는 Claude Code 모범 사례를 따름
- 각 카테고리에는 상세 사용법이 담긴 README 포함
- 스크립트에는 적절한 오류 처리 포함
- 템플릿은 커스터마이징 가능

---

## 기여하기

더 많은 예제를 추가하고 싶으신가요? 아래 구조를 따르세요:
1. 적절한 하위 디렉토리 생성
2. 사용법이 담긴 README.md 포함
3. 네이밍 컨벤션 준수
4. 충분한 테스트 수행
5. 이 인덱스 업데이트

---

**최종 수정일**: 2026년 3월
**전체 예제 수**: 100개 이상
**카테고리**: 10개 기능
**Hooks**: 8개 자동화 스크립트
**설정 예시**: 10가지 이상 시나리오
**사용 준비 완료**: 모든 예제
