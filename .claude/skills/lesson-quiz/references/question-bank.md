# Lesson Quiz — 문제 은행

레슨당 10문제. 각 문제에는: 카테고리, 문제 텍스트, 선택지 (3-4개), 정답, 해설, 복습 섹션이 있습니다.

---

## Lesson 01: Slash Commands

### Q1
- **Category**: conceptual
- **Question**: Claude Code의 slash command 유형 네 가지는 무엇인가요?
- **Options**: A) Built-in, skills, plugin commands, MCP prompts | B) Built-in, custom, hook commands, API prompts | C) System, user, plugin, terminal commands | D) Core, extension, macro, script commands
- **Correct**: A
- **Explanation**: Claude Code에는 built-in 명령어(/help, /compact 등), skills(SKILL.md 파일), plugin commands(네임스페이스가 있는 plugin-name:command), MCP prompts(/mcp__server__prompt)가 있습니다.
- **Review**: Types of Slash Commands 섹션

### Q2
- **Category**: practical
- **Question**: 사용자가 제공한 모든 인수를 skill에 전달하려면 어떻게 하나요?
- **Options**: A) `${args}` 사용 | B) `$ARGUMENTS` 사용 | C) `$@` 사용 | D) `$INPUT` 사용
- **Correct**: B
- **Explanation**: `$ARGUMENTS`는 명령어 이름 뒤의 모든 텍스트를 캡처합니다. 위치 인수는 `$0`, `$1` 등을 사용하세요.
- **Review**: Argument handling 섹션

### Q3
- **Category**: conceptual
- **Question**: 같은 이름의 skill(.claude/skills/name/SKILL.md)과 레거시 command(.claude/commands/name.md)가 모두 있을 때 어떤 것이 우선순위를 갖나요?
- **Options**: A) 레거시 command | B) Skill | C) 먼저 생성된 것 | D) Claude가 사용자에게 선택을 요청
- **Correct**: B
- **Explanation**: Skills는 같은 이름의 레거시 command보다 우선순위를 갖습니다. Skill 시스템은 구 command 시스템을 대체합니다.
- **Review**: Skill precedence 섹션

### Q4
- **Category**: practical
- **Question**: skill 프롬프트에 실시간 셸 출력을 주입하려면 어떻게 하나요?
- **Options**: A) `$(command)` 문법 사용 | B) `` !`command` `` (백틱 앞에 !) 문법 사용 | C) `@shell:command` 문법 사용 | D) `{command}` 문법 사용
- **Correct**: B
- **Explanation**: `` !`command` `` 문법은 셸 명령어를 실행하고 Claude가 보기 전에 skill 프롬프트에 그 출력을 주입합니다.
- **Review**: Dynamic context injection 섹션

### Q5
- **Category**: conceptual
- **Question**: skill frontmatter의 `disable-model-invocation: true`는 무엇을 하나요?
- **Options**: A) skill이 완전히 실행되지 않도록 방지 | B) 사용자만 호출할 수 있게 허용 (Claude는 자동 호출 불가) | C) /help 메뉴에서 숨김 | D) skill의 AI 처리 비활성화
- **Correct**: B
- **Explanation**: `disable-model-invocation: true`는 사용자만 `/command-name`을 통해 명령어를 트리거할 수 있음을 의미합니다. Claude는 절대 자동 호출하지 않으며, 배포와 같이 부수 효과가 있는 skills에 유용합니다.
- **Review**: Controlling invocation 섹션

### Q6
- **Category**: practical
- **Question**: Claude만 자동으로 호출할 수 있고 사용자의 / 메뉴에서는 숨겨진 skill을 만들려면 어떤 frontmatter 필드를 설정하나요?
- **Options**: A) `disable-model-invocation: true` | B) `user-invocable: false` | C) `hidden: true` | D) `auto-only: true`
- **Correct**: B
- **Explanation**: `user-invocable: false`는 사용자의 slash 메뉴에서 skill을 숨기지만 Claude가 컨텍스트에 따라 자동으로 호출하는 것은 허용합니다.
- **Review**: Invocation control matrix

### Q7
- **Category**: practical
- **Question**: "deploy"라는 새 커스텀 skill의 올바른 디렉토리 구조는 무엇인가요?
- **Options**: A) `.claude/commands/deploy.md` | B) `.claude/skills/deploy/SKILL.md` | C) `.claude/skills/deploy.md` | D) `.claude/deploy/SKILL.md`
- **Correct**: B
- **Explanation**: Skills는 `.claude/skills/` 아래 디렉토리에 `SKILL.md` 파일과 함께 위치합니다. 디렉토리 이름은 명령어 이름과 일치합니다.
- **Review**: Skill types and locations 섹션

### Q8
- **Category**: conceptual
- **Question**: plugin commands는 사용자 명령어와의 이름 충돌을 어떻게 피하나요?
- **Options**: A) `plugin-name:command-name` 네임스페이스 사용 | B) 특별한 .plugin 확장자를 가짐 | C) `p/` 접두사가 붙음 | D) 사용자 명령어를 자동으로 덮어씀
- **Correct**: A
- **Explanation**: Plugin commands는 독립적인 사용자 명령어와의 충돌을 피하기 위해 `pr-review:check-security`와 같은 네임스페이스를 사용합니다.
- **Review**: Plugin commands 섹션

### Q9
- **Category**: practical
- **Question**: skill이 사용할 수 있는 도구를 제한하려면 어떤 frontmatter 필드를 추가하나요?
- **Options**: A) `tools: [Read, Grep]` | B) `allowed-tools: [Read, Grep]` | C) `permissions: [Read, Grep]` | D) `restrict-tools: [Read, Grep]`
- **Correct**: B
- **Explanation**: SKILL.md frontmatter의 `allowed-tools` 필드는 명령어가 호출할 수 있는 도구를 제한합니다.
- **Review**: Frontmatter fields reference

### Q10
- **Category**: conceptual
- **Question**: skill에서 `@file` 문법은 무엇에 사용되나요?
- **Options**: A) 다른 skill 가져오기 | B) 파일을 참조하여 프롬프트에 내용 포함 | C) 심볼릭 링크 생성 | D) 파일 권한 설정
- **Correct**: B
- **Explanation**: skill의 `@path/to/file` 문법은 참조된 파일의 내용을 프롬프트에 포함시켜, skills가 템플릿이나 컨텍스트 파일을 가져올 수 있게 합니다.
- **Review**: File references 섹션

---

## Lesson 02: Memory

### Q1
- **Category**: conceptual
- **Question**: Claude Code 메모리 계층 구조는 몇 단계이며, 가장 높은 우선순위는 무엇인가요?
- **Options**: A) 5단계, User Memory가 가장 높음 | B) 7단계, Managed Policy가 가장 높음 | C) 3단계, Project Memory가 가장 높음 | D) 7단계, Auto Memory가 가장 높음
- **Correct**: B
- **Explanation**: 계층 구조는 7단계입니다: Managed Policy > Project Memory > Project Rules > User Memory > User Rules > Local Project Memory > Auto Memory. 관리자가 설정하는 Managed Policy가 가장 높은 우선순위를 갖습니다.
- **Review**: Memory hierarchy 섹션

### Q2
- **Category**: practical
- **Question**: 대화 중에 새 규칙을 메모리에 빠르게 추가하려면 어떻게 하나요?
- **Options**: A) `/memory add "rule text"` 입력 | B) 메시지 앞에 `#` 붙이기 (예: `# always use TypeScript`) | C) `/rule "rule text"` 입력 | D) `@add-memory "rule text"` 사용
- **Correct**: B
- **Explanation**: `#` 접두사 패턴을 사용하면 대화 중 단일 규칙을 빠르게 추가할 수 있습니다. Claude는 어떤 메모리 레벨에 저장할지 물어볼 것입니다.
- **Review**: Quick memory updates 섹션

