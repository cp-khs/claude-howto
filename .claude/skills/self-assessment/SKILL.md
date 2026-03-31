---
name: self-assessment
version: 2.2.0
description: Comprehensive Claude Code self-assessment and learning path advisor. Runs a multi-category quiz covering 10 feature areas, produces a detailed skill profile with per-topic scores, identifies specific gaps, and generates a personalized learning path with prioritized next steps. Use when asked to "assess my level", "take the quiz", "find my level", "where should I start", "what should I learn next", "check my skills", "skill check", or "level up".
---

# 자가 평가 및 학습 경로 어드바이저

10개 기능 영역에서 Claude Code 숙련도를 평가하고, 구체적인 기술 격차를 식별하며, 레벨업을 위한 맞춤형 학습 경로를 생성하는 종합 인터랙티브 평가입니다.

## 지침

### Step 1: 환영 및 평가 모드 선택

사용자에게 평가 깊이를 선택할 수 있도록 제시합니다:

AskUserQuestion을 사용하여 다음 선택지 제시:
- **빠른 평가** — "8개 문항, 약 2분. 전반적인 수준(초급/중급/고급)을 결정하고 학습 경로를 제공합니다."
- **심층 평가** — "5개 카테고리의 상세 문항, 약 5분. 주제별 기술 점수를 제공하고, 구체적인 격차를 파악하며, 우선순위가 있는 학습 경로를 구성합니다."

**빠른 평가** 선택 시 Step 2A로 이동합니다.
**심층 평가** 선택 시 Step 2B로 이동합니다.

---

### Step 2A: 빠른 평가

두 개의 다중 선택 문항을 제시합니다 (AskUserQuestion은 각 최대 4개 선택지 지원):

**Question 1** (header: "Basics"):
"1/2: 이미 갖추고 있는 Claude Code 기술을 선택하세요."
Options:
1. "Claude Code 시작 및 대화" — `claude`를 실행하고 상호작용할 수 있습니다
2. "CLAUDE.md 생성/편집" — 프로젝트 또는 개인 메모리를 설정했습니다
3. "3개 이상의 slash 명령어 사용" — 예: /help, /compact, /model, /clear
4. "커스텀 명령어/스킬 생성" — SKILL.md 또는 커스텀 명령어 파일을 작성했습니다

**Question 2** (header: "Advanced"):
"2/2: 보유한 고급 기술을 선택하세요."
Options:
1. "MCP 서버 설정" — 예: GitHub, 데이터베이스 또는 기타 외부 데이터 소스
2. "Hooks 설정" — ~/.claude/settings.json에 hooks를 설정했습니다
3. "Subagents 생성/사용" — 작업 위임을 위해 .claude/agents/를 사용했습니다
4. "출력 전용 모드 사용 (claude -p)" — 비인터랙티브 또는 CI/CD 용도로 `claude -p`를 사용했습니다

**채점:**
- 합계 0~2개 = 레벨 1: 초급
- 합계 3~5개 = 레벨 2: 중급
- 합계 6~8개 = 레벨 3: 고급

체크되지 않은 항목들을 격차로 나열하며 레벨 결과와 함께 Step 3으로 이동합니다.

---

### Step 2B: 심층 평가

5라운드의 문항을 제시하며, 라운드당 AskUserQuestion 1회 호출합니다. 각 라운드는 2개의 관련 기능 영역을 다룹니다. 모든 라운드에 다중 선택 사용.

**중요**: AskUserQuestion은 문항당 최대 4개의 선택지를 지원합니다. 각 라운드는 2개의 주제를 다루는 4개의 선택지로 구성된 문항 1개입니다(주제당 선택지 2개).

---

**Round 1 — Slash Commands & Memory** (header: "Commands")

"다음 중 해당하는 것을 모두 선택하세요."
Options:
1. "커스텀 slash 명령어 또는 스킬 생성" — frontmatter가 있는 SKILL.md 파일 작성 또는 .claude/commands/ 파일 생성
2. "명령어에서 동적 컨텍스트 사용" — `$ARGUMENTS`, `$0`/`$1`, 백틱 `!command` 구문 또는 스킬/명령어 파일에서 `@file` 참조 사용
3. "프로젝트 + 개인 메모리 설정" — 프로젝트 CLAUDE.md와 개인 ~/.claude/CLAUDE.md (또는 CLAUDE.local.md) 모두 생성
4. "메모리 계층 기능 사용" — 7단계 우선순위 순서 이해, .claude/rules/ 디렉토리 사용, 경로 특정 규칙 또는 @import 구문 사용

