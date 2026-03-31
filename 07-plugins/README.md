<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code Plugins

이 폴더에는 여러 Claude Code 기능을 하나의 응집력 있고 설치 가능한 패키지로 묶은 완전한 플러그인 예제들이 포함되어 있습니다.

## 개요

Claude Code Plugins는 커스터마이징(slash commands, subagents, MCP 서버, hooks)을 묶어 단일 명령으로 설치할 수 있는 번들 컬렉션입니다. 여러 기능을 하나의 응집력 있고 공유 가능한 패키지로 결합하는 최상위 확장 메커니즘입니다.

## 플러그인 아키텍처

```mermaid
graph TB
    A["Plugin"]
    B["Slash Commands"]
    C["Subagents"]
    D["MCP Servers"]
    E["Hooks"]
    F["Configuration"]

    A -->|bundles| B
    A -->|bundles| C
    A -->|bundles| D
    A -->|bundles| E
    A -->|bundles| F
```

## 플러그인 로딩 과정

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Plugin as Plugin Marketplace
    participant Install as Installation
    participant SlashCmds as Slash Commands
    participant Subagents
    participant MCPServers as MCP Servers
    participant Hooks
    participant Tools as Configured Tools

    User->>Claude: /plugin install pr-review
    Claude->>Plugin: Download plugin manifest
    Plugin-->>Claude: Return plugin definition
    Claude->>Install: Extract components
    Install->>SlashCmds: Configure
    Install->>Subagents: Configure
    Install->>MCPServers: Configure
    Install->>Hooks: Configure
    SlashCmds-->>Tools: Ready to use
    Subagents-->>Tools: Ready to use
    MCPServers-->>Tools: Ready to use
    Hooks-->>Tools: Ready to use
    Tools-->>Claude: Plugin installed ✅
```

## 플러그인 유형 및 배포 방식

| 유형 | 범위 | 공유 대상 | 관리 주체 | 예시 |
|------|-------|--------|-----------|----------|
| 공식(Official) | 전역 | 모든 사용자 | Anthropic | PR Review, Security Guidance |
| 커뮤니티(Community) | 공개 | 모든 사용자 | 커뮤니티 | DevOps, Data Science |
| 조직(Organization) | 내부 | 팀 구성원 | 회사 | 내부 표준, 도구 |
| 개인(Personal) | 개인 | 단일 사용자 | 개발자 | 커스텀 워크플로우 |

## 플러그인 정의 구조

플러그인 manifest는 `.claude-plugin/plugin.json`에 JSON 형식으로 작성합니다:

```json
{
  "name": "my-first-plugin",
  "description": "A greeting plugin",
  "version": "1.0.0",
  "author": {
    "name": "Your Name"
  },
  "homepage": "https://example.com",
  "repository": "https://github.com/user/repo",
  "license": "MIT"
}
```

## 플러그인 구조 예시

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json       # Manifest (name, description, version, author)
├── commands/             # Skills as Markdown files
│   ├── task-1.md
│   ├── task-2.md
│   └── workflows/
├── agents/               # Custom agent definitions
│   ├── specialist-1.md
│   ├── specialist-2.md
│   └── configs/
├── skills/               # Agent Skills with SKILL.md files
│   ├── skill-1.md
│   └── skill-2.md
├── hooks/                # Event handlers in hooks.json
│   └── hooks.json
├── .mcp.json             # MCP server configurations
├── .lsp.json             # LSP server configurations
├── settings.json         # Default settings
├── templates/
│   └── issue-template.md
├── scripts/
│   ├── helper-1.sh
│   └── helper-2.py
├── docs/
│   ├── README.md
│   └── USAGE.md
└── tests/
    └── plugin.test.js
```

### LSP 서버 설정

플러그인은 실시간 코드 인텔리전스를 위한 Language Server Protocol(LSP) 지원을 포함할 수 있습니다. LSP 서버는 작업 중에 진단, 코드 탐색, 심볼 정보를 제공합니다.

**설정 위치**:
- 플러그인 루트 디렉토리의 `.lsp.json` 파일
- `plugin.json`의 인라인 `lsp` 키