### Q3
- **Category**: conceptual
- **Question**: CLAUDE.md의 `@path/to/file` 가져오기의 최대 깊이는 얼마인가요?
- **Options**: A) 3단계 | B) 5단계 | C) 10단계 | D) 무제한
- **Correct**: B
- **Explanation**: `@import` 문법은 무한 루프를 방지하기 위해 최대 5단계 깊이의 재귀 가져오기를 지원합니다.
- **Review**: Import syntax 섹션

### Q4
- **Category**: practical
- **Question**: `src/api/`의 파일에만 적용되는 규칙 파일의 범위를 지정하려면 어떻게 하나요?
- **Options**: A) `src/api/CLAUDE.md`에 규칙 넣기 | B) `.claude/rules/*.md` 파일에 `paths: src/api/**` YAML frontmatter 추가 | C) 파일 이름을 `.claude/rules/api.md`로 지정 | D) 규칙 파일에 `@scope: src/api` 사용
- **Correct**: B
- **Explanation**: `.claude/rules/`의 파일들은 특정 디렉토리로 규칙 범위를 지정하기 위한 glob 패턴이 있는 `paths:` frontmatter 필드를 지원합니다.
- **Review**: Path-specific rules 섹션

### Q5
- **Category**: conceptual
- **Question**: Auto Memory의 MEMORY.md 중 세션 시작 시 몇 줄이 로드되나요?
- **Options**: A) 전체 | B) 처음 100줄 | C) 처음 200줄 | D) 처음 500줄
- **Correct**: C
- **Explanation**: MEMORY.md의 처음 200줄이 세션 시작 시 컨텍스트에 자동으로 로드됩니다. MEMORY.md에서 참조된 주제 파일들은 필요할 때 로드됩니다.
- **Review**: Auto Memory 섹션

### Q6
- **Category**: practical
- **Question**: git에 커밋하지 않을 개인 프로젝트 기본 설정을 저장하려면 어떤 파일을 사용해야 하나요?
- **Options**: A) `~/.claude/CLAUDE.md` | B) `CLAUDE.local.md` | C) `.claude/rules/personal.md` | D) `.claude/memory/personal.md`
- **Correct**: B
- **Explanation**: 프로젝트 루트의 `CLAUDE.local.md`는 개인 프로젝트별 기본 설정을 위한 파일입니다. git 무시 목록에 추가해야 합니다.
- **Review**: Memory locations comparison

### Q7
- **Category**: conceptual
- **Question**: `/init` 명령어는 무엇을 하나요?
- **Options**: A) 새 Claude Code 프로젝트를 처음부터 초기화 | B) 프로젝트 구조를 기반으로 CLAUDE.md 템플릿을 생성 | C) 모든 메모리를 기본값으로 재설정 | D) 새 세션 생성
- **Correct**: B
- **Explanation**: `/init`은 프로젝트를 분석하고 제안된 규칙과 기준이 포함된 CLAUDE.md 템플릿을 생성합니다. 일회성 부트스트랩 도구입니다.
- **Review**: /init command 섹션