**Round 1 채점:**
- 선택지 1~2 → **Slash Commands** (0~2점)
- 선택지 3~4 → **Memory** (0~2점)

---

**Round 2 — Skills & Hooks** (header: "Automation")

"다음 중 해당하는 것을 모두 선택하세요."
Options:
1. "자동 호출 스킬 설치 및 사용" — 수동 /command 호출 없이 description 기반으로 자동 트리거되는 스킬
2. "스킬 호출 동작 제어" — SKILL.md frontmatter에서 `disable-model-invocation`, `user-invocable` 또는 agent 필드와 함께 `context: fork` 사용
3. "PreToolUse 또는 PostToolUse hook 설정" — 도구 실행 전/후에 실행되는 hook 설정 (예: 명령어 유효성 검사기, 자동 포매터)
4. "고급 hook 기능 사용" — 프롬프트 타입 hooks, SKILL.md의 컴포넌트 범위 hooks, HTTP hooks 또는 커스텀 JSON 출력이 있는 hooks (updatedInput, systemMessage) 설정

**Round 2 채점:**
- 선택지 1~2 → **Skills** (0~2점)
- 선택지 3~4 → **Hooks** (0~2점)

---

**Round 3 — MCP & Subagents** (header: "Integration")

"다음 중 해당하는 것을 모두 선택하세요."
Options:
1. "MCP 서버 연결 및 도구 사용" — 예: PR/이슈용 GitHub MCP, 쿼리용 데이터베이스 MCP 또는 기타 외부 데이터 소스
2. "고급 MCP 기능 사용" — 프로젝트 범위 .mcp.json, OAuth 인증, @mentions을 사용한 MCP 리소스, Tool Search 또는 `claude mcp serve`
3. "커스텀 subagents 생성 또는 설정" — 커스텀 도구, 모델 또는 권한으로 .claude/agents/에 에이전트 정의
4. "고급 subagent 기능 사용" — 워크트리 격리, 지속적 에이전트 메모리, Ctrl+B를 사용한 백그라운드 작업, `Task(agent_name)` 에이전트 허용 목록 또는 에이전트 팀

**Round 3 채점:**
- 선택지 1~2 → **MCP** (0~2점)
- 선택지 3~4 → **Subagents** (0~2점)

---

**Round 4 — Checkpoints & Advanced Features** (header: "Power User")

"다음 중 해당하는 것을 모두 선택하세요."
Options:
1. "안전한 실험을 위해 checkpoints 사용" — checkpoints 생성, Esc+Esc 또는 /rewind 사용, 코드 및/또는 대화 복원 또는 요약 옵션 사용
2. "계획 모드 또는 확장 사고 사용" — /plan, Shift+Tab 또는 --permission-mode plan으로 계획 활성화; Alt+T/Option+T로 확장 사고 전환
3. "권한 모드 설정" — CLI 플래그, 키보드 단축키 또는 설정을 통해 acceptEdits, plan, dontAsk 또는 bypassPermissions 모드 사용
4. "원격/데스크톱/웹 기능 사용" — `claude remote-control`, `claude --remote`, `/teleport`, `/desktop` 또는 `claude -w`를 사용한 워크트리 사용

**Round 4 채점:**
- 선택지 1 → **Checkpoints** (0~1점)
- 선택지 2~4 → **Advanced Features** (0~3점, 최대 2점)

---

**Round 5 — Plugins & CLI** (header: "Mastery")

"다음 중 해당하는 것을 모두 선택하세요."
Options:
1. "플러그인 설치 또는 생성" — 마켓플레이스에서 번들 플러그인 사용 또는 plugin.json 매니페스트가 있는 .claude-plugin/ 디렉토리 생성
2. "플러그인 고급 기능 사용" — 플러그인 hooks, 플러그인 MCP 서버, LSP 설정, 플러그인 네임스페이스 명령어 또는 테스트용 --plugin-dir 플래그
3. "스크립트 또는 CI/CD에서 출력 전용 모드 사용" — --output-format json, --max-turns, 파이프 입력과 함께 `claude -p` 사용 또는 GitHub Actions / CI 파이프라인에 통합
4. "고급 CLI 기능 사용" — 세션 재개 (-c/-r), --agents 플래그, 구조화된 출력용 --json-schema, --fallback-model, --from-pr 또는 배치 처리 루프

