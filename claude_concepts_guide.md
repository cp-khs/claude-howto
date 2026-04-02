<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude 개념 완전 가이드

Slash Commands, Subagents, Memory, MCP Protocol, Agent Skills를 표, 다이어그램, 실전 예제로 정리한 종합 참고 가이드입니다.

---

## 목차

1. [Slash Commands](#slash-commands)
2. [Subagents](#subagents)
3. [Memory](#memory)
4. [MCP Protocol](#mcp-protocol)
5. [Agent Skills](#agent-skills)
6. [Plugins](#claude-code-plugins)
7. [Hooks](#hooks)
8. [Checkpoints and Rewind](#checkpoints-and-rewind)
9. [Advanced Features](#advanced-features)
10. [비교 & 통합](#comparison--integration)

---

## Slash Commands

### 개요

Slash commands는 Claude Code가 실행할 수 있는 Markdown 파일로 저장된, 사용자가 직접 호출하는 단축 명령어입니다. 팀이 자주 사용하는 프롬프트와 워크플로우를 표준화할 수 있게 해줍니다.

### 아키텍처

```mermaid
graph TD
    A["User Input: /command-name"] -->|Triggers| B["Search .claude/commands/"]
    B -->|Finds| C["command-name.md"]
    C -->|Loads| D["Markdown Content"]
    D -->|Executes| E["Claude Processes Prompt"]
    E -->|Returns| F["Result in Context"]
```

### 파일 구조

```mermaid
graph LR
    A["Project Root"] -->|contains| B[".claude/commands/"]
    B -->|contains| C["optimize.md"]
    B -->|contains| D["test.md"]
    B -->|contains| E["docs/"]
    E -->|contains| F["generate-api-docs.md"]
    E -->|contains| G["generate-readme.md"]
```

### 명령어 구성 표

| 위치 | 범위 | 사용 가능 대상 | 활용 사례 | Git 추적 |
|----------|-------|--------------|----------|-------------|
| `.claude/commands/` | 프로젝트 전용 | 팀원 | 팀 워크플로우, 공유 기준 | ✅ 예 |
| `~/.claude/commands/` | 개인 | 개별 사용자 | 프로젝트 간 개인 단축키 | ❌ 아니오 |
| 하위 디렉토리 | 네임스페이스 | 상위 기준 | 카테고리별 구성 | ✅ 예 |

### 기능 및 지원 여부

| 기능 | 예시 | 지원 여부 |
|---------|---------|-----------|
| 셸 스크립트 실행 | `bash scripts/deploy.sh` | ✅ 예 |
| 파일 참조 | `@path/to/file.js` | ✅ 예 |
| bash 통합 | `$(git log --oneline)` | ✅ 예 |
| 인수 전달 | `/pr --verbose` | ✅ 예 |
| MCP 명령어 | `/mcp__github__list_prs` | ✅ 예 |

### 실전 예제

#### 예제 1: 코드 최적화 명령어

**파일:** `.claude/commands/optimize.md`

```markdown
---
name: Code Optimization
description: Analyze code for performance issues and suggest optimizations
tags: performance, analysis
---

# Code Optimization

Review the provided code for the following issues in order of priority:

1. **Performance bottlenecks** - identify O(n²) operations, inefficient loops
2. **Memory leaks** - find unreleased resources, circular references
3. **Algorithm improvements** - suggest better algorithms or data structures
4. **Caching opportunities** - identify repeated computations
5. **Concurrency issues** - find race conditions or threading problems

Format your response with:
- Issue severity (Critical/High/Medium/Low)
- Location in code
- Explanation
- Recommended fix with code example
```

**사용법:**
```bash
# Claude Code에서 입력
/optimize

# Claude가 프롬프트를 불러오고 코드 입력을 기다림
```

#### 예제 2: Pull Request 헬퍼 명령어

**파일:** `.claude/commands/pr.md`

```markdown
---
name: Prepare Pull Request
description: Clean up code, stage changes, and prepare a pull request
tags: git, workflow
---

# Pull Request Preparation Checklist

Before creating a PR, execute these steps:

1. Run linting: `prettier --write .`
2. Run tests: `npm test`
3. Review git diff: `git diff HEAD`
4. Stage changes: `git add .`
5. Create commit message following conventional commits:
   - `fix:` for bug fixes
   - `feat:` for new features
   - `docs:` for documentation
   - `refactor:` for code restructuring
   - `test:` for test additions
   - `chore:` for maintenance

6. Generate PR summary including:
   - What changed
   - Why it changed
   - Testing performed
   - Potential impacts
```

**사용법:**
```bash
/pr

# Claude가 체크리스트를 순서대로 실행하고 PR을 준비함
```

#### 예제 3: 계층형 문서 생성기

**파일:** `.claude/commands/docs/generate-api-docs.md`

```markdown
---
name: Generate API Documentation
description: Create comprehensive API documentation from source code
tags: documentation, api
---

# API Documentation Generator

Generate API documentation by:

1. Scanning all files in `/src/api/`
2. Extracting function signatures and JSDoc comments
3. Organizing by endpoint/module
4. Creating markdown with examples
5. Including request/response schemas
6. Adding error documentation

Output format:
- Markdown file in `/docs/api.md`
- Include curl examples for all endpoints
- Add TypeScript types
```

### 명령어 생명주기 다이어그램

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant FS as File System
    participant CLI as Shell/Bash

    User->>Claude: Types /optimize
    Claude->>FS: Searches .claude/commands/
    FS-->>Claude: Returns optimize.md
    Claude->>Claude: Loads Markdown content
    Claude->>User: Displays prompt context
    User->>Claude: Provides code to analyze
    Claude->>CLI: (May execute scripts)
    CLI-->>Claude: Results
    Claude->>User: Returns analysis
```

### 모범 사례

| ✅ 권장 | ❌ 비권장 |
|------|---------|
| 명확하고 행동 지향적인 이름 사용 | 일회성 작업에 명령어 생성 |
| 설명에 트리거 단어 문서화 | 명령어에 복잡한 로직 구현 |
| 단일 작업에 집중하는 명령어 유지 | 중복 명령어 생성 |
| 프로젝트 명령어를 버전 관리 | 민감한 정보 하드코딩 |
| 하위 디렉토리로 구성 | 긴 명령어 목록 생성 |
| 단순하고 읽기 쉬운 프롬프트 사용 | 축약어나 암호 같은 표현 사용 |

---

## Subagents

### 개요

Subagents는 격리된 컨텍스트 창과 맞춤형 시스템 프롬프트를 가진 전문화된 AI 어시스턴트입니다. 명확한 관심사 분리를 유지하면서 위임된 작업 실행을 가능하게 합니다.

### 아키텍처 다이어그램

```mermaid
graph TB
    User["👤 User"]
    Main["🎯 Main Agent<br/>(Coordinator)"]
    Reviewer["🔍 Code Reviewer<br/>Subagent"]
    Tester["✅ Test Engineer<br/>Subagent"]
    Docs["📝 Documentation<br/>Subagent"]

    User -->|asks| Main
    Main -->|delegates| Reviewer
    Main -->|delegates| Tester
    Main -->|delegates| Docs
    Reviewer -->|returns result| Main
    Tester -->|returns result| Main
    Docs -->|returns result| Main
    Main -->|synthesizes| User
```

### Subagent 생명주기

```mermaid
sequenceDiagram
    participant User
    participant MainAgent as Main Agent
    participant CodeReviewer as Code Reviewer<br/>Subagent
    participant Context as Separate<br/>Context Window

    User->>MainAgent: "Build new auth feature"
    MainAgent->>MainAgent: Analyze task
    MainAgent->>CodeReviewer: "Review this code"
    CodeReviewer->>Context: Initialize clean context
    Context->>CodeReviewer: Load reviewer instructions
    CodeReviewer->>CodeReviewer: Perform review
    CodeReviewer-->>MainAgent: Return findings
    MainAgent->>MainAgent: Incorporate results
    MainAgent-->>User: Provide synthesis
```

### Subagent 설정 표

| 설정 항목 | 타입 | 목적 | 예시 |
|---------------|------|---------|---------|
| `name` | String | 에이전트 식별자 | `code-reviewer` |
| `description` | String | 목적 및 트리거 단어 | `Comprehensive code quality analysis` |
| `tools` | List/String | 허용된 기능 | `read, grep, diff, lint_runner` |
| `system_prompt` | Markdown | 행동 지침 | 커스텀 가이드라인 |

### 도구 접근 계층

```mermaid
graph TD
    A["Subagent Configuration"] -->|Option 1| B["Inherit All Tools<br/>from Main Thread"]
    A -->|Option 2| C["Specify Individual Tools"]
    B -->|Includes| B1["File Operations"]
    B -->|Includes| B2["Shell Commands"]
    B -->|Includes| B3["MCP Tools"]
    C -->|Explicit List| C1["read, grep, diff"]
    C -->|Explicit List| C2["Bash(npm:*), Bash(test:*)"]
```

### 실전 예제

#### 예제 1: 완전한 Subagent 설정

**파일:** `.claude/agents/code-reviewer.md`

```yaml
---
name: code-reviewer
description: Comprehensive code quality and maintainability analysis
tools: read, grep, diff, lint_runner
---

# Code Reviewer Agent

You are an expert code reviewer specializing in:
- Performance optimization
- Security vulnerabilities
- Code maintainability
- Testing coverage
- Design patterns

## Review Priorities (in order)

1. **Security Issues** - Authentication, authorization, data exposure
2. **Performance Problems** - O(n²) operations, memory leaks, inefficient queries
3. **Code Quality** - Readability, naming, documentation
4. **Test Coverage** - Missing tests, edge cases
5. **Design Patterns** - SOLID principles, architecture

## Review Output Format

For each issue:
- **Severity**: Critical / High / Medium / Low
- **Category**: Security / Performance / Quality / Testing / Design
- **Location**: File path and line number
- **Issue Description**: What's wrong and why
- **Suggested Fix**: Code example
- **Impact**: How this affects the system

## Example Review

### Issue: N+1 Query Problem
- **Severity**: High
- **Category**: Performance
- **Location**: src/user-service.ts:45
- **Issue**: Loop executes database query in each iteration
- **Fix**: Use JOIN or batch query
```

**파일:** `.claude/agents/test-engineer.md`

```yaml
---
name: test-engineer
description: Test strategy, coverage analysis, and automated testing
tools: read, write, bash, grep
---

# Test Engineer Agent

You are expert at:
- Writing comprehensive test suites
- Ensuring high code coverage (>80%)
- Testing edge cases and error scenarios
- Performance benchmarking
- Integration testing

## Testing Strategy

1. **Unit Tests** - Individual functions/methods
2. **Integration Tests** - Component interactions
3. **End-to-End Tests** - Complete workflows
4. **Edge Cases** - Boundary conditions
5. **Error Scenarios** - Failure handling

## Test Output Requirements

- Use Jest for JavaScript/TypeScript
- Include setup/teardown for each test
- Mock external dependencies
- Document test purpose
- Include performance assertions when relevant

## Coverage Requirements

- Minimum 80% code coverage
- 100% for critical paths
- Report missing coverage areas
```

**파일:** `.claude/agents/documentation-writer.md`

```yaml
---
name: documentation-writer
description: Technical documentation, API docs, and user guides
tools: read, write, grep
---

# Documentation Writer Agent

You create:
- API documentation with examples
- User guides and tutorials
- Architecture documentation
- Changelog entries
- Code comment improvements

## Documentation Standards

1. **Clarity** - Use simple, clear language
2. **Examples** - Include practical code examples
3. **Completeness** - Cover all parameters and returns
4. **Structure** - Use consistent formatting
5. **Accuracy** - Verify against actual code

## Documentation Sections

### For APIs
- Description
- Parameters (with types)
- Returns (with types)
- Throws (possible errors)
- Examples (curl, JavaScript, Python)
- Related endpoints

### For Features
- Overview
- Prerequisites
- Step-by-step instructions
- Expected outcomes
- Troubleshooting
- Related topics
```

#### 예제 2: Subagent 위임 실행

```markdown
# 시나리오: 결제 기능 구축

## 사용자 요청
"Stripe와 연동하는 안전한 결제 처리 기능을 만들어줘"

## Main Agent 흐름

1. **계획 단계**
   - 요구사항 파악
   - 필요한 작업 결정
   - 아키텍처 계획

2. **Code Reviewer Subagent에 위임**
   - 작업: "결제 처리 구현의 보안을 검토해줘"
   - 컨텍스트: 인증, API 키, 토큰 처리
   - 검토 항목: SQL 인젝션, 키 노출, HTTPS 강제 여부

3. **Test Engineer Subagent에 위임**
   - 작업: "결제 플로우에 대한 포괄적인 테스트를 작성해줘"
   - 컨텍스트: 성공 시나리오, 실패, 엣지 케이스
   - 작성 대상: 정상 결제, 카드 거부, 네트워크 오류, 웹훅

4. **Documentation Writer Subagent에 위임**
   - 작업: "결제 API 엔드포인트를 문서화해줘"
   - 컨텍스트: 요청/응답 스키마
   - 산출물: curl 예제와 에러 코드가 포함된 API 문서

5. **통합**
   - Main agent가 모든 결과물 수집
   - 결과 통합
   - 완성된 솔루션을 사용자에게 반환
```

#### 예제 3: 도구 권한 범위 설정

**제한적 설정 - 특정 명령어만 허용**

```yaml
---
name: secure-reviewer
description: Security-focused code review with minimal permissions
tools: read, grep
---

# Secure Code Reviewer

Reviews code for security vulnerabilities only.

This agent:
- ✅ Reads files to analyze
- ✅ Searches for patterns
- ❌ Cannot execute code
- ❌ Cannot modify files
- ❌ Cannot run tests

This ensures the reviewer doesn't accidentally break anything.
```

**확장 설정 - 구현을 위한 모든 도구 허용**

```yaml
---
name: implementation-agent
description: Full implementation capabilities for feature development
tools: read, write, bash, grep, edit, glob
---

# Implementation Agent

Builds features from specifications.

This agent:
- ✅ Reads specifications
- ✅ Writes new code files
- ✅ Runs build commands
- ✅ Searches codebase
- ✅ Edits existing files
- ✅ Finds files matching patterns

Full capabilities for independent feature development.
```

### Subagent 컨텍스트 관리

```mermaid
graph TB
    A["Main Agent Context<br/>50,000 tokens"]
    B["Subagent 1 Context<br/>20,000 tokens"]
    C["Subagent 2 Context<br/>20,000 tokens"]
    D["Subagent 3 Context<br/>20,000 tokens"]

    A -->|Clean slate| B
    A -->|Clean slate| C
    A -->|Clean slate| D

    B -->|Results only| A
    C -->|Results only| A
    D -->|Results only| A

    style A fill:#e1f5ff
    style B fill:#fff9c4
    style C fill:#fff9c4
    style D fill:#fff9c4
```

### Subagent를 사용해야 할 때

| 시나리오 | Subagent 사용 | 이유 |
|----------|--------------|-----|
| 여러 단계로 구성된 복잡한 기능 | ✅ 예 | 관심사 분리, 컨텍스트 오염 방지 |
| 간단한 코드 리뷰 | ❌ 아니오 | 불필요한 오버헤드 |
| 병렬 작업 실행 | ✅ 예 | 각 subagent가 독립된 컨텍스트 보유 |
| 전문 지식이 필요한 경우 | ✅ 예 | 커스텀 시스템 프롬프트 적용 가능 |
| 장시간 분석 작업 | ✅ 예 | main 컨텍스트 소진 방지 |
| 단일 작업 | ❌ 아니오 | 불필요하게 지연 증가 |

### Agent Teams

Agent Teams는 관련 작업을 수행하는 여러 에이전트를 조율합니다. 하나의 subagent에 순차적으로 위임하는 방식과 달리, Agent Teams는 main agent가 그룹을 지휘하여 에이전트들이 협업하고 중간 결과를 공유하며 공동 목표를 향해 함께 작업할 수 있게 합니다. 프론트엔드 에이전트, 백엔드 에이전트, 테스팅 에이전트가 병렬로 작업하는 풀스택 기능 개발과 같은 대규모 작업에 유용합니다.

---

## Memory

### 개요

Memory는 Claude가 세션과 대화 간에 컨텍스트를 유지할 수 있게 합니다. 두 가지 형태로 존재합니다: claude.ai에서의 자동 합성, 그리고 Claude Code에서의 파일시스템 기반 CLAUDE.md입니다.

### Memory 아키텍처

```mermaid
graph TB
    A["Claude Session"]
    B["User Input"]
    C["Memory System"]
    D["Memory Storage"]

    B -->|User provides info| C
    C -->|Synthesizes every 24h| D
    D -->|Loads automatically| A
    A -->|Uses context| C
```

### Claude Code의 Memory 계층 구조 (7단계)

Claude Code는 7단계의 계층에서 memory를 불러오며, 우선순위가 높은 것부터 낮은 것 순으로 나열됩니다:

```mermaid
graph TD
    A["1. Managed Policy<br/>Enterprise admin policies"] --> B["2. Project Memory<br/>./CLAUDE.md"]
    B --> C["3. Project Rules<br/>.claude/rules/*.md"]
    C --> D["4. User Memory<br/>~/.claude/CLAUDE.md"]
    D --> E["5. User Rules<br/>~/.claude/rules/*.md"]
    E --> F["6. Local Memory<br/>.claude/local/CLAUDE.md"]
    F --> G["7. Auto Memory<br/>Automatically captured preferences"]

    style A fill:#fce4ec,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#e1f5fe,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
    style G fill:#fff3e0,stroke:#333,color:#333
```

### Memory 위치 표

| 단계 | 위치 | 범위 | 우선순위 | 공유 여부 | 최적 활용 |
|------|----------|-------|----------|--------|----------|
| 1. Managed Policy | 엔터프라이즈 관리자 | 조직 | 최고 | 전체 조직 사용자 | 컴플라이언스, 보안 정책 |
| 2. Project | `./CLAUDE.md` | 프로젝트 | 높음 | 팀 (Git) | 팀 기준, 아키텍처 |
| 3. Project Rules | `.claude/rules/*.md` | 프로젝트 | 높음 | 팀 (Git) | 모듈식 프로젝트 규칙 |
| 4. User | `~/.claude/CLAUDE.md` | 개인 | 중간 | 개인 | 개인 환경설정 |
| 5. User Rules | `~/.claude/rules/*.md` | 개인 | 중간 | 개인 | 개인 규칙 모듈 |
| 6. Local | `.claude/local/CLAUDE.md` | 로컬 | 낮음 | 공유 안 됨 | 머신별 설정 |
| 7. Auto Memory | 자동 | 세션 | 최저 | 개인 | 학습된 환경설정, 패턴 |

### Auto Memory

Auto Memory는 세션 중 관찰된 사용자 환경설정과 패턴을 자동으로 캡처합니다. Claude는 상호작용을 통해 다음을 학습하고 기억합니다:

- 코딩 스타일 환경설정
- 자주 하는 수정 사항
- 프레임워크 및 도구 선택
- 커뮤니케이션 스타일 환경설정

Auto Memory는 백그라운드에서 작동하며 별도의 설정이 필요하지 않습니다.

### Memory 업데이트 생명주기

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Editor as File System
    participant Memory as CLAUDE.md

    User->>Claude: "Remember: use async/await"
    Claude->>User: "Which memory file?"
    User->>Claude: "Project memory"
    Claude->>Editor: Open ~/.claude/settings.json
    Claude->>Memory: Write to ./CLAUDE.md
    Memory-->>Claude: File saved
    Claude->>Claude: Load updated memory
    Claude-->>User: "Memory saved!"
```

### 실전 예제

#### 예제 1: 프로젝트 Memory 구조

**파일:** `./CLAUDE.md`

```markdown
# Project Configuration

## Project Overview
- **Name**: E-commerce Platform
- **Tech Stack**: Node.js, PostgreSQL, React 18, Docker
- **Team Size**: 5 developers
- **Deadline**: Q4 2025

## Architecture
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Development Standards

### Code Style
- Use Prettier for formatting
- Use ESLint with airbnb config
- Maximum line length: 100 characters
- Use 2-space indentation

### Naming Conventions
- **Files**: kebab-case (user-controller.js)
- **Classes**: PascalCase (UserService)
- **Functions/Variables**: camelCase (getUserById)
- **Constants**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Database Tables**: snake_case (user_accounts)

### Git Workflow
- Branch names: `feature/description` or `fix/description`
- Commit messages: Follow conventional commits
- PR required before merge
- All CI/CD checks must pass
- Minimum 1 approval required

### Testing Requirements
- Minimum 80% code coverage
- All critical paths must have tests
- Use Jest for unit tests
- Use Cypress for E2E tests
- Test filenames: `*.test.ts` or `*.spec.ts`

### API Standards
- RESTful endpoints only
- JSON request/response
- Use HTTP status codes correctly
- Version API endpoints: `/api/v1/`
- Document all endpoints with examples

### Database
- Use migrations for schema changes
- Never hardcode credentials
- Use connection pooling
- Enable query logging in development
- Regular backups required

### Deployment
- Docker-based deployment
- Kubernetes orchestration
- Blue-green deployment strategy
- Automatic rollback on failure
- Database migrations run before deploy

## Common Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server |
| `npm test` | Run test suite |
| `npm run lint` | Check code style |
| `npm run build` | Build for production |
| `npm run migrate` | Run database migrations |

## Team Contacts
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Known Issues & Workarounds
- PostgreSQL connection pooling limited to 20 during peak hours
- Workaround: Implement query queuing
- Safari 14 compatibility issues with async generators
- Workaround: Use Babel transpiler

## Related Projects
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`
```

#### 예제 2: 디렉토리별 Memory

**파일:** `./src/api/CLAUDE.md`

~~~~markdown
# API Module Standards

This file overrides root CLAUDE.md for everything in /src/api/

## API-Specific Standards

### Request Validation
- Use Zod for schema validation
- Always validate input
- Return 400 with validation errors
- Include field-level error details

### Authentication
- All endpoints require JWT token
- Token in Authorization header
- Token expires after 24 hours
- Implement refresh token mechanism

### Response Format

All responses must follow this structure:

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

### Error responses:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Pagination
- Use cursor-based pagination (not offset)
- Include `hasMore` boolean
- Limit max page size to 100
- Default page size: 20

### Rate Limiting
- 1000 requests per hour for authenticated users
- 100 requests per hour for public endpoints
- Return 429 when exceeded
- Include retry-after header

### Caching
- Use Redis for session caching
- Cache duration: 5 minutes default
- Invalidate on write operations
- Tag cache keys with resource type
~~~~

#### 예제 3: 개인 Memory

**파일:** `~/.claude/CLAUDE.md`

~~~~markdown
# My Development Preferences

## About Me
- **Experience Level**: 8 years full-stack development
- **Preferred Languages**: TypeScript, Python
- **Communication Style**: Direct, with examples
- **Learning Style**: Visual diagrams with code

## Code Preferences

### Error Handling
I prefer explicit error handling with try-catch blocks and meaningful error messages.
Avoid generic errors. Always log errors for debugging.

### Comments
Use comments for WHY, not WHAT. Code should be self-documenting.
Comments should explain business logic or non-obvious decisions.

### Testing
I prefer TDD (test-driven development).
Write tests first, then implementation.
Focus on behavior, not implementation details.

### Architecture
I prefer modular, loosely-coupled design.
Use dependency injection for testability.
Separate concerns (Controllers, Services, Repositories).

## Debugging Preferences
- Use console.log with prefix: `[DEBUG]`
- Include context: function name, relevant variables
- Use stack traces when available
- Always include timestamps in logs

## Communication
- Explain complex concepts with diagrams
- Show concrete examples before explaining theory
- Include before/after code snippets
- Summarize key points at the end

## Project Organization
I organize my projects as:
```
project/
  ├── src/
  │   ├── api/
  │   ├── services/
  │   ├── models/
  │   └── utils/
  ├── tests/
  ├── docs/
  └── docker/
```

## Tooling
- **IDE**: VS Code with vim keybindings
- **Terminal**: Zsh with Oh-My-Zsh
- **Format**: Prettier (100 char line length)
- **Linter**: ESLint with airbnb config
- **Test Framework**: Jest with React Testing Library
~~~~

#### 예제 4: 세션 중 Memory 업데이트

**세션 대화:**

```markdown
User: Remember that I prefer using React hooks instead of class components
     for all new components.

Claude: I'm adding that to your memory. Which memory file should this go in?
        1. Project memory (./CLAUDE.md)
        2. Personal memory (~/.claude/CLAUDE.md)

User: Project memory

Claude: ✅ Memory saved!

Added to ./CLAUDE.md:
---

### Component Development
- Use functional components with React Hooks
- Prefer hooks over class components
- Custom hooks for reusable logic
- Use useCallback for event handlers
- Use useMemo for expensive computations
```

### Claude 웹/데스크톱에서의 Memory

#### Memory 합성 타임라인

```mermaid
graph LR
    A["Day 1: User<br/>Conversations"] -->|24 hours| B["Day 2: Memory<br/>Synthesis"]
    B -->|Automatic| C["Memory Updated<br/>Summarized"]
    C -->|Loaded in| D["Day 2-N:<br/>New Conversations"]
    D -->|Add to| E["Memory"]
    E -->|24 hours later| F["Memory Refreshed"]
```

**Memory 요약 예시:**

```markdown
## Claude's Memory of User

### Professional Background
- Senior full-stack developer with 8 years experience
- Focus on TypeScript/Node.js backends and React frontends
- Active open source contributor
- Interested in AI and machine learning

### Project Context
- Currently building e-commerce platform
- Tech stack: Node.js, PostgreSQL, React 18, Docker
- Working with team of 5 developers
- Using CI/CD and blue-green deployments

### Communication Preferences
- Prefers direct, concise explanations
- Likes visual diagrams and examples
- Appreciates code snippets
- Explains business logic in comments

### Current Goals
- Improve API performance
- Increase test coverage to 90%
- Implement caching strategy
- Document architecture
```

### Memory 기능 비교

| 기능 | Claude 웹/데스크톱 | Claude Code (CLAUDE.md) |
|---------|-------------------|------------------------|
| 자동 합성 | ✅ 24시간마다 | ❌ 수동 |
| 크로스 프로젝트 | ✅ 공유됨 | ❌ 프로젝트 전용 |
| 팀 접근 | ✅ 공유 프로젝트 | ✅ Git 추적 |
| 검색 가능 | ✅ 내장 | ✅ `/memory`를 통해 |
| 편집 가능 | ✅ 대화 내에서 | ✅ 파일 직접 편집 |
| 가져오기/내보내기 | ✅ 예 | ✅ 복사/붙여넣기 |
| 영속성 | ✅ 24시간+ | ✅ 무기한 |

---

## MCP Protocol

### 개요

MCP (Model Context Protocol)는 Claude가 외부 도구, API, 실시간 데이터 소스에 접근하는 표준화된 방법입니다. Memory와 달리 MCP는 변화하는 데이터에 실시간으로 접근합니다.

### MCP 아키텍처

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
```

### MCP 생태계

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
```

### MCP 설정 과정

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

### 사용 가능한 MCP 서버 표

| MCP 서버 | 목적 | 주요 도구 | 인증 | 실시간 |
|------------|---------|--------------|------|-----------|
| **Filesystem** | 파일 작업 | read, write, delete | OS 권한 | ✅ 예 |
| **GitHub** | 저장소 관리 | list_prs, create_issue, push | OAuth | ✅ 예 |
| **Slack** | 팀 커뮤니케이션 | send_message, list_channels | Token | ✅ 예 |
| **Database** | SQL 쿼리 | query, insert, update | 자격증명 | ✅ 예 |
| **Google Docs** | 문서 접근 | read, write, share | OAuth | ✅ 예 |
| **Asana** | 프로젝트 관리 | create_task, update_status | API Key | ✅ 예 |
| **Stripe** | 결제 데이터 | list_charges, create_invoice | API Key | ✅ 예 |
| **Memory** | 영속적 메모리 | store, retrieve, delete | 로컬 | ❌ 아니오 |

### 실전 예제

#### 예제 1: GitHub MCP 설정

**파일:** `.mcp.json` (프로젝트 범위) 또는 `~/.claude.json` (사용자 범위)

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

~~~~markdown
# GitHub MCP Tools

## Pull Request Management
- `list_prs` - List all PRs in repository
- `get_pr` - Get PR details including diff
- `create_pr` - Create new PR
- `update_pr` - Update PR description/title
- `merge_pr` - Merge PR to main branch
- `review_pr` - Add review comments

Example request:
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

## Issue Management
- `list_issues` - List all issues
- `get_issue` - Get issue details
- `create_issue` - Create new issue
- `close_issue` - Close issue
- `add_comment` - Add comment to issue

## Repository Information
- `get_repo_info` - Repository details
- `list_files` - File tree structure
- `get_file_content` - Read file contents
- `search_code` - Search across codebase

## Commit Operations
- `list_commits` - Commit history
- `get_commit` - Specific commit details
- `create_commit` - Create new commit
~~~~

#### 예제 2: 데이터베이스 MCP 설정

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

# MCP database tool 사용:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# 결과:
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

#### 예제 3: 다중 MCP 워크플로우

**시나리오: 일일 보고서 생성**

```markdown
# 여러 MCP를 활용한 일일 보고서 워크플로우

## 설정
1. GitHub MCP - PR 지표 가져오기
2. Database MCP - 판매 데이터 쿼리
3. Slack MCP - 보고서 게시
4. Filesystem MCP - 보고서 저장

## 워크플로우

### 1단계: GitHub 데이터 가져오기
/mcp__github__list_prs completed:true last:7days

결과:
- 총 PR: 42개
- 평균 병합 시간: 2.3시간
- 리뷰 처리 시간: 1.1시간

### 2단계: 데이터베이스 쿼리
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

결과:
- 판매: 247건
- 매출: $12,450

### 3단계: 보고서 생성
데이터를 HTML 보고서로 취합

### 4단계: 파일시스템에 저장
/reports/에 report.html 저장

### 5단계: Slack에 게시
#daily-reports 채널에 요약 전송

최종 결과:
✅ 보고서 생성 및 게시 완료
📊 이번 주 PR 47개 병합
💰 일일 매출 $12,450
```

#### 예제 4: Filesystem MCP 작업

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

| 작업 | 명령어 | 목적 |
|-----------|---------|---------|
| 파일 목록 | `ls ~/projects` | 디렉토리 내용 표시 |
| 파일 읽기 | `cat src/main.ts` | 파일 내용 읽기 |
| 파일 쓰기 | `create docs/api.md` | 새 파일 생성 |
| 파일 편집 | `edit src/app.ts` | 파일 수정 |
| 검색 | `grep "async function"` | 파일 내 검색 |
| 삭제 | `rm old-file.js` | 파일 삭제 |

### MCP vs Memory: 결정 매트릭스

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style B fill:#e1f5ff
    style D fill:#fff9c4
```

### 요청/응답 패턴

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

---

## Agent Skills

### 개요

Agent Skills는 지침, 스크립트, 리소스가 담긴 폴더로 패키징된 재사용 가능한 모델 호출 기능입니다. Claude가 관련 Skills를 자동으로 감지하고 사용합니다.

### Skill 아키텍처

```mermaid
graph TB
    A["Skill Directory"]
    B["SKILL.md"]
    C["YAML Metadata"]
    D["Instructions"]
    E["Scripts"]
    F["Templates"]

    A --> B
    B --> C
    B --> D
    E --> A
    F --> A
```

### Skill 로딩 과정

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude
    participant System as System
    participant Skill as Skill

    User->>Claude: "Create Excel report"
    Claude->>System: Scan available skills
    System->>System: Load skill metadata
    Claude->>Claude: Match user request to skills
    Claude->>Skill: Load xlsx skill SKILL.md
    Skill-->>Claude: Return instructions + tools
    Claude->>Claude: Execute skill
    Claude->>User: Generate Excel file
```

### Skill 유형 및 위치 표

| 유형 | 위치 | 범위 | 공유 여부 | 동기화 | 최적 활용 |
|------|----------|-------|--------|------|----------|
| 사전 빌드 | 내장 | 전역 | 모든 사용자 | 자동 | 문서 생성 |
| 개인 | `~/.claude/skills/` | 개인 | 아니오 | 수동 | 개인 자동화 |
| 프로젝트 | `.claude/skills/` | 팀 | 예 | Git | 팀 기준 |
| Plugin | 플러그인 설치 경유 | 다양 | 상황에 따라 | 자동 | 통합 기능 |

### 사전 빌드 Skills

```mermaid
graph TB
    A["Pre-built Skills"]
    B["PowerPoint (pptx)"]
    C["Excel (xlsx)"]
    D["Word (docx)"]
    E["PDF"]

    A --> B
    A --> C
    A --> D
    A --> E

    B --> B1["Create presentations"]
    B --> B2["Edit slides"]
    C --> C1["Create spreadsheets"]
    C --> C2["Analyze data"]
    D --> D1["Create documents"]
    D --> D2["Format text"]
    E --> E1["Generate PDFs"]
    E --> E2["Fill forms"]
```

### 번들 Skills

Claude Code에는 이제 기본 제공되는 5가지 번들 Skills가 포함되어 있습니다:

| Skill | 명령어 | 목적 |
|-------|---------|---------|
| **Simplify** | `/simplify` | 복잡한 코드나 설명 단순화 |
| **Batch** | `/batch` | 여러 파일 또는 항목에 걸쳐 작업 실행 |
| **Debug** | `/debug` | 근본 원인 분석을 통한 체계적인 디버깅 |
| **Loop** | `/loop` | 타이머로 반복 작업 예약 |
| **Claude API** | `/claude-api` | Anthropic API 직접 상호작용 |

이 번들 Skills는 항상 사용 가능하며 설치나 설정이 필요하지 않습니다.

### 실전 예제

#### 예제 1: 커스텀 코드 리뷰 Skill

**디렉토리 구조:**

```
~/.claude/skills/code-review/
├── SKILL.md
├── templates/
│   ├── review-checklist.md
│   └── finding-template.md
└── scripts/
    ├── analyze-metrics.py
    └── compare-complexity.py
```

**파일:** `~/.claude/skills/code-review/SKILL.md`

```yaml
---
name: Code Review Specialist
description: Comprehensive code review with security, performance, and quality analysis
version: "1.0.0"
tags:
  - code-review
  - quality
  - security
when_to_use: When users ask to review code, analyze code quality, or evaluate pull requests
effort: high
shell: bash
---

# Code Review Skill

This skill provides comprehensive code review capabilities focusing on:

1. **Security Analysis**
   - Authentication/authorization issues
   - Data exposure risks
   - Injection vulnerabilities
   - Cryptographic weaknesses
   - Sensitive data logging

2. **Performance Review**
   - Algorithm efficiency (Big O analysis)
   - Memory optimization
   - Database query optimization
   - Caching opportunities
   - Concurrency issues

3. **Code Quality**
   - SOLID principles
   - Design patterns
   - Naming conventions
   - Documentation
   - Test coverage

4. **Maintainability**
   - Code readability
   - Function size (should be < 50 lines)
   - Cyclomatic complexity
   - Dependency management
   - Type safety

## Review Template

For each piece of code reviewed, provide:

### Summary
- Overall quality assessment (1-5)
- Key findings count
- Recommended priority areas

### Critical Issues (if any)
- **Issue**: Clear description
- **Location**: File and line number
- **Impact**: Why this matters
- **Severity**: Critical/High/Medium
- **Fix**: Code example

### Findings by Category

#### Security (if issues found)
List security vulnerabilities with examples

#### Performance (if issues found)
List performance problems with complexity analysis

#### Quality (if issues found)
List code quality issues with refactoring suggestions

#### Maintainability (if issues found)
List maintainability problems with improvements
```
## Python Script: analyze-metrics.py

```python
#!/usr/bin/env python3
import re
import sys

def analyze_code_metrics(code):
    """Analyze code for common metrics."""

    # Count functions
    functions = len(re.findall(r'^def\s+\w+', code, re.MULTILINE))

    # Count classes
    classes = len(re.findall(r'^class\s+\w+', code, re.MULTILINE))

    # Average line length
    lines = code.split('\n')
    avg_length = sum(len(l) for l in lines) / len(lines) if lines else 0

    # Estimate complexity
    complexity = len(re.findall(r'\b(if|elif|else|for|while|and|or)\b', code))

    return {
        'functions': functions,
        'classes': classes,
        'avg_line_length': avg_length,
        'complexity_score': complexity
    }

if __name__ == '__main__':
    with open(sys.argv[1], 'r') as f:
        code = f.read()
    metrics = analyze_code_metrics(code)
    for key, value in metrics.items():
        print(f"{key}: {value:.2f}")
```

## Python Script: compare-complexity.py

```python
#!/usr/bin/env python3
"""
Compare cyclomatic complexity of code before and after changes.
Helps identify if refactoring actually simplifies code structure.
"""

import re
import sys
from typing import Dict, Tuple

class ComplexityAnalyzer:
    """Analyze code complexity metrics."""

    def __init__(self, code: str):
        self.code = code
        self.lines = code.split('\n')

    def calculate_cyclomatic_complexity(self) -> int:
        """
        Calculate cyclomatic complexity using McCabe's method.
        Count decision points: if, elif, else, for, while, except, and, or
        """
        complexity = 1  # Base complexity

        # Count decision points
        decision_patterns = [
            r'\bif\b',
            r'\belif\b',
            r'\bfor\b',
            r'\bwhile\b',
            r'\bexcept\b',
            r'\band\b(?!$)',
            r'\bor\b(?!$)'
        ]

        for pattern in decision_patterns:
            matches = re.findall(pattern, self.code)
            complexity += len(matches)

        return complexity

    def calculate_cognitive_complexity(self) -> int:
        """
        Calculate cognitive complexity - how hard is it to understand?
        Based on nesting depth and control flow.
        """
        cognitive = 0
        nesting_depth = 0

        for line in self.lines:
            # Track nesting depth
            if re.search(r'^\s*(if|for|while|def|class|try)\b', line):
                nesting_depth += 1
                cognitive += nesting_depth
            elif re.search(r'^\s*(elif|else|except|finally)\b', line):
                cognitive += nesting_depth

            # Reduce nesting when unindenting
            if line and not line[0].isspace():
                nesting_depth = 0

        return cognitive

    def calculate_maintainability_index(self) -> float:
        """
        Maintainability Index ranges from 0-100.
        > 85: Excellent
        > 65: Good
        > 50: Fair
        < 50: Poor
        """
        lines = len(self.lines)
        cyclomatic = self.calculate_cyclomatic_complexity()
        cognitive = self.calculate_cognitive_complexity()

        # Simplified MI calculation
        mi = 171 - 5.2 * (cyclomatic / lines) - 0.23 * (cognitive) - 16.2 * (lines / 1000)

        return max(0, min(100, mi))

    def get_complexity_report(self) -> Dict:
        """Generate comprehensive complexity report."""
        return {
            'cyclomatic_complexity': self.calculate_cyclomatic_complexity(),
            'cognitive_complexity': self.calculate_cognitive_complexity(),
            'maintainability_index': round(self.calculate_maintainability_index(), 2),
            'lines_of_code': len(self.lines),
            'avg_line_length': round(sum(len(l) for l in self.lines) / len(self.lines), 2) if self.lines else 0
        }


def compare_files(before_file: str, after_file: str) -> None:
    """Compare complexity metrics between two code versions."""

    with open(before_file, 'r') as f:
        before_code = f.read()

    with open(after_file, 'r') as f:
        after_code = f.read()

    before_analyzer = ComplexityAnalyzer(before_code)
    after_analyzer = ComplexityAnalyzer(after_code)

    before_metrics = before_analyzer.get_complexity_report()
    after_metrics = after_analyzer.get_complexity_report()

    print("=" * 60)
    print("CODE COMPLEXITY COMPARISON")
    print("=" * 60)

    print("\nBEFORE:")
    print(f"  Cyclomatic Complexity:    {before_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {before_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {before_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {before_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {before_metrics['avg_line_length']}")

    print("\nAFTER:")
    print(f"  Cyclomatic Complexity:    {after_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {after_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {after_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {after_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {after_metrics['avg_line_length']}")

    print("\nCHANGES:")
    cyclomatic_change = after_metrics['cyclomatic_complexity'] - before_metrics['cyclomatic_complexity']
    cognitive_change = after_metrics['cognitive_complexity'] - before_metrics['cognitive_complexity']
    mi_change = after_metrics['maintainability_index'] - before_metrics['maintainability_index']
    loc_change = after_metrics['lines_of_code'] - before_metrics['lines_of_code']

    print(f"  Cyclomatic Complexity:    {cyclomatic_change:+d}")
    print(f"  Cognitive Complexity:     {cognitive_change:+d}")
    print(f"  Maintainability Index:    {mi_change:+.2f}")
    print(f"  Lines of Code:            {loc_change:+d}")

    print("\nASSESSMENT:")
    if mi_change > 0:
        print("  ✅ Code is MORE maintainable")
    elif mi_change < 0:
        print("  ⚠️  Code is LESS maintainable")
    else:
        print("  ➡️  Maintainability unchanged")

    if cyclomatic_change < 0:
        print("  ✅ Complexity DECREASED")
    elif cyclomatic_change > 0:
        print("  ⚠️  Complexity INCREASED")
    else:
        print("  ➡️  Complexity unchanged")

    print("=" * 60)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python compare-complexity.py <before_file> <after_file>")
        sys.exit(1)

    compare_files(sys.argv[1], sys.argv[2])
```

## Template: review-checklist.md

```markdown
# Code Review Checklist

## Security Checklist
- [ ] No hardcoded credentials or secrets
- [ ] Input validation on all user inputs
- [ ] SQL injection prevention (parameterized queries)
- [ ] CSRF protection on state-changing operations
- [ ] XSS prevention with proper escaping
- [ ] Authentication checks on protected endpoints
- [ ] Authorization checks on resources
- [ ] Secure password hashing (bcrypt, argon2)
- [ ] No sensitive data in logs
- [ ] HTTPS enforced

## Performance Checklist
- [ ] No N+1 queries
- [ ] Appropriate use of indexes
- [ ] Caching implemented where beneficial
- [ ] No blocking operations on main thread
- [ ] Async/await used correctly
- [ ] Large datasets paginated
- [ ] Database connections pooled
- [ ] Regular expressions optimized
- [ ] No unnecessary object creation
- [ ] Memory leaks prevented

## Quality Checklist
- [ ] Functions < 50 lines
- [ ] Clear variable naming
- [ ] No duplicate code
- [ ] Proper error handling
- [ ] Comments explain WHY, not WHAT
- [ ] No console.logs in production
- [ ] Type checking (TypeScript/JSDoc)
- [ ] SOLID principles followed
- [ ] Design patterns applied correctly
- [ ] Self-documenting code

## Testing Checklist
- [ ] Unit tests written
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Integration tests present
- [ ] Coverage > 80%
- [ ] No flaky tests
- [ ] Mock external dependencies
- [ ] Clear test names
```

## Template: finding-template.md

~~~~markdown
# Code Review Finding Template

Use this template when documenting each issue found during code review.

---

## Issue: [TITLE]

### Severity
- [ ] Critical (blocks deployment)
- [ ] High (should fix before merge)
- [ ] Medium (should fix soon)
- [ ] Low (nice to have)

### Category
- [ ] Security
- [ ] Performance
- [ ] Code Quality
- [ ] Maintainability
- [ ] Testing
- [ ] Design Pattern
- [ ] Documentation

### Location
**File:** `src/components/UserCard.tsx`

**Lines:** 45-52

**Function/Method:** `renderUserDetails()`

### Issue Description

**What:** Describe what the issue is.

**Why it matters:** Explain the impact and why this needs to be fixed.

**Current behavior:** Show the problematic code or behavior.

**Expected behavior:** Describe what should happen instead.

### Code Example

#### Current (Problematic)

```typescript
// N+1 쿼리 문제를 보여줌
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // 사용자당 쿼리 발생!
  renderUserPosts(posts);
});
```

#### Suggested Fix

```typescript
// JOIN 쿼리로 최적화
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Impact Analysis

| Aspect | Impact | Severity |
|--------|--------|----------|
| Performance | 100+ queries for 20 users | High |
| User Experience | Slow page load | High |
| Scalability | Breaks at scale | Critical |
| Maintainability | Hard to debug | Medium |

### Related Issues

- Similar issue in `AdminUserList.tsx` line 120
- Related PR: #456
- Related issue: #789

### Additional Resources

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)

### Reviewer Notes

- This is a common pattern in this codebase
- Consider adding this to the code style guide
- Might be worth creating a helper function

### Author Response (for feedback)

*To be filled by the code author:*

- [ ] Fix implemented in commit: `abc123`
- [ ] Fix status: Complete / In Progress / Needs Discussion
- [ ] Questions or concerns: (describe)

---

## Finding Statistics (for Reviewer)

When reviewing multiple findings, track:

- **Total Issues Found:** X
- **Critical:** X
- **High:** X
- **Medium:** X
- **Low:** X

**Recommendation:** ✅ Approve / ⚠️ Request Changes / 🔄 Needs Discussion

**Overall Code Quality:** 1-5 stars
~~~~

## 사용 예시

~~~~markdown
User: Review this React component code

Claude: I'll conduct a comprehensive code review using my Code Review Skill.

[Loads SKILL.md]
[Analyzes code against checklist]
[Runs Python metrics script]
[Applies templates]

## Code Review Results

### Summary
Quality Score: 3.5/5
Key Findings: 7 items
Priority Areas: Performance optimization, error handling

### Critical Issues: 1

**Issue**: N+1 Query Problem
**Location**: UserComponent.tsx, lines 45-52
**Impact**: Renders 100+ database queries for list of 20 users
**Severity**: High
**Fix**:
```javascript
// Before: N+1 queries
const users = fetchUsers();
users.forEach(user => fetchUserPosts(user.id)); // 20+ queries

// After: Single query with JOIN
const users = fetchUsersWithPosts(); // 1 query
```

### Performance Findings
- Missing pagination on large lists
- Recommendation: Use React.memo() for items
- Database query: Could be optimized with index

### Quality Findings
- Function in line 20 is 127 lines (max: 50)
- Missing error boundary
- Props should have TypeScript types
~~~~

#### 예제 2: 브랜드 보이스 Skill

**디렉토리 구조:**

```
.claude/skills/brand-voice/
├── SKILL.md
├── brand-guidelines.md
├── tone-examples.md
└── templates/
    ├── email-template.txt
    ├── social-post-template.txt
    └── blog-post-template.md
```

**파일:** `.claude/skills/brand-voice/SKILL.md`

```yaml
---
name: Brand Voice Consistency
description: Ensure all communication matches brand voice and tone guidelines
tags:
  - brand
  - writing
  - consistency
when_to_use: When creating marketing copy, customer communications, or public-facing content
---

# Brand Voice Skill

## Overview
This skill ensures all communications maintain consistent brand voice, tone, and messaging.

## Brand Identity

### Mission
Help teams automate their development workflows with AI

### Values
- **Simplicity**: Make complex things simple
- **Reliability**: Rock-solid execution
- **Empowerment**: Enable human creativity

### Tone of Voice
- **Friendly but professional** - approachable without being casual
- **Clear and concise** - avoid jargon, explain technical concepts simply
- **Confident** - we know what we're doing
- **Empathetic** - understand user needs and pain points

## Writing Guidelines

### Do's ✅
- Use "you" when addressing readers
- Use active voice: "Claude generates reports" not "Reports are generated by Claude"
- Start with value proposition
- Use concrete examples
- Keep sentences under 20 words
- Use lists for clarity
- Include calls-to-action

### Don'ts ❌
- Don't use corporate jargon
- Don't patronize or oversimplify
- Don't use "we believe" or "we think"
- Don't use ALL CAPS except for emphasis
- Don't create walls of text
- Don't assume technical knowledge

## Vocabulary

### ✅ Preferred Terms
- Claude (not "the Claude AI")
- Code generation (not "auto-coding")
- Agent (not "bot")
- Streamline (not "revolutionize")
- Integrate (not "synergize")

### ❌ Avoid Terms
- "Cutting-edge" (overused)
- "Game-changer" (vague)
- "Leverage" (corporate-speak)
- "Utilize" (use "use")
- "Paradigm shift" (unclear)
```
## Examples

### ✅ Good Example
"Claude automates your code review process. Instead of manually checking each PR, Claude reviews security, performance, and quality—saving your team hours every week."

Why it works: Clear value, specific benefits, action-oriented

### ❌ Bad Example
"Claude leverages cutting-edge AI to provide comprehensive software development solutions."

Why it doesn't work: Vague, corporate jargon, no specific value

## Template: Email

```
Subject: [Clear, benefit-driven subject]

Hi [Name],

[Opening: What's the value for them]

[Body: How it works / What they'll get]

[Specific example or benefit]

[Call to action: Clear next step]

Best regards,
[Name]
```

## Template: Social Media

```
[Hook: Grab attention in first line]
[2-3 lines: Value or interesting fact]
[Call to action: Link, question, or engagement]
[Emoji: 1-2 max for visual interest]
```

## File: tone-examples.md
```
Exciting announcement:
"Save 8 hours per week on code reviews. Claude reviews your PRs automatically."

Empathetic support:
"We know deployments can be stressful. Claude handles testing so you don't have to worry."

Confident product feature:
"Claude doesn't just suggest code. It understands your architecture and maintains consistency."

Educational blog post:
"Let's explore how agents improve code review workflows. Here's what we learned..."
```

#### 예제 3: 문서 생성기 Skill

**파일:** `.claude/skills/doc-generator/SKILL.md`

~~~~yaml
---
name: API Documentation Generator
description: Generate comprehensive, accurate API documentation from source code
version: "1.0.0"
tags:
  - documentation
  - api
  - automation
when_to_use: When creating or updating API documentation
---

# API Documentation Generator Skill

## Generates

- OpenAPI/Swagger specifications
- API endpoint documentation
- SDK usage examples
- Integration guides
- Error code references
- Authentication guides

## Documentation Structure

### For Each Endpoint

```markdown
## GET /api/v1/users/:id

### Description
Brief explanation of what this endpoint does

### Parameters

| Name | Type | Required | Description |
|------|------|----------|-------------|
| id | string | Yes | User ID |

### Response

**200 Success**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Not Found**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "User does not exist"
}
```

### Examples

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```

## Python Script: generate-docs.py

```python
#!/usr/bin/env python3
import ast
import json
from typing import Dict, List

class APIDocExtractor(ast.NodeVisitor):
    """Extract API documentation from Python source code."""

    def __init__(self):
        self.endpoints = []

    def visit_FunctionDef(self, node):
        """Extract function documentation."""
        if node.name.startswith('get_') or node.name.startswith('post_'):
            doc = ast.get_docstring(node)
            endpoint = {
                'name': node.name,
                'docstring': doc,
                'params': [arg.arg for arg in node.args.args],
                'returns': self._extract_return_type(node)
            }
            self.endpoints.append(endpoint)
        self.generic_visit(node)

    def _extract_return_type(self, node):
        """Extract return type from function annotation."""
        if node.returns:
            return ast.unparse(node.returns)
        return "Any"

def generate_markdown_docs(endpoints: List[Dict]) -> str:
    """Generate markdown documentation from endpoints."""
    docs = "# API Documentation\n\n"

    for endpoint in endpoints:
        docs += f"## {endpoint['name']}\n\n"
        docs += f"{endpoint['docstring']}\n\n"
        docs += f"**Parameters**: {', '.join(endpoint['params'])}\n\n"
        docs += f"**Returns**: {endpoint['returns']}\n\n"
        docs += "---\n\n"

    return docs

if __name__ == '__main__':
    import sys
    with open(sys.argv[1], 'r') as f:
        tree = ast.parse(f.read())

    extractor = APIDocExtractor()
    extractor.visit(tree)

    markdown = generate_markdown_docs(extractor.endpoints)
    print(markdown)
~~~~
### Skill 탐색 및 호출

```mermaid
graph TD
    A["User Request"] --> B["Claude Analyzes"]
    B -->|Scans| C["Available Skills"]
    C -->|Metadata check| D["Skill Description Match?"]
    D -->|Yes| E["Load SKILL.md"]
    D -->|No| F["Try next skill"]
    F -->|More skills?| D
    F -->|No more| G["Use general knowledge"]
    E --> H["Extract Instructions"]
    H --> I["Execute Skill"]
    I --> J["Return Results"]
```

### Skill vs 다른 기능 비교

```mermaid
graph TB
    A["Extending Claude"]
    B["Slash Commands"]
    C["Subagents"]
    D["Memory"]
    E["MCP"]
    F["Skills"]

    A --> B
    A --> C
    A --> D
    A --> E
    A --> F

    B -->|User-invoked| G["Quick shortcuts"]
    C -->|Auto-delegated| H["Isolated contexts"]
    D -->|Persistent| I["Cross-session context"]
    E -->|Real-time| J["External data access"]
    F -->|Auto-invoked| K["Autonomous execution"]
```

---

## Claude Code Plugins

### 개요

Claude Code Plugins는 단일 명령어로 설치되는 커스터마이징(slash commands, subagents, MCP 서버, hooks)의 번들 모음입니다. 여러 기능을 응집된 공유 가능한 패키지로 결합하는 최상위 확장 메커니즘입니다.

### 아키텍처

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

### Plugin 로딩 과정

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

### Plugin 유형 및 배포

| 유형 | 범위 | 공유 여부 | 권한 | 예시 |
|------|-------|--------|-----------|----------|
| 공식 | 전역 | 모든 사용자 | Anthropic | PR Review, Security Guidance |
| 커뮤니티 | 공개 | 모든 사용자 | 커뮤니티 | DevOps, Data Science |
| 조직 | 내부 | 팀원 | 회사 | 내부 기준, 도구 |
| 개인 | 개인 | 단일 사용자 | 개발자 | 커스텀 워크플로우 |

### Plugin 정의 구조

```yaml
---
name: plugin-name
version: "1.0.0"
description: "What this plugin does"
author: "Your Name"
license: MIT

# Plugin 메타데이터
tags:
  - category
  - use-case

# 요구사항
requires:
  - claude-code: ">=1.0.0"

# 번들된 컴포넌트
components:
  - type: commands
    path: commands/
  - type: agents
    path: agents/
  - type: mcp
    path: mcp/
  - type: hooks
    path: hooks/

# 설정
config:
  auto_load: true
  enabled_by_default: true
---
```

### Plugin 구조

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── task-1.md
│   ├── task-2.md
│   └── workflows/
├── agents/
│   ├── specialist-1.md
│   ├── specialist-2.md
│   └── configs/
├── skills/
│   ├── skill-1.md
│   └── skill-2.md
├── hooks/
│   └── hooks.json
├── .mcp.json
├── .lsp.json
├── settings.json
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

### 실전 예제

#### 예제 1: PR Review Plugin

**파일:** `.claude-plugin/plugin.json`

```json
{
  "name": "pr-review",
  "version": "1.0.0",
  "description": "Complete PR review workflow with security, testing, and docs",
  "author": {
    "name": "Anthropic"
  },
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

#### 예제 2: DevOps Plugin

**컴포넌트:**

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

#### 예제 3: Documentation Plugin

**번들 컴포넌트:**

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

### Plugin 마켓플레이스

```mermaid
graph TB
    A["Plugin Marketplace"]
    B["Official<br/>Anthropic"]
    C["Community<br/>Marketplace"]
    D["Enterprise<br/>Registry"]

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
```

### Plugin 설치 및 생명주기

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

### Plugin 기능 비교

| 기능 | Slash Command | Skill | Subagent | Plugin |
|---------|---------------|-------|----------|--------|
| **설치** | 수동 복사 | 수동 복사 | 수동 설정 | 명령어 한 번 |
| **설정 시간** | 5분 | 10분 | 15분 | 2분 |
| **번들링** | 단일 파일 | 단일 파일 | 단일 파일 | 다중 |
| **버전 관리** | 수동 | 수동 | 수동 | 자동 |
| **팀 공유** | 파일 복사 | 파일 복사 | 파일 복사 | 설치 ID |
| **업데이트** | 수동 | 수동 | 수동 | 자동 제공 |
| **의존성** | 없음 | 없음 | 없음 | 포함 가능 |
| **마켓플레이스** | 아니오 | 아니오 | 아니오 | 예 |
| **배포** | 저장소 | 저장소 | 저장소 | 마켓플레이스 |

### Plugin 활용 사례

| 활용 사례 | 권장 사항 | 이유 |
|----------|-----------------|-----|
| **팀 온보딩** | ✅ Plugin 사용 | 즉각적인 설정, 모든 설정 포함 |
| **프레임워크 설정** | ✅ Plugin 사용 | 프레임워크별 명령어 번들 |
| **엔터프라이즈 기준** | ✅ Plugin 사용 | 중앙 배포, 버전 관리 |
| **빠른 작업 자동화** | ❌ Command 사용 | 과도한 복잡성 |
| **단일 도메인 전문성** | ❌ Skill 사용 | 너무 무거움, Skill 사용 권장 |
| **전문 분석** | ❌ Subagent 사용 | 수동 생성 또는 Skill 사용 |
| **실시간 데이터 접근** | ❌ MCP 사용 | 독립적으로, 번들하지 않음 |

### Plugin 생성 시점

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

### Plugin 배포하기

**배포 단계:**

1. 모든 컴포넌트를 포함한 Plugin 구조 생성
2. `.claude-plugin/plugin.json` 매니페스트 작성
3. 문서와 함께 `README.md` 생성
4. `/plugin install ./my-plugin`으로 로컬 테스트
5. Plugin 마켓플레이스에 제출
6. 검토 및 승인
7. 마켓플레이스에 게시
8. 사용자가 명령어 한 번으로 설치 가능

**제출 예시:**

~~~~markdown
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
~~~~

### Plugin vs 수동 설정

**수동 설정 (2시간 이상):**
- Slash commands 하나씩 설치
- Subagents 개별 생성
- MCPs 별도 설정
- Hooks 수동 설정
- 모든 내용 문서화
- 팀과 공유 (올바르게 설정했기를 바람)

**Plugin 사용 (2분):**
```bash
/plugin install pr-review
# ✅ 모든 항목 설치 및 설정 완료
# ✅ 즉시 사용 가능
# ✅ 팀이 동일한 설정 재현 가능
```

---

## 비교 & 통합

### 기능 비교 매트릭스

| 기능 | 호출 방식 | 영속성 | 범위 | 활용 사례 |
|---------|-----------|------------|-------|----------|
| **Slash Commands** | 수동 (`/cmd`) | 세션만 | 단일 명령어 | 빠른 단축키 |
| **Subagents** | 자동 위임 | 격리된 컨텍스트 | 전문화된 작업 | 작업 분배 |
| **Memory** | 자동 로드 | 세션 간 | 사용자/팀 컨텍스트 | 장기 학습 |
| **MCP Protocol** | 자동 쿼리 | 실시간 외부 | 실시간 데이터 접근 | 동적 정보 |
| **Skills** | 자동 호출 | 파일시스템 기반 | 재사용 가능한 전문성 | 자동화 워크플로우 |

### 상호작용 타임라인

```mermaid
graph LR
    A["Session Start"] -->|Load| B["Memory (CLAUDE.md)"]
    B -->|Discover| C["Available Skills"]
    C -->|Register| D["Slash Commands"]
    D -->|Connect| E["MCP Servers"]
    E -->|Ready| F["User Interaction"]

    F -->|Type /cmd| G["Slash Command"]
    F -->|Request| H["Skill Auto-Invoke"]
    F -->|Query| I["MCP Data"]
    F -->|Complex task| J["Delegate to Subagent"]

    G -->|Uses| B
    H -->|Uses| B
    I -->|Uses| B
    J -->|Uses| B
```

### 실전 통합 예제: 고객 지원 자동화

#### 아키텍처

```mermaid
graph TB
    User["Customer Email"] -->|Receives| Router["Support Router"]

    Router -->|Analyze| Memory["Memory<br/>Customer history"]
    Router -->|Lookup| MCP1["MCP: Customer DB<br/>Previous tickets"]
    Router -->|Check| MCP2["MCP: Slack<br/>Team status"]

    Router -->|Route Complex| Sub1["Subagent: Tech Support<br/>Context: Technical issues"]
    Router -->|Route Simple| Sub2["Subagent: Billing<br/>Context: Payment issues"]
    Router -->|Route Urgent| Sub3["Subagent: Escalation<br/>Context: Priority handling"]

    Sub1 -->|Format| Skill1["Skill: Response Generator<br/>Brand voice maintained"]
    Sub2 -->|Format| Skill2["Skill: Response Generator"]
    Sub3 -->|Format| Skill3["Skill: Response Generator"]

    Skill1 -->|Generate| Output["Formatted Response"]
    Skill2 -->|Generate| Output
    Skill3 -->|Generate| Output

    Output -->|Post| MCP3["MCP: Slack<br/>Notify team"]
    Output -->|Send| Reply["Customer Reply"]
```

#### 요청 흐름

```markdown
## 고객 지원 요청 흐름

### 1. 수신 이메일
"파일 업로드 시 500 에러가 발생합니다. 업무가 막혀 있어요!"

### 2. Memory 조회
- 지원 기준이 담긴 CLAUDE.md 로드
- 고객 이력 확인: VIP 고객, 이번 달 3번째 사고

### 3. MCP 쿼리
- GitHub MCP: 오픈 이슈 목록 (관련 버그 리포트 발견)
- Database MCP: 시스템 상태 확인 (장애 없음)
- Slack MCP: 엔지니어링팀 인지 여부 확인

### 4. Skill 감지 및 로딩
- 요청이 "Technical Support" Skill에 매칭
- Skill에서 지원 응답 템플릿 로드

### 5. Subagent 위임
- Tech Support Subagent로 라우팅
- 컨텍스트 제공: 고객 이력, 오류 세부사항, 알려진 이슈
- Subagent는 read, bash, grep 도구 전체 접근 가능

### 6. Subagent 처리
Tech Support Subagent:
- 파일 업로드의 500 에러를 코드베이스에서 검색
- 커밋 8f4a2c에서 최근 변경 발견
- 임시 해결책 문서 작성

### 7. Skill 실행
Response Generator Skill:
- Brand Voice 가이드라인 적용
- 공감을 담은 응답 형식화
- 임시 해결 단계 포함
- 관련 문서 링크 추가

### 8. MCP 출력
- #support Slack 채널에 업데이트 게시
- 엔지니어링팀 태그
- Jira MCP에서 티켓 업데이트

### 9. 응답
고객이 받는 내용:
- 공감적인 인정
- 원인 설명
- 즉각적인 임시 해결책
- 영구 수정 일정
- 관련 이슈 링크
```

### 전체 기능 조율

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Memory as Memory<br/>CLAUDE.md
    participant MCP as MCP Servers
    participant Skills as Skills
    participant SubAgent as Subagents

    User->>Claude: Request: "Build auth system"
    Claude->>Memory: Load project standards
    Memory-->>Claude: Auth standards, team practices
    Claude->>MCP: Query GitHub for similar implementations
    MCP-->>Claude: Code examples, best practices
    Claude->>Skills: Detect matching Skills
    Skills-->>Claude: Security Review Skill + Testing Skill
    Claude->>SubAgent: Delegate implementation
    SubAgent->>SubAgent: Build feature
    Claude->>Skills: Apply Security Review Skill
    Skills-->>Claude: Security checklist results
    Claude->>SubAgent: Delegate testing
    SubAgent-->>Claude: Test results
    Claude->>User: Complete system delivered
```

### 각 기능을 사용할 때

```mermaid
graph TD
    A["New Task"] --> B{Type of Task?}

    B -->|Repeated workflow| C["Slash Command"]
    B -->|Need real-time data| D["MCP Protocol"]
    B -->|Remember for next time| E["Memory"]
    B -->|Specialized subtask| F["Subagent"]
    B -->|Domain-specific work| G["Skill"]

    C --> C1["✅ Team shortcut"]
    D --> D1["✅ Live API access"]
    E --> E1["✅ Persistent context"]
    F --> F1["✅ Parallel execution"]
    G --> G1["✅ Auto-invoked expertise"]
```

### 선택 결정 트리

```mermaid
graph TD
    Start["Need to extend Claude?"]

    Start -->|Quick repeated task| A{"Manual or Auto?"}
    A -->|Manual| B["Slash Command"]
    A -->|Auto| C["Skill"]

    Start -->|Need external data| D{"Real-time?"}
    D -->|Yes| E["MCP Protocol"]
    D -->|No/Cross-session| F["Memory"]

    Start -->|Complex project| G{"Multiple roles?"}
    G -->|Yes| H["Subagents"]
    G -->|No| I["Skills + Memory"]

    Start -->|Long-term context| J["Memory"]
    Start -->|Team workflow| K["Slash Command +<br/>Memory"]
    Start -->|Full automation| L["Skills +<br/>Subagents +<br/>MCP"]
```

---

## 요약 표

| 항목 | Slash Commands | Subagents | Memory | MCP | Skills | Plugins |
|--------|---|---|---|---|---|---|
| **설정 난이도** | 쉬움 | 중간 | 쉬움 | 중간 | 중간 | 쉬움 |
| **학습 곡선** | 낮음 | 중간 | 낮음 | 중간 | 중간 | 낮음 |
| **팀 혜택** | 높음 | 높음 | 중간 | 높음 | 높음 | 매우 높음 |
| **자동화 수준** | 낮음 | 높음 | 중간 | 높음 | 높음 | 매우 높음 |
| **컨텍스트 관리** | 단일 세션 | 격리됨 | 영속적 | 실시간 | 영속적 | 모든 기능 |
| **유지보수 부담** | 낮음 | 중간 | 낮음 | 중간 | 중간 | 낮음 |
| **확장성** | 좋음 | 탁월 | 좋음 | 탁월 | 탁월 | 탁월 |
| **공유 가능성** | 보통 | 보통 | 좋음 | 좋음 | 좋음 | 탁월 |
| **버전 관리** | 수동 | 수동 | 수동 | 수동 | 수동 | 자동 |
| **설치** | 수동 복사 | 수동 설정 | 해당 없음 | 수동 설정 | 수동 복사 | 명령어 한 번 |

---

## 빠른 시작 가이드

### 1주차: 간단하게 시작
- 자주 사용하는 작업에 대한 slash commands 2-3개 생성
- 설정에서 Memory 활성화
- CLAUDE.md에 팀 기준 문서화

### 2주차: 실시간 접근 추가
- MCP 1개 설정 (GitHub 또는 데이터베이스)
- `/mcp`로 설정
- 워크플로우에서 실시간 데이터 쿼리

### 3주차: 작업 분배
- 특정 역할을 위한 첫 번째 Subagent 생성
- `/agents` 명령어 사용
- 간단한 작업으로 위임 테스트

### 4주차: 모든 것 자동화
- 반복 자동화를 위한 첫 번째 Skill 생성
- Skill 마켓플레이스 활용 또는 커스텀 빌드
- 모든 기능 결합하여 전체 워크플로우 구성

### 지속적으로
- Memory를 월별로 검토 및 업데이트
- 패턴이 생기면 새 Skills 추가
- MCP 쿼리 최적화
- Subagent 프롬프트 개선

---

## Hooks

### 개요

Hooks는 Claude Code 이벤트에 응답하여 자동으로 실행되는 이벤트 기반 셸 명령어입니다. 수동 개입 없이 자동화, 유효성 검사, 커스텀 워크플로우를 구현할 수 있습니다.

### Hook 이벤트

Claude Code는 네 가지 hook 유형(command, http, prompt, agent)에 걸쳐 **25개의 hook 이벤트**를 지원합니다:

| Hook 이벤트 | 트리거 | 활용 사례 |
|------------|---------|-----------|
| **SessionStart** | 세션 시작/재개/초기화/압축 | 환경 설정, 초기화 |
| **InstructionsLoaded** | CLAUDE.md 또는 rules 파일 로드 | 유효성 검사, 변환, 증강 |
| **UserPromptSubmit** | 사용자가 프롬프트 제출 | 입력 유효성 검사, 프롬프트 필터링 |
| **PreToolUse** | 도구 실행 전 | 유효성 검사, 승인 게이트, 로깅 |
| **PermissionRequest** | 권한 다이얼로그 표시 | 자동 승인/거부 흐름 |
| **PostToolUse** | 도구 성공 후 | 자동 포맷팅, 알림, 정리 |
| **PostToolUseFailure** | 도구 실행 실패 | 오류 처리, 로깅 |
| **Notification** | 알림 전송 | 알림, 외부 통합 |
| **SubagentStart** | Subagent 생성 | 컨텍스트 주입, 초기화 |
| **SubagentStop** | Subagent 완료 | 결과 유효성 검사, 로깅 |
| **Stop** | Claude가 응답 완료 | 요약 생성, 정리 작업 |
| **StopFailure** | API 오류로 턴 종료 | 오류 복구, 로깅 |
| **TeammateIdle** | 에이전트 팀 동료 유휴 | 작업 분배, 조율 |
| **TaskCompleted** | 작업이 완료로 표시됨 | 작업 후 처리 |
| **TaskCreated** | TaskCreate를 통해 작업 생성 | 작업 추적, 로깅 |
| **ConfigChange** | 설정 파일 변경 | 유효성 검사, 전파 |
| **CwdChanged** | 작업 디렉토리 변경 | 디렉토리별 설정 |
| **FileChanged** | 감시 파일 변경 | 파일 모니터링, 리빌드 트리거 |
| **PreCompact** | 컨텍스트 압축 전 | 상태 보존 |
| **PostCompact** | 압축 완료 후 | 압축 후 작업 |
| **WorktreeCreate** | 워크트리 생성 중 | 환경 설정, 의존성 설치 |
| **WorktreeRemove** | 워크트리 제거 중 | 정리, 리소스 해제 |
| **Elicitation** | MCP 서버가 사용자 입력 요청 | 입력 유효성 검사 |
| **ElicitationResult** | 사용자가 elicitation에 응답 | 응답 처리 |
| **SessionEnd** | 세션 종료 | 정리, 최종 로깅 |

### 일반적인 Hooks

Hooks는 `~/.claude/settings.json` (사용자 수준) 또는 `.claude/settings.json` (프로젝트 수준)에서 설정합니다:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write $CLAUDE_FILE_PATH"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "eslint $CLAUDE_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Hook 환경 변수

- `$CLAUDE_FILE_PATH` - 편집/작성 중인 파일 경로
- `$CLAUDE_TOOL_NAME` - 사용 중인 도구 이름
- `$CLAUDE_SESSION_ID` - 현재 세션 식별자
- `$CLAUDE_PROJECT_DIR` - 프로젝트 디렉토리 경로

### 모범 사례

✅ **권장:**
- Hook을 빠르게 유지 (1초 미만)
- 유효성 검사와 자동화에 Hooks 활용
- 오류를 우아하게 처리
- 절대 경로 사용

❌ **비권장:**
- Hooks를 인터랙티브하게 만들지 말 것
- 장시간 실행 작업에 Hooks 사용 금지
- 자격증명 하드코딩 금지

**참조**: [06-hooks/](06-hooks/) 에서 상세 예제 확인

---

## Checkpoints and Rewind

### 개요

Checkpoints는 대화 상태를 저장하고 이전 시점으로 되돌릴 수 있게 하여 안전한 실험과 여러 접근 방법 탐색을 가능하게 합니다.

### 핵심 개념

| 개념 | 설명 |
|---------|-------------|
| **Checkpoint** | 메시지, 파일, 컨텍스트를 포함한 대화 상태의 스냅샷 |
| **Rewind** | 이전 checkpoint로 돌아가고 이후 변경사항 폐기 |
| **Branch Point** | 여러 접근 방법을 탐색하는 출발점이 되는 checkpoint |

### Checkpoints 접근하기

Checkpoints는 모든 사용자 프롬프트와 함께 자동으로 생성됩니다. 되돌리려면:

```bash
# Esc를 두 번 눌러 checkpoint 브라우저 열기
Esc + Esc

# 또는 /rewind 명령어 사용
/rewind
```

checkpoint를 선택하면 다섯 가지 옵션 중 선택합니다:
1. **Restore code and conversation** -- 코드와 대화 모두 해당 시점으로 되돌림
2. **Restore conversation** -- 메시지만 되돌리고 현재 코드 유지
3. **Restore code** -- 파일만 되돌리고 대화 유지
4. **Summarize from here** -- 대화를 요약으로 압축
5. **Never mind** -- 취소

### 활용 사례

| 시나리오 | 워크플로우 |
|----------|----------|
| **접근 방법 탐색** | 저장 → A 시도 → 저장 → Rewind → B 시도 → 비교 |
| **안전한 리팩토링** | 저장 → 리팩토링 → 테스트 → 실패 시: Rewind |
| **A/B 테스트** | 저장 → 디자인 A → 저장 → Rewind → 디자인 B → 비교 |
| **실수 복구** | 문제 발견 → 마지막 정상 상태로 Rewind |

### 설정

```json
{
  "autoCheckpoint": true
}
```

**참조**: [08-checkpoints/](08-checkpoints/) 에서 상세 예제 확인

---

## Advanced Features

### Planning Mode

코딩 전에 상세한 구현 계획을 수립합니다.

**활성화:**
```bash
/plan Implement user authentication system
```

**장점:**
- 시간 예상이 포함된 명확한 로드맵
- 위험 평가
- 체계적인 작업 분해
- 검토 및 수정 기회

### Extended Thinking

복잡한 문제에 대한 심층 추론입니다.

**활성화:**
- 세션 중 `Alt+T` (macOS에서는 `Option+T`)로 토글
- 프로그래밍 방식 제어를 위해 `MAX_THINKING_TOKENS` 환경 변수 설정

```bash
# 환경 변수로 extended thinking 활성화
export MAX_THINKING_TOKENS=50000
claude -p "Should we use microservices or monolith?"
```

**장점:**
- 트레이드오프의 철저한 분석
- 더 나은 아키텍처 결정
- 엣지 케이스 고려
- 체계적인 평가

### Background Tasks

대화를 차단하지 않고 장시간 작업을 실행합니다.

**사용법:**
```bash
User: Run tests in background

Claude: Started task bg-1234

/task list           # 모든 작업 표시
/task status bg-1234 # 진행 상황 확인
/task show bg-1234   # 출력 내용 확인
/task cancel bg-1234 # 작업 취소
```

### Permission Modes

Claude가 수행할 수 있는 작업을 제어합니다.

| 모드 | 설명 | 활용 사례 |
|------|-------------|----------|
| **default** | 민감한 작업에는 프롬프트가 표시되는 표준 권한 | 일반 개발 |
| **acceptEdits** | 확인 없이 파일 편집 자동 수락 | 신뢰할 수 있는 편집 워크플로우 |
| **plan** | 분석 및 계획만, 파일 수정 없음 | 코드 리뷰, 아키텍처 계획 |
| **auto** | 안전한 작업은 자동 승인, 위험한 것만 프롬프트 | 안전성과 자율성의 균형 |
| **dontAsk** | 확인 프롬프트 없이 모든 작업 실행 | 숙련 사용자, 자동화 |
| **bypassPermissions** | 완전 무제한 접근, 안전 검사 없음 | CI/CD 파이프라인, 신뢰할 수 있는 스크립트 |

**사용법:**
```bash
claude --permission-mode plan          # 읽기 전용 분석
claude --permission-mode acceptEdits   # 편집 자동 수락
claude --permission-mode auto          # 안전한 작업 자동 승인
claude --permission-mode dontAsk       # 확인 프롬프트 없음
```

### Headless Mode (Print Mode)

`-p` (print) 플래그를 사용하여 인터랙티브 입력 없이 자동화 및 CI/CD에서 Claude Code를 실행합니다.

**사용법:**
```bash
# 특정 작업 실행
claude -p "Run all tests"

# 분석을 위해 입력 파이프
cat error.log | claude -p "explain this error"

# CI/CD 통합 (GitHub Actions)
- name: AI Code Review
  run: claude -p "Review PR changes and report issues"

# 스크립팅을 위한 JSON 출력
claude -p --output-format json "list all functions in src/"
```

### Scheduled Tasks

`/loop` 명령어를 사용하여 반복 일정으로 작업을 실행합니다.

**사용법:**
```bash
/loop every 30m "Run tests and report failures"
/loop every 2h "Check for dependency updates"
/loop every 1d "Generate daily summary of code changes"
```

예약된 작업은 백그라운드에서 실행되며 완료 시 결과를 보고합니다. 지속적인 모니터링, 주기적인 점검, 자동화된 유지보수 워크플로우에 유용합니다.

### Chrome 통합

Claude Code는 웹 자동화 작업을 위해 Chrome 브라우저와 통합될 수 있습니다. 개발 워크플로우 내에서 웹 페이지 탐색, 양식 작성, 스크린샷 촬영, 웹사이트에서 데이터 추출 등의 기능을 직접 사용할 수 있습니다.

### Session Management

여러 작업 세션을 관리합니다.

**명령어:**
```bash
/resume                # 이전 대화 재개
/rename "Feature"      # 현재 세션 이름 지정
/fork                  # 새 세션으로 분기
claude -c              # 가장 최근 대화 계속
claude -r "Feature"    # 이름/ID로 세션 재개
```

### Interactive Features

**키보드 단축키:**
- `Ctrl + R` - 명령어 기록 검색
- `Tab` - 자동완성
- `↑ / ↓` - 명령어 기록
- `Ctrl + L` - 화면 지우기

**멀티라인 입력:**
```bash
User: \
> Long complex prompt
> spanning multiple lines
> \end
```

### 설정

완전한 설정 예시:

```json
{
  "planning": {
    "autoEnter": true,
    "requireApproval": true
  },
  "extendedThinking": {
    "enabled": true,
    "showThinkingProcess": true
  },
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5
  },
  "permissions": {
    "mode": "default"
  }
}
```

**참조**: [09-advanced-features/](09-advanced-features/) 에서 종합 가이드 확인

---

## 리소스

- [Claude Code Documentation](https://code.claude.com/docs/en/overview)
- [Anthropic Documentation](https://docs.anthropic.com)
- [MCP GitHub Servers](https://github.com/modelcontextprotocol/servers)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

---

*최종 업데이트: 2026년 3월*
*Claude Haiku 4.5, Sonnet 4.6, Opus 4.6 기준*
*포함 내용: Hooks, Checkpoints, Planning Mode, Extended Thinking, Background Tasks, Permission Modes (6가지), Headless Mode, Session Management, Auto Memory, Agent Teams, Scheduled Tasks, Chrome Integration, Channels, Voice Dictation, 번들 Skills*