### Q8
- **Category**: practical
- **Question**: Auto Memory를 완전히 비활성화하려면 어떻게 하나요?
- **Options**: A) ~/.claude/projects 디렉토리 삭제 | B) `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` 설정 | C) CLAUDE.md에 `auto-memory: false` 추가 | D) `/memory disable auto` 사용
- **Correct**: B
- **Explanation**: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`을 설정하면 auto memory가 비활성화됩니다. 값 `0`은 강제 활성화입니다. 미설정 = 기본적으로 활성화.
- **Review**: Auto Memory configuration 섹션

### Q9
- **Category**: conceptual
- **Question**: 낮은 우선순위 메모리 계층이 높은 우선순위 계층의 규칙을 덮어쓸 수 있나요?
- **Options**: A) 예, 가장 최근 규칙이 항상 이김 | B) 아니오, 높은 계층이 항상 우선순위를 가짐 | C) 예, 낮은 계층이 `!important` 플래그를 사용하면 가능 | D) 규칙 유형에 따라 다름
- **Correct**: B
- **Explanation**: 메모리 우선순위는 Managed Policy에서 아래로 흐릅니다. 낮은 계층(Auto Memory 등)은 높은 계층(Project Memory 등)을 덮어쓸 수 없습니다.
- **Review**: Memory hierarchy 섹션

### Q10
- **Category**: practical
- **Question**: 두 저장소에서 작업하고 두 곳 모두에서 CLAUDE.md를 로드하고 싶습니다. 어떤 플래그를 사용하나요?
- **Options**: A) `--multi-repo` | B) `--add-dir /path/to/other` | C) `--include /path/to/other` | D) `--merge-context /path/to/other`
- **Correct**: B
- **Explanation**: `--add-dir` 플래그는 추가 디렉토리에서 CLAUDE.md를 로드하여 다중 저장소 컨텍스트를 가능하게 합니다.
- **Review**: Additional directories 섹션

---

## Lesson 03: Skills

### Q1
- **Category**: conceptual
- **Question**: skill 시스템의 점진적 공개(progressive disclosure)의 3단계는 무엇인가요?
- **Options**: A) Metadata, instructions, resources | B) Name, body, attachments | C) Header, content, scripts | D) Summary, details, data
- **Correct**: A
- **Explanation**: Level 1: 메타데이터 (~100 토큰, 항상 로드), Level 2: SKILL.md 본문 (<5k 토큰, 트리거 시 로드), Level 3: 번들 리소스 (scripts/references/assets, 필요 시 로드).
- **Review**: Progressive disclosure architecture 섹션

### Q2
- **Category**: practical
- **Question**: Claude가 skill을 자동 호출하는 데 가장 중요한 요소는 무엇인가요?
- **Options**: A) skill의 파일 이름 | B) 언제 사용할지 키워드가 있는 frontmatter의 `description` 필드 | C) skill의 디렉토리 위치 | D) `auto-invoke: true` frontmatter 필드
- **Correct**: B
- **Explanation**: Claude는 오직 `description` 필드만을 기반으로 skill 자동 호출 여부를 결정합니다. 구체적인 트리거 구문과 시나리오가 포함되어야 합니다.
- **Review**: Auto-invocation 섹션

### Q3
- **Category**: conceptual
- **Question**: SKILL.md 파일의 최대 권장 길이는 얼마인가요?
- **Options**: A) 100줄 | B) 250줄 | C) 500줄 | D) 1000줄
- **Correct**: C
- **Explanation**: SKILL.md는 500줄 미만으로 유지해야 합니다. 더 큰 참조 자료는 `references/` 하위 디렉토리 파일에 넣어야 합니다.
- **Review**: Content guidelines 섹션

### Q4
- **Category**: practical
- **Question**: skill을 격리된 subagent에서 자체 컨텍스트로 실행하려면 어떻게 하나요?
- **Options**: A) frontmatter에 `isolation: true` 설정 | B) frontmatter에 `agent` 필드와 함께 `context: fork` 설정 | C) frontmatter에 `subagent: true` 설정 | D) `.claude/agents/`에 skill 넣기
- **Correct**: B
- **Explanation**: `context: fork`는 별도 컨텍스트에서 skill을 실행하고, `agent` 필드는 사용할 에이전트 유형(예: `Explore`, `Plan`, 커스텀 에이전트)을 지정합니다.
- **Review**: Running skills in subagents 섹션

### Q5
- **Category**: conceptual
- **Question**: skill 메타데이터(Level 1)에 할당된 대략적인 컨텍스트 예산은 얼마인가요?
- **Options**: A) 컨텍스트 창의 0.5% | B) 컨텍스트 창의 2% | C) 컨텍스트 창의 5% | D) 컨텍스트 창의 10%
- **Correct**: B
- **Explanation**: Skill 메타데이터는 컨텍스트 창의 약 2%를 차지합니다 (대체 값: 16,000자). `SLASH_COMMAND_TOOL_CHAR_BUDGET`으로 설정 가능합니다.
- **Review**: Context budget 섹션

### Q6
- **Category**: practical
- **Question**: skill이 대규모 API 명세를 참조해야 합니다. 어디에 넣어야 하나요?
- **Options**: A) SKILL.md에 인라인으로 | B) skill 디렉토리 내 `references/api-spec.md` 파일에 | C) 프로젝트의 CLAUDE.md에 | D) 별도의 `.claude/rules/` 파일에
- **Correct**: B
- **Explanation**: 대규모 참조 자료는 `references/` 하위 디렉토리에 넣어야 합니다. Claude는 Level 3 리소스를 필요할 때 로드하여 SKILL.md를 가볍게 유지합니다.
- **Review**: Supporting files structure 섹션

### Q7
- **Category**: conceptual
- **Question**: skill의 Reference Content와 Task Content의 차이는 무엇인가요?
- **Options**: A) Reference는 읽기 전용, Task는 읽기/쓰기 | B) Reference는 컨텍스트에 지식을 추가하고, Task는 단계별 지시를 제공 | C) Reference는 문서용, Task는 코드용 | D) 차이가 없음
- **Correct**: B
- **Explanation**: Reference Content는 Claude의 컨텍스트에 도메인 지식을 추가합니다(예: 브랜드 가이드라인). Task Content는 워크플로우를 위한 실행 가능한 단계별 지시를 제공합니다.
- **Review**: Skill content types 섹션

### Q8
- **Category**: practical
- **Question**: skill frontmatter의 `name` 필드에 허용되는 문자는 무엇인가요?
- **Options**: A) 모든 문자 | B) 소문자, 숫자, 하이픈만 (최대 64자) | C) 문자와 밑줄 | D) 영숫자만
- **Correct**: B
- **Explanation**: 이름은 kebab-case(소문자, 하이픈)여야 하고, 최대 64자이며, "anthropic"이나 "claude"를 포함할 수 없습니다.
- **Review**: SKILL.md format 섹션

### Q9
- **Category**: conceptual
- **Question**: Claude는 어떤 순서로 skills를 검색하나요?
- **Options**: A) User > Project > Enterprise | B) Enterprise > Personal > Project (plugin은 네임스페이스 사용) | C) Project > User > Enterprise | D) 알파벳 순서
- **Correct**: B
- **Explanation**: 우선순위 순서: Enterprise > Personal > Project. Plugin skills는 네임스페이스(plugin-name:skill)를 사용하여 충돌을 방지합니다.
- **Review**: Skill types and locations 섹션

### Q10
- **Category**: practical
- **Question**: 사용자가 수동으로 사용하는 것은 허용하면서 Claude가 skill을 자동 호출하는 것을 방지하려면 어떻게 하나요?
- **Options**: A) `user-invocable: false` 설정 | B) `disable-model-invocation: true` 설정 | C) description 필드 제거 | D) `auto-invoke: false` 설정
- **Correct**: B
- **Explanation**: `disable-model-invocation: true`는 Claude의 자동 호출을 방지하지만 사용자의 `/` 메뉴에서 수동 사용은 가능하게 유지합니다.
- **Review**: Controlling invocation 섹션

---

## Lesson 04: Subagents

### Q1
- **Category**: conceptual
- **Question**: subagents의 인라인 대화 대비 주요 장점은 무엇인가요?
- **Options**: A) 더 빠름 | B) 컨텍스트 오염을 방지하는 별도의 깨끗한 컨텍스트 창에서 작동 | C) 더 많은 도구를 사용할 수 있음 | D) 더 나은 오류 처리
- **Correct**: B
- **Explanation**: Subagents는 새 컨텍스트 창을 갖고 메인 에이전트가 전달하는 것만 받습니다. 이로 인해 메인 대화가 작업별 세부 사항으로 오염되는 것을 방지합니다.
- **Review**: Overview 섹션

### Q2
- **Category**: practical
- **Question**: 에이전트 정의의 우선순위 순서는 무엇인가요?
- **Options**: A) Project > User > CLI | B) CLI > User > Project | C) User > Project > CLI | D) 모두 동일한 우선순위
- **Correct**: B
- **Explanation**: CLI에서 정의된 에이전트(`--agents` 플래그)가 User 레벨(`~/.claude/agents/`)을 덮어쓰고, User 레벨은 Project 레벨(`.claude/agents/`)을 덮어씁니다.
- **Review**: File locations 섹션

### Q3
- **Category**: conceptual
- **Question**: Haiku 모델을 사용하고 읽기 전용 코드베이스 탐색에 최적화된 내장 subagent는 무엇인가요?
- **Options**: A) general-purpose | B) Plan | C) Explore | D) Bash
- **Correct**: C
- **Explanation**: Explore subagent는 빠른 읽기 전용 코드베이스 탐색을 위해 Haiku를 사용합니다. 세 가지 철저함 수준을 지원합니다: quick, medium, very thorough.
- **Review**: Built-in subagents 섹션

### Q4
- **Category**: practical
- **Question**: coordinator 에이전트가 생성할 수 있는 subagents를 제한하려면 어떻게 하나요?
- **Options**: A) `allowed-agents:` 필드 사용 | B) `tools` 필드에 `Task(agent_name)` 문법 사용 | C) `spawn-limit: 2` 설정 | D) `restrict-agents: [name1, name2]` 사용
- **Correct**: B
- **Explanation**: `tools` 필드에 `Task(worker, researcher)`를 추가하면 허용 목록이 생성됩니다 — 에이전트는 "worker"나 "researcher"로 명명된 subagents만 생성할 수 있습니다.
- **Review**: Restrict spawnable subagents 섹션

### Q5
- **Category**: conceptual
- **Question**: subagent에서 `isolation: worktree`는 무엇을 하나요?
- **Options**: A) Docker 컨테이너에서 에이전트 실행 | B) 메인 트리에 영향 없는 자체 git worktree를 에이전트에 제공 | C) 에이전트가 파일을 읽지 못하게 방지 | D) 에이전트를 샌드박스에서 실행
- **Correct**: B
- **Explanation**: Worktree 격리는 별도의 git worktree를 생성합니다. 에이전트가 변경을 하지 않으면 자동으로 정리됩니다. 변경이 있으면 worktree 경로와 브랜치가 반환됩니다.
- **Review**: Worktree isolation 섹션

### Q6
- **Category**: practical
- **Question**: subagent를 백그라운드에서 실행하려면 어떻게 하나요?
- **Options**: A) 에이전트 설정에서 `background: true` 설정 | B) 에이전트 설정에서 `async: true` 설정 | C) 시작 후 Ctrl+D 누르기 | D) `--background` CLI 플래그 사용
- **Correct**: A
- **Explanation**: 에이전트 설정의 `background: true`는 subagent를 항상 백그라운드 작업으로 실행합니다. 사용자는 Ctrl+B를 사용하여 포그라운드 작업을 백그라운드로 보낼 수도 있습니다.
- **Review**: Background subagents 섹션

### Q7
- **Category**: conceptual
- **Question**: subagent의 `memory` 필드에 `project` 범위를 지정하면 무엇을 하나요?
- **Options**: A) 프로젝트 CLAUDE.md에 읽기 접근 권한 부여 | B) 현재 프로젝트에 범위가 지정된 영구 메모리 디렉토리 생성 | C) 메인 에이전트의 대화 이력 공유 | D) 프로젝트의 git 이력 로드
- **Correct**: B
- **Explanation**: `memory` 필드는 subagent를 위한 영구 디렉토리를 생성합니다. `project` 범위는 메모리가 현재 프로젝트에 연결됨을 의미합니다. 에이전트의 MEMORY.md 처음 200줄이 자동으로 로드됩니다.
- **Review**: Persistent memory 섹션

### Q8
- **Category**: practical
- **Question**: subagent의 description에 Claude가 자동으로 작업을 위임하도록 권장하는 구문을 어떻게 포함하나요?
- **Options**: A) "priority: high" 추가 | B) description에 "use PROACTIVELY" 또는 "MUST BE USED" 포함 | C) `auto-delegate: true` 설정 | D) "trigger: always" 추가
- **Correct**: B
- **Explanation**: description에 "use PROACTIVELY" 또는 "MUST BE USED"와 같은 구문을 포함하면 Claude가 매칭 작업을 자동으로 위임하도록 강하게 권장합니다.
- **Review**: Automatic delegation 섹션

### Q9
- **Category**: conceptual
- **Question**: subagent의 유효한 `permissionMode` 값은 무엇인가요?
- **Options**: A) read, write, admin | B) default, acceptEdits, bypassPermissions, plan, dontAsk, auto | C) safe, normal, dangerous | D) restricted, standard, elevated
- **Correct**: B
- **Explanation**: Subagents는 여섯 가지 권한 모드를 지원합니다: default(모든 것에 프롬프트), acceptEdits(파일 편집 자동 수락), bypassPermissions(모두 건너뜀), plan(읽기 전용), dontAsk(사전 승인 없으면 자동 거부), auto(백그라운드 분류기가 결정).
- **Review**: Configuration fields 섹션

### Q10
- **Category**: practical
- **Question**: 이전 실행에서 agentId를 반환한 subagent를 어떻게 재개하나요?
- **Options**: A) `/resume agent-id` 사용 | B) Task 도구 호출 시 agentId와 함께 `resume` 매개변수 전달 | C) `claude -r agent-id` 사용 | D) Subagents는 재개할 수 없음
- **Correct**: B
- **Explanation**: Subagents는 이전에 반환된 agentId와 함께 `resume` 매개변수를 전달하여 재개할 수 있으며, 전체 컨텍스트가 보존된 채로 계속됩니다.
- **Review**: Resumable agents 섹션

---

## Lesson 05: MCP

### Q1
- **Category**: conceptual
- **Question**: 세 가지 MCP 전송 프로토콜은 무엇이며, 권장되는 것은 무엇인가요?
- **Options**: A) HTTP (권장), Stdio, SSE (deprecated) | B) WebSocket (권장), REST, gRPC | C) TCP, UDP, HTTP | D) Stdio (권장), HTTP, SSE
- **Correct**: A
- **Explanation**: HTTP는 원격 서버에 권장됩니다. Stdio는 로컬 프로세스용(현재 가장 일반적)입니다. SSE는 deprecated이지만 여전히 지원됩니다.
- **Review**: Transport protocols 섹션

### Q2
- **Category**: practical
- **Question**: CLI를 통해 GitHub MCP 서버를 추가하려면 어떻게 하나요?
- **Options**: A) `claude mcp install github` | B) `claude mcp add --transport http github https://api.github.com/mcp` | C) `claude plugin add github-mcp` | D) `claude connect github`
- **Correct**: B
- **Explanation**: `--transport` 플래그, 이름, 서버 URL과 함께 `claude mcp add`를 사용하세요. stdio의 경우: `claude mcp add github -- npx -y @modelcontextprotocol/server-github`.
- **Review**: MCP configuration management 섹션