**Round 5 채점:**
- 선택지 1~2 → **Plugins** (0~2점)
- 선택지 3~4 → **CLI** (0~2점)

---

### Step 3: 결과 계산 및 제시

#### 3A: 빠른 평가

총 선택 수를 계산하고 레벨을 결정합니다. 그런 다음 제시:

```markdown
## Claude Code 기술 평가 결과

### 현재 레벨: [레벨 1: 초급 / 레벨 2: 중급 / 레벨 3: 고급]

총 **N/8**개 항목을 선택하셨습니다.

[레벨별 한 줄 동기 부여 요약]

### 기술 프로필

| 영역 | 상태 |
|------|--------|
| 기본 CLI 및 대화 | [완료/부족] |
| CLAUDE.md 및 메모리 | [완료/부족] |
| Slash Commands (내장) | [완료/부족] |
| 커스텀 명령어 및 Skills | [완료/부족] |
| MCP 서버 | [완료/부족] |
| Hooks | [완료/부족] |
| Subagents | [완료/부족] |
| 출력 전용 모드 및 CI/CD | [완료/부족] |

### 파악된 격차

[체크되지 않은 각 항목에 대해 배워야 할 내용과 튜토리얼 링크를 한 줄로 제공]

### 맞춤형 학습 경로

[레벨별 학습 경로 출력 — Step 4 참조]
```

#### 3B: 심층 평가

5라운드에서 주제별 점수를 계산합니다. 각 주제는 0~2점을 받습니다. 그런 다음 제시:

```markdown
## Claude Code 기술 평가 결과

### 전반적 레벨: [레벨 1 / 레벨 2 / 레벨 3]

**총점: N/20점**

[한 줄 동기 부여 요약]

### 기술 프로필

| 기능 영역 | 점수 | 숙련도 | 상태 |
|-------------|-------|---------|--------|
| Slash Commands | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Memory | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Skills | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Hooks | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| MCP | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Subagents | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Checkpoints | N/1 | [없음/능숙] | [학습/완료] |
| Advanced Features | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| Plugins | N/2 | [없음/기초/능숙] | [학습/복습/완료] |
| CLI | N/2 | [없음/기초/능숙] | [학습/복습/완료] |

**숙련도 기준:** 0 = 없음, 1 = 기초, 2 = 능숙

### 강점 영역
[2/2 점수를 받은 주제 목록 — 완전히 숙달된 항목]

### 우선 격차 (먼저 학습)
[0점 주제 목록 — 의존성 순서로 정렬된 최우선 항목]

### 복습 영역
[1/2 점수 주제 목록 — 기초는 알지만 고급 기능을 아직 사용하지 않은 항목]

### 맞춤형 학습 경로

[격차별 학습 경로 출력 — Step 4 참조]
```

**심층 평가 전반적 레벨 계산:**
- 총 0~6점 = 레벨 1: 초급
- 총 7~13점 = 레벨 2: 중급
- 총 14~20점 = 레벨 3: 고급

---

### Step 4: 맞춤형 학습 경로 생성

평가 결과를 바탕으로 사용자의 격차에 맞는 학습 경로를 생성합니다. 일반적인 레벨별 경로를 반복하지 마세요 — 맞춤화하세요.

#### 경로 생성 규칙

1. **숙달한 주제 건너뜀**: 2/2 점수를 받은 주제는 경로에 포함하지 않습니다.
2. **의존성 순서로 우선순위 지정**: Skills 전에 Slash Commands, Subagents 전에 Memory 등. 의존성 순서:
   - Slash Commands (의존성 없음) -> Skills (Slash Commands에 의존)
   - Memory (의존성 없음) -> Subagents (Memory에 의존)
   - CLI 기초 (의존성 없음) -> CLI 숙달 (모든 것에 의존)
   - Checkpoints (의존성 없음)
   - Hooks (Slash Commands에 의존)
   - MCP (의존성 없음) -> Plugins (MCP, Skills, Hooks에 의존)
   - Advanced Features (이전 모든 것에 의존)
