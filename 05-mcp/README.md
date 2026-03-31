<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# MCP (Model Context Protocol)

이 폴더에는 Claude Code와 함께 사용하는 MCP 서버 설정 및 활용에 관한 포괄적인 문서와 예제가 담겨 있습니다.

## 개요

MCP (Model Context Protocol)는 Claude가 외부 도구, API, 실시간 데이터 소스에 접근하기 위한 표준화된 방법입니다. Memory와 달리 MCP는 변화하는 데이터에 실시간으로 접근합니다.

주요 특징:
- 외부 서비스에 실시간 접근
- 라이브 데이터 동기화
- 확장 가능한 아키텍처
- 안전한 인증
- 도구 기반 상호작용

## MCP 아키텍처

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["External Service"]

    A -->|Request: list_issues| B
    B -->|Query| C
    C -->|Data| B
    B -->|Response| A

    A -->|Request: create_issue| B
    B -->|Action| C
    C -->|Result| B
    B -->|Response| A

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#e8f5e9,stroke:#333,color:#333
```

## MCP 생태계

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#f3e5f5,stroke:#333,color:#333
    style G fill:#e8f5e9,stroke:#333,color:#333
    style H fill:#e8f5e9,stroke:#333,color:#333
    style I fill:#e8f5e9,stroke:#333,color:#333
    style J fill:#e8f5e9,stroke:#333,color:#333
    style K fill:#e8f5e9,stroke:#333,color:#333
```

## MCP 설치 방법

Claude Code는 MCP 서버 연결에 여러 전송 프로토콜을 지원합니다.

### HTTP 전송 (권장)

```bash
# 기본 HTTP 연결
claude mcp add --transport http notion https://mcp.notion.com/mcp

# 인증 헤더 포함 HTTP 연결
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### Stdio 전송 (로컬)

로컬에서 실행 중인 MCP 서버에 사용합니다.

```bash
# 로컬 Node.js 서버
claude mcp add --transport stdio myserver -- npx @myorg/mcp-server

# 환경 변수 포함
claude mcp add --transport stdio myserver --env KEY=value -- npx server
```

### SSE 전송 (deprecated)

Server-Sent Events 전송은 `http`로 대체되어 deprecated되었지만 여전히 지원됩니다.

```bash
claude mcp add --transport sse legacy-server https://example.com/sse
```

### WebSocket 전송

지속적인 양방향 연결을 위한 WebSocket 전송입니다.

```bash
claude mcp add --transport ws realtime-server wss://example.com/mcp
```

### Windows 특이사항

네이티브 Windows(WSL 제외)에서는 npx 명령에 `cmd /c`를 사용합니다.

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

### OAuth 2.0 인증

Claude Code는 OAuth 2.0이 필요한 MCP 서버를 지원합니다. OAuth가 활성화된 서버에 연결할 때 Claude Code가 전체 인증 흐름을 처리합니다.

```bash
# OAuth가 활성화된 MCP 서버에 연결 (대화형 흐름)
claude mcp add --transport http my-service https://my-service.example.com/mcp

# 비대화형 설정을 위한 OAuth 자격 증명 사전 구성
claude mcp add --transport http my-service https://my-service.example.com/mcp \
  --client-id "your-client-id" \
  --client-secret "your-client-secret" \
  --callback-port 8080
```

| 기능 | 설명 |
|---------|-------------|
| **대화형 OAuth** | `/mcp`를 사용하여 브라우저 기반 OAuth 흐름 시작 |
| **사전 구성된 OAuth 클라이언트** | Notion, Stripe 등 일반적인 서비스를 위한 내장 OAuth 클라이언트 (v2.1.30+) |
| **사전 구성된 자격 증명** | 자동화 설정을 위한 `--client-id`, `--client-secret`, `--callback-port` 플래그 |
| **토큰 저장** | 토큰은 시스템 키체인에 안전하게 저장됨 |
| **단계적 인증** | 권한이 필요한 작업에 대한 step-up 인증 지원 |
| **검색 캐싱** | OAuth 검색 메타데이터를 캐싱하여 재연결 속도 향상 |
| **메타데이터 재정의** | `.mcp.json`의 `oauth.authServerMetadataUrl`로 기본 OAuth 메타데이터 검색 재정의 |

#### OAuth 메타데이터 검색 재정의

MCP 서버가 표준 OAuth 메타데이터 엔드포인트(`/.well-known/oauth-authorization-server`)에서 오류를 반환하지만 작동하는 OIDC 엔드포인트를 노출하는 경우, Claude Code에 특정 URL에서 OAuth 메타데이터를 가져오도록 지정할 수 있습니다. 서버 설정의 `oauth` 객체에 `authServerMetadataUrl`을 설정합니다.

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "oauth": {
        "authServerMetadataUrl": "https://auth.example.com/.well-known/openid-configuration"
      }
    }
  }
}
```

