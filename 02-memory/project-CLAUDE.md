# 프로젝트 설정

## 프로젝트 개요
- **이름**: E-commerce 플랫폼
- **기술 스택**: Node.js, PostgreSQL, React 18, Docker
- **팀 규모**: 개발자 5명
- **마감일**: 2025년 4분기

## 아키텍처
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## 개발 표준

### 코드 스타일
- 포매팅에 Prettier 사용
- airbnb 설정의 ESLint 사용
- 최대 줄 길이: 100자
- 들여쓰기: 공백 2칸

### 네이밍 컨벤션
- **파일**: kebab-case (user-controller.js)
- **클래스**: PascalCase (UserService)
- **함수/변수**: camelCase (getUserById)
- **상수**: UPPER_SNAKE_CASE (API_BASE_URL)
- **데이터베이스 테이블**: snake_case (user_accounts)

### Git 워크플로우
- 브랜치명: `feature/설명` 또는 `fix/설명`
- 커밋 메시지: conventional commits 준수
- 병합 전 PR 필수
- 모든 CI/CD 검사 통과 필수
- 최소 1명의 승인 필요

### 테스트 요구사항
- 최소 코드 커버리지 80%
- 모든 중요 경로에 테스트 필수
- 단위 테스트에 Jest 사용
- E2E 테스트에 Cypress 사용
- 테스트 파일명: `*.test.ts` 또는 `*.spec.ts`

### API 표준
- RESTful 엔드포인트만 사용
- JSON 요청/응답
- HTTP 상태 코드 올바르게 사용
- API 엔드포인트 버전 관리: `/api/v1/`
- 모든 엔드포인트를 예시와 함께 문서화

### 데이터베이스
- 스키마 변경에 마이그레이션 사용
- 자격증명 하드코딩 금지
- 커넥션 풀링 사용
- 개발 환경에서 쿼리 로깅 활성화
- 정기적인 백업 필수

### 배포
- Docker 기반 배포
- Kubernetes 오케스트레이션
- Blue-green 배포 전략
- 장애 시 자동 롤백
- 배포 전 데이터베이스 마이그레이션 실행

## 공통 명령어

| 명령어 | 목적 |
|---------|---------|
| `npm run dev` | 개발 서버 시작 |
| `npm test` | 테스트 스위트 실행 |
| `npm run lint` | 코드 스타일 검사 |
| `npm run build` | 프로덕션 빌드 |
| `npm run migrate` | 데이터베이스 마이그레이션 실행 |

## 팀 연락처
- 기술 리드: Sarah Chen (@sarah.chen)
- 프로덕트 매니저: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## 알려진 문제 및 해결책
- 피크 시간대에 PostgreSQL 커넥션 풀링이 20으로 제한됨
- 해결책: 쿼리 큐잉 구현
- Safari 14에서 async generator 호환성 문제
- 해결책: Babel 트랜스파일러 사용

## 관련 프로젝트
- 분석 대시보드: `/projects/analytics`
- 모바일 앱: `/projects/mobile`
- 관리자 패널: `/projects/admin`