3. **점수 1/2 주제**: "심화 학습" 권장 — 부족한 특정 고급 섹션 링크 제공.
4. **시간 추정**: 학습/복습이 필요한 주제만 합산.
5. **단계별 그룹화**: 남은 주제를 각 2~3개 주제로 구성된 논리적 단계로 정리.

#### 경로 출력 형식

```markdown
### 맞춤형 학습 경로

**예상 시간**: 약 N시간 (현재 기술 수준에 맞게 조정됨)

#### 단계 1: [단계 이름] (약 N시간)
[이 영역에 격차가 있는 경우만]

**[주제 이름]** — [처음부터 학습 / 고급 기능 심화]
- 튜토리얼: [튜토리얼 디렉토리 링크]
- 집중 영역: [필요한 특정 섹션/개념]
- 핵심 실습: [할 구체적인 실습 1개]
- 완료 기준: [구체적인 성공 기준]

**[주제 이름]** — ...

---

#### 단계 2: [단계 이름] (약 N시간)
...

---

### 권장 실습 프로젝트

격차를 바탕으로 학습을 다지기 위한 실제 연습:

1. **[프로젝트 이름]**: [2~3개의 격차 주제를 결합한 한 줄 설명]
2. **[프로젝트 이름]**: [한 줄 설명]
3. **[프로젝트 이름]**: [한 줄 설명]
```

#### 주제별 구체적 권장 사항

격차가 있는 경우 다음의 구체적인 권장 사항을 사용합니다:

**Slash Commands (점수 0)**:
- 튜토리얼: [01-slash-commands/](../../../01-slash-commands/)
- 집중 영역: 내장 명령어 레퍼런스, 첫 SKILL.md 생성, `$ARGUMENTS` 구문
- 핵심 실습: `/optimize` 명령어를 만들고 테스트하기
- 완료 기준: 인수와 동적 컨텍스트로 커스텀 스킬을 만들 수 있을 때

**Slash Commands (점수 1 — 복습)**:
- 집중 영역: `!`백틱`` 구문을 사용한 동적 컨텍스트, `@file` 참조, `disable-model-invocation` vs `user-invocable` 제어
- 완료 기준: 실시간 명령어 출력을 삽입하고 자체 호출 동작을 제어하는 스킬을 만들 수 있을 때

**Memory (점수 0)**:
- 튜토리얼: [02-memory/](../../../02-memory/)
- 집중 영역: CLAUDE.md 생성, `/init` 및 `/memory` 명령어, 빠른 업데이트를 위한 `#` 접두사
- 핵심 실습: 코딩 표준이 담긴 프로젝트 CLAUDE.md 만들기
- 완료 기준: Claude가 세션 간에 선호 사항을 기억할 때

**Memory (점수 1 — 복습)**:
- 집중 영역: 7단계 계층 및 우선순위 순서, 경로 특정 규칙이 있는 .claude/rules/ 디렉토리, `@import` 구문 (최대 깊이 5), Auto Memory MEMORY.md (200줄 제한)
- 완료 기준: 다양한 디렉토리에 대한 모듈식 규칙을 갖추고 전체 계층을 이해할 때

**Skills (점수 0)**:
- 튜토리얼: [03-skills/](../../../03-skills/)
- 집중 영역: SKILL.md 형식, description 필드를 통한 자동 호출, 점진적 공개 (3가지 로딩 레벨)
- 핵심 실습: code-review 스킬을 설치하고 자동 트리거 확인
- 완료 기준: 대화 컨텍스트에 따라 스킬이 자동으로 활성화될 때

**Skills (점수 1 — 복습)**:
- 집중 영역: subagent 실행을 위한 agent 필드와 `context: fork`, `disable-model-invocation` vs `user-invocable`, 컨텍스트 예산 2%, 번들 리소스 (scripts/, references/, assets/)
- 완료 기준: 포크된 컨텍스트로 subagent에서 실행되는 스킬을 만들 수 있을 때

**Hooks (점수 0)**:
- 튜토리얼: [06-hooks/](../../../06-hooks/)
- 집중 영역: 설정 구조 (matcher + hooks 배열), PreToolUse/PostToolUse 이벤트, 종료 코드 (0=성공, 2=차단), JSON 입/출력 형식
- 핵심 실습: Bash 명령어를 검증하는 PreToolUse hook 만들기
- 완료 기준: hook이 실행 전에 위험한 명령어를 차단할 때