URL은 반드시 `https://`를 사용해야 합니다. 이 옵션은 Claude Code v2.1.64 이상이 필요합니다.

### Claude.ai MCP 커넥터

Claude.ai 계정에 설정된 MCP 서버는 Claude Code에서 자동으로 사용할 수 있습니다. Claude.ai 웹 인터페이스를 통해 설정한 MCP 연결은 별도 설정 없이 접근 가능합니다.

Claude.ai MCP 커넥터는 `--print` 모드(v2.1.83+)에서도 사용할 수 있어 비대화형 및 스크립트 방식의 활용이 가능합니다.

Claude Code에서 Claude.ai MCP 서버를 비활성화하려면 `ENABLE_CLAUDEAI_MCP_SERVERS` 환경 변수를 `false`로 설정합니다.

```bash
ENABLE_CLAUDEAI_MCP_SERVERS=false claude
```

> **참고:** 이 기능은 Claude.ai 계정으로 로그인한 사용자에게만 제공됩니다.

## MCP 설정 프로세스

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Config File
    participant Service as External Service

    User->>Claude: Type /mcp
    Claude->>Claude: List available MCP servers
    Claude->>User: Show options
    User->>Claude: Select GitHub MCP
    Claude->>Config: Update configuration
    Config->>Claude: Activate connection
    Claude->>Service: Test connection
    Service-->>Claude: Authentication successful
    Claude->>User: ✅ MCP connected!
```

## MCP 도구 검색

MCP 도구 설명이 컨텍스트 창의 10%를 초과하면 Claude Code는 자동으로 도구 검색을 활성화하여 모델 컨텍스트를 과부하시키지 않고 적절한 도구를 효율적으로 선택합니다.

| 설정 | 값 | 설명 |
|---------|-------|-------------|
| `ENABLE_TOOL_SEARCH` | `auto` (기본값) | 도구 설명이 컨텍스트의 10%를 초과하면 자동 활성화 |
| `ENABLE_TOOL_SEARCH` | `auto:<N>` | 사용자 지정 임계값 `N`개 도구에서 자동 활성화 |
| `ENABLE_TOOL_SEARCH` | `true` | 도구 수에 관계없이 항상 활성화 |
| `ENABLE_TOOL_SEARCH` | `false` | 비활성화; 모든 도구 설명을 전체 전송 |

> **참고:** 도구 검색은 Sonnet 4 이상 또는 Opus 4 이상이 필요합니다. Haiku 모델은 도구 검색을 지원하지 않습니다.

## 동적 도구 업데이트

Claude Code는 MCP `list_changed` 알림을 지원합니다. MCP 서버가 동적으로 도구를 추가, 제거, 수정하면 Claude Code가 업데이트를 수신하고 재연결이나 재시작 없이 자동으로 도구 목록을 조정합니다.

## MCP 요청(Elicitation)

MCP 서버는 대화형 다이얼로그를 통해 사용자에게 구조화된 입력을 요청할 수 있습니다(v2.1.49+). 이를 통해 MCP 서버가 워크플로 도중 추가 정보를 요청할 수 있습니다. 예를 들어, 확인 요청, 옵션 목록 중 선택, 필수 필드 입력 등 MCP 서버 상호작용에 대화성을 추가합니다.

## 도구 설명 및 지침 크기 제한

v2.1.84부터 Claude Code는 MCP 서버당 도구 설명 및 지침에 **2 KB 제한**을 적용합니다. 이는 개별 서버가 지나치게 장황한 도구 정의로 과도한 컨텍스트를 소비하는 것을 방지하여 컨텍스트 비대화를 줄이고 상호작용을 효율적으로 유지합니다.

## MCP 프롬프트를 슬래시 명령으로 사용

MCP 서버는 Claude Code에서 슬래시 명령으로 나타나는 프롬프트를 노출할 수 있습니다. 프롬프트는 다음 명명 규칙으로 접근합니다.

```
/mcp__<server>__<prompt>
```

예를 들어, `github`라는 서버가 `review`라는 프롬프트를 노출하면 `/mcp__github__review`로 호출할 수 있습니다.

## 서버 중복 제거

동일한 MCP 서버가 여러 범위(local, project, user)에 정의된 경우 로컬 설정이 우선합니다. 이를 통해 충돌 없이 프로젝트 수준 또는 사용자 수준 MCP 설정을 로컬 커스터마이징으로 재정의할 수 있습니다.

## @ 멘션을 통한 MCP 리소스 참조

`@` 멘션 구문을 사용하여 프롬프트에서 MCP 리소스를 직접 참조할 수 있습니다.

```
@server-name:protocol://resource/path
```

예를 들어, 특정 데이터베이스 리소스를 참조하려면 다음과 같이 합니다.

```
@database:postgres://mydb/users
```

이를 통해 Claude가 MCP 리소스 내용을 가져와 대화 컨텍스트의 일부로 인라인 포함할 수 있습니다.

## MCP 범위

MCP 설정은 다양한 공유 수준을 가진 여러 범위에 저장할 수 있습니다.

| 범위 | 위치 | 설명 | 공유 대상 | 승인 필요 |
|-------|----------|-------------|-------------|------------------|
| **Local** (기본값) | `~/.claude.json` (프로젝트 경로 아래) | 현재 사용자, 현재 프로젝트에만 비공개 (이전 버전에서는 `project`라 불림) | 본인만 | 아니오 |
| **Project** | `.mcp.json` | git 저장소에 커밋됨 | 팀 구성원 | 예 (최초 사용 시) |
| **User** | `~/.claude.json` | 모든 프로젝트에서 사용 가능 (이전 버전에서는 `global`이라 불림) | 본인만 | 아니오 |

### Project 범위 사용

프로젝트별 MCP 설정을 `.mcp.json`에 저장합니다.

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.github.com/mcp"
    }
  }
}
```