#### 필드 참조

| 필드 | 필수 여부 | 설명 |
|-------|----------|-------------|
| `command` | 필수 | LSP 서버 바이너리 (PATH에 있어야 함) |
| `extensionToLanguage` | 필수 | 파일 확장자를 언어 ID에 매핑 |
| `args` | 선택 | 서버의 커맨드라인 인수 |
| `transport` | 선택 | 통신 방식: `stdio` (기본값) 또는 `socket` |
| `env` | 선택 | 서버 프로세스용 환경 변수 |
| `initializationOptions` | 선택 | LSP 초기화 시 전달되는 옵션 |
| `settings` | 선택 | 서버에 전달되는 워크스페이스 설정 |
| `workspaceFolder` | 선택 | 워크스페이스 폴더 경로 재정의 |
| `startupTimeout` | 선택 | 서버 시작 대기 최대 시간(ms) |
| `shutdownTimeout` | 선택 | 정상 종료를 위한 최대 시간(ms) |
| `restartOnCrash` | 선택 | 서버 충돌 시 자동 재시작 여부 |
| `maxRestarts` | 선택 | 포기 전 최대 재시작 횟수 |

#### 설정 예시

**Go (gopls)**:

```json
{
  "go": {
    "command": "gopls",
    "args": ["serve"],
    "extensionToLanguage": {
      ".go": "go"
    }
  }
}
```

**Python (pyright)**:

```json
{
  "python": {
    "command": "pyright-langserver",
    "args": ["--stdio"],
    "extensionToLanguage": {
      ".py": "python",
      ".pyi": "python"
    }
  }
}
```

**TypeScript**:

```json
{
  "typescript": {
    "command": "typescript-language-server",
    "args": ["--stdio"],
    "extensionToLanguage": {
      ".ts": "typescript",
      ".tsx": "typescriptreact",
      ".js": "javascript",
      ".jsx": "javascriptreact"
    }
  }
}
```

#### 사용 가능한 LSP 플러그인

공식 마켓플레이스에는 미리 설정된 LSP 플러그인이 포함되어 있습니다:

| 플러그인 | 언어 | 서버 바이너리 | 설치 명령 |
|--------|----------|---------------|----------------|
| `pyright-lsp` | Python | `pyright-langserver` | `pip install pyright` |
| `typescript-lsp` | TypeScript/JavaScript | `typescript-language-server` | `npm install -g typescript-language-server typescript` |
| `rust-lsp` | Rust | `rust-analyzer` | `rustup component add rust-analyzer`으로 설치 |

#### LSP 기능

설정이 완료되면 LSP 서버가 다음 기능을 제공합니다:

- **즉각적인 진단** — 편집 직후 오류 및 경고 표시
- **코드 탐색** — 정의로 이동, 참조 찾기, 구현 확인
- **호버 정보** — 호버 시 타입 서명 및 문서 표시
- **심볼 목록** — 현재 파일 또는 워크스페이스의 심볼 탐색

## 플러그인 옵션 (v2.1.83+)

플러그인은 manifest의 `userConfig`를 통해 사용자가 설정 가능한 옵션을 선언할 수 있습니다. `sensitive: true`로 표시된 값은 일반 텍스트 설정 파일 대신 시스템 키체인에 저장됩니다:

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "userConfig": {
    "apiKey": {
      "description": "API key for the service",
      "sensitive": true
    },
    "region": {
      "description": "Deployment region",
      "default": "us-east-1"
    }
  }
}
```

## 영구적 플러그인 데이터 (`${CLAUDE_PLUGIN_DATA}`) (v2.1.78+)

플러그인은 `${CLAUDE_PLUGIN_DATA}` 환경 변수를 통해 영구 상태 디렉토리에 접근할 수 있습니다. 이 디렉토리는 플러그인별로 고유하며 세션이 종료되어도 유지되므로, 캐시, 데이터베이스 등 영구적인 상태 저장에 적합합니다:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "command": "node ${CLAUDE_PLUGIN_DATA}/track-usage.js"
      }
    ]
  }
}
```

