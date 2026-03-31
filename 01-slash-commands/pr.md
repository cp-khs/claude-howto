---
description: Clean up code, stage changes, and prepare a pull request
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(npm test:*), Bash(npm run lint:*)
---

# Pull Request 준비 체크리스트

PR 생성 전 다음 단계를 수행합니다:

1. 린팅 실행: `prettier --write .`
2. 테스트 실행: `npm test`
3. git diff 확인: `git diff HEAD`
4. 변경 사항 스테이징: `git add .`
5. conventional commits에 따른 커밋 메시지 작성:
   - `fix:` 버그 수정
   - `feat:` 새로운 기능
   - `docs:` 문서 변경
   - `refactor:` 코드 구조 변경
   - `test:` 테스트 추가
   - `chore:` 유지 보수 작업

6. 다음 내용을 포함한 PR 요약 생성:
   - 변경된 내용
   - 변경 이유
   - 수행한 테스트
   - 잠재적 영향