팀 구성원은 프로젝트 MCP를 최초 사용 시 승인 프롬프트를 보게 됩니다.

## MCP 설정 관리

### MCP 서버 추가

```bash
# HTTP 기반 서버 추가
claude mcp add --transport http github https://api.github.com/mcp

# 로컬 stdio 서버 추가
claude mcp add --transport stdio database -- npx @company/db-server

# 모든 MCP 서버 나열
claude mcp list

# 특정 서버 세부 정보 확인
claude mcp get github

# MCP 서버 제거
claude mcp remove github

# 프로젝트별 승인 선택 초기화
claude mcp reset-project-choices

# Claude Desktop에서 가져오기
claude mcp add-from-claude-desktop
```

## 사용 가능한 MCP 서버 목록

| MCP 서버 | 목적 | 주요 도구 | 인증 | 실시간 |
|------------|---------|--------------|------|-----------|
| **Filesystem** | 파일 작업 | read, write, delete | OS 권한 | ✅ 예 |
| **GitHub** | 저장소 관리 | list_prs, create_issue, push | OAuth | ✅ 예 |
| **Slack** | 팀 커뮤니케이션 | send_message, list_channels | Token | ✅ 예 |
| **Database** | SQL 쿼리 | query, insert, update | 자격 증명 | ✅ 예 |
| **Google Docs** | 문서 접근 | read, write, share | OAuth | ✅ 예 |
| **Asana** | 프로젝트 관리 | create_task, update_status | API Key | ✅ 예 |
| **Stripe** | 결제 데이터 | list_charges, create_invoice | API Key | ✅ 예 |
| **Memory** | 영구 메모리 | store, retrieve, delete | 로컬 | ❌ 아니오 |

## 실용적인 예제

### 예제 1: GitHub MCP 설정

**파일:** `.mcp.json` (프로젝트 루트)

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**사용 가능한 GitHub MCP 도구:**

#### Pull Request 관리
- `list_prs` - 저장소의 모든 PR 나열
- `get_pr` - diff 포함 PR 세부 정보 가져오기
- `create_pr` - 새 PR 생성
- `update_pr` - PR 설명/제목 업데이트
- `merge_pr` - PR을 main 브랜치에 병합
- `review_pr` - 리뷰 댓글 추가

**요청 예시:**
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

#### 이슈 관리
- `list_issues` - 모든 이슈 나열
- `get_issue` - 이슈 세부 정보 가져오기
- `create_issue` - 새 이슈 생성
- `close_issue` - 이슈 닫기
- `add_comment` - 이슈에 댓글 추가

#### 저장소 정보
- `get_repo_info` - 저장소 세부 정보
- `list_files` - 파일 트리 구조
- `get_file_content` - 파일 내용 읽기
- `search_code` - 코드베이스 전체 검색

#### 커밋 작업
- `list_commits` - 커밋 이력
- `get_commit` - 특정 커밋 세부 정보
- `create_commit` - 새 커밋 생성

**설정**:
```bash
export GITHUB_TOKEN="your_github_token"
# 또는 CLI를 사용하여 직접 추가:
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

### 설정에서의 환경 변수 확장

MCP 설정은 기본값이 있는 환경 변수 확장을 지원합니다. `${VAR}` 및 `${VAR:-default}` 구문은 `command`, `args`, `env`, `url`, `headers` 필드에서 동작합니다.

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_HEADER:-default-value}"
      }
    },
    "local-server": {
      "command": "${MCP_BIN_PATH:-npx}",
      "args": ["${MCP_PACKAGE:-@company/mcp-server}"],
      "env": {
        "DB_URL": "${DATABASE_URL:-postgresql://localhost/dev}"
      }
    }
  }
}
```