플러그인이 설치될 때 디렉토리가 자동으로 생성됩니다. 여기에 저장된 파일은 플러그인을 제거할 때까지 유지됩니다.

## 설정을 통한 인라인 플러그인 (`source: 'settings'`) (v2.1.80+)

플러그인은 `source: 'settings'` 필드를 사용하여 설정 파일에 마켓플레이스 항목으로 인라인 정의될 수 있습니다. 이를 통해 별도의 저장소나 마켓플레이스 없이 플러그인 정의를 직접 포함할 수 있습니다:

```json
{
  "pluginMarketplaces": [
    {
      "name": "inline-tools",
      "source": "settings",
      "plugins": [
        {
          "name": "quick-lint",
          "source": "./local-plugins/quick-lint"
        }
      ]
    }
  ]
}
```

## 플러그인 설정

플러그인은 기본 설정을 제공하기 위해 `settings.json` 파일을 포함할 수 있습니다. 현재 플러그인의 메인 스레드 에이전트를 설정하는 `agent` 키를 지원합니다:

```json
{
  "agent": "agents/specialist-1.md"
}
```

플러그인이 `settings.json`을 포함하는 경우, 설치 시 기본값이 적용됩니다. 사용자는 자신의 프로젝트 또는 사용자 설정에서 이 설정을 재정의할 수 있습니다.

## 독립 실행 방식 vs 플러그인 방식

| 방식 | 커맨드 이름 | 설정 | 적합한 상황 |
|----------|---------------|---|---|
| **독립 실행(Standalone)** | `/hello` | CLAUDE.md에 수동 설정 | 개인, 프로젝트별 용도 |
| **Plugins** | `/plugin-name:hello` | plugin.json으로 자동화 | 공유, 배포, 팀 사용 |

빠른 개인 워크플로우에는 **독립 실행 slash commands**를 사용하세요. 여러 기능을 묶거나 팀과 공유하거나 배포하려면 **plugins**를 사용하세요.

## 실용적인 예시

### 예시 1: PR Review 플러그인

**파일:** `.claude-plugin/plugin.json`

```json
{
  "name": "pr-review",
  "version": "1.0.0",
  "description": "Complete PR review workflow with security, testing, and docs",
  "author": {
    "name": "Anthropic"
  },
  "repository": "https://github.com/anthropic/pr-review",
  "license": "MIT"
}
```

**파일:** `commands/review-pr.md`

```markdown
---
name: Review PR
description: Start comprehensive PR review with security and testing checks
---

# PR Review

This command initiates a complete pull request review including:

1. Security analysis
2. Test coverage verification
3. Documentation updates
4. Code quality checks
5. Performance impact assessment
```

**파일:** `agents/security-reviewer.md`

```yaml
---
name: security-reviewer
description: Security-focused code review
tools: read, grep, diff
---

# Security Reviewer

Specializes in finding security vulnerabilities:
- Authentication/authorization issues
- Data exposure
- Injection attacks
- Secure configuration
```

**설치:**

```bash
/plugin install pr-review

# 결과:
# ✅ 3 slash commands installed
# ✅ 3 subagents configured
# ✅ 2 MCP servers connected
# ✅ 4 hooks registered
# ✅ Ready to use!
```

### 예시 2: DevOps 플러그인

**구성 요소:**

```
devops-automation/
├── commands/
│   ├── deploy.md
│   ├── rollback.md
│   ├── status.md
│   └── incident.md
├── agents/
│   ├── deployment-specialist.md
│   ├── incident-commander.md
│   └── alert-analyzer.md
├── mcp/
│   ├── github-config.json
│   ├── kubernetes-config.json
│   └── prometheus-config.json
├── hooks/
│   ├── pre-deploy.js
│   ├── post-deploy.js
│   └── on-error.js
└── scripts/
    ├── deploy.sh
    ├── rollback.sh
    └── health-check.sh
```

### 예시 3: 문서화 플러그인

**번들 구성 요소:**