### Q3
- **Category**: conceptual
- **Question**: MCP 도구 설명이 컨텍스트 창의 10%를 초과하면 어떻게 되나요?
- **Options**: A) 잘림 | B) Tool Search가 자동 활성화되어 관련 도구를 동적으로 선택 | C) Claude가 오류 표시 | D) 추가 도구가 비활성화됨
- **Correct**: B
- **Explanation**: MCP Tool Search는 도구가 컨텍스트의 10%를 초과할 때 자동으로 활성화됩니다. Sonnet 4 또는 Opus 4 이상이 필요합니다(Haiku는 미지원).
- **Review**: MCP Tool Search 섹션

### Q4
- **Category**: practical
- **Question**: MCP 설정에서 환경 변수 대체값을 사용하려면 어떻게 하나요?
- **Options**: A) `${VAR || "default"}` | B) `${VAR:-default}` | C) `${VAR:default}` | D) `${VAR ? "default"}`
- **Correct**: B
- **Explanation**: `${VAR:-default}`는 환경 변수가 설정되지 않은 경우 대체값을 제공합니다. 대체값 없는 `${VAR}`는 미설정 시 오류가 발생합니다.
- **Review**: Environment variable expansion 섹션

### Q5
- **Category**: conceptual
- **Question**: 데이터 접근에서 MCP와 Memory의 차이는 무엇인가요?
- **Options**: A) MCP는 빠르고, Memory는 느림 | B) MCP는 실시간/변화하는 외부 데이터용, Memory는 영구적/정적 기본 설정용 | C) MCP는 코드용, Memory는 텍스트용 | D) 서로 교환 가능
- **Correct**: B
- **Explanation**: MCP는 실시간으로 변화하는 외부 데이터 소스(API, 데이터베이스)에 연결합니다. Memory는 영구적인 정적 프로젝트 컨텍스트와 기본 설정을 저장합니다.
- **Review**: MCP vs Memory 섹션

### Q6
- **Category**: practical
- **Question**: 팀원이 처음으로 프로젝트 범위의 `.mcp.json`을 접하면 무슨 일이 발생하나요?
- **Options**: A) 자동으로 로드됨 | B) 프로젝트의 MCP 서버를 신뢰할지 묻는 승인 프롬프트가 표시됨 | C) 설정을 통해 opt-in하지 않으면 무시됨 | D) Claude가 관리자에게 승인을 요청
- **Correct**: B
- **Explanation**: 프로젝트 범위의 `.mcp.json`은 각 팀원이 처음 사용할 때 보안 승인 프롬프트를 트리거합니다. 이는 의도적인 설계 — 신뢰할 수 없는 MCP 서버를 방지합니다.
- **Review**: MCP Scopes 섹션

### Q7
- **Category**: conceptual
- **Question**: `claude mcp serve`는 무엇을 하나요?
- **Options**: A) MCP 서버 대시보드 시작 | B) Claude Code 자체가 다른 애플리케이션을 위한 MCP 서버로 동작하게 함 | C) MCP 문서 제공 | D) MCP 서버 연결 테스트
- **Correct**: B
- **Explanation**: `claude mcp serve`는 Claude Code를 MCP 서버로 전환하여 하나의 Claude 인스턴스가 다른 인스턴스에 의해 제어될 수 있는 멀티 에이전트 오케스트레이션을 가능하게 합니다.
- **Review**: Claude as MCP Server 섹션

### Q8
- **Category**: practical
- **Question**: MCP 도구의 기본 최대 출력 크기는 얼마인가요?
- **Options**: A) 5,000 토큰 | B) 10,000 토큰 | C) 25,000 토큰 | D) 50,000 토큰
- **Correct**: C
- **Explanation**: 기본 최댓값은 25,000 토큰(`MAX_MCP_OUTPUT_TOKENS`)입니다. 10k 토큰에서 경고가 표시됩니다. 디스크 지속성은 50k 문자로 제한됩니다.
- **Review**: MCP Output Limits 섹션

### Q9
- **Category**: conceptual
- **Question**: 관리 설정에서 `allowedMcpServers`와 `deniedMcpServers` 모두 서버와 매칭되면 어느 것이 우선하나요?
- **Options**: A) Allowed가 이김 | B) Denied가 이김 | C) 마지막으로 설정된 것이 이김 | D) 둘 다 독립적으로 적용됨
- **Correct**: B
- **Explanation**: 관리 MCP 설정에서 deny 규칙은 항상 allow 규칙보다 우선합니다.
- **Review**: Managed MCP Configuration 섹션

### Q10
- **Category**: practical
- **Question**: 대화에서 MCP 리소스를 참조하려면 어떻게 하나요?
- **Options**: A) `/mcp resource-name` 사용 | B) `@server-name:protocol://resource/path` mention 문법 사용 | C) `mcp.get("resource")` 사용 | D) 리소스는 자동으로 로드됨
- **Correct**: B
- **Explanation**: MCP 리소스는 대화에서 `@server-name:protocol://resource/path` mention 문법으로 접근합니다.
- **Review**: MCP Resources 섹션