변수는 런타임에 확장됩니다:
- `${VAR}` - 환경 변수 사용, 설정되지 않으면 오류
- `${VAR:-default}` - 환경 변수 사용, 설정되지 않으면 기본값으로 대체

### 예제 2: Database MCP 설정

**설정:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-database"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost/mydb"
      }
    }
  }
}
```

**사용 예시:**

```markdown
User: Fetch all users with more than 10 orders

Claude: I'll query your database to find that information.

# Using MCP database tool:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Results:
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

**설정**:
```bash
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
# 또는 CLI를 사용하여 직접 추가:
claude mcp add --transport stdio database -- npx @modelcontextprotocol/server-database
```

### 예제 3: 다중 MCP 워크플로

**시나리오: 일일 보고서 생성**

```markdown
# 여러 MCP를 활용한 일일 보고서 워크플로

## 설정
1. GitHub MCP - PR 지표 가져오기
2. Database MCP - 영업 데이터 쿼리
3. Slack MCP - 보고서 게시
4. Filesystem MCP - 보고서 저장

## 워크플로

### 1단계: GitHub 데이터 가져오기
/mcp__github__list_prs completed:true last:7days

출력:
- 총 PR: 42
- 평균 병합 시간: 2.3시간
- 리뷰 응답 시간: 1.1시간

### 2단계: 데이터베이스 쿼리
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

출력:
- 판매: 247건
- 매출: $12,450

### 3단계: 보고서 생성
데이터를 HTML 보고서로 통합

### 4단계: 파일시스템에 저장
report.html을 /reports/에 저장

### 5단계: Slack에 게시
#daily-reports 채널에 요약 전송

최종 출력:
✅ 보고서 생성 및 게시 완료
📊 이번 주 PR 병합: 47건
💰 일일 매출: $12,450
```

**설정**:
```bash
export GITHUB_TOKEN="your_github_token"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="your_slack_token"
# CLI를 통해 각 MCP 서버를 추가하거나 .mcp.json에 설정
```

### 예제 4: Filesystem MCP 작업

**설정:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**사용 가능한 작업:**

| 작업 | 명령 | 목적 |
|-----------|---------|---------|
| 파일 목록 | `ls ~/projects` | 디렉토리 내용 표시 |
| 파일 읽기 | `cat src/main.ts` | 파일 내용 읽기 |
| 파일 쓰기 | `create docs/api.md` | 새 파일 생성 |
| 파일 편집 | `edit src/app.ts` | 파일 수정 |
| 검색 | `grep "async function"` | 파일 내 검색 |
| 삭제 | `rm old-file.js` | 파일 삭제 |

**설정**:
```bash
# CLI를 사용하여 직접 추가:
claude mcp add --transport stdio filesystem -- npx @modelcontextprotocol/server-filesystem /home/user/projects
```

## MCP vs Memory: 결정 매트릭스

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style A fill:#fff3e0,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#fff3e0,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#e8f5e9,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
```

## 요청/응답 패턴

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Database

    App->>MCP: Request: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Execute query
    DB-->>MCP: Result set
    MCP-->>App: Return parsed data
    App->>App: Process result
    App->>App: Continue task

    Note over MCP,DB: Real-time access<br/>No caching
```

## 환경 변수

민감한 자격 증명은 환경 변수에 저장합니다.

```bash
# ~/.bashrc 또는 ~/.zshrc
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxx"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="xoxb-xxxxxxxxxxxxx"
```

그런 다음 MCP 설정에서 참조합니다.