```
documentation/
├── commands/
│   ├── generate-api-docs.md
│   ├── generate-readme.md
│   ├── sync-docs.md
│   └── validate-docs.md
├── agents/
│   ├── api-documenter.md
│   ├── code-commentator.md
│   └── example-generator.md
├── mcp/
│   ├── github-docs-config.json
│   └── slack-announce-config.json
└── templates/
    ├── api-endpoint.md
    ├── function-docs.md
    └── adr-template.md
```

## 플러그인 마켓플레이스

공식 Anthropic 관리 플러그인 디렉토리는 `anthropics/claude-plugins-official`입니다. 엔터프라이즈 관리자는 내부 배포를 위한 비공개 플러그인 마켓플레이스를 별도로 생성할 수도 있습니다.

```mermaid
graph TB
    A["Plugin Marketplace"]
    B["Official<br/>anthropics/claude-plugins-official"]
    C["Community<br/>Marketplace"]
    D["Enterprise<br/>Private Registry"]

    A --> B
    A --> C
    A --> D

    B -->|Categories| B1["Development"]
    B -->|Categories| B2["DevOps"]
    B -->|Categories| B3["Documentation"]

    C -->|Search| C1["DevOps Automation"]
    C -->|Search| C2["Mobile Dev"]
    C -->|Search| C3["Data Science"]

    D -->|Internal| D1["Company Standards"]
    D -->|Internal| D2["Legacy Systems"]
    D -->|Internal| D3["Compliance"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#e8f5e9,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#fff3e0,stroke:#333,color:#333
```

### 마켓플레이스 설정

엔터프라이즈 및 고급 사용자는 설정을 통해 마켓플레이스 동작을 제어할 수 있습니다:

| 설정 | 설명 |
|---------|-------------|
| `extraKnownMarketplaces` | 기본값 외에 추가 마켓플레이스 소스를 추가 |
| `strictKnownMarketplaces` | 사용자가 추가할 수 있는 마켓플레이스를 제어 |
| `deniedPlugins` | 특정 플러그인 설치를 방지하는 관리자 관리 차단 목록 |

### 마켓플레이스 추가 기능

- **기본 git 타임아웃**: 대형 플러그인 저장소를 위해 30초에서 120초로 증가
- **커스텀 npm 레지스트리**: 플러그인이 의존성 해결을 위한 커스텀 npm 레지스트리 URL을 지정 가능
- **버전 고정(Version pinning)**: 재현 가능한 환경을 위해 플러그인을 특정 버전에 고정

### 마켓플레이스 정의 스키마

플러그인 마켓플레이스는 `.claude-plugin/marketplace.json`에 정의합니다:

```json
{
  "name": "my-team-plugins",
  "owner": "my-org",
  "plugins": [
    {
      "name": "code-standards",
      "source": "./plugins/code-standards",
      "description": "Enforce team coding standards",
      "version": "1.2.0",
      "author": "platform-team"
    },
    {
      "name": "deploy-helper",
      "source": {
        "source": "github",
        "repo": "my-org/deploy-helper",
        "ref": "v2.0.0"
      },
      "description": "Deployment automation workflows"
    }
  ]
}
```

| 필드 | 필수 여부 | 설명 |
|-------|----------|-------------|
| `name` | 필수 | kebab-case 형식의 마켓플레이스 이름 |
| `owner` | 필수 | 마켓플레이스를 유지 관리하는 조직 또는 사용자 |
| `plugins` | 필수 | 플러그인 항목 배열 |
| `plugins[].name` | 필수 | 플러그인 이름 (kebab-case) |
| `plugins[].source` | 필수 | 플러그인 소스 (경로 문자열 또는 소스 객체) |
| `plugins[].description` | 선택 | 플러그인 간단 설명 |
| `plugins[].version` | 선택 | 시맨틱 버전 문자열 |
| `plugins[].author` | 선택 | 플러그인 작성자 이름 |

### 플러그인 소스 유형

플러그인은 여러 위치에서 가져올 수 있습니다:

| 소스 | 문법 | 예시 |
|--------|--------|---------|
| **상대 경로** | 문자열 경로 | `"./plugins/my-plugin"` |
| **GitHub** | `{ "source": "github", "repo": "owner/repo" }` | `{ "source": "github", "repo": "acme/lint-plugin", "ref": "v1.0" }` |
| **Git URL** | `{ "source": "url", "url": "..." }` | `{ "source": "url", "url": "https://git.internal/plugin.git" }` |
| **Git 하위 디렉토리** | `{ "source": "git-subdir", "url": "...", "path": "..." }` | `{ "source": "git-subdir", "url": "https://github.com/org/monorepo.git", "path": "packages/plugin" }` |
| **npm** | `{ "source": "npm", "package": "..." }` | `{ "source": "npm", "package": "@acme/claude-plugin", "version": "^2.0" }` |
| **pip** | `{ "source": "pip", "package": "..." }` | `{ "source": "pip", "package": "claude-data-plugin", "version": ">=1.0" }` |

GitHub 및 git 소스는 버전 고정을 위한 선택적 `ref`(브랜치/태그) 및 `sha`(커밋 해시) 필드를 지원합니다.

### 배포 방법

**GitHub (권장)**:
```bash
# 사용자가 마켓플레이스를 추가하는 명령
/plugin marketplace add owner/repo-name
```

**기타 git 서비스** (전체 URL 필요):
```bash
/plugin marketplace add https://gitlab.com/org/marketplace-repo.git
```

**비공개 저장소**: git 자격 증명 헬퍼 또는 환경 토큰을 통해 지원됩니다. 사용자는 저장소에 읽기 권한이 있어야 합니다.

**공식 마켓플레이스 제출**: 더 넓은 배포를 위해 Anthropic 큐레이션 마켓플레이스에 플러그인을 제출합니다.

### 엄격 모드(Strict mode)

마켓플레이스 정의와 로컬 `plugin.json` 파일이 상호작용하는 방식을 제어합니다:

| 설정 | 동작 |
|---------|----------|
| `strict: true` (기본값) | 로컬 `plugin.json`이 권위 있음; 마켓플레이스 항목이 보완 |
| `strict: false` | 마켓플레이스 항목이 전체 플러그인 정의가 됨 |

`strictKnownMarketplaces`를 이용한 **조직 제한**:

| 값 | 효과 |
|-------|--------|
| 미설정 | 제한 없음 — 사용자가 어떤 마켓플레이스든 추가 가능 |
| 빈 배열 `[]` | 잠금 — 마켓플레이스 추가 불가 |
| 패턴 배열 | 허용 목록 — 매칭되는 마켓플레이스만 추가 가능 |

```json
{
  "strictKnownMarketplaces": [
    "my-org/*",
    "github.com/trusted-vendor/*"
  ]
}
```

> **경고**: `strictKnownMarketplaces`와 함께 엄격 모드에서는 사용자가 허용 목록에 있는 마켓플레이스의 플러그인만 설치할 수 있습니다. 플러그인 배포를 제어해야 하는 엔터프라이즈 환경에 유용합니다.

## 플러그인 설치 및 생애주기

```mermaid
graph LR
    A["Discover"] -->|Browse| B["Marketplace"]
    B -->|Select| C["Plugin Page"]
    C -->|View| D["Components"]
    D -->|Install| E["/plugin install"]
    E -->|Extract| F["Configure"]
    F -->|Activate| G["Use"]
    G -->|Check| H["Update"]
    H -->|Available| G
    G -->|Done| I["Disable"]
    I -->|Later| J["Enable"]
    J -->|Back| G
```

## 플러그인 기능 비교

| 기능 | Slash Command | Skill | Subagent | Plugin |
|---------|---------------|-------|----------|--------|
| **설치** | 수동 복사 | 수동 복사 | 수동 설정 | 단일 명령 |
| **설정 시간** | 5분 | 10분 | 15분 | 2분 |
| **번들링** | 단일 파일 | 단일 파일 | 단일 파일 | 다중 |
| **버전 관리** | 수동 | 수동 | 수동 | 자동 |
| **팀 공유** | 파일 복사 | 파일 복사 | 파일 복사 | 설치 ID |
| **업데이트** | 수동 | 수동 | 수동 | 자동 제공 |
| **의존성** | 없음 | 없음 | 없음 | 포함 가능 |
| **마켓플레이스** | 없음 | 없음 | 없음 | 있음 |
| **배포** | 저장소 | 저장소 | 저장소 | 마켓플레이스 |