---

## Lesson 06: Hooks

### Q1
- **Category**: conceptual
- **Question**: Claude Code의 hooks 유형 네 가지는 무엇인가요?
- **Options**: A) Pre, Post, Error, Filter hooks | B) Command, HTTP, Prompt, Agent hooks | C) Before, After, Around, Through hooks | D) Input, Output, Filter, Transform hooks
- **Correct**: B
- **Explanation**: Command hooks는 셸 스크립트를 실행하고, HTTP hooks는 webhook 엔드포인트를 호출하며, Prompt hooks는 단일 턴 LLM 평가를 사용하고, Agent hooks는 subagent 기반 검증을 사용합니다.
- **Review**: Hook types 섹션

### Q2
- **Category**: practical
- **Question**: hook 스크립트가 코드 2로 종료되면 무슨 일이 발생하나요?
- **Options**: A) 비차단 경고 표시 | B) 차단 오류 — stderr가 Claude에게 오류로 표시되고 도구 사용이 방지됨 | C) Hook이 재시도됨 | D) 세션 종료
- **Correct**: B
- **Explanation**: 종료 코드 0 = 성공/계속, 종료 코드 2 = 차단 오류(stderr가 오류로 표시), 다른 0이 아닌 값 = 비차단(상세 모드에서만 stderr 표시).
- **Review**: Exit codes 섹션

### Q3
- **Category**: conceptual
- **Question**: PreToolUse hook은 stdin에서 어떤 JSON 필드를 받나요?
- **Options**: A) `tool_name`과 `tool_output` | B) `session_id`, `tool_name`, `tool_input`, `hook_event_name`, `cwd` 등 | C) `tool_name`만 | D) 전체 대화 이력
- **Correct**: B
- **Explanation**: Hooks는 stdin에서 JSON 객체를 받습니다: session_id, transcript_path, hook_event_name, tool_name, tool_input, tool_use_id, cwd, permission_mode.
- **Review**: JSON input structure 섹션

### Q4
- **Category**: practical
- **Question**: PreToolUse hook이 실행 전 도구의 입력 매개변수를 수정하려면 어떻게 하나요?
- **Options**: A) stderr에 수정된 JSON 반환 | B) stdout에 `updatedInput` 필드가 있는 JSON 반환 (종료 코드 0) | C) 임시 파일에 쓰기 | D) Hooks는 입력을 수정할 수 없음
- **Correct**: B
- **Explanation**: PreToolUse hook은 Claude가 사용하기 전에 도구의 매개변수를 수정하기 위해 stdout에 `"updatedInput": {...}`이 있는 JSON을 출력할 수 있습니다(exit 0 포함).
- **Review**: PreToolUse output 섹션

### Q5
- **Category**: conceptual
- **Question**: 세션에 환경 변수를 유지하기 위한 `CLAUDE_ENV_FILE`을 지원하는 hook 이벤트는 무엇인가요?
- **Options**: A) PreToolUse | B) UserPromptSubmit | C) SessionStart | D) 모든 이벤트
- **Correct**: C
- **Explanation**: SessionStart hooks만 `CLAUDE_ENV_FILE`을 사용하여 환경 변수를 세션에 유지할 수 있습니다.
- **Review**: SessionStart 섹션

### Q6
- **Category**: practical
- **Question**: 모든 도구 호출이 아닌 skill이 처음 로드될 때 한 번만 실행되는 hook을 원합니다. 어떤 필드를 추가하나요?
- **Options**: A) `run-once: true` | B) 컴포넌트 hook 정의에 `once: true` | C) `single: true` | D) `max-runs: 1`
- **Correct**: B
- **Explanation**: 컴포넌트 범위 hooks(SKILL.md 또는 에이전트 frontmatter에 정의됨)는 첫 번째 활성화 시에만 실행되도록 `once: true`를 지원합니다.
- **Review**: Component-scoped hooks 섹션

### Q7
- **Category**: conceptual
- **Question**: subagent의 frontmatter에 Stop hook이 정의되면 자동으로 무엇으로 변환되나요?
- **Options**: A) PostToolUse hook | B) SubagentStop hook | C) SessionEnd hook | D) Stop hook으로 유지
- **Correct**: B
- **Explanation**: Stop hook이 subagent의 frontmatter에 배치되면 해당 특정 subagent가 끝날 때 실행되도록 SubagentStop으로 자동 변환됩니다.
- **Review**: Component-scoped hooks 섹션

### Q8
- **Category**: practical
- **Question**: 특정 서버의 모든 MCP 도구에 hook을 매칭하려면 어떻게 하나요?
- **Options**: A) `matcher: "mcp_github"` | B) `matcher: "mcp__github__.*"` (정규식 패턴) | C) `matcher: "mcp:github:*"` | D) `matcher: "github-mcp"`
- **Correct**: B
- **Explanation**: matcher에는 정규식 패턴을 사용하세요. MCP 도구는 `mcp__server__tool` 명명 규칙을 따르므로 `mcp__github__.*`는 모든 GitHub MCP 도구와 매칭됩니다.
- **Review**: Matcher patterns 섹션

### Q9
- **Category**: conceptual
- **Question**: Claude Code가 지원하는 hook 이벤트는 총 몇 개인가요?
- **Options**: A) 10 | B) 16 | C) 25 | D) 30
- **Correct**: C
- **Explanation**: Claude Code는 25개의 hook 이벤트를 지원합니다: PreToolUse, PostToolUse, PostToolUseFailure, UserPromptSubmit, Stop, StopFailure, SubagentStop, SubagentStart, PermissionRequest, Notification, PreCompact, PostCompact, SessionStart, SessionEnd, WorktreeCreate, WorktreeRemove, ConfigChange, CwdChanged, FileChanged, TeammateIdle, TaskCompleted, TaskCreated, Elicitation, ElicitationResult, InstructionsLoaded.
- **Review**: Hook events table

### Q10
- **Category**: practical
- **Question**: hook이 실행되지 않는 이유를 디버그하려면 어떤 것이 최선인가요?
- **Options**: A) hook 스크립트에 print 문 추가 | B) `--debug` 플래그와 상세 모드를 위한 `Ctrl+O` 사용 | C) 시스템 로그 확인 | D) Hooks에는 디버깅 도구가 없음
- **Correct**: B
- **Explanation**: `--debug` 플래그와 `Ctrl+O` 상세 모드는 어떤 hooks가 실행되는지, 입출력 포함 hook 실행 세부 사항을 표시합니다.
- **Review**: Debugging 섹션

---

## Lesson 07: Plugins

### Q1
- **Category**: conceptual
- **Question**: plugin의 핵심 매니페스트 파일은 무엇이며 어디에 위치하나요?
- **Options**: A) 루트 디렉토리의 `plugin.yaml` | B) `.claude-plugin/plugin.json` | C) "claude" 키가 있는 `package.json` | D) `.claude/plugin.md`
- **Correct**: B
- **Explanation**: plugin 매니페스트는 `.claude-plugin/plugin.json`에 위치하며 필수 필드: name, description, version, author.
- **Review**: Plugin definition structure 섹션

### Q2
- **Category**: practical
- **Question**: 게시 전에 plugin을 로컬에서 테스트하려면 어떻게 하나요?
- **Options**: A) `/plugin test ./my-plugin` 사용 | B) `claude --plugin-dir ./my-plugin` 사용 | C) `claude plugin validate ./my-plugin` 사용 | D) ~/.claude/plugins/에 복사
- **Correct**: B
- **Explanation**: `--plugin-dir` 플래그는 테스트를 위해 로컬 디렉토리에서 plugin을 로드합니다. 여러 plugin 로드를 위해 반복 사용 가능합니다.
- **Review**: Testing 섹션

