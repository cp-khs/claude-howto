<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

<p align="center">
  <a href="https://github.com/trending">
    <img src="https://img.shields.io/badge/GitHub-🔥%20%231%20Trending-purple?style=for-the-badge&logo=github"/>
  </a>
</p>

[![GitHub Stars](https://img.shields.io/github/stars/luongnv89/claude-howto?style=flat&color=gold)](https://github.com/luongnv89/claude-howto/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/luongnv89/claude-howto?style=flat)](https://github.com/luongnv89/claude-howto/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.2.0-brightgreen)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1+-purple)](https://code.claude.com)

# 주말 만에 Claude Code 마스터하기

`claude`를 입력하는 것에서 시작해 에이전트, Hooks, Skills, MCP 서버를 자유자재로 다루기까지 — 시각적 튜토리얼, 바로 복사해 쓸 수 있는 템플릿, 그리고 체계적인 학습 경로로 안내합니다.

**[15분 만에 시작하기](#15분-만에-시작하기)** | **[나에게 맞는 레벨 찾기](#어디서부터-시작해야-할지-모르겠다면)** | **[기능 카탈로그 보기](CATALOG.md)**

---

## 목차

- [문제](#문제)
- [Claude How To가 해결하는 방법](#claude-how-to가-해결하는-방법)
- [동작 방식](#동작-방식)
- [어디서부터 시작해야 할지 모르겠다면?](#어디서부터-시작해야-할지-모르겠다면)
- [15분 만에 시작하기](#15분-만에-시작하기)
- [이것으로 무엇을 만들 수 있을까?](#이것으로-무엇을-만들-수-있을까)
- [FAQ](#faq)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

---

## 문제

Claude Code를 설치했습니다. 몇 가지 프롬프트를 입력해 봤습니다. 그 다음은?

- **공식 문서는 기능을 설명하지만, 기능을 조합하는 방법은 알려주지 않습니다.** Slash Commands가 있다는 건 알지만, 그것을 Hooks, 메모리, Subagents와 연결해 실질적인 시간을 절약하는 워크플로우로 만드는 방법은 모릅니다.
- **명확한 학습 경로가 없습니다.** MCP를 먼저 배워야 할까요, Hooks를 먼저 배워야 할까요? Skills 먼저인가요, Subagents 먼저인가요? 결국 모든 것을 훑어보다가 아무것도 제대로 익히지 못하게 됩니다.
- **예제가 너무 기본적입니다.** "Hello World" Slash Command 하나로는 메모리를 활용하고, 특화된 에이전트에게 위임하며, 보안 스캔을 자동으로 실행하는 프로덕션 수준의 코드 리뷰 파이프라인을 만들 수 없습니다.

Claude Code 잠재력의 90%를 활용하지 못하고 있으면서도, 무엇을 모르는지조차 모르는 상태입니다.

---

## Claude How To가 해결하는 방법

이것은 또 다른 기능 레퍼런스가 아닙니다. 오늘 당장 프로젝트에 복사해 쓸 수 있는 실제 템플릿과 함께, Claude Code의 모든 기능을 가르쳐 주는 **구조화된 시각적 예제 중심의 가이드**입니다.

| | 공식 문서 | 이 가이드 |
|--|---------------|------------|
| **형식** | 레퍼런스 문서 | Mermaid 다이어그램이 포함된 시각적 튜토리얼 |
| **깊이** | 기능 설명 | 내부 동작 원리 |
| **예제** | 기본 코드 조각 | 즉시 사용 가능한 프로덕션 수준 템플릿 |
| **구조** | 기능별 구성 | 점진적 학습 경로 (초급 → 고급) |
| **온보딩** | 자기 주도 | 예상 시간이 포함된 가이드 로드맵 |
| **자가 평가** | 없음 | 부족한 부분을 찾아 개인 맞춤 경로를 만드는 인터랙티브 퀴즈 |

### 무엇을 얻게 되나요:

- **10개의 튜토리얼 모듈** — Slash Commands부터 커스텀 에이전트 팀까지 Claude Code의 모든 기능 포함
- **바로 붙여 쓸 수 있는 설정** — Slash Commands, CLAUDE.md 템플릿, Hook 스크립트, MCP 설정, Subagent 정의, 전체 Plugin 번들
- **Mermaid 다이어그램** — 각 기능이 내부에서 어떻게 작동하는지 시각적으로 보여줘서 *왜* 그런지를 이해할 수 있게 합니다
- **체계적인 학습 경로** — 11~13시간으로 초급자를 파워 유저로 만들어 주는 로드맵
- **내장 자가 평가** — Claude Code에서 `/self-assessment` 또는 `/lesson-quiz hooks`를 직접 실행해 부족한 부분을 파악하세요

**[학습 경로 시작하기 ->](LEARNING-ROADMAP.md)**

---

## 동작 방식

### 1. 나의 레벨 파악하기

[자가 평가 퀴즈](LEARNING-ROADMAP.md#-find-your-level)를 받거나 Claude Code에서 `/self-assessment`를 실행하세요. 이미 알고 있는 내용을 바탕으로 개인 맞춤 로드맵을 받을 수 있습니다.

### 2. 가이드 경로 따라가기

10개의 모듈을 순서대로 학습하세요 — 각 모듈은 이전 모듈을 기반으로 구성됩니다. 학습하면서 바로 프로젝트에 템플릿을 복사해 사용하세요.

### 3. 기능들을 워크플로우로 조합하기

진짜 힘은 기능을 조합하는 데서 나옵니다. Slash Commands + 메모리 + Subagents + Hooks를 연결해 코드 리뷰, 배포, 문서 생성을 자동으로 처리하는 파이프라인을 만드는 방법을 배우세요.

### 4. 이해도 확인하기

각 모듈이 끝나면 `/lesson-quiz [topic]`을 실행하세요. 퀴즈가 놓친 부분을 정확히 짚어줘서 빠르게 보완할 수 있습니다.

**[15분 만에 시작하기](#15분-만에-시작하기)**

---

## 5,900명 이상의 개발자가 신뢰합니다

- **5,900개 이상의 GitHub 스타** — Claude Code를 매일 사용하는 개발자들의 선택
- **690개 이상의 포크** — 자신의 워크플로우에 맞게 이 가이드를 응용하는 팀들
- **활발한 유지 관리** — 모든 Claude Code 릴리스와 동기화 (최신 버전: v2.2.0, 2026년 3월)
- **커뮤니티 기반** — 실제 설정을 공유하는 개발자들의 기여로 구성

[![Star History Chart](https://api.star-history.com/svg?repos=luongnv89/claude-howto&type=Date)](https://star-history.com/#luongnv89/claude-howto&Date)

---

## 어디서부터 시작해야 할지 모르겠다면?

자가 평가를 받거나 레벨을 선택하세요:

| 레벨 | 현재 할 수 있는 것 | 시작 위치 | 시간 |
|-------|-----------|------------|------|
| **초급** | Claude Code 실행 및 채팅 | [Slash Commands](01-slash-commands/) | 약 2.5시간 |
| **중급** | CLAUDE.md 및 커스텀 명령어 사용 | [Skills](03-skills/) | 약 3.5시간 |
| **고급** | MCP 서버 및 Hooks 설정 | [Advanced Features](09-advanced-features/) | 약 5시간 |

**10개 모듈의 전체 학습 경로:**

| 순서 | 모듈 | 레벨 | 시간 |
|-------|--------|-------|------|
| 1 | [Slash Commands](01-slash-commands/) | 초급 | 30분 |
| 2 | [Memory](02-memory/) | 초급+ | 45분 |
| 3 | [Checkpoints](08-checkpoints/) | 중급 | 45분 |
| 4 | [CLI Basics](10-cli/) | 초급+ | 30분 |
| 5 | [Skills](03-skills/) | 중급 | 1시간 |
| 6 | [Hooks](06-hooks/) | 중급 | 1시간 |
| 7 | [MCP](05-mcp/) | 중급+ | 1시간 |
| 8 | [Subagents](04-subagents/) | 중급+ | 1.5시간 |
| 9 | [Advanced Features](09-advanced-features/) | 고급 | 2~3시간 |
| 10 | [Plugins](07-plugins/) | 고급 | 2시간 |

**[전체 학습 로드맵 ->](LEARNING-ROADMAP.md)**

---

## 15분 만에 시작하기

```bash
# 1. 가이드 클론
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# 2. 첫 번째 Slash Command 복사
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. 실행해 보기 — Claude Code에서 입력:
# /optimize

# 4. 더 알고 싶다면? 프로젝트 메모리 설정:
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. Skill 설치:
cp -r 03-skills/code-review ~/.claude/skills/
```

전체 설정이 필요하다면? **1시간 핵심 설정**입니다:

```bash
# Slash Commands (15분)
cp 01-slash-commands/*.md .claude/commands/

# 프로젝트 메모리 (15분)
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skill 설치 (15분)
cp -r 03-skills/code-review ~/.claude/skills/

# 주말 목표: Hooks, Subagents, MCP, Plugins 추가
# 가이드 경로를 따라 단계별로 설정하세요
```

**[전체 설치 레퍼런스 보기](#15분-만에-시작하기)**

---

## 이것으로 무엇을 만들 수 있을까?

| 활용 사례 | 조합할 기능 |
|----------|------------------------|
| **자동화된 코드 리뷰** | Slash Commands + Subagents + Memory + MCP |
| **팀 온보딩** | Memory + Slash Commands + Plugins |
| **CI/CD 자동화** | CLI Reference + Hooks + 백그라운드 작업 |
| **문서 자동 생성** | Skills + Subagents + Plugins |
| **보안 감사** | Subagents + Skills + Hooks (읽기 전용 모드) |
| **DevOps 파이프라인** | Plugins + MCP + Hooks + 백그라운드 작업 |
| **복잡한 리팩토링** | Checkpoints + Planning Mode + Hooks |

---

## FAQ

**무료인가요?**
네. MIT 라이선스로, 영구 무료입니다. 개인 프로젝트, 업무, 팀 내에서 자유롭게 사용하세요 — 라이선스 고지 포함 외에 별도 제한이 없습니다.

**유지 관리가 되고 있나요?**
적극적으로 유지됩니다. 모든 Claude Code 릴리스와 동기화됩니다. 현재 버전: v2.2.0 (2026년 3월), Claude Code 2.1+와 호환됩니다.

**공식 문서와 무엇이 다른가요?**
공식 문서는 기능 레퍼런스입니다. 이 가이드는 다이어그램, 프로덕션 수준 템플릿, 점진적 학습 경로가 포함된 튜토리얼입니다. 서로 보완 관계입니다 — 먼저 이 가이드로 배우고, 세부 사항이 필요할 때 공식 문서를 참고하세요.

**전부 학습하는 데 얼마나 걸리나요?**
전체 경로는 11~13시간입니다. 하지만 15분 안에 바로 가치를 느낄 수 있습니다 — Slash Command 템플릿을 복사해서 바로 사용해 보세요.

**Claude Sonnet / Haiku / Opus와도 사용할 수 있나요?**
네. 모든 템플릿은 Claude Sonnet 4.6, Claude Opus 4.6, Claude Haiku 4.5에서 동작합니다.

**기여할 수 있나요?**
물론입니다. 시작 방법에 대한 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요. 새로운 예제, 버그 수정, 문서 개선, 커뮤니티 템플릿을 환영합니다.

**오프라인으로 읽을 수 있나요?**
네. `uv run scripts/build_epub.py`를 실행하면 모든 콘텐츠와 렌더링된 다이어그램이 포함된 EPUB 전자책을 생성할 수 있습니다.

---

## 지금 바로 Claude Code 마스터하기

Claude Code는 이미 설치되어 있습니다. 10배의 생산성과 여러분 사이에 있는 것은 오직 사용 방법을 아는 것뿐입니다. 이 가이드는 체계적인 경로, 시각적 설명, 그리고 바로 복사해 쓸 수 있는 템플릿을 제공합니다.

MIT 라이선스. 영구 무료. 클론하고, 포크하고, 여러분의 것으로 만드세요.

**[학습 경로 시작하기 ->](LEARNING-ROADMAP.md)** | **[기능 카탈로그 보기](CATALOG.md)** | **[15분 만에 시작하기](#15분-만에-시작하기)**

---

<details>
<summary>빠른 탐색 — 전체 기능</summary>

| 기능 | 설명 | 폴더 |
|---------|-------------|--------|
| **기능 카탈로그** | 설치 명령어가 포함된 전체 레퍼런스 | [CATALOG.md](CATALOG.md) |
| **Slash Commands** | 사용자가 직접 호출하는 단축키 | [01-slash-commands/](01-slash-commands/) |
| **Memory** | 세션 간 지속되는 컨텍스트 | [02-memory/](02-memory/) |
| **Skills** | 재사용 가능한 기능 | [03-skills/](03-skills/) |
| **Subagents** | 특화된 AI 어시스턴트 | [04-subagents/](04-subagents/) |
| **MCP Protocol** | 외부 도구 접근 | [05-mcp/](05-mcp/) |
| **Hooks** | 이벤트 기반 자동화 | [06-hooks/](06-hooks/) |
| **Plugins** | 묶음 기능 패키지 | [07-plugins/](07-plugins/) |
| **Checkpoints** | 세션 스냅샷 및 되감기 | [08-checkpoints/](08-checkpoints/) |
| **Advanced Features** | Planning, Thinking, 백그라운드 작업 | [09-advanced-features/](09-advanced-features/) |
| **CLI Reference** | 명령어, 플래그, 옵션 | [10-cli/](10-cli/) |
| **블로그 포스트** | 실제 사용 사례 | [Blog Posts](https://medium.com/@luongnv89) |

</details>

<details>
<summary>기능 비교</summary>

| 기능 | 호출 방식 | 지속성 | 적합한 용도 |
|---------|-----------|------------|----------|
| **Slash Commands** | 수동 (`/cmd`) | 세션 내 | 빠른 단축키 |
| **Memory** | 자동 로드 | 세션 간 | 장기 학습 |
| **Skills** | 자동 호출 | 파일시스템 | 자동화 워크플로우 |
| **Subagents** | 자동 위임 | 독립 컨텍스트 | 작업 분산 |
| **MCP Protocol** | 자동 조회 | 실시간 | 실시간 데이터 접근 |
| **Hooks** | 이벤트 트리거 | 설정 기반 | 자동화 및 검증 |
| **Plugins** | 명령어 한 번 | 전체 기능 | 완전한 솔루션 |
| **Checkpoints** | 수동/자동 | 세션 기반 | 안전한 실험 |
| **Planning Mode** | 수동/자동 | 계획 단계 | 복잡한 구현 |
| **Background Tasks** | 수동 | 작업 기간 | 장시간 작업 |
| **CLI Reference** | 터미널 명령어 | 세션/스크립트 | 자동화 및 스크립팅 |

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

# Checkpoints (자동 활성화됨, settings에서 설정)
# 08-checkpoints/README.md 참고

# Advanced Features (settings에서 설정)
# 09-advanced-features/config-examples.json 참고

# CLI Reference (설치 불필요)
# 사용 예제는 10-cli/README.md 참고
```

</details>

<details>
<summary>01. Slash Commands</summary>

**위치**: [01-slash-commands/](01-slash-commands/)

**설명**: Markdown 파일로 저장되는 사용자 호출 단축키

**예제**:
- `optimize.md` - 코드 최적화 분석
- `pr.md` - Pull Request 준비
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
- `directory-api-CLAUDE.md` - 디렉토리 특화 규칙
- `personal-CLAUDE.md` - 개인 설정

**설치**:
```bash
# 프로젝트 메모리
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# 디렉토리 메모리
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# 개인 메모리
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**사용법**: Claude가 자동으로 로드합니다

</details>

<details>
<summary>03. Skills</summary>

**위치**: [03-skills/](03-skills/)

**설명**: 지시사항과 스크립트가 포함된 재사용 가능한 자동 호출 기능

**예제**:
- `code-review/` - 스크립트가 포함된 종합 코드 리뷰
- `brand-voice/` - 브랜드 보이스 일관성 검사기
- `doc-generator/` - API 문서 생성기

**설치**:
```bash
# 개인 Skills
cp -r 03-skills/code-review ~/.claude/skills/

# 프로젝트 Skills
cp -r 03-skills/code-review /path/to/project/.claude/skills/
```

**사용법**: 관련 상황에서 자동으로 호출됩니다

</details>

<details>
<summary>04. Subagents</summary>

**위치**: [04-subagents/](04-subagents/)

**설명**: 독립된 컨텍스트와 커스텀 프롬프트를 가진 특화된 AI 어시스턴트

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

**사용법**: 메인 에이전트가 자동으로 위임합니다

</details>

<details>
<summary>05. MCP Protocol</summary>

**위치**: [05-mcp/](05-mcp/)

**설명**: 외부 도구 및 API에 접근하기 위한 Model Context Protocol

**예제**:
- `github-mcp.json` - GitHub 연동
- `database-mcp.json` - 데이터베이스 조회
- `filesystem-mcp.json` - 파일 작업
- `multi-mcp.json` - 다중 MCP 서버

**설치**:
```bash
# 환경 변수 설정
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# CLI로 MCP 서버 추가
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 또는 프로젝트 .mcp.json에 직접 추가 (예제는 05-mcp/ 참고)
```

**사용법**: 설정 후 MCP 도구는 Claude에서 자동으로 사용 가능합니다

</details>

<details>
<summary>06. Hooks</summary>

**위치**: [06-hooks/](06-hooks/)

**설명**: Claude Code 이벤트에 반응해 자동으로 실행되는 이벤트 기반 셸 명령어

**예제**:
- `format-code.sh` - 파일 작성 전 코드 자동 포맷
- `pre-commit.sh` - 커밋 전 테스트 실행
- `security-scan.sh` - 보안 이슈 스캔
- `log-bash.sh` - bash 명령어 로깅
- `validate-prompt.sh` - 사용자 프롬프트 검증
- `notify-team.sh` - 이벤트 발생 시 팀 알림

**설치**:
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

`~/.claude/settings.json`에서 Hooks 설정:
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

**사용법**: Hooks는 이벤트 발생 시 자동으로 실행됩니다

**Hook 유형** (4가지 유형, 25개 이벤트):
- **도구 Hooks**: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`
- **세션 Hooks**: `SessionStart`, `SessionEnd`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`
- **작업 Hooks**: `UserPromptSubmit`, `TaskCompleted`, `TaskCreated`, `TeammateIdle`
- **생명주기 Hooks**: `ConfigChange`, `CwdChanged`, `FileChanged`, `PreCompact`, `PostCompact`, `WorktreeCreate`, `WorktreeRemove`, `Notification`, `InstructionsLoaded`, `Elicitation`, `ElicitationResult`

</details>

<details>
<summary>07. Plugins</summary>

**위치**: [07-plugins/](07-plugins/)

**설명**: 명령어, 에이전트, MCP, Hooks가 묶인 번들 모음

**예제**:
- `pr-review/` - 완전한 PR 리뷰 워크플로우
- `devops-automation/` - 배포 및 모니터링
- `documentation/` - 문서 생성

**설치**:
```bash
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

**사용법**: 번들된 Slash Commands와 기능을 사용합니다

</details>

<details>
<summary>08. Checkpoints와 되감기</summary>

**위치**: [08-checkpoints/](08-checkpoints/)

**설명**: 대화 상태를 저장하고 이전 지점으로 되감아 다른 접근 방식을 탐색합니다

**핵심 개념**:
- **Checkpoint**: 대화 상태의 스냅샷
- **Rewind**: 이전 Checkpoint로 돌아가기
- **Branch Point**: 같은 Checkpoint에서 여러 접근 방식 탐색

**사용법**:
```
# Checkpoint는 모든 사용자 프롬프트마다 자동으로 생성됩니다
# 되감기: Esc를 두 번 누르거나 아래 명령어 사용:
/rewind

# 다섯 가지 옵션 중 선택:
# 1. 코드와 대화 복원
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
- 다른 디자인의 A/B 테스트

</details>

<details>
<summary>09. Advanced Features</summary>

**위치**: [09-advanced-features/](09-advanced-features/)

**설명**: 복잡한 워크플로우와 자동화를 위한 고급 기능

**포함 내용**:
- **Planning Mode** — 코딩 전 상세한 구현 계획 수립
- **Extended Thinking** — 복잡한 문제를 위한 깊은 추론 (`Alt+T` / `Option+T`로 토글)
- **Background Tasks** — 차단 없이 장시간 작업 실행
- **Permission Modes** — `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`
- **Headless Mode** — CI/CD에서 Claude Code 실행: `claude -p "테스트 실행 후 리포트 생성"`
- **세션 관리** — `/resume`, `/rename`, `/fork`, `claude -c`, `claude -r`
- **설정** — `~/.claude/settings.json`에서 동작 방식 커스터마이즈

전체 설정 예제는 [config-examples.json](09-advanced-features/config-examples.json)을 참고하세요.

</details>

<details>
<summary>10. CLI Reference</summary>

**위치**: [10-cli/](10-cli/)

**설명**: Claude Code를 위한 완전한 커맨드라인 인터페이스 레퍼런스

**빠른 예제**:
```bash
# 인터랙티브 모드
claude "이 프로젝트를 설명해줘"

# 출력 모드 (비대화형)
claude -p "이 코드를 리뷰해줘"

# 파일 내용 처리
cat error.log | claude -p "이 에러를 설명해줘"

# 스크립트용 JSON 출력
claude -p --output-format json "함수 목록을 나열해줘"

# 세션 재개
claude -r "feature-auth" "구현 계속해줘"
```

**활용 사례**: CI/CD 파이프라인 연동, 스크립트 자동화, 배치 처리, 다중 세션 워크플로우, 커스텀 에이전트 설정

</details>

<details>
<summary>예제 워크플로우</summary>

### 완전한 코드 리뷰 워크플로우

```markdown
# 사용 기능: Slash Commands + Subagents + Memory + MCP

사용자: /review-pr

Claude:
1. 프로젝트 메모리 로드 (코딩 표준)
2. GitHub MCP로 PR 가져오기
3. code-reviewer Subagent에 위임
4. test-engineer Subagent에 위임
5. 결과 종합
6. 종합적인 리뷰 제공
```

### 자동화된 문서 생성

```markdown
# 사용 기능: Skills + Subagents + Memory

사용자: "auth 모듈의 API 문서를 생성해줘"

Claude:
1. 프로젝트 메모리 로드 (문서 표준)
2. 문서 생성 요청 감지
3. doc-generator Skill 자동 호출
4. api-documenter Subagent에 위임
5. 예제가 포함된 종합 문서 생성
```

### DevOps 배포

```markdown
# 사용 기능: Plugins + MCP + Hooks

사용자: /deploy production

Claude:
1. 사전 배포 Hook 실행 (환경 검증)
2. deployment-specialist Subagent에 위임
3. Kubernetes MCP로 배포 실행
4. 진행 상황 모니터링
5. 사후 배포 Hook 실행 (상태 확인)
6. 상태 보고
```

</details>

<details>
<summary>디렉토리 구조</summary>

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

### 권장 사항
- Slash Commands로 간단하게 시작하세요
- 기능을 점진적으로 추가하세요
- 팀 표준에는 Memory를 사용하세요
- 로컬에서 먼저 설정을 테스트하세요
- 커스텀 구현을 문서화하세요
- 프로젝트 설정은 버전 관리하세요
- 팀과 Plugins를 공유하세요

### 주의 사항
- 중복된 기능을 만들지 마세요
- 자격 증명을 하드코딩하지 마세요
- 문서화를 생략하지 마세요
- 간단한 작업을 지나치게 복잡하게 만들지 마세요
- 보안 모범 사례를 무시하지 마세요
- 민감한 데이터를 커밋하지 마세요

</details>

<details>
<summary>문제 해결</summary>

### 기능이 로드되지 않는 경우
1. 파일 위치와 이름 확인
2. YAML frontmatter 문법 확인
3. 파일 권한 확인
4. Claude Code 버전 호환성 확인

### MCP 연결 실패
1. 환경 변수 확인
2. MCP 서버 설치 확인
3. 자격 증명 테스트
4. 네트워크 연결 확인

### Subagent가 위임하지 않는 경우
1. 도구 권한 확인
2. 에이전트 설명의 명확성 확인
3. 작업 복잡도 검토
4. 에이전트 독립 테스트

</details>

<details>
<summary>테스트</summary>

이 프로젝트는 포괄적인 자동화 테스트를 포함합니다:

- **단위 테스트**: pytest를 사용하는 Python 테스트 (Python 3.10, 3.11, 3.12)
- **코드 품질**: Ruff를 사용한 린팅 및 포맷팅
- **보안**: Bandit을 사용한 취약점 스캔
- **타입 검사**: mypy를 사용한 정적 타입 분석
- **빌드 검증**: EPUB 생성 테스트
- **커버리지 추적**: Codecov 연동

```bash
# 개발 의존성 설치
uv pip install -r requirements-dev.txt

# 모든 단위 테스트 실행
pytest scripts/tests/ -v

# 커버리지 리포트와 함께 테스트 실행
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 코드 품질 검사 실행
ruff check scripts/
ruff format --check scripts/

# 보안 스캔 실행
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# 타입 검사 실행
mypy scripts/ --ignore-missing-imports
```

테스트는 `main`/`develop` 브랜치에 푸시할 때마다, 그리고 `main`에 대한 모든 PR마다 자동으로 실행됩니다. 자세한 정보는 [TESTING.md](.github/TESTING.md)를 참고하세요.

</details>

<details>
<summary>EPUB 생성</summary>

오프라인으로 이 가이드를 읽고 싶으신가요? EPUB 전자책을 생성하세요:

```bash
uv run scripts/build_epub.py
```

모든 콘텐츠와 렌더링된 Mermaid 다이어그램이 포함된 `claude-howto-guide.epub`가 생성됩니다.

더 많은 옵션은 [scripts/README.md](scripts/README.md)를 참고하세요.

</details>

<details>
<summary>기여하기</summary>

문제를 발견하셨거나 예제를 기여하고 싶으신가요? 여러분의 도움을 환영합니다!

**기여에 대한 자세한 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 읽어주세요:**
- 기여 유형 (예제, 문서, 기능, 버그, 피드백)
- 개발 환경 설정 방법
- 디렉토리 구조 및 콘텐츠 추가 방법
- 작성 가이드라인 및 모범 사례
- 커밋 및 PR 프로세스

**커뮤니티 표준:**
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - 서로를 대하는 방식
- [SECURITY.md](SECURITY.md) - 보안 정책 및 취약점 보고

### 보안 이슈 보고

보안 취약점을 발견하셨다면, 책임감 있게 보고해 주세요:

1. **GitHub 비공개 취약점 보고 사용**: https://github.com/luongnv89/claude-howto/security/advisories
2. **또는** 자세한 지침은 [.github/SECURITY_REPORTING.md](.github/SECURITY_REPORTING.md) 참고
3. **보안 취약점에 대해 공개 이슈를 열지 마세요**

빠른 시작:
1. 저장소를 포크하고 클론합니다
2. 설명이 있는 브랜치를 만듭니다 (`add/feature-name`, `fix/bug`, `docs/improvement`)
3. 가이드라인에 따라 변경 사항을 만듭니다
4. 명확한 설명과 함께 Pull Request를 제출합니다

**도움이 필요하신가요?** 이슈나 토론을 열어주시면 안내해 드리겠습니다.

</details>

<details>
<summary>추가 리소스</summary>

- [Claude Code 문서](https://code.claude.com/docs/en/overview)
- [MCP Protocol 명세](https://modelcontextprotocol.io)
- [Skills 저장소](https://github.com/luongnv89/skills) - 바로 사용 가능한 Skills 모음
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Boris Cherny의 Claude Code 워크플로우](https://x.com/bcherny/status/2007179832300581177) - Claude Code 창시자가 자신의 체계화된 워크플로우를 공유합니다: 병렬 에이전트, 공유 CLAUDE.md, Plan 모드, Slash Commands, Subagents, 자율적인 장시간 세션을 위한 검증 Hooks.

</details>

---

## 기여하기

기여를 환영합니다! 시작하는 방법은 [기여 가이드](CONTRIBUTING.md)를 참고하세요.

## 기여자

이 프로젝트에 기여해 주신 모든 분께 감사드립니다!

| 기여자 | PR |
|-------------|-----|
| [wjhrdy](https://github.com/wjhrdy) | [#1 - epub 생성 도구 추가](https://github.com/luongnv89/claude-howto/pull/1) |
| [VikalpP](https://github.com/VikalpP) | [#7 - fix(docs): 개념 가이드에서 중첩 코드 블록에 틸드 펜스 사용](https://github.com/luongnv89/claude-howto/pull/7) |

---

## 라이선스

MIT 라이선스 - [LICENSE](LICENSE) 참고. 자유롭게 사용, 수정, 배포할 수 있습니다. 유일한 요구 사항은 라이선스 고지를 포함하는 것입니다.

---

**마지막 업데이트**: 2026년 3월
**Claude Code 버전**: 2.1+
**호환 모델**: Claude Sonnet 4.6, Claude Opus 4.6, Claude Haiku 4.5