**Hooks (점수 1 — 복습)**:
- 집중 영역: 25개의 모든 hook 이벤트 (PostToolUseFailure, StopFailure, TaskCreated, CwdChanged, FileChanged, PostCompact, Elicitation, ElicitationResult 포함), 4가지 hook 타입 (command, http, prompt, agent), SKILL.md frontmatter의 컴포넌트 범위 hooks, allowedEnvVars가 있는 HTTP hooks, SessionStart/CwdChanged/FileChanged의 `CLAUDE_ENV_FILE`
- 완료 기준: 프롬프트 기반 Stop hook과 스킬의 컴포넌트 범위 hook을 만들 수 있을 때

**MCP (점수 0)**:
- 튜토리얼: [05-mcp/](../../../05-mcp/)
- 집중 영역: `claude mcp add` 명령어, 전송 타입 (HTTP 권장), GitHub MCP 설정, 환경 변수 확장
- 핵심 실습: GitHub MCP 서버를 추가하고 PR 쿼리하기
- 완료 기준: MCP를 통해 외부 서비스의 실시간 데이터를 쿼리할 수 있을 때

**MCP (점수 1 — 복습)**:
- 집중 영역: 프로젝트 범위 .mcp.json (팀 승인 필요), OAuth 2.0 인증, `@server:resource` mentions를 사용한 MCP 리소스, Tool Search (ENABLE_TOOL_SEARCH), `claude mcp serve`, 출력 제한 (10k/25k/50k)
- 완료 기준: 프로젝트 .mcp.json을 갖추고 Tool Search 자동 모드를 이해할 때