```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

## Claude를 MCP 서버로 사용 (`claude mcp serve`)

Claude Code 자체가 다른 애플리케이션을 위한 MCP 서버로 동작할 수 있습니다. 이를 통해 외부 도구, 편집기, 자동화 시스템이 표준 MCP 프로토콜을 통해 Claude의 기능을 활용할 수 있습니다.

```bash
# Claude Code를 stdio MCP 서버로 시작
claude mcp serve
```

다른 애플리케이션은 stdio 기반 MCP 서버처럼 이 서버에 연결할 수 있습니다. 예를 들어, 다른 Claude Code 인스턴스에 Claude Code를 MCP 서버로 추가하려면 다음과 같이 합니다.

```bash
claude mcp add --transport stdio claude-agent -- claude mcp serve
```

이는 한 Claude 인스턴스가 다른 인스턴스를 조율하는 멀티 에이전트 워크플로를 구축할 때 유용합니다.

## 관리형 MCP 설정 (엔터프라이즈)

엔터프라이즈 배포를 위해 IT 관리자는 `managed-mcp.json` 설정 파일을 통해 MCP 서버 정책을 강제할 수 있습니다. 이 파일은 조직 전체에서 허용되거나 차단되는 MCP 서버를 독점적으로 제어합니다.

**위치:**
- macOS: `/Library/Application Support/ClaudeCode/managed-mcp.json`
- Linux: `~/.config/ClaudeCode/managed-mcp.json`
- Windows: `%APPDATA%\ClaudeCode\managed-mcp.json`

**기능:**
- `allowedMcpServers` -- 허용된 서버의 화이트리스트
- `deniedMcpServers` -- 금지된 서버의 블랙리스트
- 서버 이름, 명령, URL 패턴으로 매칭 지원
- 사용자 설정 이전에 적용되는 조직 전체 MCP 정책
- 승인되지 않은 서버 연결 방지

**설정 예시:**

```json
{
  "allowedMcpServers": [
    {
      "serverName": "github",
      "serverUrl": "https://api.github.com/mcp"
    },
    {
      "serverName": "company-internal",
      "serverCommand": "company-mcp-server"
    }
  ],
  "deniedMcpServers": [
    {
      "serverName": "untrusted-*"
    },
    {
      "serverUrl": "http://*"
    }
  ]
}
```

> **참고:** `allowedMcpServers`와 `deniedMcpServers` 모두 서버에 매칭되면 거부 규칙이 우선합니다.

## 플러그인 제공 MCP 서버

플러그인은 자체 MCP 서버를 번들로 포함하여 플러그인 설치 시 자동으로 사용 가능하게 할 수 있습니다. 플러그인 제공 MCP 서버는 두 가지 방식으로 정의할 수 있습니다.

1. **독립 `.mcp.json`** -- 플러그인 루트 디렉토리에 `.mcp.json` 파일 배치
2. **`plugin.json`에 인라인 정의** -- 플러그인 매니페스트 내에 직접 MCP 서버 정의

플러그인의 설치 디렉토리에 상대적인 경로를 참조하려면 `${CLAUDE_PLUGIN_ROOT}` 변수를 사용합니다.

```json
{
  "mcpServers": {
    "plugin-tools": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/dist/mcp-server.js"],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config.json"
      }
    }
  }
}
```

## Subagent 범위 MCP

MCP 서버는 에이전트 프론트매터의 `mcpServers:` 키를 사용하여 인라인으로 정의할 수 있으며, 전체 프로젝트가 아닌 특정 Subagent에 한정됩니다. 이는 워크플로의 다른 에이전트는 필요하지 않지만 특정 에이전트만 특정 MCP 서버에 접근해야 할 때 유용합니다.

```yaml
---
mcpServers:
  my-tool:
    type: http
    url: https://my-tool.example.com/mcp
---

You are an agent with access to my-tool for specialized operations.
```

Subagent 범위 MCP 서버는 해당 에이전트의 실행 컨텍스트 내에서만 사용 가능하며 부모 또는 형제 에이전트와 공유되지 않습니다.

## MCP 출력 제한

Claude Code는 컨텍스트 오버플로를 방지하기 위해 MCP 도구 출력에 제한을 적용합니다.

| 제한 | 임계값 | 동작 |
|-------|-----------|----------|
| **경고** | 10,000 토큰 | 출력이 크다는 경고 표시 |
| **기본 최대값** | 25,000 토큰 | 이 제한을 초과하면 출력 잘림 |
| **디스크 지속성** | 50,000자 | 50K자를 초과하는 도구 결과는 디스크에 저장 |

최대 출력 제한은 `MAX_MCP_OUTPUT_TOKENS` 환경 변수로 설정할 수 있습니다.

```bash
# 최대 출력을 50,000 토큰으로 늘리기
export MAX_MCP_OUTPUT_TOKENS=50000
```

## 코드 실행을 통한 컨텍스트 비대화 해결

MCP 도입이 확장됨에 따라 수백, 수천 개의 도구를 가진 수십 개의 서버에 연결하면 중요한 문제가 생깁니다: **컨텍스트 비대화**. 이는 MCP를 대규모로 사용할 때 가장 큰 문제이며, Anthropic 엔지니어링 팀은 직접 도구 호출 대신 코드 실행을 사용하는 우아한 해결책을 제안했습니다.

> **출처**: [Code Execution with MCP: Building More Efficient Agents](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic Engineering Blog

### 문제: 토큰 낭비의 두 가지 원인

**1. 도구 정의가 컨텍스트 창을 과부하시킴**

대부분의 MCP 클라이언트는 모든 도구 정의를 미리 로드합니다. 수천 개의 도구에 연결된 경우 모델은 사용자 요청을 읽기도 전에 수십만 토큰을 처리해야 합니다.

**2. 중간 결과가 추가 토큰을 소비함**

모든 중간 도구 결과가 모델의 컨텍스트를 통과합니다. Google Drive에서 Salesforce로 회의록을 전송하는 경우를 생각해보면 — 전체 회의록이 컨텍스트를 **두 번** 통과합니다: 읽을 때 한 번, 대상에 쓸 때 또 한 번. 2시간짜리 회의록은 50,000개 이상의 추가 토큰을 의미할 수 있습니다.

```mermaid
graph LR
    A["Model"] -->|"Tool Call: getDocument"| B["MCP Server"]
    B -->|"Full transcript (50K tokens)"| A
    A -->|"Tool Call: updateRecord<br/>(re-sends full transcript)"| B
    B -->|"Confirmation"| A

    style A fill:#ffcdd2,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