### Q3
- **Category**: conceptual
- **Question**: plugin hooks와 MCP 설정에서 plugin의 설치 디렉토리를 참조하기 위해 사용할 수 있는 환경 변수는 무엇인가요?
- **Options**: A) `$PLUGIN_HOME` | B) `${CLAUDE_PLUGIN_ROOT}` | C) `$PLUGIN_DIR` | D) `${CLAUDE_PLUGIN_PATH}`
- **Correct**: B
- **Explanation**: `${CLAUDE_PLUGIN_ROOT}`는 plugin의 설치된 디렉토리로 확인되어 hooks와 MCP 설정에서 이식 가능한 경로 참조를 가능하게 합니다.
- **Review**: Plugin directory structure 섹션

### Q4
- **Category**: practical
- **Question**: "pr-review" plugin에 "check-security"라는 명령어가 있습니다. 사용자는 어떻게 호출하나요?
- **Options**: A) `/check-security` | B) `/pr-review:check-security` | C) `/plugin pr-review check-security` | D) `/pr-review/check-security`
- **Correct**: B
- **Explanation**: Plugin commands는 사용자 명령어 및 다른 plugins와의 충돌을 피하기 위해 `plugin-name:command-name` 네임스페이스를 사용합니다.
- **Review**: Plugin commands 섹션

### Q5
- **Category**: conceptual
- **Question**: plugin이 번들할 수 있는 컴포넌트는 무엇인가요?
- **Options**: A) 명령어와 설정만 | B) Commands, agents, skills, hooks, MCP servers, LSP config, settings, templates, scripts | C) 명령어, hooks, MCP servers만 | D) Skills와 agents만
- **Correct**: B
- **Explanation**: Plugins는 다음을 번들할 수 있습니다: commands/, agents/, skills/, hooks/hooks.json, .mcp.json, .lsp.json, settings.json, templates/, scripts/, docs/, tests/.
- **Review**: Plugin directory structure 섹션

### Q6
- **Category**: practical
- **Question**: GitHub에서 plugin을 설치하려면 어떻게 하나요?
- **Options**: A) `claude plugin add github:username/repo` | B) `/plugin install github:username/repo` | C) `npm install @claude/username-repo` | D) `git clone` 후 `claude plugin register`
- **Correct**: B
- **Explanation**: `/plugin install github:username/repo`를 사용하면 GitHub 저장소에서 직접 설치할 수 있습니다.
- **Review**: Installation methods 섹션

### Q7
- **Category**: conceptual
- **Question**: plugin의 `settings.json`에서 `agent` 키는 무엇을 하나요?
- **Options**: A) 인증 자격 증명 지정 | B) plugin의 메인 스레드 에이전트 설정 | C) 사용 가능한 subagents 나열 | D) 에이전트 권한 설정
- **Correct**: B
- **Explanation**: plugin의 settings.json의 `agent` 키는 plugin이 활성화될 때 메인 스레드 에이전트로 사용할 에이전트 정의를 지정합니다.
- **Review**: Plugin Settings 섹션

### Q8
- **Category**: practical
- **Question**: plugin 수명 주기(활성화/비활성화/업데이트)를 어떻게 관리하나요?
- **Options**: A) 설정 파일을 수동으로 편집 | B) `/plugin enable`, `/plugin disable`, `/plugin update plugin-name` 사용 | C) `claude plugin-manager` 사용 | D) Plugin 재설치
- **Correct**: B
- **Explanation**: Claude Code는 전체 수명 주기 관리를 위한 slash commands를 제공합니다: enable, disable, update, uninstall.
- **Review**: Installation methods 섹션

### Q9
- **Category**: conceptual
- **Question**: 독립적인 skills/hooks/MCP 대비 plugin의 주요 장점은 무엇인가요?
- **Options**: A) Plugins가 더 빠름 | B) 단일 명령어 설치, 버전 관리, 마켓플레이스 배포, 모든 것을 하나로 번들 | C) Plugins가 더 많은 권한을 가짐 | D) Plugins는 오프라인에서 작동
- **Correct**: B
- **Explanation**: Plugins는 여러 컴포넌트를 버전 관리, 마켓플레이스 배포, 자동 업데이트가 있는 하나의 설치 가능한 단위로 패키징합니다 — 독립적 컴포넌트의 수동 설정과 비교.
- **Review**: Standalone vs Plugin comparison 섹션

### Q10
- **Category**: practical
- **Question**: Plugin 디렉토리 내에서 plugin hooks 설정은 어디에 위치하나요?
- **Options**: A) `.claude-plugin/hooks.json` | B) `hooks/hooks.json` | C) `plugin.json` hooks 섹션 | D) `.claude/settings.json`
- **Correct**: B
- **Explanation**: Plugin hooks는 plugin 디렉토리 구조 내의 `hooks/hooks.json`에 설정됩니다.
- **Review**: Plugin hooks 섹션

---

## Lesson 08: Checkpoints

### Q1
- **Category**: conceptual
- **Question**: Checkpoints가 캡처하는 네 가지는 무엇인가요?
- **Options**: A) Git commits, branches, tags, stashes | B) 메시지, 파일 수정, 도구 사용 이력, 세션 컨텍스트 | C) 코드, 테스트, 로그, 설정 | D) 입력, 출력, 오류, 타이밍
- **Correct**: B
- **Explanation**: Checkpoints는 대화 메시지, Claude의 도구로 수행된 파일 수정, 도구 사용 이력, 세션 컨텍스트를 캡처합니다.
- **Review**: Overview 섹션

### Q2
- **Category**: practical
- **Question**: checkpoint 브라우저에 접근하려면 어떻게 하나요?
- **Options**: A) `/checkpoints` 명령어 사용 | B) `Esc + Esc` (더블 이스케이프) 또는 `/rewind` 사용 | C) `/history` 명령어 사용 | D) `Ctrl+Z` 누르기
- **Correct**: B
- **Explanation**: 더블 이스케이프(Esc+Esc) 또는 `/rewind` 명령어로 checkpoint 브라우저를 열어 복원 지점을 선택할 수 있습니다.
- **Review**: Accessing checkpoints 섹션

### Q3
- **Category**: conceptual
- **Question**: 사용 가능한 rewind 옵션은 몇 개이며 무엇인가요?
- **Options**: A) 3개: Undo, Redo, Reset | B) 5개: 코드+대화 복원, 대화 복원, 코드 복원, 여기서 요약, 취소 | C) 2개: 전체 복원, 부분 복원 | D) 4개: 코드, 메시지, 모두, 취소
- **Correct**: B
- **Explanation**: 5가지 옵션: 코드와 대화 복원(전체 롤백), 대화만 복원, 코드만 복원, 여기서 요약(압축), 취소.
- **Review**: Rewind options 섹션

### Q4
- **Category**: practical
- **Question**: Claude Code에서 Bash를 통해 `rm -rf temp/`를 사용했다가 rewind하려고 합니다. Checkpoint가 해당 파일을 복원하나요?
- **Options**: A) 예, checkpoints는 모든 것을 캡처 | B) 아니오, Bash 파일시스템 작업(rm, mv, cp)은 checkpoints가 추적하지 않음 | C) Edit 도구를 사용했을 경우에만 | D) autoCheckpoint가 활성화된 경우에만
- **Correct**: B
- **Explanation**: Checkpoints는 Claude의 도구(Write, Edit)로 수행된 파일 변경만 추적합니다. rm, mv, cp 같은 Bash 명령어는 checkpoint 추적 범위 밖에서 작동합니다.
- **Review**: Limitations 섹션

### Q5
- **Category**: conceptual
- **Question**: Checkpoints는 얼마나 보존되나요?
- **Options**: A) 세션 종료 시까지 | B) 7일 | C) 30일 | D) 무기한
- **Correct**: C
- **Explanation**: Checkpoints는 세션 간에 최대 30일 동안 유지되며, 이후 자동으로 정리됩니다.
- **Review**: Checkpoint persistence 섹션