## 플러그인 CLI 명령

모든 플러그인 작업은 CLI 명령으로 사용 가능합니다:

```bash
claude plugin install <name>@<marketplace>   # 마켓플레이스에서 설치
claude plugin uninstall <name>               # 플러그인 제거
claude plugin list                           # 설치된 플러그인 목록
claude plugin enable <name>                  # 비활성화된 플러그인 활성화
claude plugin disable <name>                 # 플러그인 비활성화
claude plugin validate                       # 플러그인 구조 유효성 검사
```

## 설치 방법

### 마켓플레이스에서 설치
```bash
/plugin install plugin-name
# 또는 CLI에서:
claude plugin install plugin-name@marketplace-name
```

### 활성화 / 비활성화 (범위 자동 감지)
```bash
/plugin enable plugin-name
/plugin disable plugin-name
```

### 로컬 플러그인 (개발용)
```bash
# 로컬 테스트를 위한 CLI 플래그 (여러 플러그인에 반복 사용 가능)
claude --plugin-dir ./path/to/plugin
claude --plugin-dir ./plugin-a --plugin-dir ./plugin-b
```

### Git 저장소에서 설치
```bash
/plugin install github:username/repo
```

## 플러그인 생성 시점

```mermaid
graph TD
    A["Should I create a plugin?"]
    A -->|Need multiple components| B{"Multiple commands<br/>or subagents<br/>or MCPs?"}
    B -->|Yes| C["✅ Create Plugin"]
    B -->|No| D["Use Individual Feature"]
    A -->|Team workflow| E{"Share with<br/>team?"}
    E -->|Yes| C
    E -->|No| F["Keep as Local Setup"]
    A -->|Complex setup| G{"Needs auto<br/>configuration?"}
    G -->|Yes| C
    G -->|No| D
```

### 플러그인 활용 사례

| 활용 사례 | 권장 사항 | 이유 |
|----------|-----------------|-----|
| **팀 온보딩** | ✅ 플러그인 사용 | 즉각적인 설정, 모든 설정 포함 |
| **프레임워크 설정** | ✅ 플러그인 사용 | 프레임워크별 명령 번들 |
| **엔터프라이즈 표준** | ✅ 플러그인 사용 | 중앙 배포, 버전 관리 |
| **빠른 작업 자동화** | ❌ Command 사용 | 플러그인은 과도한 복잡성 |
| **단일 도메인 전문성** | ❌ Skill 사용 | 너무 무거움, skill 사용 권장 |
| **특화된 분석** | ❌ Subagent 사용 | 수동으로 생성하거나 skill 사용 |
| **실시간 데이터 접근** | ❌ MCP 사용 | 독립 실행, 번들 불필요 |

## 플러그인 테스트

게시 전에 `--plugin-dir` CLI 플래그를 사용하여 플러그인을 로컬에서 테스트합니다 (여러 플러그인에 반복 사용 가능):

```bash
claude --plugin-dir ./my-plugin
claude --plugin-dir ./my-plugin --plugin-dir ./another-plugin
```

이를 통해 플러그인이 로드된 Claude Code가 실행되어 다음을 확인할 수 있습니다:
- 모든 slash commands 사용 가능 여부 확인
- subagents와 에이전트 정상 동작 테스트
- MCP 서버 올바른 연결 확인
- hook 실행 유효성 검사
- LSP 서버 설정 확인
- 설정 오류 확인

## 핫 리로드(Hot-Reload)

플러그인은 개발 중 핫 리로드를 지원합니다. 플러그인 파일을 수정하면 Claude Code가 변경 사항을 자동으로 감지할 수 있습니다. 다음 명령으로 강제 리로드도 가능합니다:

```bash
/reload-plugins
```

이 명령은 세션을 재시작하지 않고 모든 플러그인 manifest, commands, agents, skills, hooks, MCP/LSP 설정을 다시 읽습니다.

## 플러그인 관리 설정

관리자는 관리 설정을 사용하여 조직 전체의 플러그인 동작을 제어할 수 있습니다:

| 설정 | 설명 |
|---------|-------------|
| `enabledPlugins` | 기본적으로 활성화되는 플러그인 허용 목록 |
| `deniedPlugins` | 설치할 수 없는 플러그인 차단 목록 |
| `extraKnownMarketplaces` | 기본값 외에 추가 마켓플레이스 소스를 추가 |
| `strictKnownMarketplaces` | 사용자가 추가할 수 있는 마켓플레이스 제한 |
| `allowedChannelPlugins` | 릴리스 채널별 허용 플러그인 제어 |

이 설정들은 관리 설정 파일을 통해 조직 수준에서 적용되며 사용자 수준 설정보다 우선합니다.

## 플러그인 보안

플러그인 subagents는 제한된 샌드박스에서 실행됩니다. 다음 frontmatter 키는 플러그인 subagent 정의에서 **허용되지 않습니다**:

- `hooks` -- Subagents는 이벤트 핸들러를 등록할 수 없음
- `mcpServers` -- Subagents는 MCP 서버를 설정할 수 없음
- `permissionMode` -- Subagents는 권한 모델을 재정의할 수 없음

이를 통해 플러그인이 선언된 범위를 넘어 권한을 확대하거나 호스트 환경을 수정할 수 없도록 보장합니다.

## 플러그인 게시

**게시 단계:**

1. 모든 구성 요소를 포함한 플러그인 구조 생성
2. `.claude-plugin/plugin.json` manifest 작성
3. 문서화를 위한 `README.md` 작성
4. `claude --plugin-dir ./my-plugin`으로 로컬 테스트
5. 플러그인 마켓플레이스에 제출
6. 검토 및 승인
7. 마켓플레이스에 게시
8. 사용자가 단일 명령으로 설치 가능

**제출 예시:**

```markdown
# PR Review Plugin

## Description
Complete PR review workflow with security, testing, and documentation checks.

## What's Included
- 3 slash commands for different review types
- 3 specialized subagents
- GitHub and CodeQL MCP integration
- Automated security scanning hooks

## Installation
```bash
/plugin install pr-review
```

## Features
✅ Security analysis
✅ Test coverage checking
✅ Documentation verification
✅ Code quality assessment
✅ Performance impact analysis

## Usage
```bash
/review-pr
/check-security
/check-tests
```

## Requirements
- Claude Code 1.0+
- GitHub access
- CodeQL (optional)
```

## 플러그인 vs 수동 설정

**수동 설정 (2시간 이상):**
- slash commands를 하나씩 설치
- subagents를 개별적으로 생성
- MCPs를 별도로 설정
- hooks를 수동으로 설정
- 모든 내용 문서화
- 팀과 공유 (올바르게 설정되기를 기대)

**플러그인 사용 시 (2분):**
```bash
/plugin install pr-review
# ✅ 모든 것이 설치 및 설정됨
# ✅ 즉시 사용 가능
# ✅ 팀이 동일한 설정 재현 가능
```

## 모범 사례

### 권장 사항 ✅
- 명확하고 설명적인 플러그인 이름 사용
- 포괄적인 README 포함
- 플러그인 버전을 올바르게 관리 (semver)
- 모든 구성 요소를 함께 테스트
- 요구 사항 명확히 문서화
- 사용 예시 제공
- 오류 처리 포함
- 검색을 위한 적절한 태그 지정
- 하위 호환성 유지
- 플러그인을 집중적이고 응집력 있게 유지
- 포괄적인 테스트 포함
- 모든 의존성 문서화

### 금지 사항 ❌
- 관련 없는 기능을 번들로 묶지 말 것
- 자격 증명을 하드코딩하지 말 것
- 테스트를 건너뛰지 말 것
- 문서화를 잊지 말 것
- 중복 플러그인을 만들지 말 것
- 버전 관리를 무시하지 말 것
- 구성 요소 의존성을 과도하게 복잡하게 만들지 말 것
- 오류를 정상적으로 처리하는 것을 잊지 말 것

## 설치 안내

### 마켓플레이스에서 설치

1. **사용 가능한 플러그인 탐색:**
   ```bash
   /plugin list
   ```