```

### 해결책: MCP 도구를 코드 API로 사용

도구 정의와 결과를 컨텍스트 창을 통해 전달하는 대신, 에이전트가 MCP 도구를 API로 호출하는 **코드를 작성**합니다. 코드는 샌드박스 실행 환경에서 실행되고 최종 결과만 모델로 반환됩니다.

```mermaid
graph LR
    A["Model"] -->|"Writes code"| B["Code Execution<br/>Environment"]
    B -->|"Calls tools directly"| C["MCP Servers"]
    C -->|"Data stays in<br/>execution env"| B
    B -->|"Only final result<br/>(minimal tokens)"| A

    style A fill:#c8e6c9,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
```

#### 작동 방식

MCP 도구는 타입이 있는 함수들의 파일 트리로 표현됩니다.

```
servers/
├── google-drive/
│   ├── getDocument.ts
│   └── index.ts
├── salesforce/
│   ├── updateRecord.ts
│   └── index.ts
└── ...
```

각 도구 파일에는 타입이 있는 래퍼가 포함됩니다.

```typescript
// ./servers/google-drive/getDocument.ts
import { callMCPTool } from "../../../client.js";

interface GetDocumentInput {
  documentId: string;
}

interface GetDocumentResponse {
  content: string;
}

export async function getDocument(
  input: GetDocumentInput
): Promise<GetDocumentResponse> {
  return callMCPTool<GetDocumentResponse>(
    'google_drive__get_document', input
  );
}
```

그런 다음 에이전트는 도구를 조율하는 코드를 작성합니다.

```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

// 데이터가 모델을 거치지 않고 도구 간에 직접 흐름
const transcript = (
  await gdrive.getDocument({ documentId: 'abc123' })
).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

**결과: 토큰 사용량이 약 150,000에서 약 2,000으로 감소 — 98.7% 절감.**

### 주요 이점

| 이점 | 설명 |
|---------|-------------|
| **점진적 공개** | 에이전트가 파일시스템을 탐색하여 미리 모든 도구를 로드하는 대신 필요한 도구 정의만 로드 |
| **컨텍스트 효율적 결과** | 데이터가 모델로 반환되기 전에 실행 환경에서 필터링/변환됨 |
| **강력한 제어 흐름** | 루프, 조건문, 오류 처리가 모델을 왕복하지 않고 코드에서 실행됨 |
| **프라이버시 보호** | 중간 데이터(PII, 민감한 기록)가 실행 환경에 유지되어 모델 컨텍스트에 들어가지 않음 |
| **상태 지속성** | 에이전트가 중간 결과를 파일에 저장하고 재사용 가능한 스킬 함수를 구축할 수 있음 |

#### 예시: 대용량 데이터셋 필터링

```typescript
// 코드 실행 없이 — 10,000개 행이 모두 컨텍스트를 통과
// TOOL CALL: gdrive.getSheet(sheetId: 'abc123')
//   -> returns 10,000 rows in context

// 코드 실행 사용 — 실행 환경에서 필터링
const allRows = await gdrive.getSheet({ sheetId: 'abc123' });
const pendingOrders = allRows.filter(
  row => row["Status"] === 'pending'
);
console.log(`Found ${pendingOrders.length} pending orders`);
console.log(pendingOrders.slice(0, 5)); // 5개 행만 모델에 도달
```

#### 예시: 왕복 없는 루프

```typescript
// 배포 알림을 폴링 — 전적으로 코드에서 실행
let found = false;
while (!found) {
  const messages = await slack.getChannelHistory({
    channel: 'C123456'
  });
  found = messages.some(
    m => m.text.includes('deployment complete')
  );
  if (!found) await new Promise(r => setTimeout(r, 5000));
}
console.log('Deployment notification received');
```

### 고려해야 할 트레이드오프