### Q6
- **Category**: practical
- **Question**: rewind 시 "여기서 요약"은 무엇을 하나요?
- **Options**: A) 해당 지점부터 대화를 삭제 | B) 원본을 트랜스크립트 파일에 보존하면서 대화를 AI 생성 요약으로 압축 | C) 변경 사항의 글머리 목록 생성 | D) 대화를 파일로 내보내기
- **Correct**: B
- **Explanation**: 요약은 대화를 더 짧은 AI 생성 요약으로 압축합니다. 원본 전체 텍스트는 트랜스크립트 파일에 보존됩니다.
- **Review**: Summarize option 섹션

### Q7
- **Category**: conceptual
- **Question**: Checkpoints는 언제 자동으로 생성되나요?
- **Options**: A) 5분마다 | B) 모든 사용자 프롬프트에 | C) 수동으로 저장할 때만 | D) 모든 도구 사용 후
- **Correct**: B
- **Explanation**: 자동 checkpoints는 모든 사용자 프롬프트와 함께 생성되어 Claude가 요청을 처리하기 전의 상태를 캡처합니다.
- **Review**: Automatic checkpoints 섹션

### Q8
- **Category**: practical
- **Question**: 자동 checkpoint 생성을 비활성화하려면 어떻게 하나요?
- **Options**: A) `--no-checkpoints` 플래그 사용 | B) 설정에서 `autoCheckpoint: false` 설정 | C) checkpoints 디렉토리 삭제 | D) Checkpoints는 비활성화 불가
- **Correct**: B
- **Explanation**: 자동 checkpoint 생성을 비활성화하려면 설정에서 `autoCheckpoint: false`를 설정하세요 (기본값은 true).
- **Review**: Configuration 섹션

### Q9
- **Category**: conceptual
- **Question**: Checkpoints는 git commits의 대체인가요?
- **Options**: A) 예, 더 강력함 | B) 아니오, 상호 보완적 — checkpoints는 세션 범위이고 만료되며, git은 영구적이고 공유 가능 | C) 예, 소규모 프로젝트에서는 | D) 솔로 개발에서만
- **Correct**: B
- **Explanation**: Checkpoints는 임시적(30일 보존), 세션 범위이며 공유할 수 없습니다. Git commits는 영구적이고 감사 가능하며 공유 가능합니다. 둘 다 함께 사용하세요.
- **Review**: Integration with git 섹션

### Q10
- **Category**: practical
- **Question**: 두 가지 접근 방식을 비교하고 싶습니다. 권장되는 checkpoint 워크플로우는 무엇인가요?
- **Options**: A) 두 개의 별도 세션 생성 | B) 접근 방식 A 전에 checkpoint, 시도 후 rewind, 접근 방식 B 시도, 결과 비교 | C) 대신 git branches 사용 | D) 접근 방식을 비교하는 좋은 방법이 없음
- **Correct**: B
- **Explanation**: 분기 전략: 깨끗한 상태에서 checkpoint, 접근 방식 A 시도 후 결과 기록, 동일 checkpoint로 rewind, 접근 방식 B 시도. 두 결과 비교.
- **Review**: Workflow patterns 섹션

---

## Lesson 09: Advanced Features

### Q1
- **Category**: conceptual
- **Question**: Claude Code의 여섯 가지 권한 모드는 무엇인가요?
- **Options**: A) read, write, execute, admin, root, sudo | B) default, acceptEdits, plan, auto, dontAsk, bypassPermissions | C) safe, normal, elevated, admin, unrestricted, god | D) view, edit, run, deploy, full, bypass
- **Correct**: B
- **Explanation**: 여섯 가지 모드: default(모든 것에 프롬프트), acceptEdits(파일 편집 자동 수락), plan(읽기 전용 분석), auto(백그라운드 분류기가 결정), dontAsk(사전 승인 패턴과 일치하지 않으면 자동 거부), bypassPermissions(모든 검사 건너뜀).
- **Review**: Permission Modes 섹션

### Q2
- **Category**: practical
- **Question**: planning 모드를 활성화하려면 어떻게 하나요?
- **Options**: A) `/plan` 명령어로만 | B) `/plan`, `Shift+Tab`/`Alt+M`, `--permission-mode plan` 플래그, 또는 기본 설정으로 | C) `--planning` 플래그로만 | D) Planning은 항상 켜져 있음
- **Correct**: B
- **Explanation**: Planning 모드는 여러 방법으로 활성화할 수 있습니다: /plan 명령어, Shift+Tab/Alt+M 키보드 단축키, --permission-mode plan CLI 플래그, 또는 설정의 기본값으로.
- **Review**: Planning Mode 섹션

### Q3
- **Category**: conceptual
- **Question**: `opusplan` 모델 별칭은 무엇을 하나요?
- **Options**: A) 모든 것에 Opus만 사용 | B) 계획 단계에는 Opus, 구현에는 Sonnet 사용 | C) 특별히 계획에 최적화된 모델 사용 | D) 자동으로 plan 모드 활성화
- **Correct**: B
- **Explanation**: `opusplan`은 계획 단계(더 높은 품질 분석)에는 Opus를 사용하고 실행 단계(더 빠른 구현)에는 Sonnet을 사용하는 모델 별칭입니다.
- **Review**: Planning Mode 섹션

### Q4
- **Category**: practical
- **Question**: 세션 중 extended thinking을 어떻게 토글하나요?
- **Options**: A) `/think` 입력 | B) `Option+T` (macOS) 또는 `Alt+T` 누르기 | C) `--thinking` 플래그 사용 | D) 항상 활성화되어 있고 토글 불가
- **Correct**: B
- **Explanation**: Option+T (macOS) 또는 Alt+T가 extended thinking을 토글합니다. 모든 모델에 대해 기본적으로 활성화됩니다. Opus 4.6은 적응형 노력 수준을 지원합니다.
- **Review**: Extended Thinking 섹션

### Q5
- **Category**: conceptual
- **Question**: "think"나 "ultrathink"가 향상된 사고를 활성화하는 특별 키워드인가요?
- **Options**: A) 예, 더 깊은 추론을 활성화 | B) 아니오, 특별한 동작 없는 일반 프롬프트 텍스트로 처리됨 | C) "ultrathink"만 특별 | D) Opus에서만 작동
- **Correct**: B
- **Explanation**: 문서는 이것들이 특별한 활성화 키워드가 아닌 일반 프롬프트 지시임을 명시합니다. Extended thinking은 Alt+T 토글과 환경 변수로 제어됩니다.
- **Review**: Extended Thinking 섹션

### Q6
- **Category**: practical
- **Question**: 구조화된 JSON 출력과 턴 제한으로 CI/CD 파이프라인에서 Claude를 실행하려면 어떻게 하나요?
- **Options**: A) `claude --ci --json --limit 3` | B) `claude -p --output-format json --max-turns 3 "review code"` | C) `claude --pipeline --format json` | D) `claude run --json --turns 3`
- **Correct**: B
- **Explanation**: `--output-format json`과 `--max-turns`가 있는 Print 모드(`-p`)가 표준 CI/CD 통합 패턴입니다.
- **Review**: Headless/Print Mode 섹션

### Q7
- **Category**: conceptual
- **Question**: Task List 기능(Ctrl+T)은 무엇을 제공하나요?
- **Options**: A) 실행 중인 백그라운드 프로세스 목록 | B) 컨텍스트 압축에서 살아남는 영구 할 일 목록으로 `CLAUDE_CODE_TASK_LIST_ID`로 공유 가능 | C) 과거 세션의 이력 | D) 보류 중인 도구 호출 대기열
- **Correct**: B
- **Explanation**: Task List(Ctrl+T)는 컨텍스트 압축 전반에 걸쳐 영구적이며 `CLAUDE_CODE_TASK_LIST_ID`를 사용하여 명명된 작업 디렉토리를 통해 세션 간 공유할 수 있습니다.
- **Review**: Task List 섹션