2. **플러그인 상세 정보 확인:**
   ```bash
   /plugin info plugin-name
   ```

3. **플러그인 설치:**
   ```bash
   /plugin install plugin-name
   ```

### 로컬 경로에서 설치

```bash
/plugin install ./path/to/plugin-directory
```

### GitHub에서 설치

```bash
/plugin install github:username/repo
```

### 설치된 플러그인 목록 확인

```bash
/plugin list --installed
```

### 플러그인 업데이트

```bash
/plugin update plugin-name
```

### 플러그인 비활성화/활성화

```bash
# 일시적으로 비활성화
/plugin disable plugin-name

# 다시 활성화
/plugin enable plugin-name
```

### 플러그인 제거

```bash
/plugin uninstall plugin-name
```

## 관련 개념

다음 Claude Code 기능들은 플러그인과 함께 동작합니다:

- **[Slash Commands](../01-slash-commands/)** — 플러그인에 번들된 개별 명령
- **[Memory](../02-memory/)** — 플러그인을 위한 영구적 컨텍스트
- **[Skills](../03-skills/)** — 플러그인으로 래핑될 수 있는 도메인 전문성
- **[Subagents](../04-subagents/)** — 플러그인 구성 요소로 포함된 특화 에이전트
- **[MCP Servers](../05-mcp/)** — 플러그인에 번들된 Model Context Protocol 통합
- **[Hooks](../06-hooks/)** — 플러그인 워크플로우를 트리거하는 이벤트 핸들러

## 완전한 예시 워크플로우

### PR Review 플러그인 전체 워크플로우

```
1. 사용자: /review-pr

2. 플러그인 실행:
   ├── pre-review.js hook이 git 저장소 유효성 검사
   ├── GitHub MCP가 PR 데이터 가져오기
   ├── security-reviewer subagent가 보안 분석
   ├── test-checker subagent가 커버리지 확인
   └── performance-analyzer subagent가 성능 점검

3. 결과 종합 및 표시:
   ✅ Security: No critical issues
   ⚠️  Testing: Coverage 65% (recommend 80%+)
   ✅ Performance: No significant impact
   📝 12 recommendations provided
```

## 문제 해결

### 플러그인이 설치되지 않는 경우
- Claude Code 버전 호환성 확인: `/version`
- JSON 유효성 검사기로 `plugin.json` 문법 확인
- 인터넷 연결 확인 (원격 플러그인의 경우)
- 권한 확인: `ls -la plugin/`

### 구성 요소가 로드되지 않는 경우
- `plugin.json`의 경로가 실제 디렉토리 구조와 일치하는지 확인
- 파일 권한 확인: `chmod +x scripts/`
- 구성 요소 파일 문법 검토
- 로그 확인: `/plugin debug plugin-name`

### MCP 연결 실패
- 환경 변수가 올바르게 설정되어 있는지 확인
- MCP 서버 설치 및 상태 확인
- `/mcp test`로 MCP 연결을 독립적으로 테스트
- `mcp/` 디렉토리의 MCP 설정 검토

### 설치 후 명령을 사용할 수 없는 경우
- 플러그인이 성공적으로 설치되었는지 확인: `/plugin list --installed`
- 플러그인 활성화 여부 확인: `/plugin status plugin-name`
- Claude Code 재시작: `exit` 후 다시 열기
- 기존 명령과의 이름 충돌 확인

### Hook 실행 문제
- hook 파일에 올바른 권한이 있는지 확인
- hook 문법 및 이벤트 이름 확인
- 오류 세부 정보를 위한 hook 로그 검토
- 가능하다면 hooks 수동 테스트

## 추가 리소스

- [공식 Plugins 문서](https://code.claude.com/docs/en/plugins)
- [Plugins 탐색](https://code.claude.com/docs/en/discover-plugins)
- [Plugin Marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- [Plugins 참조](https://code.claude.com/docs/en/plugins-reference)
- [MCP Server 참조](https://modelcontextprotocol.io/)
- [Subagent 설정 가이드](../04-subagents/README.md)
- [Hook 시스템 참조](../06-hooks/README.md)
