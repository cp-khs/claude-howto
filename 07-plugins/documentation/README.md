<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# Documentation 플러그인

프로젝트를 위한 종합적인 문서 생성 및 유지 관리입니다.

## 기능

✅ API 문서 생성
✅ README 생성 및 업데이트
✅ 문서 동기화
✅ 코드 주석 개선
✅ 예제 생성

## 설치

```bash
/plugin install documentation
```

## 포함 항목

### Slash Commands
- `/generate-api-docs` - API 문서 생성
- `/generate-readme` - README 생성 또는 업데이트
- `/sync-docs` - 코드 변경사항과 문서 동기화
- `/validate-docs` - 문서 검증

### Subagents
- `api-documenter` - API 문서화 전문가
- `code-commentator` - 코드 주석 개선
- `example-generator` - 코드 예제 생성

### Templates
- `api-endpoint.md` - API 엔드포인트 문서 템플릿
- `function-docs.md` - 함수 문서 템플릿
- `adr-template.md` - Architecture Decision Record 템플릿

### MCP Servers
- 문서 동기화를 위한 GitHub 통합

## 사용법

### API 문서 생성
```
/generate-api-docs
```

### README 생성
```
/generate-readme
```

### 문서 동기화
```
/sync-docs
```

### 문서 검증
```
/validate-docs
```

## 요구 사항

- Claude Code 1.0+
- GitHub 접근 권한 (선택 사항)

## 예제 워크플로우

```
User: /generate-api-docs

Claude:
1. /src/api/ 내 모든 API 엔드포인트 스캔
2. api-documenter subagent에 위임
3. 함수 시그니처 및 JSDoc 추출
4. 모듈/엔드포인트별 정리
5. api-endpoint.md 템플릿 사용
6. 종합 마크다운 문서 생성
7. curl, JavaScript, Python 예제 포함

결과:
✅ API 문서 생성 완료
📄 생성된 파일:
   - docs/api/users.md
   - docs/api/auth.md
   - docs/api/products.md
📊 커버리지: 23/23 엔드포인트 문서화 완료
```

## 템플릿 사용법

### API Endpoint Template
전체 예제를 포함한 REST API 엔드포인트 문서화에 사용합니다.

### Function Documentation Template
개별 함수/메서드 문서화에 사용합니다.

### ADR Template
아키텍처 결정 사항 문서화에 사용합니다.

## 설정

문서 동기화를 위한 GitHub 토큰을 설정하세요:
```bash
export GITHUB_TOKEN="your_github_token"
```

## 모범 사례

- 코드와 가까운 위치에 문서를 유지하세요
- 코드 변경 시 문서도 함께 업데이트하세요
- 실용적인 예제를 포함하세요
- 정기적으로 검증하세요
- 일관성을 위해 템플릿을 사용하세요
