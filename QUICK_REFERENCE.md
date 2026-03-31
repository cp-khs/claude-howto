<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 예제 - 빠른 참조 카드

## 🚀 빠른 설치 명령어

### Slash Commands
```bash
# 전체 설치
cp 01-slash-commands/*.md .claude/commands/

# 특정 항목 설치
cp 01-slash-commands/optimize.md .claude/commands/
```

### Memory
```bash
# 프로젝트 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 개인 memory
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

### Skills
```bash
# 개인 skills
cp -r 03-skills/code-review ~/.claude/skills/

# 프로젝트 skills
cp -r 03-skills/code-review .claude/skills/
```

### Subagents
```bash
# 전체 설치
cp 04-subagents/*.md .claude/agents/

# 특정 항목 설치
cp 04-subagents/code-reviewer.md .claude/agents/
```

### MCP
```bash
# 자격 증명 설정
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# 설정 설치 (프로젝트 범위)
cp 05-mcp/github-mcp.json .mcp.json

# 또는 사용자 범위: ~/.claude.json 에 추가
```

### Hooks
```bash
# hooks 설치
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# settings에서 설정 (~/.claude/settings.json)
```

### Plugins
```bash
# 예제에서 설치 (게시된 경우)
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

### Checkpoints
```bash
# Checkpoints는 모든 사용자 프롬프트마다 자동으로 생성됩니다
# 되돌리려면 Esc를 두 번 누르거나 아래 명령을 사용하세요:
/rewind

# 선택: 코드와 대화 복원, 대화만 복원,
# 코드만 복원, 여기서부터 요약, 취소
```

### 고급 기능
```bash
# settings에서 설정 (.claude/settings.json)
# 09-advanced-features/config-examples.json 참고

# Planning mode
/plan Task description

# Permission modes (--permission-mode 플래그 사용)
# default        - 위험한 작업에 대해 승인 요청
# acceptEdits    - 파일 수정 자동 수락, 나머지는 요청
# plan           - 읽기 전용 분석, 수정 없음
# dontAsk        - 위험한 작업 제외 모두 수락
# auto           - 백그라운드 분류기가 권한 자동 결정
# bypassPermissions - 모든 작업 수락 (--dangerously-skip-permissions 필요)

# 세션 관리
/resume                # 이전 대화 재개
/rename "name"         # 현재 세션 이름 지정
/fork                  # 현재 세션 분기
claude -c              # 가장 최근 대화 이어서 시작
claude -r "session"    # 이름/ID로 세션 재개
```

---

## 📋 기능 치트 시트

| 기능 | 설치 경로 | 사용법 |
|---------|-------------|-------|
| **Slash Commands (55+)** | `.claude/commands/*.md` | `/command-name` |
| **Memory** | `./CLAUDE.md` | 자동 로드 |
| **Skills** | `.claude/skills/*/SKILL.md` | 자동 실행 |
| **Subagents** | `.claude/agents/*.md` | 자동 위임 |
| **MCP** | `.mcp.json` (프로젝트) 또는 `~/.claude.json` (사용자) | `/mcp__server__action` |
| **Hooks (25가지 이벤트)** | `~/.claude/hooks/*.sh` | 이벤트 트리거 (4가지 유형) |
| **Plugins** | `/plugin install` 사용 | 모두 번들 |
| **Checkpoints** | 내장 | `Esc+Esc` 또는 `/rewind` |
| **Planning Mode** | 내장 | `/plan <task>` |
| **Permission Modes (6가지)** | 내장 | `--allowedTools`, `--permission-mode` |
| **Sessions** | 내장 | `/session <command>` |
| **백그라운드 태스크** | 내장 | 백그라운드 실행 |
| **원격 제어** | 내장 | WebSocket API |
| **Web Sessions** | 내장 | `claude web` |
| **Git Worktrees** | 내장 | `/worktree` |
| **Auto Memory** | 내장 | CLAUDE.md에 자동 저장 |
| **Task List** | 내장 | `/task list` |
| **번들 Skills (5개)** | 내장 | `/simplify`, `/loop`, `/claude-api`, `/voice`, `/browse` |

---

## 🎯 주요 사용 사례

### 코드 리뷰
```bash
# 방법 1: Slash command
cp 01-slash-commands/optimize.md .claude/commands/
# 사용: /optimize

# 방법 2: Subagent
cp 04-subagents/code-reviewer.md .claude/agents/
# 사용: 자동 위임

# 방법 3: Skill
cp -r 03-skills/code-review ~/.claude/skills/
# 사용: 자동 실행

# 방법 4: Plugin (최선)
/plugin install pr-review
# 사용: /review-pr
```

### 문서화
```bash
# Slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# Subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# Skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# Plugin (완전한 솔루션)
/plugin install documentation
```

### DevOps
```bash
# 완전한 plugin
/plugin install devops-automation

# 명령어: /deploy, /rollback, /status, /incident
```

### 팀 표준
```bash
# 프로젝트 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 팀에 맞게 편집
vim CLAUDE.md
```

### 자동화 및 Hooks
```bash
# hooks 설치 (25가지 이벤트, 4가지 유형: command, http, prompt, agent)
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 예시:
# - 커밋 전 테스트: pre-commit.sh
# - 코드 자동 포맷: format-code.sh
# - 보안 스캔: security-scan.sh

# 완전 자율 워크플로우를 위한 Auto Mode
claude --enable-auto-mode -p "Refactor and test the auth module"
# 또는 Shift+Tab으로 대화형 모드 전환
```

### 안전한 리팩토링
```bash
# Checkpoints는 각 프롬프트 전에 자동으로 생성됩니다
# 리팩토링 시도
# 성공 시: 계속 진행
# 실패 시: Esc+Esc를 누르거나 /rewind로 되돌리기
```

### 복잡한 구현
```bash
# Planning mode 사용
/plan Implement user authentication system

# Claude가 상세 계획 생성
# 검토 및 승인
# Claude가 체계적으로 구현
```

### CI/CD 연동
```bash
# 헤드리스 모드(비대화형)로 실행
claude -p "Run all tests and generate report"

# CI용 permission mode 사용
claude -p "Run tests" --permission-mode dontAsk

# 완전 자율 CI 작업을 위한 Auto Mode
claude --enable-auto-mode -p "Run tests and fix failures"

# 자동화를 위한 hooks 사용
# 09-advanced-features/README.md 참고
```

### 학습 및 실험
```bash
# 안전한 분석을 위해 plan mode 사용
claude --permission-mode plan

# 안전하게 실험 - checkpoints가 자동으로 생성됩니다
# 되돌려야 할 경우: Esc+Esc를 누르거나 /rewind 사용
```

### 에이전트 팀
```bash
# 에이전트 팀 활성화
export CLAUDE_AGENT_TEAMS=1

# 또는 settings.json에서
{ "agentTeams": { "enabled": true } }

# 시작: "Implement feature X using a team approach"
```

### 예약 태스크
```bash
# 5분마다 명령 실행
/loop 5m /check-status

# 일회성 알림
/loop 30m "remind me to check the deploy"
```

---

## 📁 파일 위치 참조

```
프로젝트 폴더/
├── .claude/
│   ├── commands/              # Slash commands 위치
│   ├── agents/                # Subagents 위치
│   ├── skills/                # 프로젝트 skills 위치
│   └── settings.json          # 프로젝트 설정 (hooks 등)
├── .mcp.json                  # MCP 설정 (프로젝트 범위)
├── CLAUDE.md                  # 프로젝트 memory
└── src/
    └── api/
        └── CLAUDE.md          # 디렉토리별 memory

사용자 홈/
├── .claude/
│   ├── commands/              # 개인 commands
│   ├── agents/                # 개인 agents
│   ├── skills/                # 개인 skills
│   ├── hooks/                 # Hook 스크립트
│   ├── settings.json          # 사용자 설정
│   ├── managed-settings.d/    # 관리형 설정 (엔터프라이즈/조직)
│   └── CLAUDE.md              # 개인 memory
└── .claude.json               # 개인 MCP 설정 (사용자 범위)
```

---

## 🔍 예제 찾기

### 카테고리별
- **Slash Commands**: `01-slash-commands/`
- **Memory**: `02-memory/`
- **Skills**: `03-skills/`
- **Subagents**: `04-subagents/`
- **MCP**: `05-mcp/`
- **Hooks**: `06-hooks/`
- **Plugins**: `07-plugins/`
- **Checkpoints**: `08-checkpoints/`
- **고급 기능**: `09-advanced-features/`
- **CLI**: `10-cli/`

### 사용 사례별
- **성능 최적화**: `01-slash-commands/optimize.md`
- **보안**: `04-subagents/secure-reviewer.md`
- **테스팅**: `04-subagents/test-engineer.md`
- **문서화**: `03-skills/doc-generator/`
- **DevOps**: `07-plugins/devops-automation/`

### 복잡도별
- **간단**: Slash commands
- **중간**: Subagents, Memory
- **고급**: Skills, Hooks
- **완전**: Plugins

---

## 🎓 학습 경로

### 1일차
```bash
# 개요 읽기
cat README.md

# 명령어 설치
cp 01-slash-commands/optimize.md .claude/commands/

# 사용해보기
/optimize
```

### 2~3일차
```bash
# memory 설정
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
vim CLAUDE.md

# subagent 설치
cp 04-subagents/code-reviewer.md .claude/agents/
```

### 4~5일차
```bash
# MCP 설정
export GITHUB_TOKEN="your_token"
cp 05-mcp/github-mcp.json .mcp.json

# MCP 명령어 사용
/mcp__github__list_prs
```

### 2주차
```bash
# skill 설치
cp -r 03-skills/code-review ~/.claude/skills/

# 자동 실행 허용
# 그냥 말하면 됩니다: "Review this code for issues"
```

### 3주차 이후
```bash
# 완전한 plugin 설치
/plugin install pr-review

# 번들 기능 사용
/review-pr
/check-security
/check-tests
```

---

## 새 기능 (2026년 3월)

| 기능 | 설명 | 사용법 |
|---------|-------------|-------|
| **Auto Mode** | 백그라운드 분류기를 통한 완전 자율 동작 | `--enable-auto-mode` 플래그, `Shift+Tab`으로 모드 전환 |
| **Channels** | Discord 및 Telegram 연동 | `--channels` 플래그, Discord/Telegram 봇 |
| **Voice Dictation** | Claude에게 명령과 컨텍스트를 음성으로 전달 | `/voice` 명령어 |
| **Hooks (25가지 이벤트)** | 4가지 유형으로 확장된 hook 시스템 | command, http, prompt, agent hook 유형 |
| **MCP Elicitation** | MCP 서버가 런타임에 사용자 입력 요청 가능 | 서버에 설명이 필요할 때 자동 프롬프트 |
| **WebSocket MCP** | MCP 연결을 위한 WebSocket 전송 | `.mcp.json`에서 `ws://` URL로 설정 |
| **Plugin LSP** | plugins를 위한 Language Server Protocol 지원 | `userConfig`, `${CLAUDE_PLUGIN_DATA}` 변수 |
| **원격 제어** | WebSocket API로 Claude Code 제어 | 외부 연동을 위한 `claude --remote` |
| **Web Sessions** | 브라우저 기반 Claude Code 인터페이스 | `claude web`으로 실행 |
| **데스크톱 앱** | 네이티브 데스크톱 애플리케이션 | claude.ai/download에서 다운로드 |
| **Task List** | 백그라운드 태스크 관리 | `/task list`, `/task status <id>` |
| **Auto Memory** | 대화에서 자동 memory 저장 | Claude가 핵심 컨텍스트를 CLAUDE.md에 자동 저장 |
| **Git Worktrees** | 병렬 개발을 위한 격리된 작업 공간 | `/worktree`로 격리된 작업 공간 생성 |
| **모델 선택** | Sonnet 4.6과 Opus 4.6 간 전환 | `/model` 또는 `--model` 플래그 |
| **Agent Teams** | 여러 에이전트를 태스크에 협력 조율 | `CLAUDE_AGENT_TEAMS=1` 환경 변수로 활성화 |
| **Scheduled Tasks** | `/loop`을 통한 반복 태스크 | `/loop 5m /command` 또는 CronCreate 도구 |
| **Chrome Integration** | 브라우저 자동화 | `--chrome` 플래그 또는 `/chrome` 명령어 |
| **키보드 커스터마이징** | 사용자 정의 키 바인딩 | `/keybindings` 명령어 |

---

## 팁 & 트릭

### 커스터마이징
- 예제를 그대로 시작하세요
- 필요에 맞게 수정하세요
- 팀과 공유하기 전에 테스트하세요
- 설정 파일을 버전 관리하세요

### 모범 사례
- 팀 표준에는 memory 사용
- 완전한 워크플로우에는 plugins 사용
- 복잡한 태스크에는 subagents 사용
- 빠른 작업에는 slash commands 사용

### 트러블슈팅
```bash
# 파일 위치 확인
ls -la .claude/commands/
ls -la .claude/agents/

# YAML 문법 확인
head -20 .claude/agents/code-reviewer.md

# MCP 연결 테스트
echo $GITHUB_TOKEN
```

---

## 📊 기능 매트릭스

| 필요 | 사용할 것 | 예제 |
|------|----------|---------|
| 빠른 단축키 | Slash Command (55+) | `01-slash-commands/optimize.md` |
| 팀 표준 | Memory | `02-memory/project-CLAUDE.md` |
| 자동 워크플로우 | Skill | `03-skills/code-review/` |
| 전문화된 태스크 | Subagent | `04-subagents/code-reviewer.md` |
| 외부 데이터 | MCP (+ Elicitation, WebSocket) | `05-mcp/github-mcp.json` |
| 이벤트 자동화 | Hook (25가지 이벤트, 4가지 유형) | `06-hooks/pre-commit.sh` |
| 완전한 솔루션 | Plugin (+ LSP 지원) | `07-plugins/pr-review/` |
| 안전한 실험 | Checkpoint | `08-checkpoints/checkpoint-examples.md` |
| 완전 자율 | Auto Mode | `--enable-auto-mode` 또는 `Shift+Tab` |
| 채팅 연동 | Channels | `--channels` (Discord, Telegram) |
| CI/CD 파이프라인 | CLI | `10-cli/README.md` |

---

## 🔗 빠른 링크

- **메인 가이드**: `README.md`
- **전체 인덱스**: `INDEX.md`
- **요약**: `EXAMPLES_SUMMARY.md`
- **원본 가이드**: `claude_concepts_guide.md`

---

## 📞 자주 묻는 질문

**Q: 무엇을 사용해야 하나요?**
A: slash commands부터 시작하고, 필요에 따라 기능을 추가하세요.

**Q: 기능을 혼합해서 사용할 수 있나요?**
A: 네! 함께 작동합니다. Memory + Commands + MCP = 강력한 조합.

**Q: 팀과 공유하려면 어떻게 하나요?**
A: `.claude/` 디렉토리를 git에 커밋하세요.

**Q: 시크릿(비밀 값)은 어떻게 하나요?**
A: 환경 변수를 사용하고, 절대 하드코딩하지 마세요.

**Q: 예제를 수정할 수 있나요?**
A: 물론입니다! 커스터마이징을 위한 템플릿입니다.

---

## ✅ 체크리스트

시작하기 체크리스트:

- [ ] `README.md` 읽기
- [ ] slash command 1개 설치
- [ ] 명령어 사용해보기
- [ ] 프로젝트 `CLAUDE.md` 생성
- [ ] subagent 1개 설치
- [ ] MCP 연동 1개 설정
- [ ] skill 1개 설치
- [ ] 완전한 plugin 사용해보기
- [ ] 필요에 맞게 커스터마이징
- [ ] 팀과 공유

---

**빠른 시작**: `cat README.md`

**전체 인덱스**: `cat INDEX.md`

**이 카드**: 빠른 참조를 위해 가까이 두세요!