코드 실행은 자체적인 복잡성을 도입합니다. 에이전트가 생성한 코드를 실행하려면 다음이 필요합니다.

- 적절한 리소스 제한이 있는 **안전한 샌드박스 실행 환경**
- 실행된 코드의 **모니터링 및 로깅**
- 직접 도구 호출에 비해 추가적인 **인프라 오버헤드**

토큰 비용 절감, 지연 시간 단축, 향상된 도구 구성 등의 이점을 이러한 구현 비용과 비교해야 합니다. MCP 서버가 몇 개뿐인 에이전트에서는 직접 도구 호출이 더 간단할 수 있습니다. 대규모(수십 개의 서버, 수백 개의 도구) 에이전트에서는 코드 실행이 상당한 개선입니다.

### MCPorter: MCP 도구 구성을 위한 런타임

[MCPorter](https://github.com/steipete/mcporter)는 보일러플레이트 없이 MCP 서버를 실용적으로 호출할 수 있게 하고, 선택적 도구 노출과 타입이 있는 래퍼를 통해 컨텍스트 비대화를 줄이는 데 도움을 주는 TypeScript 런타임 및 CLI 툴킷입니다.

**해결하는 문제:** 모든 MCP 서버의 모든 도구 정의를 미리 로드하는 대신 MCPorter를 사용하면 특정 도구를 온디맨드로 검색, 검사, 호출할 수 있어 컨텍스트를 가볍게 유지합니다.

**주요 기능:**

| 기능 | 설명 |
|---------|-------------|
| **설정 없는 검색** | Cursor, Claude, Codex 또는 로컬 설정에서 MCP 서버를 자동 검색 |
| **타입 있는 도구 클라이언트** | `mcporter emit-ts`가 `.d.ts` 인터페이스와 즉시 실행 가능한 래퍼 생성 |
| **조합 가능한 API** | `createServerProxy()`가 `.text()`, `.json()`, `.markdown()` 헬퍼와 함께 도구를 camelCase 메서드로 노출 |
| **CLI 생성** | `mcporter generate-cli`가 `--include-tools` / `--exclude-tools` 필터링 기능을 가진 독립 CLI로 MCP 서버를 변환 |
| **파라미터 숨김** | 선택적 파라미터가 기본적으로 숨겨져 스키마 장황함 감소 |

**설치:**

```bash
npx mcporter list          # 설치 불필요 — 즉시 서버 검색
pnpm add mcporter          # 프로젝트에 추가
brew install steipete/tap/mcporter  # macOS Homebrew를 통해 설치
```

**예시 — TypeScript에서 도구 구성:**

```typescript
import { createRuntime, createServerProxy } from "mcporter";

const runtime = await createRuntime();
const gdrive = createServerProxy(runtime, "google-drive");
const salesforce = createServerProxy(runtime, "salesforce");

// 데이터가 모델 컨텍스트를 거치지 않고 도구 간에 흐름
const doc = await gdrive.getDocument({ documentId: "abc123" });
await salesforce.updateRecord({
  objectType: "SalesMeeting",
  recordId: "00Q5f000001abcXYZ",
  data: { Notes: doc.text() }
});
```

**예시 — CLI 도구 호출:**

```bash
# 특정 도구를 직접 호출
npx mcporter call linear.create_comment issueId:ENG-123 body:'Looks good!'

# 사용 가능한 서버 및 도구 나열
npx mcporter list
```

MCPorter는 위에서 설명한 코드 실행 접근 방식을 보완하여 MCP 도구를 타입 있는 API로 호출하기 위한 런타임 인프라를 제공합니다 — 중간 데이터를 모델 컨텍스트 밖에 유지하는 것을 간단하게 만듭니다.

## 모범 사례

### 보안 고려 사항

#### 해야 할 것 ✅
- 모든 자격 증명에 환경 변수 사용
- 토큰 및 API 키 정기 교체 (월 1회 권장)
- 가능한 경우 읽기 전용 토큰 사용
- MCP 서버 접근 범위를 최소 필요 수준으로 제한
- MCP 서버 사용량 및 접근 로그 모니터링
- 외부 서비스에는 가능한 경우 OAuth 사용
- MCP 요청에 속도 제한 구현
- 프로덕션 사용 전 MCP 연결 테스트
- 모든 활성 MCP 연결 문서화
- MCP 서버 패키지를 최신 상태로 유지

#### 하지 말아야 할 것 ❌
- 설정 파일에 자격 증명 하드코딩 금지
- 토큰이나 시크릿을 git에 커밋 금지
- 팀 채팅이나 이메일에서 토큰 공유 금지
- 팀 프로젝트에 개인 토큰 사용 금지
- 불필요한 권한 부여 금지
- 인증 오류 무시 금지
- MCP 엔드포인트를 공개적으로 노출 금지
- root/admin 권한으로 MCP 서버 실행 금지
- 로그에 민감한 데이터 캐싱 금지
- 인증 메커니즘 비활성화 금지

### 설정 모범 사례

1. **버전 관리**: `.mcp.json`을 git에 유지하되 시크릿은 환경 변수 사용
2. **최소 권한**: 각 MCP 서버에 필요한 최소 권한만 부여
3. **격리**: 가능한 경우 서로 다른 MCP 서버를 별도 프로세스에서 실행
4. **모니터링**: 감사 추적을 위해 모든 MCP 요청 및 오류 로깅
5. **테스팅**: 프로덕션에 배포하기 전 모든 MCP 설정 테스트

### 성능 팁

- 애플리케이션 수준에서 자주 접근하는 데이터 캐싱
- 데이터 전송을 줄이기 위해 구체적인 MCP 쿼리 사용
- MCP 작업의 응답 시간 모니터링
- 외부 API에 대한 속도 제한 고려
- 여러 작업을 수행할 때 배치 처리 사용

## 설치 안내

### 사전 조건
- Node.js 및 npm 설치
- Claude Code CLI 설치
- 외부 서비스용 API 토큰/자격 증명

### 단계별 설정

1. **첫 번째 MCP 서버 추가** — CLI 사용 (예: GitHub):
```bash
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

   또는 프로젝트 루트에 `.mcp.json` 파일 생성:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

2. **환경 변수 설정:**
```bash
export GITHUB_TOKEN="your_github_personal_access_token"
```

3. **연결 테스트:**
```bash
claude /mcp
```

4. **MCP 도구 사용:**
```bash
/mcp__github__list_prs
/mcp__github__create_issue "Title" "Description"
```

### 특정 서비스 설치

**GitHub MCP:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**Database MCP:**
```bash
npm install -g @modelcontextprotocol/server-database
```

**Filesystem MCP:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Slack MCP:**
```bash
npm install -g @modelcontextprotocol/server-slack
```

## 문제 해결

### MCP 서버를 찾을 수 없음
```bash
# MCP 서버 설치 여부 확인
npm list -g @modelcontextprotocol/server-github

# 없으면 설치
npm install -g @modelcontextprotocol/server-github
```

### 인증 실패
```bash
# 환경 변수가 설정되어 있는지 확인
echo $GITHUB_TOKEN

# 필요한 경우 다시 내보내기
export GITHUB_TOKEN="your_token"

# 토큰에 올바른 권한이 있는지 확인
# https://github.com/settings/tokens 에서 GitHub 토큰 범위 확인
```

### 연결 타임아웃
- 네트워크 연결 확인: `ping api.github.com`
- API 엔드포인트 접근 가능 여부 확인
- API 속도 제한 확인
- 설정에서 타임아웃 값 늘리기 시도
- 방화벽 또는 프록시 문제 확인

### MCP 서버 충돌
- MCP 서버 로그 확인: `~/.claude/logs/`
- 모든 환경 변수가 설정되어 있는지 확인
- 적절한 파일 권한 확인
- MCP 서버 패키지 재설치 시도
- 동일 포트에서 충돌하는 프로세스 확인

## 관련 개념

### Memory vs MCP
- **Memory**: 변경되지 않는 영구 데이터 저장 (환경 설정, 컨텍스트, 이력)
- **MCP**: 변화하는 라이브 데이터 접근 (API, 데이터베이스, 실시간 서비스)

### 각각을 사용할 때
- **Memory 사용**: 사용자 환경 설정, 대화 이력, 학습된 컨텍스트
- **MCP 사용**: 현재 GitHub 이슈, 라이브 데이터베이스 쿼리, 실시간 데이터

### 다른 Claude 기능과의 통합
- 풍부한 컨텍스트를 위해 MCP와 Memory 결합
- 더 나은 추론을 위해 프롬프트에서 MCP 도구 사용
- 복잡한 워크플로를 위해 여러 MCP 활용

## 추가 자료

- [공식 MCP 문서](https://code.claude.com/docs/en/mcp)
- [MCP 프로토콜 사양](https://modelcontextprotocol.io/specification)
- [MCP GitHub 저장소](https://github.com/modelcontextprotocol/servers)
- [사용 가능한 MCP 서버](https://github.com/modelcontextprotocol/servers)
- [MCPorter](https://github.com/steipete/mcporter) — 보일러플레이트 없이 MCP 서버를 호출하기 위한 TypeScript 런타임 & CLI
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) — 컨텍스트 비대화 해결에 관한 Anthropic 엔지니어링 블로그
- [Claude Code CLI 레퍼런스](https://code.claude.com/docs/en/cli-reference)
- [Claude API 문서](https://docs.anthropic.com)