### Q8
- **Category**: practical
- **Question**: planning 모드 중 외부(선호하는 에디터)에서 계획을 편집하려면 어떻게 하나요?
- **Options**: A) 터미널에서 복사-붙여넣기 | B) `Ctrl+G`를 눌러 외부 에디터에서 계획 열기 | C) `/export-plan` 명령어 사용 | D) 계획은 외부에서 편집 불가
- **Correct**: B
- **Explanation**: Ctrl+G는 수정을 위해 설정된 외부 에디터에서 현재 계획을 엽니다.
- **Review**: Planning Mode 섹션

### Q9
- **Category**: conceptual
- **Question**: `dontAsk`와 `bypassPermissions` 모드의 차이는 무엇인가요?
- **Options**: A) 동일함 | B) `dontAsk`는 사전 승인 없으면 자동 거부, `bypassPermissions`는 모든 검사를 완전히 건너뜀 | C) `dontAsk`는 파일용, `bypassPermissions`는 명령어용 | D) `bypassPermissions`가 더 안전함
- **Correct**: B
- **Explanation**: dontAsk는 사전 승인 패턴과 일치하지 않으면 권한 요청을 자동 거부합니다. bypassPermissions는 모든 안전 검사를 완전히 건너뜁니다 — 일상적인 사용에는 위험합니다.
- **Review**: Permission Modes 섹션

### Q10
- **Category**: practical
- **Question**: CLI 세션을 데스크톱 앱으로 전환하려면 어떻게 하나요?
- **Options**: A) `/export` 명령어 사용 | B) `/desktop` 명령어 사용 | C) 세션 ID를 복사하여 앱에 붙여넣기 | D) CLI와 데스크톱 간 세션 전환 불가
- **Correct**: B
- **Explanation**: `/desktop` 명령어는 현재 CLI 세션을 시각적 diff 검토 및 다중 세션 관리를 위한 네이티브 데스크톱 앱으로 전환합니다.
- **Review**: Desktop App 섹션

---

## Lesson 10: CLI Reference

### Q1
- **Category**: conceptual
- **Question**: Claude CLI의 두 가지 주요 모드는 무엇인가요?
- **Options**: A) 온라인 및 오프라인 모드 | B) Interactive REPL(`claude`)과 Print 모드(`claude -p`) | C) GUI 및 터미널 모드 | D) 단일 및 배치 모드
- **Correct**: B
- **Explanation**: Interactive REPL은 기본 대화 모드입니다. Print 모드(-p)는 비대화형으로 스크립트 가능하고 파이프 가능 — 하나의 응답 후 종료됩니다.
- **Review**: CLI architecture 섹션

### Q2
- **Category**: practical
- **Question**: 파일을 Claude에 파이프하고 JSON 출력을 얻으려면 어떻게 하나요?
- **Options**: A) `claude --file error.log --json` | B) `cat error.log | claude -p --output-format json "explain this"` | C) `claude < error.log --format json` | D) `claude -p --input error.log --json`
- **Correct**: B
- **Explanation**: stdin을 통해 print 모드(-p)로 내용을 파이프하고 구조화된 출력을 위해 --output-format json을 사용하세요.
- **Review**: Interactive vs Print Mode 섹션

### Q3
- **Category**: conceptual
- **Question**: `-c`와 `-r` 플래그의 차이는 무엇인가요?
- **Options**: A) 둘 다 같은 동작 | B) `-c`는 가장 최근 세션을 계속, `-r`은 이름 또는 ID로 재개 | C) `-c`는 새 세션 생성, `-r`은 재개 | D) `-c`는 코드용, `-r`은 리뷰용
- **Correct**: B
- **Explanation**: `-c/--continue`는 가장 최근 대화를 재개합니다. `-r/--resume "name"`은 이름 또는 세션 ID로 특정 세션을 재개합니다.
- **Review**: Session management 섹션

### Q4
- **Category**: practical
- **Question**: Claude에서 스키마 유효성이 보장된 JSON 출력을 얻으려면 어떻게 하나요?
- **Options**: A) `--output-format json`만 사용 | B) `--output-format json --json-schema '{"type":"object",...}'` 사용 | C) `--strict-json` 플래그 사용 | D) JSON 출력은 항상 스키마 유효
- **Correct**: B
- **Explanation**: `--output-format json`만으로는 최선 노력 JSON을 생성합니다. JSON Schema 정의와 함께 `--json-schema`를 추가하면 출력이 스키마와 일치함을 보장합니다.
- **Review**: Output and format 섹션

### Q5
- **Category**: conceptual
- **Question**: print 모드(-p)에서만 작동하고 interactive 모드에서는 효과가 없는 플래그는 무엇인가요?
- **Options**: A) `--model` | B) `--system-prompt-file` | C) `--verbose` | D) `--max-turns`
- **Correct**: B
- **Explanation**: `--system-prompt-file`은 파일에서 시스템 프롬프트를 로드하지만 print 모드에서만 작동합니다. interactive 세션에는 `--system-prompt`(인라인 문자열)를 사용하세요.
- **Review**: System prompt flags comparison table

### Q6
- **Category**: practical
- **Question**: 보안 감사를 위해 Claude를 읽기 전용 도구만 사용하도록 제한하려면 어떻게 하나요?
- **Options**: A) `claude --read-only "audit code"` | B) `claude --permission-mode plan --tools "Read,Grep,Glob" "audit code"` | C) `claude --safe-mode "audit code"` | D) `claude --no-write "audit code"`
- **Correct**: B
- **Explanation**: `--permission-mode plan`(읽기 전용 분석)과 `--tools`(특정 도구의 허용 목록)를 결합하여 Claude를 읽기 작업으로만 제한하세요.
- **Review**: Tool and permission management 섹션

### Q7
- **Category**: conceptual
- **Question**: 에이전트 정의 우선순위 순서는 무엇인가요?
- **Options**: A) Project > User > CLI | B) CLI > User > Project | C) User > CLI > Project | D) 모두 동일한 우선순위
- **Correct**: B
- **Explanation**: CLI에서 정의된 에이전트(--agents 플래그)가 가장 높은 우선순위를 가지며, 그 다음 User 레벨(~/.claude/agents/), 그 다음 Project 레벨(.claude/agents/).
- **Review**: Agents configuration 섹션

### Q8
- **Category**: practical
- **Question**: 원본을 잃지 않고 다른 접근 방식을 시도하기 위해 기존 세션을 포크하려면 어떻게 하나요?
- **Options**: A) `/fork` 명령어 사용 | B) `--resume session-name --fork-session "branch name"` 사용 | C) `--clone session-name` 사용 | D) `/branch session-name` 사용
- **Correct**: B
- **Explanation**: `--resume`과 `--fork-session`을 함께 사용하면 재개된 세션에서 독립적인 새 브랜치를 생성하여 원본 대화를 보존합니다.
- **Review**: Session management 섹션

### Q9
- **Category**: conceptual
- **Question**: 사용자가 로그인된 경우 `claude auth status`의 종료 코드는 무엇인가요?
- **Options**: A) 1 | B) 0 | C) 200 | D) 종료 코드를 반환하지 않음
- **Correct**: B
- **Explanation**: `claude auth status`는 로그인된 경우 코드 0으로, 로그인되지 않은 경우 1로 종료합니다. CI/CD 인증 검사에 스크립트화할 수 있습니다.
- **Review**: CLI commands table

### Q10
- **Category**: practical
- **Question**: Claude로 여러 파일을 배치 처리하려면 어떻게 하나요?
- **Options**: A) `claude --batch *.md` | B) for 루프 사용: `for file in *.md; do claude -p "summarize: $(cat $file)" > ${file%.md}.json; done` | C) `claude -p --files *.md "summarize all"` | D) 배치 처리는 지원되지 않음
- **Correct**: B
- **Explanation**: print 모드와 함께 셸 for 루프를 사용하여 파일을 하나씩 처리하세요. 각 호출은 독립적이며 구조화된 출력을 생성할 수 있습니다.
- **Review**: Batch processing 섹션
