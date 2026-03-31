<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 기능 카탈로그

> Claude Code의 모든 기능에 대한 빠른 참조 가이드: 명령어, 에이전트, Skills, Plugins, Hooks.

**탐색**: [Commands](#slash-commands) | [권한 모드](#permission-modes) | [Subagents](#subagents) | [Skills](#skills) | [Plugins](#plugins) | [MCP Servers](#mcp-servers) | [Hooks](#hooks) | [Memory](#memory-files) | [신규 기능](#new-features-march-2026)

---

## 요약

| 기능 | 기본 제공 | 예제 | 합계 | 참조 |
|---------|----------|----------|-------|-----------|
| **Slash Commands** | 55+ | 8 | 63+ | [01-slash-commands/](01-slash-commands/) |
| **Subagents** | 6 | 10 | 16 | [04-subagents/](04-subagents/) |
| **Skills** | 번들 5개 | 4 | 9 | [03-skills/](03-skills/) |
| **Plugins** | - | 3 | 3 | [07-plugins/](07-plugins/) |
| **MCP Servers** | 1 | 8 | 9 | [05-mcp/](05-mcp/) |
| **Hooks** | 이벤트 25개 | 7 | 7 | [06-hooks/](06-hooks/) |
| **Memory** | 타입 7가지 | 3 | 3 | [02-memory/](02-memory/) |
| **합계** | **99** | **43** | **117** | |

---

## Slash Commands

Commands는 사용자가 직접 호출하여 특정 동작을 실행하는 단축 명령어입니다.

### 기본 제공 Commands

| Command | 설명 | 사용 시점 |
|---------|-------------|-------------|
| `/help` | 도움말 정보 표시 | 시작 단계, 명령어 학습 |
| `/btw` | 컨텍스트에 추가하지 않고 사이드 질문 | 간단한 부가 질문 |
| `/chrome` | Chrome 통합 설정 | 브라우저 자동화 |
| `/clear` | 대화 기록 지우기 | 새로 시작, 컨텍스트 줄이기 |
| `/diff` | 대화형 diff 뷰어 | 변경 사항 검토 |
| `/config` | 설정 보기/편집 | 동작 방식 커스터마이즈 |
| `/status` | 세션 상태 표시 | 현재 상태 확인 |
| `/agents` | 사용 가능한 에이전트 목록 | 위임 옵션 확인 |
| `/skills` | 사용 가능한 Skills 목록 | 자동 호출 기능 확인 |
| `/hooks` | 설정된 Hooks 목록 | 자동화 디버그 |
| `/insights` | 세션 패턴 분석 | 세션 최적화 |
| `/install-slack-app` | Claude Slack 앱 설치 | Slack 통합 |
| `/keybindings` | 키보드 단축키 커스터마이즈 | 키 설정 변경 |
| `/mcp` | MCP 서버 목록 | 외부 통합 확인 |
| `/memory` | 로드된 memory 파일 보기 | 컨텍스트 로딩 디버그 |
| `/mobile` | 모바일 QR 코드 생성 | 모바일 접근 |
| `/passes` | 이용 패스 보기 | 구독 정보 |
| `/plugin` | 플러그인 관리 | 확장 프로그램 설치/제거 |
| `/plan` | 계획 모드 진입 | 복잡한 구현 작업 |
| `/rewind` | 체크포인트로 되돌리기 | 변경 취소, 대안 탐색 |
| `/checkpoint` | Checkpoints 관리 | 상태 저장/복원 |
| `/cost` | 토큰 사용 비용 표시 | 지출 모니터링 |
| `/context` | 컨텍스트 창 사용량 표시 | 대화 길이 관리 |
| `/export` | 대화 내보내기 | 참조용 저장 |
| `/extra-usage` | 추가 사용 한도 설정 | 속도 제한 관리 |
| `/feedback` | 피드백 또는 버그 리포트 제출 | 문제 보고 |
| `/login` | Anthropic 인증 | 기능 접근 |
| `/logout` | 로그아웃 | 계정 전환 |
| `/sandbox` | 샌드박스 모드 토글 | 안전한 명령어 실행 |
| `/vim` | vim 모드 토글 | vim 스타일 편집 |
| `/doctor` | 진단 실행 | 문제 해결 |
| `/reload-plugins` | 설치된 플러그인 재로드 | 플러그인 관리 |
| `/release-notes` | 릴리즈 노트 표시 | 신규 기능 확인 |
| `/remote-control` | 원격 제어 활성화 | 원격 접근 |
| `/permissions` | 권한 관리 | 접근 제어 |
| `/session` | 세션 관리 | 멀티 세션 워크플로우 |
| `/rename` | 현재 세션 이름 변경 | 세션 정리 |
| `/resume` | 이전 세션 재개 | 작업 이어가기 |
| `/todo` | 할 일 목록 보기/관리 | 작업 추적 |
| `/tasks` | 백그라운드 작업 보기 | 비동기 작업 모니터링 |
| `/copy` | 마지막 응답을 클립보드에 복사 | 출력 빠르게 공유 |
| `/teleport` | 세션을 다른 기기로 이전 | 원격에서 작업 이어가기 |
| `/desktop` | Claude Desktop 앱 열기 | 데스크탑 인터페이스로 전환 |
| `/theme` | 색상 테마 변경 | 외관 커스터마이즈 |
| `/usage` | API 사용 통계 표시 | 할당량 및 비용 모니터링 |
| `/fork` | 현재 대화 포크 | 대안 탐색 |
| `/stats` | 세션 통계 표시 | 세션 지표 검토 |
| `/statusline` | 상태 줄 설정 | 상태 표시 커스터마이즈 |
| `/stickers` | 세션 스티커 보기 | 재미 요소 |
| `/fast` | 빠른 출력 모드 토글 | 응답 속도 향상 |
| `/terminal-setup` | 터미널 통합 설정 | 터미널 기능 설정 |
| `/upgrade` | 업데이트 확인 | 버전 관리 |

### 커스텀 Commands (예제)

| Command | 설명 | 사용 시점 | 범위 | 설치 방법 |
|---------|-------------|-------------|-------|--------------|
| `/optimize` | 최적화를 위한 코드 분석 | 성능 개선 | 프로젝트 | `cp 01-slash-commands/optimize.md .claude/commands/` |
| `/pr` | 풀 리퀘스트 준비 | PR 제출 전 | 프로젝트 | `cp 01-slash-commands/pr.md .claude/commands/` |
| `/generate-api-docs` | API 문서 생성 | API 문서화 | 프로젝트 | `cp 01-slash-commands/generate-api-docs.md .claude/commands/` |
| `/commit` | 컨텍스트를 포함한 git 커밋 생성 | 변경 사항 커밋 | 사용자 | `cp 01-slash-commands/commit.md .claude/commands/` |
| `/push-all` | 스테이징, 커밋, 푸시 | 빠른 배포 | 사용자 | `cp 01-slash-commands/push-all.md .claude/commands/` |
| `/doc-refactor` | 문서 구조 재편성 | 문서 개선 | 프로젝트 | `cp 01-slash-commands/doc-refactor.md .claude/commands/` |
| `/setup-ci-cd` | CI/CD 파이프라인 설정 | 신규 프로젝트 | 프로젝트 | `cp 01-slash-commands/setup-ci-cd.md .claude/commands/` |
| `/unit-test-expand` | 테스트 커버리지 확장 | 테스트 개선 | 프로젝트 | `cp 01-slash-commands/unit-test-expand.md .claude/commands/` |

> **범위**: `User` = 개인 워크플로우 (`~/.claude/commands/`), `Project` = 팀 공유 (`.claude/commands/`)

**참조**: [01-slash-commands/](01-slash-commands/) | [공식 문서](https://code.claude.com/docs/en/interactive-mode)

**전체 커스텀 Commands 일괄 설치**:
```bash
cp 01-slash-commands/*.md .claude/commands/
```

---

## Permission Modes

Claude Code는 도구 사용 승인 방식을 제어하는 6가지 permission mode를 지원합니다.

| 모드 | 설명 | 사용 시점 |
|------|-------------|-------------|
| `default` | 각 도구 호출마다 확인 요청 | 표준 대화형 사용 |
| `acceptEdits` | 파일 편집은 자동 승인, 나머지는 확인 | 신뢰할 수 있는 편집 워크플로우 |
| `plan` | 읽기 전용 도구만 허용, 쓰기 없음 | 계획 수립 및 탐색 |
| `auto` | 확인 없이 모든 도구 자동 승인 | 완전 자율 작동 (Research Preview) |
| `bypassPermissions` | 모든 권한 확인 생략 | CI/CD, headless 환경 |
| `dontAsk` | 권한이 필요한 도구 건너뜀 | 비대화형 스크립팅 |

> **참고**: `auto` 모드는 Research Preview 기능입니다 (2026년 3월). `bypassPermissions`는 신뢰할 수 있는 샌드박스 환경에서만 사용하세요.

**참조**: [공식 문서](https://code.claude.com/docs/en/permissions)

---

## Subagents

특정 작업을 위한 격리된 컨텍스트를 가진 전문화된 AI 어시스턴트입니다.

### 기본 제공 Subagents

| 에이전트 | 설명 | 도구 | 모델 | 사용 시점 |
|-------|-------------|-------|-------|-------------|
| **general-purpose** | 다단계 작업, 리서치 | 모든 도구 | 상속 | 복잡한 리서치, 다중 파일 작업 |
| **Plan** | 구현 계획 수립 | Read, Glob, Grep, Bash | 상속 | 아키텍처 설계, 계획 수립 |
| **Explore** | 코드베이스 탐색 | Read, Glob, Grep | Haiku 4.5 | 빠른 검색, 코드 이해 |
| **Bash** | 명령어 실행 | Bash | 상속 | Git 작업, 터미널 작업 |
| **statusline-setup** | 상태 줄 설정 | Bash, Read, Write | Sonnet 4.6 | 상태 줄 표시 설정 |
| **Claude Code Guide** | 도움말 및 문서화 | Read, Glob, Grep | Haiku 4.5 | 도움말 얻기, 기능 학습 |

### Subagent 설정 필드

| 필드 | 타입 | 설명 |
|-------|------|-------------|
| `name` | string | 에이전트 식별자 |
| `description` | string | 에이전트의 역할 |
| `model` | string | 모델 재정의 (예: `haiku-4.5`) |
| `tools` | array | 허용된 도구 목록 |
| `effort` | string | 추론 노력 수준 (`low`, `medium`, `high`) |
| `initialPrompt` | string | 에이전트 시작 시 주입되는 시스템 프롬프트 |
| `disallowedTools` | array | 이 에이전트에 명시적으로 차단된 도구 |

### 커스텀 Subagents (예제)

| 에이전트 | 설명 | 사용 시점 | 범위 | 설치 방법 |
|-------|-------------|-------------|-------|--------------|
| `code-reviewer` | 종합적인 코드 품질 검토 | 코드 리뷰 세션 | 프로젝트 | `cp 04-subagents/code-reviewer.md .claude/agents/` |
| `code-architect` | 기능 아키텍처 설계 | 신규 기능 기획 | 프로젝트 | `cp 04-subagents/code-architect.md .claude/agents/` |
| `code-explorer` | 심층 코드베이스 분석 | 기존 기능 파악 | 프로젝트 | `cp 04-subagents/code-explorer.md .claude/agents/` |
| `clean-code-reviewer` | Clean Code 원칙 리뷰 | 유지보수성 검토 | 프로젝트 | `cp 04-subagents/clean-code-reviewer.md .claude/agents/` |
| `test-engineer` | 테스트 전략 및 커버리지 | 테스트 계획 | 프로젝트 | `cp 04-subagents/test-engineer.md .claude/agents/` |
| `documentation-writer` | 기술 문서 작성 | API 문서, 가이드 | 프로젝트 | `cp 04-subagents/documentation-writer.md .claude/agents/` |
| `secure-reviewer` | 보안 중심 리뷰 | 보안 감사 | 프로젝트 | `cp 04-subagents/secure-reviewer.md .claude/agents/` |
| `implementation-agent` | 전체 기능 구현 | 기능 개발 | 프로젝트 | `cp 04-subagents/implementation-agent.md .claude/agents/` |
| `debugger` | 근본 원인 분석 | 버그 조사 | 사용자 | `cp 04-subagents/debugger.md .claude/agents/` |
| `data-scientist` | SQL 쿼리, 데이터 분석 | 데이터 작업 | 사용자 | `cp 04-subagents/data-scientist.md .claude/agents/` |

> **범위**: `User` = 개인 (`~/.claude/agents/`), `Project` = 팀 공유 (`.claude/agents/`)

**참조**: [04-subagents/](04-subagents/) | [공식 문서](https://code.claude.com/docs/en/sub-agents)

**전체 커스텀 에이전트 일괄 설치**:
```bash
cp 04-subagents/*.md .claude/agents/
```

---

## Skills

지침, 스크립트, 템플릿을 포함하는 자동 호출 기능입니다.

### 예제 Skills

| Skill | 설명 | 자동 호출 시점 | 범위 | 설치 방법 |
|-------|-------------|-------------------|-------|--------------|
| `code-review` | 종합적인 코드 리뷰 | "이 코드 리뷰해줘", "품질 확인해줘" | 프로젝트 | `cp -r 03-skills/code-review .claude/skills/` |
| `brand-voice` | 브랜드 일관성 검사 | 마케팅 문구 작성 시 | 프로젝트 | `cp -r 03-skills/brand-voice .claude/skills/` |
| `doc-generator` | API 문서 생성기 | "문서 생성해줘", "API 문서화해줘" | 프로젝트 | `cp -r 03-skills/doc-generator .claude/skills/` |
| `refactor` | 체계적인 코드 리팩토링 (Martin Fowler 기반) | "리팩토링해줘", "코드 정리해줘" | 사용자 | `cp -r 03-skills/refactor ~/.claude/skills/` |

> **범위**: `User` = 개인 (`~/.claude/skills/`), `Project` = 팀 공유 (`.claude/skills/`)

### Skill 구조

```
~/.claude/skills/skill-name/
├── SKILL.md          # Skill 정의 및 지침
├── scripts/          # 헬퍼 스크립트
└── templates/        # 출력 템플릿
```

### Skill Frontmatter 필드

Skills는 `SKILL.md`에서 설정을 위한 YAML frontmatter를 지원합니다:

| 필드 | 타입 | 설명 |
|-------|------|-------------|
| `name` | string | Skill 표시 이름 |
| `description` | string | Skill의 역할 |
| `autoInvoke` | array | 자동 호출 트리거 문구 |
| `effort` | string | 추론 노력 수준 (`low`, `medium`, `high`) |
| `shell` | string | 스크립트에 사용할 shell (`bash`, `zsh`, `sh`) |

**참조**: [03-skills/](03-skills/) | [공식 문서](https://code.claude.com/docs/en/skills)

**전체 Skills 일괄 설치**:
```bash
cp -r 03-skills/* ~/.claude/skills/
```

### 번들 Skills

| Skill | 설명 | 자동 호출 시점 |
|-------|-------------|-------------------|
| `/simplify` | 코드 품질 검토 | 코드 작성 후 |
| `/batch` | 여러 파일에 프롬프트 일괄 실행 | 배치 작업 |
| `/debug` | 테스트 실패/오류 디버그 | 디버깅 세션 |
| `/loop` | 일정 간격으로 프롬프트 실행 | 반복 작업 |
| `/claude-api` | Claude API로 앱 빌드 | API 개발 |

---

## Plugins

Commands, 에이전트, MCP 서버, Hooks을 묶은 번들 모음입니다.

### 예제 Plugins

| Plugin | 설명 | 구성 요소 | 사용 시점 | 범위 | 설치 방법 |
|--------|-------------|------------|-------------|-------|--------------|
| `pr-review` | PR 리뷰 워크플로우 | Commands 3개, 에이전트 3개, GitHub MCP | 코드 리뷰 | 프로젝트 | `/plugin install pr-review` |
| `devops-automation` | 배포 및 모니터링 | Commands 4개, 에이전트 3개, K8s MCP | DevOps 작업 | 프로젝트 | `/plugin install devops-automation` |
| `documentation` | 문서 생성 모음 | Commands 4개, 에이전트 3개, 템플릿 | 문서화 | 프로젝트 | `/plugin install documentation` |

> **범위**: `Project` = 팀 공유, `User` = 개인 워크플로우

### Plugin 구조

```
.claude-plugin/
├── plugin.json       # 매니페스트 파일
├── commands/         # Slash commands
├── agents/           # Subagents
├── skills/           # Skills
├── mcp/              # MCP 설정
├── hooks/            # Hook 스크립트
└── scripts/          # 유틸리티 스크립트
```

**참조**: [07-plugins/](07-plugins/) | [공식 문서](https://code.claude.com/docs/en/plugins)

**Plugin 관리 Commands**:
```bash
/plugin list              # 설치된 플러그인 목록
/plugin install <name>    # 플러그인 설치
/plugin remove <name>     # 플러그인 제거
/plugin update <name>     # 플러그인 업데이트
```

---

## MCP Servers

외부 도구 및 API 접근을 위한 Model Context Protocol 서버입니다.

### 주요 MCP Servers

| 서버 | 설명 | 사용 시점 | 범위 | 설치 방법 |
|--------|-------------|-------------|-------|--------------|
| **GitHub** | PR 관리, 이슈, 코드 | GitHub 워크플로우 | 프로젝트 | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| **Database** | SQL 쿼리, 데이터 접근 | 데이터베이스 작업 | 프로젝트 | `claude mcp add db -- npx -y @modelcontextprotocol/server-postgres` |
| **Filesystem** | 고급 파일 작업 | 복잡한 파일 작업 | 사용자 | `claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem` |
| **Slack** | 팀 커뮤니케이션 | 알림, 업데이트 | 프로젝트 | 설정에서 구성 |
| **Google Docs** | 문서 접근 | 문서 편집, 검토 | 프로젝트 | 설정에서 구성 |
| **Asana** | 프로젝트 관리 | 작업 추적 | 프로젝트 | 설정에서 구성 |
| **Stripe** | 결제 데이터 | 재무 분석 | 프로젝트 | 설정에서 구성 |
| **Memory** | 영구 메모리 | 세션 간 기억 | 사용자 | 설정에서 구성 |
| **Context7** | 라이브러리 문서화 | 최신 문서 조회 | 기본 제공 | 기본 제공 |

> **범위**: `Project` = 팀 (`.mcp.json`), `User` = 개인 (`~/.claude.json`), `Built-in` = 사전 설치

### MCP 설정 예제

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**참조**: [05-mcp/](05-mcp/) | [MCP 프로토콜 문서](https://modelcontextprotocol.io)

**GitHub MCP 빠른 설치**:
```bash
export GITHUB_TOKEN="your_token" && claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## Hooks

Claude Code 이벤트에 따라 shell 명령어를 실행하는 이벤트 기반 자동화입니다.

### Hook 이벤트

| 이벤트 | 설명 | 트리거 시점 | 활용 사례 |
|-------|-------------|----------------|-----------|
| `SessionStart` | 세션 시작/재개 | 세션 초기화 | 설정 작업 |
| `InstructionsLoaded` | 지침 로드 완료 | CLAUDE.md 또는 rules 파일 로드 시 | 커스텀 지침 처리 |
| `UserPromptSubmit` | 프롬프트 처리 전 | 사용자가 메시지 전송 시 | 입력 유효성 검사 |
| `PreToolUse` | 도구 실행 전 | 도구 실행 직전 | 유효성 검사, 로깅 |
| `PermissionRequest` | 권한 대화상자 표시 | 민감한 작업 전 | 커스텀 승인 플로우 |
| `PostToolUse` | 도구 성공 후 | 도구 완료 후 | 포맷팅, 알림 |
| `PostToolUseFailure` | 도구 실행 실패 | 도구 오류 후 | 오류 처리, 로깅 |
| `Notification` | 알림 전송 | Claude가 알림 전송 시 | 외부 알림 |
| `SubagentStart` | Subagent 생성 | Subagent 작업 시작 | Subagent 컨텍스트 초기화 |
| `SubagentStop` | Subagent 완료 | Subagent 작업 완료 | 후속 작업 연결 |
| `Stop` | Claude 응답 완료 | 응답 완료 | 정리, 리포팅 |
| `StopFailure` | API 오류로 턴 종료 | API 오류 발생 시 | 오류 복구, 로깅 |
| `TeammateIdle` | 팀원 에이전트 유휴 상태 | 에이전트 팀 조율 | 작업 분배 |
| `TaskCompleted` | 작업 완료 표시 | 작업 완료 시 | 작업 후 처리 |
| `TaskCreated` | TaskCreate로 작업 생성 | 새 작업 생성 시 | 작업 추적, 로깅 |
| `ConfigChange` | 설정 업데이트 | 설정 변경 시 | 설정 변경에 반응 |
| `CwdChanged` | 작업 디렉터리 변경 | 디렉터리 변경 시 | 디렉터리별 설정 |
| `FileChanged` | 감시 중인 파일 변경 | 파일 수정 시 | 파일 모니터링, 재빌드 |
| `PreCompact` | compact 작업 전 | 컨텍스트 압축 전 | 상태 보존 |
| `PostCompact` | compaction 완료 후 | compaction 완료 시 | compact 후 작업 |
| `WorktreeCreate` | Worktree 생성 중 | Git worktree 생성 시 | worktree 환경 설정 |
| `WorktreeRemove` | Worktree 제거 중 | Git worktree 제거 시 | worktree 리소스 정리 |
| `Elicitation` | MCP 서버가 입력 요청 | MCP elicitation 시 | 입력 유효성 검사 |
| `ElicitationResult` | 사용자가 elicitation에 응답 | 사용자 응답 시 | 응답 처리 |
| `SessionEnd` | 세션 종료 | 세션 종료 시 | 정리, 상태 저장 |

### 예제 Hooks

| Hook | 설명 | 이벤트 | 범위 | 설치 방법 |
|------|-------------|-------|-------|--------------|
| `validate-bash.py` | 명령어 유효성 검사 | PreToolUse:Bash | 프로젝트 | `cp 06-hooks/validate-bash.py .claude/hooks/` |
| `security-scan.py` | 보안 스캔 | PostToolUse:Write | 프로젝트 | `cp 06-hooks/security-scan.py .claude/hooks/` |
| `format-code.sh` | 자동 포맷팅 | PostToolUse:Write | 사용자 | `cp 06-hooks/format-code.sh ~/.claude/hooks/` |
| `validate-prompt.py` | 프롬프트 유효성 검사 | UserPromptSubmit | 프로젝트 | `cp 06-hooks/validate-prompt.py .claude/hooks/` |
| `context-tracker.py` | 토큰 사용량 추적 | Stop | 사용자 | `cp 06-hooks/context-tracker.py ~/.claude/hooks/` |
| `pre-commit.sh` | 커밋 전 유효성 검사 | PreToolUse:Bash | 프로젝트 | `cp 06-hooks/pre-commit.sh .claude/hooks/` |
| `log-bash.sh` | 명령어 로깅 | PostToolUse:Bash | 사용자 | `cp 06-hooks/log-bash.sh ~/.claude/hooks/` |

> **범위**: `Project` = 팀 (`.claude/settings.json`), `User` = 개인 (`~/.claude/settings.json`)

### Hook 설정

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "~/.claude/hooks/validate-bash.py"
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "~/.claude/hooks/format-code.sh"
      }
    ]
  }
}
```

**참조**: [06-hooks/](06-hooks/) | [공식 문서](https://code.claude.com/docs/en/hooks)

**전체 Hooks 일괄 설치**:
```bash
mkdir -p ~/.claude/hooks && cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh
```

---

## Memory Files

세션 전반에 걸쳐 자동으로 로드되는 영구 컨텍스트입니다.

### Memory 타입

| 타입 | 위치 | 범위 | 사용 시점 |
|------|----------|-------|-------------|
| **Managed Policy** | 조직 관리 정책 | 조직 | 조직 전체 표준 적용 |
| **Project** | `./CLAUDE.md` | 프로젝트 (팀) | 팀 표준, 프로젝트 컨텍스트 |
| **Project Rules** | `.claude/rules/` | 프로젝트 (팀) | 모듈식 프로젝트 규칙 |
| **User** | `~/.claude/CLAUDE.md` | 사용자 (개인) | 개인 설정 |
| **User Rules** | `~/.claude/rules/` | 사용자 (개인) | 모듈식 개인 규칙 |
| **Local** | `./CLAUDE.local.md` | 로컬 (git 제외) | 기기별 오버라이드 (2026년 3월 기준 공식 문서 미기재; 레거시일 수 있음) |
| **Auto Memory** | 자동 | 세션 | 자동 캡처된 인사이트 및 수정 사항 |

> **범위**: `Organization` = 관리자 관리, `Project` = git으로 팀 공유, `User` = 개인 설정, `Local` = 커밋 안 됨, `Session` = 자동 관리

**참조**: [02-memory/](02-memory/) | [공식 문서](https://code.claude.com/docs/en/memory)

**빠른 설치**:
```bash
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

---

## New Features (March 2026)

| 기능 | 설명 | 사용 방법 |
|---------|-------------|------------|
| **Remote Control** | API를 통한 Claude Code 세션 원격 제어 | remote control API로 프롬프트 전송 및 응답 수신 |
| **Web Sessions** | 브라우저 기반 환경에서 Claude Code 실행 | `claude web` 또는 Anthropic Console에서 접근 |
| **Desktop App** | Claude Code 네이티브 데스크탑 앱 | `/desktop` 사용 또는 Anthropic 웹사이트에서 다운로드 |
| **Agent Teams** | 관련 작업에 협력하는 여러 에이전트 조율 | 컨텍스트를 공유하고 협업하는 팀원 에이전트 설정 |
| **Task List** | 백그라운드 작업 관리 및 모니터링 | `/tasks`로 백그라운드 작업 확인 및 관리 |
| **Prompt Suggestions** | 컨텍스트 인식 명령어 제안 | 현재 컨텍스트에 따라 자동으로 제안 표시 |
| **Git Worktrees** | 병렬 개발을 위한 격리된 git worktree | 안전한 병렬 브랜치 작업을 위한 worktree 명령어 사용 |
| **Sandboxing** | 안전한 격리 실행 환경 | `/sandbox`로 토글; 제한된 환경에서 명령어 실행 |
| **MCP OAuth** | MCP 서버용 OAuth 인증 | 보안 접근을 위해 MCP 서버 설정에서 OAuth 자격증명 구성 |
| **MCP Tool Search** | MCP 도구 동적 검색 및 발견 | 연결된 서버의 사용 가능한 MCP 도구 검색 |
| **Scheduled Tasks** | `/loop` 및 cron 도구로 반복 작업 설정 | `/loop 5m /command` 또는 CronCreate 도구 사용 |
| **Chrome Integration** | headless Chromium을 사용한 브라우저 자동화 | `--chrome` 플래그 또는 `/chrome` 명령어 사용 |
| **Keyboard Customization** | 코드 지원 포함 keybinding 커스터마이즈 | `/keybindings` 사용 또는 `~/.claude/keybindings.json` 편집 |
| **Auto Mode** | 권한 확인 없이 완전 자율 작동 (Research Preview) | `--mode auto` 또는 `/permissions auto` 사용; 2026년 3월 |
| **Channels** | 다채널 커뮤니케이션 (Telegram, Slack 등) (Research Preview) | 채널 플러그인 설정; 2026년 3월 |
| **Voice Dictation** | 프롬프트를 위한 음성 입력 | 마이크 아이콘 또는 음성 keybinding 사용 |
| **Agent Hook Type** | shell 명령어 대신 subagent를 생성하는 Hooks | Hook 설정에서 `"type": "agent"` 지정 |
| **Prompt Hook Type** | 대화에 프롬프트 텍스트를 주입하는 Hooks | Hook 설정에서 `"type": "prompt"` 지정 |
| **MCP Elicitation** | 도구 실행 중 MCP 서버가 사용자 입력 요청 | `Elicitation` 및 `ElicitationResult` Hook 이벤트로 처리 |
| **WebSocket MCP Transport** | MCP 서버 연결을 위한 WebSocket 기반 전송 | MCP 서버 설정에서 `"transport": "websocket"` 사용 |
| **Plugin LSP Support** | 플러그인을 통한 Language Server Protocol 통합 | 편집기 기능을 위해 `plugin.json`에 LSP 서버 설정 |
| **Managed Drop-ins** | 조직 관리 drop-in 설정 (v2.1.83) | 관리자가 managed policies를 통해 설정; 전체 사용자에게 자동 적용 |

---

## 빠른 참조 매트릭스

### 기능 선택 가이드

| 필요 사항 | 권장 기능 | 이유 |
|------|---------------------|-----|
| 빠른 단축키 | Slash Command | 수동, 즉시 실행 |
| 영구 컨텍스트 | Memory | 자동 로드 |
| 복잡한 자동화 | Skill | 자동 호출 |
| 전문화된 작업 | Subagent | 격리된 컨텍스트 |
| 외부 데이터 | MCP Server | 실시간 접근 |
| 이벤트 자동화 | Hook | 이벤트 트리거 |
| 완전한 솔루션 | Plugin | 올인원 번들 |

### 설치 우선순위

| 우선순위 | 기능 | 명령어 |
|----------|---------|---------|
| 1. 필수 | Memory | `cp 02-memory/project-CLAUDE.md ./CLAUDE.md` |
| 2. 일상 사용 | Slash Commands | `cp 01-slash-commands/*.md .claude/commands/` |
| 3. 품질 | Subagents | `cp 04-subagents/*.md .claude/agents/` |
| 4. 자동화 | Hooks | `cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh` |
| 5. 외부 | MCP | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| 6. 고급 | Skills | `cp -r 03-skills/* ~/.claude/skills/` |
| 7. 완전 | Plugins | `/plugin install pr-review` |

---

## 전체 원클릭 설치

이 저장소의 모든 예제를 설치합니다:

```bash
# 디렉터리 생성
mkdir -p .claude/{commands,agents,skills} ~/.claude/{hooks,skills}

# 전체 기능 설치
cp 01-slash-commands/*.md .claude/commands/ && \
cp 02-memory/project-CLAUDE.md ./CLAUDE.md && \
cp -r 03-skills/* ~/.claude/skills/ && \
cp 04-subagents/*.md .claude/agents/ && \
cp 06-hooks/*.sh ~/.claude/hooks/ && \
chmod +x ~/.claude/hooks/*.sh
```

---

## 추가 자료

- [Claude Code 공식 문서](https://code.claude.com/docs/en/overview)
- [MCP 프로토콜 사양](https://modelcontextprotocol.io)
- [학습 로드맵](LEARNING-ROADMAP.md)
- [메인 README](README.md)

---

**최종 업데이트**: 2026년 3월