**Subagents (점수 0)**:
- 튜토리얼: [04-subagents/](../../../04-subagents/)
- 집중 영역: 에이전트 파일 형식 (.claude/agents/*.md), 내장 에이전트 (general-purpose, Plan, Explore), tools/model/permissionMode 설정
- 핵심 실습: code-reviewer subagent를 만들고 위임 테스트
- 완료 기준: Claude가 커스텀 에이전트에게 코드 리뷰를 위임할 때

**Subagents (점수 1 — 복습)**:
- 집중 영역: 워크트리 격리 (`isolation: worktree`), 지속적 에이전트 메모리 (범위가 있는 `memory` 필드), 백그라운드 에이전트 (Ctrl+B/Ctrl+F), `Task(agent_name)` 에이전트 허용 목록, 에이전트 팀 (`--teammate-mode`)
- 완료 기준: 워크트리 격리로 실행되는 지속적 메모리를 가진 subagent를 만들 때

**Checkpoints (점수 0)**:
- 튜토리얼: [08-checkpoints/](../../../08-checkpoints/)
- 집중 영역: Esc+Esc 및 /rewind 접근, 5가지 되감기 옵션 (코드+대화 복원, 대화 복원, 코드 복원, 요약, 취소), 제한사항 (bash 파일 시스템 작업은 추적 안 됨)
- 핵심 실습: 실험적 변경 후 복원으로 되감기
- 완료 기준: 되감기 가능하다는 것을 알고 자신 있게 실험할 수 있을 때

**Advanced Features (점수 0)**:
- 튜토리얼: [09-advanced-features/](../../../09-advanced-features/)
- 집중 영역: 계획 모드 (/plan 또는 Shift+Tab), 권한 모드 (5가지 타입), 확장 사고 (Alt+T 토글)
- 핵심 실습: 계획 모드를 사용하여 기능 설계 후 구현
- 완료 기준: 계획 모드와 구현 모드 사이를 자유롭게 전환할 때

**Advanced Features (점수 1 — 복습)**:
- 집중 영역: 원격 제어 (`claude remote-control`), 웹 세션 (`claude --remote`), 데스크톱 핸드오프 (`/desktop`), 워크트리 (`claude -w`), 작업 목록 (Ctrl+T), 엔터프라이즈용 관리형 설정
- 완료 기준: CLI, 웹, 데스크톱 간에 세션을 전환할 수 있을 때

**Plugins (점수 0)**:
- 튜토리얼: [07-plugins/](../../../07-plugins/)
- 집중 영역: 플러그인 구조 (.claude-plugin/plugin.json), 플러그인 번들 내용 (commands, agents, MCP, hooks, settings), 마켓플레이스에서 설치
- 핵심 실습: 플러그인을 설치하고 컴포넌트 살펴보기
- 완료 기준: 플러그인과 개별 컴포넌트의 사용 시점을 이해할 때

**Plugins (점수 1 — 복습)**:
- 집중 영역: plugin.json 매니페스트 생성, 플러그인 hooks (hooks/hooks.json), LSP 설정 (.lsp.json), `${CLAUDE_PLUGIN_ROOT}` 변수, 테스트용 --plugin-dir, 마켓플레이스 게시
- 완료 기준: 팀을 위한 플러그인을 만들고 테스트할 수 있을 때

**CLI (점수 0)**:
- 튜토리얼: [10-cli/](../../../10-cli/)
- 집중 영역: 인터랙티브 vs 출력 전용 모드, 파이핑과 함께 `claude -p`, `--output-format json`, 세션 관리 (-c/-r)
- 핵심 실습: 파일을 `claude -p`에 파이프하고 JSON 출력 받기
- 완료 기준: 스크립트에서 비인터랙티브 방식으로 Claude를 사용할 수 있을 때

**CLI (점수 1 — 복습)**:
- 집중 영역: JSON 설정이 있는 --agents 플래그, 구조화된 출력용 --json-schema, --fallback-model, --from-pr, --strict-mcp-config, for 루프를 사용한 배치 처리, `claude mcp serve`
- 완료 기준: 구조화된 JSON 출력으로 Claude를 사용하는 CI/CD 스크립트를 작성할 때

---

### Step 5: 후속 작업 제안

결과 제시 후 사용자에게 다음에 할 일을 묻습니다:

AskUserQuestion을 사용하여 다음 선택지 제시:
- **학습 시작** — "지금 바로 학습 경로의 첫 번째 주제를 시작하도록 도와주세요"
- **격차 심화 학습** — "격차 영역 중 하나에 대해 자세히 설명해주세요"
- **실습 프로젝트** — "격차 영역을 다루는 실습 프로젝트를 설정해주세요"
- **평가 재시도** — "퀴즈를 다시 풀고 싶습니다 (다른 모드로도 가능)"

**학습 시작**: 첫 번째 격차 튜토리얼의 README.md를 읽고 첫 번째 실습을 안내합니다.
**격차 심화**: 어떤 격차 주제인지 묻고, 관련 튜토리얼 README.md를 읽어 예시와 함께 핵심 개념을 설명합니다.
**실습 프로젝트**: 2~3개의 격차 주제를 결합한 구체적인 단계가 있는 소규모 프로젝트를 설계합니다.
**평가 재시도**: Step 1으로 돌아가 새로운 평가를 시작합니다.

## 오류 처리

### 라운드에서 아무것도 선택하지 않은 경우
해당 라운드의 주제에 0점을 줍니다. 다음 라운드로 계속 진행합니다.

### 어떤 라운드에서도 아무것도 선택하지 않은 경우
레벨 1: 초급으로 지정합니다. 처음부터 시작하도록 격려합니다. 전체 레벨 1 경로를 출력합니다.

### 재시도 원하는 경우
새로운 평가로 Step 1부터 다시 실행합니다.

### 레벨에 동의하지 않는 경우
사용자의 의견을 수용합니다. 어떤 레벨로 인식하는지 묻습니다. 선택한 레벨의 경로를 제시하되 빠진 주제에 대한 사전 요건 확인을 포함합니다.

### 특정 주제에 대해 묻는 경우
평가 중에 "hooks에 대해 알려줘" 또는 "MCP를 배우고 싶어" 같은 말을 하면 메모해 둡니다. 결과 제시 후 점수와 관계없이 학습 경로에서 해당 주제를 강조합니다.

## 유효성 검사

### 트리거 테스트 스위트

**트리거되어야 하는 경우:**
- "내 수준 평가해줘"
- "퀴즈 풀어줘"
- "내 레벨 찾아줘"
- "어디서 시작해야 하나"
- "내 레벨이 어느 정도야"
- "학습 경로 퀴즈"
- "자가 평가"
- "다음에 뭘 배워야 해"
- "기술 확인"
- "스킬 체크"
- "레벨 올려줘"
- "Claude Code 얼마나 잘 하는지"
- "Claude Code 지식 평가해줘"

**트리거되지 않아야 하는 경우:**
- "내 코드 리뷰해줘"
- "스킬 만들어줘"
- "MCP 도와줘"
- "slash commands 설명해줘"
- "checkpoint가 뭐야"
