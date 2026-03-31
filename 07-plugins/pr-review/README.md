<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# PR Review 플러그인

보안, 테스트, 문서화 검사를 포함한 완전한 PR 리뷰 워크플로우입니다.

## 기능

✅ 보안 분석
✅ 테스트 커버리지 검사
✅ 문서화 검증
✅ 코드 품질 평가
✅ 성능 영향 분석

## 설치

```bash
/plugin install pr-review
```

## 포함 항목

### Slash Commands
- `/review-pr` - 종합 PR 리뷰
- `/check-security` - 보안 중심 리뷰
- `/check-tests` - 테스트 커버리지 분석

### Subagents
- `security-reviewer` - 보안 취약점 탐지
- `test-checker` - 테스트 커버리지 분석
- `performance-analyzer` - 성능 영향 평가

### MCP Servers
- PR 데이터를 위한 GitHub 통합

### Hooks
- `pre-review.js` - 리뷰 전 검증

## 사용법

### 기본 PR 리뷰
```
/review-pr
```

### 보안 검사만 수행
```
/check-security
```

### 테스트 커버리지 검사
```
/check-tests
```

## 요구 사항

- Claude Code 1.0+
- GitHub 접근 권한
- Git 저장소

## 설정

GitHub 토큰을 설정하세요:
```bash
export GITHUB_TOKEN="your_github_token"
```

## 예제 워크플로우

```
User: /review-pr

Claude:
1. pre-review hook 실행 (git 저장소 검증)
2. GitHub MCP를 통해 PR 데이터 가져오기
3. security-reviewer subagent에 보안 리뷰 위임
4. test-checker subagent에 테스트 검사 위임
5. performance-analyzer subagent에 성능 분석 위임
6. 모든 결과 종합
7. 종합 리뷰 보고서 제공

결과:
✅ Security: 심각한 문제 없음
⚠️  Testing: 커버리지 65%, 80% 이상 권장
✅ Performance: 유의미한 영향 없음
📝 권장사항: 엣지 케이스에 대한 테스트 추가
```
