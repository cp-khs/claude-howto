<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# 유용한 리소스 목록

## 공식 문서

| 리소스 | 설명 | 링크 |
|----------|-------------|------|
| Claude Code Docs | Claude Code 공식 문서 | [code.claude.com/docs/en/overview](https://code.claude.com/docs/en/overview) |
| Anthropic Docs | Anthropic 전체 문서 | [docs.anthropic.com](https://docs.anthropic.com) |
| MCP Protocol | Model Context Protocol 명세 | [modelcontextprotocol.io](https://modelcontextprotocol.io) |
| MCP Servers | 공식 MCP 서버 구현체 | [github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) |
| Anthropic Cookbook | 코드 예제 및 튜토리얼 | [github.com/anthropics/anthropic-cookbook](https://github.com/anthropics/anthropic-cookbook) |
| Claude Code Skills | 커뮤니티 Skills 저장소 | [github.com/anthropics/skills](https://github.com/anthropics/skills) |
| Agent Teams | 멀티 에이전트 조율 및 협업 | [code.claude.com/docs/en/agent-teams](https://code.claude.com/docs/en/agent-teams) |
| Scheduled Tasks | /loop 및 cron을 활용한 반복 작업 | [code.claude.com/docs/en/scheduled-tasks](https://code.claude.com/docs/en/scheduled-tasks) |
| Chrome Integration | 브라우저 자동화 | [code.claude.com/docs/en/chrome](https://code.claude.com/docs/en/chrome) |
| Keybindings | 키보드 단축키 커스터마이징 | [code.claude.com/docs/en/keybindings](https://code.claude.com/docs/en/keybindings) |
| Desktop App | Claude Code 네이티브 데스크톱 앱 | [code.claude.com/docs/en/desktop](https://code.claude.com/docs/en/desktop) |
| Remote Control | 원격 세션 제어 | [code.claude.com/docs/en/remote-control](https://code.claude.com/docs/en/remote-control) |
| Auto Mode | 자동 권한 관리 | [code.claude.com/docs/en/auto-mode](https://code.claude.com/docs/en/auto-mode) |
| Channels | 멀티채널 통신 | [code.claude.com/docs/en/channels](https://code.claude.com/docs/en/channels) |
| Voice Dictation | Claude Code 음성 입력 | [code.claude.com/docs/en/voice-dictation](https://code.claude.com/docs/en/voice-dictation) |

## Anthropic 엔지니어링 블로그

| 아티클 | 설명 | 링크 |
|---------|-------------|------|
| Code Execution with MCP | 코드 실행으로 MCP 컨텍스트 팽창을 해결하는 방법 — 토큰 98.7% 절감 | [anthropic.com/engineering/code-execution-with-mcp](https://www.anthropic.com/engineering/code-execution-with-mcp) |

---

## 30분 만에 Claude Code 마스터하기

_영상_: https://www.youtube.com/watch?v=6eBSHbLKuN0

_**모든 팁**_
- **고급 기능 및 단축키 탐색**
  - 릴리스 노트에서 Claude의 새 코드 편집 및 컨텍스트 기능을 정기적으로 확인하세요.
  - 채팅, 파일, 에디터 뷰 간 빠른 전환을 위한 키보드 단축키를 익히세요.

- **효율적인 설정**
  - 쉽게 찾을 수 있도록 명확한 이름/설명이 있는 프로젝트별 세션을 생성하세요.
  - Claude가 언제든 접근할 수 있도록 가장 많이 사용하는 파일이나 폴더를 고정하세요.
  - 코딩 프로세스를 간소화하기 위해 Claude의 통합 (예: GitHub, 인기 IDE)을 설정하세요.

- **효과적인 코드베이스 Q&A**
  - 아키텍처, 디자인 패턴, 특정 모듈에 대해 Claude에게 자세히 질문하세요.
  - 질문에 파일 및 줄 참조를 사용하세요 (예: "`app/models/user.py`의 로직은 무엇을 하나요?").
  - 대규모 코드베이스에서는 Claude가 집중할 수 있도록 요약이나 매니페스트를 제공하세요.
  - **예제 프롬프트**: _"src/auth/AuthService.ts:45-120에 구현된 인증 플로우를 설명해주세요. src/middleware/auth.ts의 미들웨어와 어떻게 통합되나요?"_

- **코드 편집 및 리팩토링**
  - 코드 블록의 인라인 주석이나 요청으로 집중된 편집을 받으세요 ("명확성을 위해 이 함수를 리팩토링해주세요").
  - 전후 비교를 요청하세요.
  - 품질 보증을 위해 주요 편집 후 Claude에게 테스트나 문서를 생성하게 하세요.
  - **예제 프롬프트**: _"api/users.js의 getUserData 함수를 Promise 대신 async/await를 사용하도록 리팩토링해주세요. 전후 비교를 보여주고 리팩토링된 버전에 대한 단위 테스트를 생성해주세요."_

- **컨텍스트 관리**
  - 현재 작업과 관련된 코드/컨텍스트만 붙여넣기하세요.
  - 최상의 성능을 위해 구조화된 프롬프트("파일 A, 함수 B, 질문 X")를 사용하세요.
  - 컨텍스트 한계 초과를 피하기 위해 프롬프트 창에서 큰 파일을 제거하거나 축소하세요.
  - **예제 프롬프트**: _"models/User.js의 User 모델과 utils/validation.js의 validateUser 함수입니다. 이전 버전과의 호환성을 유지하면서 이메일 유효성 검사를 어떻게 추가할 수 있나요?"_

- **팀 도구 통합**
  - Claude 세션을 팀의 저장소와 문서에 연결하세요.
  - 반복되는 엔지니어링 작업에 내장 템플릿을 사용하거나 커스텀 템플릿을 만드세요.
  - 팀원들과 세션 트랜스크립트와 프롬프트를 공유하여 협업하세요.

- **성능 향상**
  - Claude에게 명확하고 목표 지향적인 지시를 주세요 (예: "이 클래스를 다섯 가지 요점으로 요약해주세요").
  - 컨텍스트 창에서 불필요한 주석과 보일러플레이트를 제거하세요.
  - Claude의 출력이 엇나가면 컨텍스트를 재설정하거나 더 나은 정렬을 위해 질문을 재구성하세요.
  - **예제 프롬프트**: _"src/db/Manager.ts의 DatabaseManager 클래스를 주요 책임과 핵심 메서드에 집중하여 다섯 가지 요점으로 요약해주세요."_

- **실용적인 사용 예제**
  - 디버깅: 오류와 스택 트레이스를 붙여넣고 가능한 원인과 수정 방법을 물어보세요.
  - 테스트 생성: 복잡한 로직에 대한 속성 기반, 단위 또는 통합 테스트를 요청하세요.
  - 코드 리뷰: Claude에게 위험한 변경사항, 엣지 케이스, 코드 냄새를 식별하도록 요청하세요.
  - **예제 프롬프트**:
    - _"이런 오류가 발생합니다: 'TypeError: Cannot read property 'map' of undefined at line 42 in components/UserList.jsx'. 스택 트레이스와 관련 코드가 있습니다. 원인이 무엇이며 어떻게 수정할 수 있나요?"_
    - _"PaymentProcessor 클래스에 대한 포괄적인 단위 테스트를 생성해주세요. 실패한 트랜잭션, 타임아웃, 잘못된 입력에 대한 엣지 케이스를 포함해주세요."_
    - _"이 PR diff를 검토하고 잠재적인 보안 문제, 성능 병목, 코드 냄새를 식별해주세요."_

- **워크플로우 자동화**
  - Claude 프롬프트를 사용하여 반복 작업(포맷, 정리, 반복 이름 변경 등)을 스크립트화하세요.
  - Claude를 사용하여 코드 diff를 기반으로 PR 설명, 릴리스 노트, 문서 초안을 작성하세요.
  - **예제 프롬프트**: _"git diff를 기반으로 변경 사항 요약, 수정된 파일 목록, 테스트 단계, 잠재적 영향이 포함된 자세한 PR 설명을 만들어주세요. 버전 2.3.0의 릴리스 노트도 생성해주세요."_

**팁**: 최상의 결과를 위해 여러 관행을 결합하세요 — 중요한 파일을 고정하고 목표를 요약하는 것부터 시작한 다음, 집중된 프롬프트와 Claude의 리팩토링 도구를 사용하여 코드베이스와 자동화를 점진적으로 개선하세요.


**Claude Code를 활용한 권장 워크플로우**

### Claude Code를 활용한 권장 워크플로우

#### 새 저장소의 경우

1. **저장소 및 Claude 통합 초기화**
   - 필수 구조(README, LICENSE, .gitignore, 루트 설정)로 새 저장소를 설정하세요.
   - 아키텍처, 고수준 목표, 코딩 가이드라인을 설명하는 `CLAUDE.md` 파일을 만드세요.
   - Claude Code를 설치하고 저장소에 연결하여 코드 제안, 테스트 스캐폴딩, 워크플로우 자동화를 활용하세요.

2. **Plan 모드 및 명세 사용**
   - 기능을 구현하기 전에 plan 모드 (`shift-tab` 또는 `/plan`)를 사용하여 자세한 명세를 작성하세요.
   - Claude에게 아키텍처 제안과 초기 프로젝트 레이아웃을 요청하세요.
   - 명확하고 목표 지향적인 프롬프트 시퀀스를 유지하세요 — 컴포넌트 개요, 주요 모듈, 책임을 요청하세요.

3. **반복적인 개발 및 검토**
   - 작은 단위로 핵심 기능을 구현하면서 Claude에게 코드 생성, 리팩토링, 문서화를 요청하세요.
   - 각 증분 후 단위 테스트와 예제를 요청하세요.
   - CLAUDE.md에 실행 중인 작업 목록을 유지하세요.

4. **CI/CD 및 배포 자동화**
   - Claude를 사용하여 GitHub Actions, npm/yarn 스크립트, 배포 워크플로우를 스캐폴딩하세요.
   - CLAUDE.md를 업데이트하고 해당 명령어/스크립트를 요청하여 파이프라인을 쉽게 조정하세요.

```mermaid
graph TD
    A[새 저장소 시작] --> B[저장소 구조 초기화]
    B --> C[README, LICENSE, .gitignore 생성]
    C --> D[CLAUDE.md 생성]
    D --> E[아키텍처 및 가이드라인 문서화]
    E --> F[Claude Code 설치 및 연결]

    F --> G[Plan 모드 진입]
    G --> H[기능 명세 초안 작성]
    H --> I[아키텍처 제안 받기]
    I --> J[컴포넌트 및 모듈 정의]

    J --> K[기능 단위 구현]
    K --> L[Claude로 코드 생성]
    L --> M[단위 테스트 요청]
    M --> N[검토 및 리팩토링]
    N --> O{더 많은 기능?}
    O -->|Yes| K
    O -->|No| P[CLAUDE.md 작업 목록 업데이트]

    P --> Q[CI/CD 파이프라인 설정]
    Q --> R[GitHub Actions 스캐폴딩]
    R --> S[배포 스크립트 생성]
    S --> T[자동화 테스트]
    T --> U[저장소 준비 완료]

    style A fill:#e1f5ff
    style G fill:#fff4e1
    style K fill:#f0ffe1
    style Q fill:#ffe1f5
    style U fill:#90EE90
```

#### 기존 저장소의 경우

1. **저장소 및 컨텍스트 설정**
   - 저장소 구조, 코딩 패턴, 핵심 파일을 문서화하기 위해 `CLAUDE.md`를 추가하거나 업데이트하세요. 레거시 저장소에는 프레임워크, 버전 맵, 지침, 버그, 업그레이드 노트를 다루는 `CLAUDE_LEGACY.md`를 사용하세요.
   - Claude가 컨텍스트로 사용할 주요 파일을 고정하거나 강조하세요.

2. **컨텍스트 기반 코드 Q&A**
   - 특정 파일/함수를 참조하여 Claude에게 코드 리뷰, 버그 설명, 리팩토링, 마이그레이션 계획을 요청하세요.
   - Claude에게 명확한 경계를 주세요 (예: "이 파일만 수정하세요" 또는 "새 의존성 없음").

3. **브랜치, Worktree, 다중 세션 관리**
   - 격리된 기능이나 버그 수정에 여러 git worktree를 사용하고 worktree별로 별도의 Claude 세션을 실행하세요.
   - 병렬 워크플로우를 위해 브랜치나 기능별로 터미널 탭/창을 정리하세요.

4. **팀 도구 및 자동화**
   - 팀 간 일관성을 위해 `.claude/commands/`를 통해 커스텀 명령어를 동기화하세요.
   - Claude의 slash commands나 hooks를 통해 반복 작업, PR 생성, 코드 포맷을 자동화하세요.
   - 협업적인 문제 해결과 리뷰를 위해 팀원들과 세션 및 컨텍스트를 공유하세요.

```mermaid
graph TD
    A[기존 저장소 시작] --> B{레거시 코드베이스?}
    B -->|Yes| C[CLAUDE_LEGACY.md 생성]
    B -->|No| D[CLAUDE.md 생성/업데이트]
    C --> E[프레임워크 및 버전 맵 문서화]
    D --> F[구조 및 패턴 문서화]
    E --> G[컨텍스트를 위한 핵심 파일 고정]
    F --> G

    G --> H[작업 유형 파악]
    H --> I{작업 분류}
    I -->|버그 수정| J[Claude에게 버그 분석 요청]
    I -->|코드 리뷰| K[코드 리뷰 요청]
    I -->|리팩토링| L[리팩토링 전략 계획]
    I -->|마이그레이션| M[마이그레이션 계획 생성]

    J --> N[명확한 경계 설정]
    K --> N
    L --> N
    M --> N

    N --> O{여러 기능?}
    O -->|Yes| P[Git Worktree 생성]
    O -->|No| Q[메인 브랜치에서 작업]
    P --> R[별도 Claude 세션 실행]
    R --> S[터미널 탭 정리]
    Q --> S

    S --> T[팀 자동화 설정]
    T --> U[.claude/commands/ 동기화]
    U --> V[Slash Commands 설정]
    V --> W[자동화를 위한 Hooks 설정]
    W --> X[팀과 세션 컨텍스트 공유]

    X --> Y{더 많은 작업?}
    Y -->|Yes| H
    Y -->|No| Z[워크플로우 완료]

    style A fill:#e1f5ff
    style C fill:#ffecec
    style D fill:#fff4e1
    style P fill:#f0ffe1
    style T fill:#ffe1f5
    style Z fill:#90EE90
```

**팁**:
- 각 새 기능이나 수정을 명세와 plan 모드 프롬프트로 시작하세요.
- 레거시 및 복잡한 저장소에는 CLAUDE.md/CLAUDE_LEGACY.md에 자세한 가이드를 저장하세요.
- 명확하고 집중된 지시를 주고 복잡한 작업을 다단계 계획으로 분해하세요.
- 세션을 정기적으로 정리하고, 컨텍스트를 정돈하며, 완료된 worktree를 삭제하여 혼잡함을 피하세요.

이 단계들은 새 저장소와 기존 저장소 모두에서 Claude Code와 함께 원활한 워크플로우를 위한 핵심 권장 사항을 담고 있습니다.

---

## 새 기능 및 기능 (2026년 3월)

### 주요 기능 리소스

| 기능 | 설명 | 더 알아보기 |
|---------|-------------|------------|
| **Auto Memory** | Claude가 세션 간 사용자 기본 설정을 자동으로 학습하고 기억 | [Memory Guide](02-memory/) |
| **Remote Control** | 외부 도구 및 스크립트에서 Claude Code 세션을 프로그래밍 방식으로 제어 | [Advanced Features](09-advanced-features/) |
| **Web Sessions** | 원격 개발을 위한 브라우저 기반 인터페이스로 Claude Code 접근 | [CLI Reference](10-cli/) |
| **Desktop App** | 향상된 UI를 갖춘 Claude Code 네이티브 데스크톱 앱 | [Claude Code Docs](https://code.claude.com/docs/en/desktop) |
| **Extended Thinking** | `Alt+T`/`Option+T` 또는 `MAX_THINKING_TOKENS` 환경 변수로 심층 추론 토글 | [Advanced Features](09-advanced-features/) |
| **Permission Modes** | 세밀한 제어: default, acceptEdits, plan, auto, dontAsk, bypassPermissions | [Advanced Features](09-advanced-features/) |
| **7-Tier Memory** | Managed Policy, Project, Project Rules, User, User Rules, Local, Auto Memory | [Memory Guide](02-memory/) |
| **Hook Events** | 25개 이벤트: PreToolUse, PostToolUse, PostToolUseFailure, Stop, StopFailure, SubagentStart, SubagentStop, Notification, Elicitation 등 | [Hooks Guide](06-hooks/) |
| **Agent Teams** | 복잡한 작업을 위해 함께 작업하는 여러 에이전트 조율 | [Subagents Guide](04-subagents/) |
| **Scheduled Tasks** | `/loop`와 cron 도구로 반복 작업 설정 | [Advanced Features](09-advanced-features/) |
| **Chrome Integration** | 헤드리스 Chromium으로 브라우저 자동화 | [Advanced Features](09-advanced-features/) |
| **Keyboard Customization** | 코드 시퀀스를 포함한 키바인딩 커스터마이징 | [Advanced Features](09-advanced-features/) |
