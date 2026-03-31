<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

[![GitHub Stars](https://img.shields.io/github/stars/luongnv89/claude-howto?style=flat&color=gold)](https://github.com/luongnv89/claude-howto/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/luongnv89/claude-howto?style=flat)](https://github.com/luongnv89/claude-howto/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.2.0-brightgreen)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1+-purple)](https://code.claude.com)

# 주말 만에 Claude Code 마스터하기

`claude` 명령어를 입력하는 것에서 시작해 에이전트, hooks, skills, MCP 서버를 자유자재로 다루는 수준까지 — 시각적 튜토리얼, 바로 붙여넣을 수 있는 템플릿, 체계적인 학습 경로와 함께.

**[15분 만에 시작하기](#-15분-만에-시작하기)** | **[내 수준 확인하기](#-어디서-시작해야-할지-모르겠다면)** | **[기능 카탈로그 보기](CATALOG.md)**

---

## 목차

- [문제 인식](#문제-인식)
- [Claude How To가 이 문제를 해결하는 방법](#claude-how-to가-이-문제를-해결하는-방법)
- [작동 방식](#작동-방식)
- [어디서 시작해야 할지 모르겠다면?](#-어디서-시작해야-할지-모르겠다면)
- [15분 만에 시작하기](#-15분-만에-시작하기)
- [이걸로 무엇을 만들 수 있나요?](#이걸로-무엇을-만들-수-있나요)
- [FAQ](#faq)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

---

## 문제 인식

Claude Code를 설치했습니다. 몇 가지 프롬프트도 실행해봤습니다. 그런데 이제 어떻게 해야 할까요?

- **공식 문서는 기능을 설명할 뿐, 조합하는 방법은 알려주지 않습니다.** Slash commands가 있다는 건 알지만, hooks, 메모리, subagents와 연결해 실제로 시간을 절약하는 워크플로로 만드는 방법은 모릅니다.
- **명확한 학습 경로가 없습니다.** MCP를 hooks보다 먼저 배워야 할까요? Skills를 subagents보다 먼저 배워야 할까요? 결국 모든 것을 겉핥기로 훑다가 아무것도 제대로 익히지 못합니다.
- **예제가 너무 기초적입니다.** "Hello world" slash command는 메모리를 활용하고, 전문 에이전트에게 위임하며, 보안 스캔을 자동으로 실행하는 프로덕션 코드 리뷰 파이프라인을 만드는 데 도움이 되지 않습니다.

Claude Code 파워의 90%를 활용하지 못하고 있습니다 — 그리고 자신이 무엇을 모르는지조차 모르고 있습니다.

---

## Claude How To가 이 문제를 해결하는 방법

이것은 또 하나의 기능 레퍼런스가 아닙니다. Claude Code의 모든 기능을 실제 세계에서 바로 쓸 수 있는 템플릿과 함께 가르쳐주는 **체계적이고 시각적인, 예제 중심의 가이드**입니다.

| | 공식 문서 | 이 가이드 |
|--|---------------|------------|
| **형식** | 레퍼런스 문서 | Mermaid 다이어그램이 포함된 시각적 튜토리얼 |
| **깊이** | 기능 설명 | 내부 동작 원리 |
| **예제** | 기본 코드 조각 | 즉시 사용 가능한 프로덕션 수준 템플릿 |
| **구조** | 기능 중심 | 초급에서 고급까지 이어지는 점진적 학습 경로 |
| **온보딩** | 자기 주도 | 소요 시간 안내가 포함된 가이드 로드맵 |
| **자가 진단** | 없음 | 부족한 부분을 찾아 맞춤 경로를 제시하는 인터랙티브 퀴즈 |

### 제공 내용:

- **10개 튜토리얼 모듈** — slash commands부터 커스텀 에이전트 팀까지 Claude Code의 모든 기능 포괄
- **바로 붙여넣기 가능한 설정** — slash commands, CLAUDE.md 템플릿, hook 스크립트, MCP 설정, subagent 정의, 완전한 plugin 번들
- **Mermaid 다이어그램** — 각 기능이 내부적으로 어떻게 동작하는지 시각화하여 *왜* 그런지 이해할 수 있도록
- **체계적인 학습 경로** — 11~13시간 안에 초급에서 파워유저로
- **내장 자가 진단** — Claude Code에서 `/self-assessment` 또는 `/lesson-quiz hooks`를 실행해 부족한 부분 파악

**[학습 경로 시작하기  ->](LEARNING-ROADMAP.md)**

---

## 작동 방식

### 1. 나의 수준 파악하기

[자가 진단 퀴즈](LEARNING-ROADMAP.md#-find-your-level)를 풀거나 Claude Code에서 `/self-assessment`를 실행하세요. 현재 알고 있는 내용을 바탕으로 맞춤형 로드맵을 제공합니다.

### 2. 체계적인 경로 따라가기

10개 모듈을 순서대로 학습합니다 — 각 모듈은 이전 내용 위에 쌓입니다. 배우면서 바로 프로젝트에 템플릿을 적용하세요.

### 3. 기능들을 워크플로로 조합하기

진정한 힘은 기능 조합에 있습니다. Slash commands + 메모리 + subagents + hooks를 연결해 코드 리뷰, 배포, 문서 생성을 자동화하는 파이프라인을 만드는 방법을 배웁니다.

### 4. 이해도 확인하기

각 모듈 학습 후 `/lesson-quiz [topic]`을 실행하세요. 퀴즈가 놓친 부분을 짚어줘서 빠르게 보완할 수 있습니다.

**[15분 만에 시작하기](#-15분-만에-시작하기)**

---

## 5,900명 이상의 개발자가 신뢰합니다

- **GitHub 스타 5,900개 이상** — Claude Code를 매일 사용하는 개발자들로부터
- **포크 690개 이상** — 자신의 워크플로에 맞게 가이드를 응용하는 팀들
- **지속적으로 유지보수 중** — 모든 Claude Code 릴리스와 동기화 (최신 버전: v2.2.0, 2026년 3월)
- **커뮤니티 주도** — 실제 설정을 공유하는 개발자들의 기여

[![Star History Chart](https://api.star-history.com/svg?repos=luongnv89/claude-howto&type=Date)](https://star-history.com/#luongnv89/claude-howto&Date)

---

## 어디서 시작해야 할지 모르겠다면?

자가 진단을 하거나 자신의 수준을 선택하세요:

| 수준 | 할 수 있는 것 | 시작 위치 | 소요 시간 |
|-------|-----------|------------|------|
| **초급** | Claude Code 실행 및 대화 | [Slash Commands](01-slash-commands/) | 약 2.5시간 |
| **중급** | CLAUDE.md 및 커스텀 명령어 사용 | [Skills](03-skills/) | 약 3.5시간 |
| **고급** | MCP 서버 및 hooks 설정 | [고급 기능](09-advanced-features/) | 약 5시간 |

**전체 10개 모듈 학습 경로:**

| 순서 | 모듈 | 수준 | 소요 시간 |
|-------|--------|-------|------|
| 1 | [Slash Commands](01-slash-commands/) | 초급 | 30분 |
| 2 | [Memory](02-memory/) | 초급+ | 45분 |
| 3 | [Checkpoints](08-checkpoints/) | 중급 | 45분 |
| 4 | [CLI 기초](10-cli/) | 초급+ | 30분 |
| 5 | [Skills](03-skills/) | 중급 | 1시간 |
| 6 | [Hooks](06-hooks/) | 중급 | 1시간 |
| 7 | [MCP](05-mcp/) | 중급+ | 1시간 |
| 8 | [Subagents](04-subagents/) | 중급+ | 1.5시간 |
| 9 | [고급 기능](09-advanced-features/) | 고급 | 2~3시간 |
| 10 | [Plugins](07-plugins/) | 고급 | 2시간 |

**[완전한 학습 로드맵 ->](LEARNING-ROADMAP.md)**

---

## 15분 만에 시작하기

```bash
# 1. 가이드 클론하기
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# 2. 첫 번째 slash command 복사하기
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. 사용해보기 — Claude Code에서 다음을 입력하세요:
# /optimize

# 4. 더 해보고 싶다면? 프로젝트 메모리 설정하기:
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. skill 설치하기:
cp -r 03-skills/code-review ~/.claude/skills/
```

전체 설정이 필요하신가요? **1시간 필수 설정** 안내입니다:

```bash
# Slash commands (15분)
cp 01-slash-commands/*.md .claude/commands/

# 프로젝트 메모리 (15분)
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# skill 설치 (15분)
cp -r 03-skills/code-review ~/.claude/skills/

# 주말 목표: hooks, subagents, MCP, plugins 추가하기
# 가이드 학습 경로를 따라 단계별로 설정하세요
```

**[전체 설치 레퍼런스 보기](#설치-빠른-레퍼런스)**

---

## 이걸로 무엇을 만들 수 있나요?

| 활용 사례 | 조합할 기능 |
|----------|------------------------|
| **자동화된 코드 리뷰** | Slash Commands + Subagents + Memory + MCP |
| **팀 온보딩** | Memory + Slash Commands + Plugins |
| **CI/CD 자동화** | CLI 레퍼런스 + Hooks + 백그라운드 태스크 |
| **문서 자동 생성** | Skills + Subagents + Plugins |
| **보안 감사** | Subagents + Skills + Hooks (읽기 전용 모드) |
| **DevOps 파이프라인** | Plugins + MCP + Hooks + 백그라운드 태스크 |
| **대규모 리팩토링** | Checkpoints + Planning 모드 + Hooks |

---

## FAQ

**무료인가요?**
네. MIT 라이선스로 영구 무료입니다. 개인 프로젝트, 업무, 팀 어디서든 사용 가능하며 라이선스 고지만 포함하면 됩니다.

**계속 업데이트되나요?**
활발히 유지보수 중입니다. Claude Code 릴리스마다 동기화됩니다. 현재 버전: v2.2.0 (2026년 3월), Claude Code 2.1+와 호환됩니다.

**공식 문서와 무엇이 다른가요?**
공식 문서는 기능 레퍼런스입니다. 이 가이드는 다이어그램, 프로덕션 수준 템플릿, 점진적 학습 경로가 있는 튜토리얼입니다. 서로 보완 관계입니다 — 배울 때는 이 가이드를 먼저, 세부 사항이 필요할 때는 공식 문서를 참조하세요.

**전체를 다 보는 데 얼마나 걸리나요?**
전체 경로를 완주하면 11~13시간입니다. 하지만 15분 안에 즉각적인 가치를 얻을 수 있습니다 — slash command 템플릿 하나를 복사해서 바로 사용해보세요.

**Claude Sonnet / Haiku / Opus에서도 사용할 수 있나요?**
네. 모든 템플릿은 Claude Sonnet 4.6, Claude Opus 4.6, Claude Haiku 4.5에서 동작합니다.

**기여할 수 있나요?**
물론입니다. 자세한 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요. 새로운 예제, 버그 수정, 문서 개선, 커뮤니티 템플릿을 환영합니다.

**오프라인에서 읽을 수 있나요?**
네. `uv run scripts/build_epub.py`를 실행하면 모든 내용과 렌더링된 Mermaid 다이어그램이 포함된 EPUB 전자책을 생성할 수 있습니다.

---

## 오늘부터 Claude Code 마스터하기

Claude Code는 이미 설치되어 있습니다. 10배 생산성과 나 사이에 남은 것은 올바르게 사용하는 방법을 아는 것뿐입니다. 이 가이드는 그 길을 위한 체계적인 경로, 시각적 설명, 그리고 바로 붙여넣을 수 있는 템플릿을 제공합니다.

MIT 라이선스. 영구 무료. 클론하고, 포크하고, 나만의 것으로 만드세요.

**[학습 경로 시작하기 ->](LEARNING-ROADMAP.md)** | **[기능 카탈로그 보기](CATALOG.md)** | **[15분 만에 시작하기](#-15분-만에-시작하기)**

---

<details>
<summary>빠른 탐색 — 전체 기능</summary>

| 기능 | 설명 | 폴더 |
|---------|-------------|--------|
| **기능 카탈로그** | 설치 명령어가 포함된 완전한 레퍼런스 | [CATALOG.md](CATALOG.md) |
| **Slash Commands** | 사용자가 직접 호출하는 단축 명령어 | [01-slash-commands/](01-slash-commands/) |
| **Memory** | 세션 간 지속되는 컨텍스트 | [02-memory/](02-memory/) |
| **Skills** | 재사용 가능한 기능 | [03-skills/](03-skills/) |
| **Subagents** | 특화된 AI 보조 에이전트 | [04-subagents/](04-subagents/) |
| **MCP 프로토콜** | 외부 도구 접근 | [05-mcp/](05-mcp/) |
| **Hooks** | 이벤트 기반 자동화 | [06-hooks/](06-hooks/) |
| **Plugins** | 번들된 기능 모음 | [07-plugins/](07-plugins/) |
| **Checkpoints** | 세션 스냅샷 및 되감기 | [08-checkpoints/](08-checkpoints/) |
| **고급 기능** | 계획, 사고, 백그라운드 태스크 | [09-advanced-features/](09-advanced-features/) |
| **CLI 레퍼런스** | 명령어, 플래그, 옵션 | [10-cli/](10-cli/) |
| **블로그 포스트** | 실제 사용 예시 | [블로그 포스트](https://medium.com/@luongnv89) |

</details>

<details>
<summary>기능 비교</summary>

| 기능 | 호출 방식 | 지속성 | 적합한 용도 |
|---------|-----------|------------|----------|
| **Slash Commands** | 수동 (`/cmd`) | 세션 한정 | 빠른 단축 작업 |
| **Memory** | 자동 로드 | 세션 간 유지 | 장기 학습 및 기준 |
| **Skills** | 자동 호출 | 파일시스템 | 자동화 워크플로 |
| **Subagents** | 자동 위임 | 격리된 컨텍스트 | 작업 분배 |
| **MCP 프로토콜** | 자동 조회 | 실시간 | 라이브 데이터 접근 |
| **Hooks** | 이벤트 트리거 | 설정 기반 | 자동화 및 유효성 검사 |
| **Plugins** | 명령어 하나로 | 모든 기능 포함 | 완전한 솔루션 |
| **Checkpoints** | 수동/자동 | 세션 기반 | 안전한 실험 |
| **Planning 모드** | 수동/자동 | 계획 단계 | 복잡한 구현 |
| **백그라운드 태스크** | 수동 | 태스크 기간 | 장시간 작업 |
| **CLI 레퍼런스** | 터미널 명령어 | 세션/스크립트 | 자동화 및 스크립팅 |

</details>

<details>
<summary>설치 빠른 레퍼런스</summary>

```bash
# Slash Commands
cp 01-slash-commands/*.md .claude/commands/

# Memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skills
cp -r 03-skills/code-review ~/.claude/skills/

# Subagents
cp 04-subagents/*.md .claude/agents/

# MCP
export GITHUB_TOKEN="token"
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# Hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Plugins
/plugin install pr-review

# Checkpoints (자동 활성화, settings에서 설정)
# 08-checkpoints/README.md 참고

# 고급 기능 (settings에서 설정)
# 09-advanced-features/config-examples.json 참고

# CLI 레퍼런스 (별도 설치 불필요)
# 사용 예시는 10-cli/README.md 참고
```

</details>

<details>
<summary>01. Slash Commands</summary>

**위치**: [01-slash-commands/](01-slash-commands/)

**설명**: 마크다운 파일로 저장된 사용자 호출형 단축 명령어

**예제**:
- `optimize.md` - 코드 최적화 분석
- `pr.md` - Pull request 준비
- `generate-api-docs.md` - API 문서 생성기

**설치**:
```bash
cp 01-slash-commands/*.md /path/to/project/.claude/commands/
```

**사용법**:
```
/optimize
/pr
/generate-api-docs
```

**더 알아보기**: [Discovering Claude Code Slash Commands](https://medium.com/@luongnv89/discovering-claude-code-slash-commands-cdc17f0dfb29)

</details>

<details>
<summary>02. Memory</summary>

**위치**: [02-memory/](02-memory/)

**설명**: 세션 간 지속되는 컨텍스트

**예제**:
- `project-CLAUDE.md` - 팀 전체 프로젝트 표준
- `directory-api-CLAUDE.md` - 디렉터리별 규칙
- `personal-CLAUDE.md` - 개인 설정

**설치**:
```bash
# 프로젝트 메모리
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# 디렉터리 메모리
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# 개인 메모리
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**사용법**: Claude가 자동으로 로드

</details>

<details>
<summary>03. Skills</summary>

**위치**: [03-skills/](03-skills/)

**설명**: 지시와 스크립트를 포함한 재사용 가능한 자동 호출 기능

**예제**:
- `code-review/` - 스크립트가 포함된 종합 코드 리뷰
- `brand-voice/` - 브랜드 보이스 일관성 검사기
- `doc-generator/` - API 문서 생성기

**설치**:
```bash
# 개인 skills
cp -r 03-skills/code-review ~/.claude/skills/

# 프로젝트 skills
cp -r 03-skills/code-review /path/to/project/.claude/skills/
```

**사용법**: 관련 상황에서 자동으로 호출됨

</details>

<details>
<summary>04. Subagents</summary>

**위치**: [04-subagents/](04-subagents/)

**설명**: 격리된 컨텍스트와 커스텀 프롬프트를 가진 특화된 AI 보조 에이전트

**예제**:
- `code-reviewer.md` - 종합 코드 품질 분석
- `test-engineer.md` - 테스트 전략 및 커버리지
- `documentation-writer.md` - 기술 문서 작성
- `secure-reviewer.md` - 보안 중심 리뷰 (읽기 전용)
- `implementation-agent.md` - 전체 기능 구현

**설치**:
```bash
cp 04-subagents/*.md /path/to/project/.claude/agents/
```

**사용법**: 메인 에이전트가 자동으로 위임

</details>

<details>
<summary>05. MCP 프로토콜</summary>

**위치**: [05-mcp/](05-mcp/)

**설명**: 외부 도구 및 API에 접근하기 위한 Model Context Protocol

**예제**:
- `github-mcp.json` - GitHub 연동
- `database-mcp.json` - 데이터베이스 조회
- `filesystem-mcp.json` - 파일 작업
- `multi-mcp.json` - 복수 MCP 서버

**설치**:
```bash
# 환경 변수 설정
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# CLI로 MCP 서버 추가
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 또는 프로젝트 .mcp.json에 직접 추가 (예시는 05-mcp/ 참고)
```

**사용법**: 설정 후 Claude가 MCP 도구를 자동으로 사용 가능

</details>

<details>
<summary>06. Hooks</summary>

**위치**: [06-hooks/](06-hooks/)

**설명**: Claude Code 이벤트에 자동으로 반응하는 이벤트 기반 쉘 명령어

**예제**:
- `format-code.sh` - 파일 저장 전 코드 자동 포맷
- `pre-commit.sh` - 커밋 전 테스트 실행
- `security-scan.sh` - 보안 이슈 스캔
- `log-bash.sh` - 모든 bash 명령어 로깅
- `validate-prompt.sh` - 사용자 프롬프트 유효성 검사
- `notify-team.sh` - 이벤트 발생 시 팀에 알림 전송

**설치**:
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

`~/.claude/settings.json`에서 hooks 설정:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/format-code.sh"]
    }],
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/security-scan.sh"]
    }]
  }
}
```

**사용법**: 이벤트 발생 시 자동 실행

**Hook 유형** (4가지 유형, 25가지 이벤트):
- **도구 Hooks**: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`
- **세션 Hooks**: `SessionStart`, `SessionEnd`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`
- **태스크 Hooks**: `UserPromptSubmit`, `TaskCompleted`, `TaskCreated`, `TeammateIdle`
- **라이프사이클 Hooks**: `ConfigChange`, `CwdChanged`, `FileChanged`, `PreCompact`, `PostCompact`, `WorktreeCreate`, `WorktreeRemove`, `Notification`, `InstructionsLoaded`, `Elicitation`, `ElicitationResult`

</details>

<details>
<summary>07. Plugins</summary>

**위치**: [07-plugins/](07-plugins/)

**설명**: 명령어, 에이전트, MCP, hooks가 함께 묶인 번들 모음

**예제**:
- `pr-review/` - 완전한 PR 리뷰 워크플로
- `devops-automation/` - 배포 및 모니터링
- `documentation/` - 문서 자동 생성

**설치**:
```bash
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

**사용법**: 번들된 slash commands 및 기능 사용

</details>

<details>
<summary>08. Checkpoints와 되감기</summary>

**위치**: [08-checkpoints/](08-checkpoints/)

**설명**: 대화 상태를 저장하고 이전 시점으로 되감아 다른 접근 방식을 탐색

**핵심 개념**:
- **Checkpoint**: 대화 상태의 스냅샷
- **Rewind**: 이전 checkpoint로 돌아가기
- **분기점**: 같은 checkpoint에서 여러 접근 방식 탐색

**사용법**:
```
# 모든 사용자 프롬프트마다 자동으로 checkpoint 생성
# 되감으려면 Esc를 두 번 누르거나 다음을 사용:
/rewind

# 이후 다섯 가지 옵션 중 선택:
# 1. 코드와 대화 모두 복원
# 2. 대화만 복원
# 3. 코드만 복원
# 4. 여기서부터 요약
# 5. 취소
```

**활용 사례**:
- 다양한 구현 방식 시도
- 실수 복구
- 안전한 실험
- 대안 솔루션 비교
- 다양한 설계안 A/B 테스트

</details>

<details>
<summary>09. 고급 기능</summary>

**위치**: [09-advanced-features/](09-advanced-features/)

**설명**: 복잡한 워크플로와 자동화를 위한 고급 기능

**포함 내용**:
- **Planning 모드** — 코딩 전 상세한 구현 계획 수립
- **Extended Thinking** — 복잡한 문제를 위한 심층 추론 (`Alt+T` / `Option+T`로 전환)
- **백그라운드 태스크** — 블로킹 없이 장시간 작업 실행
- **권한 모드** — `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`
- **Headless 모드** — CI/CD에서 Claude Code 실행: `claude -p "테스트 실행 후 리포트 생성"`
- **세션 관리** — `/resume`, `/rename`, `/fork`, `claude -c`, `claude -r`
- **설정** — `~/.claude/settings.json`에서 동작 커스터마이즈

완전한 설정 예시는 [config-examples.json](09-advanced-features/config-examples.json)을 참고하세요.

</details>

<details>
<summary>10. CLI 레퍼런스</summary>

**위치**: [10-cli/](10-cli/)

**설명**: Claude Code의 완전한 커맨드라인 인터페이스 레퍼런스

**빠른 예제**:
```bash
# 인터랙티브 모드
claude "이 프로젝트를 설명해줘"

# 출력 모드 (비인터랙티브)
claude -p "이 코드를 리뷰해줘"

# 파일 내용 처리
cat error.log | claude -p "이 에러를 설명해줘"

# 스크립트용 JSON 출력
claude -p --output-format json "함수 목록 출력"

# 세션 재개
claude -r "feature-auth" "구현 계속하기"
```

**활용 사례**: CI/CD 파이프라인 통합, 스크립트 자동화, 일괄 처리, 멀티 세션 워크플로, 커스텀 에이전트 설정

</details>

<details>
<summary>예제 워크플로</summary>

### 완전한 코드 리뷰 워크플로

```markdown
# 사용 기능: Slash Commands + Subagents + Memory + MCP

사용자: /review-pr

Claude:
1. 프로젝트 메모리 로드 (코딩 표준)
2. GitHub MCP로 PR 가져오기
3. code-reviewer subagent에 위임
4. test-engineer subagent에 위임
5. 결과 종합
6. 종합 리뷰 제공
```

### 자동화된 문서 생성

```markdown
# 사용 기능: Skills + Subagents + Memory

사용자: "auth 모듈의 API 문서를 생성해줘"

Claude:
1. 프로젝트 메모리 로드 (문서 표준)
2. 문서 생성 요청 감지
3. doc-generator skill 자동 호출
4. api-documenter subagent에 위임
5. 예제가 포함된 종합 문서 생성
```

### DevOps 배포

```markdown
# 사용 기능: Plugins + MCP + Hooks

사용자: /deploy production

Claude:
1. pre-deploy hook 실행 (환경 유효성 검사)
2. deployment-specialist subagent에 위임
3. Kubernetes MCP로 배포 실행
4. 진행 상황 모니터링
5. post-deploy hook 실행 (헬스 체크)
6. 상태 보고
```

</details>

<details>
<summary>디렉터리 구조</summary>

```
├── 01-slash-commands/
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   └── README.md
├── 02-memory/
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   └── README.md
├── 03-skills/
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   └── templates/
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   └── templates/
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   └── README.md
├── 04-subagents/
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   └── README.md
├── 05-mcp/
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
├── 06-hooks/
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   └── README.md
├── 07-plugins/
│   ├── pr-review/
│   ├── devops-automation/
│   ├── documentation/
│   └── README.md
├── 08-checkpoints/
│   ├── checkpoint-examples.md
│   └── README.md
├── 09-advanced-features/
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
├── 10-cli/
│   └── README.md
└── README.md (이 파일)
```

</details>

<details>
<summary>모범 사례</summary>

### 해야 할 것
- slash commands로 간단하게 시작하기
- 기능을 점진적으로 추가하기
- 팀 표준에는 memory 활용하기
- 설정을 로컬에서 먼저 테스트하기
- 커스텀 구현 문서화하기
- 프로젝트 설정을 버전 관리하기
- 팀과 plugins 공유하기

### 하지 말아야 할 것
- 중복 기능 만들지 않기
- 인증 정보 하드코딩하지 않기
- 문서화 건너뛰지 않기
- 단순한 작업을 과도하게 복잡하게 만들지 않기
- 보안 모범 사례 무시하지 않기
- 민감한 데이터 커밋하지 않기

</details>

<details>
<summary>문제 해결</summary>

### 기능이 로드되지 않는 경우
1. 파일 위치와 이름 확인
2. YAML frontmatter 문법 검사
3. 파일 권한 확인
4. Claude Code 버전 호환성 검토

### MCP 연결 실패
1. 환경 변수 확인
2. MCP 서버 설치 상태 확인
3. 인증 정보 테스트
4. 네트워크 연결 확인

### Subagent가 위임받지 못하는 경우
1. 도구 권한 확인
2. 에이전트 설명의 명확성 검토
3. 태스크 복잡도 확인
4. 에이전트 독립 테스트

</details>

<details>
<summary>테스트</summary>

이 프로젝트는 포괄적인 자동화 테스트를 포함합니다:

- **단위 테스트**: pytest를 사용한 Python 테스트 (Python 3.10, 3.11, 3.12)
- **코드 품질**: Ruff로 린팅 및 포맷팅
- **보안**: Bandit으로 취약점 스캔
- **타입 검사**: mypy로 정적 타입 분석
- **빌드 검증**: EPUB 생성 테스트
- **커버리지 추적**: Codecov 연동

```bash
# 개발 의존성 설치
uv pip install -r requirements-dev.txt

# 모든 단위 테스트 실행
pytest scripts/tests/ -v

# 커버리지 리포트와 함께 테스트 실행
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 코드 품질 검사
ruff check scripts/
ruff format --check scripts/

# 보안 스캔
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# 타입 검사
mypy scripts/ --ignore-missing-imports
```

테스트는 `main`/`develop`으로의 모든 push와 `main`으로의 모든 PR에서 자동으로 실행됩니다. 자세한 내용은 [TESTING.md](.github/TESTING.md)를 참고하세요.

</details>

<details>
<summary>EPUB 생성</summary>

오프라인에서 가이드를 읽고 싶으신가요? EPUB 전자책을 생성하세요:

```bash
uv run scripts/build_epub.py
```

이 명령어는 모든 내용과 렌더링된 Mermaid 다이어그램이 포함된 `claude-howto-guide.epub`을 생성합니다.

더 많은 옵션은 [scripts/README.md](scripts/README.md)를 참고하세요.

</details>

<details>
<summary>기여하기</summary>

문제를 발견했거나 예제를 기여하고 싶으신가요? 여러분의 도움을 환영합니다!

**자세한 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요:**
- 기여 유형 (예제, 문서, 기능, 버그, 피드백)
- 개발 환경 설정 방법
- 디렉터리 구조 및 콘텐츠 추가 방법
- 작성 가이드라인 및 모범 사례
- 커밋 및 PR 프로세스

**커뮤니티 표준:**
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - 서로를 대하는 방식
- [SECURITY.md](SECURITY.md) - 보안 정책 및 취약점 신고

### 보안 문제 신고

보안 취약점을 발견했다면 책임감 있게 신고해주세요:

1. **GitHub 비공개 취약점 신고 사용**: https://github.com/luongnv89/claude-howto/security/advisories
2. **또는** [.github/SECURITY_REPORTING.md](.github/SECURITY_REPORTING.md)에서 자세한 안내 확인
3. **보안 취약점에 대해 공개 이슈를 열지 마세요**

빠른 시작:
1. 저장소를 포크하고 클론하기
2. 설명적인 브랜치 생성 (`add/feature-name`, `fix/bug`, `docs/improvement`)
3. 가이드라인에 따라 변경 사항 적용
4. 명확한 설명과 함께 pull request 제출

**도움이 필요하신가요?** 이슈나 토론을 열면 과정을 안내해드리겠습니다.

</details>

<details>
<summary>추가 리소스</summary>

- [Claude Code 공식 문서](https://code.claude.com/docs/en/overview)
- [MCP 프로토콜 명세](https://modelcontextprotocol.io)
- [Skills 저장소](https://github.com/luongnv89/skills) - 바로 사용 가능한 skills 모음
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Boris Cherny의 Claude Code 워크플로](https://x.com/bcherny/status/2007179832300581177) - Claude Code 창시자가 자신의 체계적인 워크플로를 공유: 병렬 에이전트, 공유 CLAUDE.md, Plan 모드, slash commands, subagents, 자율 장시간 세션을 위한 검증 hooks.

</details>

---

## 기여하기

기여를 환영합니다! 시작하는 방법에 대한 자세한 내용은 [기여 가이드](CONTRIBUTING.md)를 참고하세요.

## 기여자

이 프로젝트에 기여해주신 모든 분들께 감사드립니다!

| 기여자 | PR |
|-------------|-----|
| [wjhrdy](https://github.com/wjhrdy) | [#1 - epub 생성 도구 추가](https://github.com/luongnv89/claude-howto/pull/1) |
| [VikalpP](https://github.com/VikalpP) | [#7 - fix(docs): 개념 가이드의 중첩 코드 블록에 물결표 펜스 사용](https://github.com/luongnv89/claude-howto/pull/7) |

---

## 라이선스

MIT 라이선스 - [LICENSE](LICENSE) 참고. 자유롭게 사용, 수정, 배포할 수 있습니다. 라이선스 고지만 포함하면 됩니다.

---

**최종 업데이트**: 2026년 3월
**Claude Code 버전**: 2.1+
**호환 모델**: Claude Sonnet 4.6, Claude Opus 4.6, Claude Haiku 4.5
