# Checkpoint 예시

Claude Code에서 checkpoint를 효과적으로 활용하는 실제 사례 모음입니다.

참고: Checkpoint는 사용자 프롬프트마다 자동으로 생성됩니다. 수동으로 저장할 필요가 없습니다. Rewind하려면 `Esc`를 두 번 누르거나(`Esc+Esc`) `/rewind`를 사용하여 checkpoint 브라우저를 여세요.

## 예시 1: 데이터베이스 마이그레이션

### 시나리오
MySQL에서 PostgreSQL로 마이그레이션해야 하는데, 직접 마이그레이션과 점진적 이중 쓰기(dual-write) 방식 두 가지를 모두 탐색하고 싶습니다.

### 워크플로우

```
User: MySQL에서 PostgreSQL로 직접 마이그레이션을 구현해 봅시다
      [Checkpoint A 자동 생성]

Claude: 직접 마이그레이션을 구현하겠습니다...
[데이터베이스 드라이버 변경, 쿼리 업데이트, 스키마 수정]

User: 테스트 실행
      [Checkpoint B 자동 생성]

Claude: 테스트 실행 중...
❌ 15개 테스트 실패 - 커넥션 풀 문제

User: 이 접근 방식에 문제가 있습니다. 대신 dual-write 패턴을 시도해봅시다.
[사용자가 Esc+Esc를 눌러 Checkpoint A를 선택하고 "Restore code and conversation" 선택]

User: 이제 두 데이터베이스 모두에 쓰는 dual-write 패턴을 구현해 주세요

Claude: dual-write 마이그레이션을 구현하겠습니다...
[dual-write 레이어 구현, 점진적 마이그레이션 전략 적용]

User: 테스트 실행

Claude: 테스트 실행 중...
✅ 모든 테스트 통과

User: dual-write 방식이 명확히 더 안전합니다. 이것을 커밋합시다.
```

## 예시 2: 성능 최적화

### 시나리오
여러 가지 성능 최적화 전략을 시도해 봅니다.

### 워크플로우

```
User: API 응답 시간을 최적화해봅시다. 현재: 450ms
      [Checkpoint "Baseline" 자동 생성]

Claude: 데이터베이스 쿼리 캐싱을 추가하겠습니다...
[Redis 캐싱 구현]

User: 성능 테스트 실행

Claude: 결과: 평균 응답 시간 280ms (38% 개선)

User: 다른 접근 방식을 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "Baseline" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 대신 데이터베이스 쿼리 최적화를 시도해 주세요

Claude: 데이터베이스 쿼리를 최적화하겠습니다...
[인덱스 추가, N+1 쿼리 최적화]

User: 성능 테스트 실행

Claude: 결과: 평균 응답 시간 180ms (60% 개선)

User: 세 번째 방법도 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "Baseline" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 응답 압축과 CDN을 시도해 주세요

Claude: 압축과 CDN을 추가하겠습니다...
[gzip 구현, CDN 설정]

User: 성능 테스트 실행

Claude: 결과: 평균 응답 시간 320ms (29% 개선)

User: 쿼리 최적화가 가장 좋았습니다. 돌아가서 캐싱과 함께 결합해봅시다.
[사용자가 Esc+Esc를 눌러 쿼리 최적화 이후 checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 이 최적화된 쿼리 위에 Redis 캐싱을 추가해 주세요

Claude: [최적화된 쿼리 위에 Redis 캐싱 추가]

User: 성능 테스트 실행

Claude: 결과: 평균 응답 시간 95ms (79% 개선) 🎉

User: 완벽합니다! 이게 최선입니다. 커밋합시다.
```

## 예시 3: UI/UX 반복 개선

### 시나리오
대시보드의 다양한 레이아웃을 시도합니다.

### 워크플로우

```
User: 사이드바 레이아웃으로 대시보드를 재설계해봅시다
      [Checkpoint "Start" 자동 생성]

Claude: [사이드바 레이아웃 구현]

User: 스크린샷을 보여주세요

Claude: [스크린샷 표시]

User: 사이드바가 너무 좁아 보입니다. 대신 상단 내비게이션을 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "Start" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 상단 내비게이션 레이아웃을 시도해 주세요

Claude: [상단 내비게이션 구현]

User: 스크린샷을 보여주세요

Claude: [스크린샷 표시]

User: 더 낫습니다만, 카드 기반 그리드 레이아웃을 시도해봅시다
[사용자가 Esc+Esc를 눌러 "Start" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 카드 기반 그리드 레이아웃을 시도해 주세요

Claude: [카드 그리드 구현]

User: 스크린샷을 보여주세요

Claude: [스크린샷 표시]

User: 훌륭합니다! 상단 내비게이션과 카드 그리드를 결합할 수 있을까요?
[사용자가 Esc+Esc를 눌러 카드 그리드 이후 checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 카드 그리드 레이아웃에 상단 내비게이션을 추가해 주세요

Claude: [카드 그리드에 상단 내비게이션 추가]

User: 완벽합니다! 이것이 최종 디자인입니다.
```

## 예시 4: 디버깅 세션

### 시나리오
여러 가설을 가지고 까다로운 버그를 추적합니다.

### 워크플로우

```
User: 애플리케이션에 메모리 누수가 있습니다
      [Checkpoint "디버깅 전" 자동 생성]

Claude: 조사해보겠습니다...
[코드 분석]

User: 이벤트 리스너에 문제가 있는 것 같습니다. 수정해봅시다.

Claude: [이벤트 리스너 정리 수정]

User: 메모리 프로파일러 실행

Claude: 아직 메모리가 누수됩니다 - 이벤트 리스너는 문제가 아니었습니다

User: 돌아가서 다른 가설을 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "디버깅 전" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 데이터베이스 연결 문제일까요?

Claude: [커넥션 풀링 수정 구현]

User: 메모리 프로파일러 실행

Claude: 아직 누수됩니다 - 연결도 아닙니다

User: 돌아가서 다른 각도로 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "디버깅 전" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 순환 참조를 확인해봅시다

Claude: [캐시에서 순환 참조 발견 및 수정]

User: 메모리 프로파일러 실행

Claude: ✅ 메모리 누수 수정! 캐싱 레이어의 순환 참조가 원인이었습니다.

User: 훌륭합니다! 이 수정 사항을 커밋합시다.
```

## 예시 5: API 설계 발전

### 시나리오
여러 번의 반복으로 REST API를 설계합니다.

### 워크플로우

```
User: 블로그 플랫폼용 REST API를 만들어 주세요
      [Checkpoint "API 설계 전" 자동 생성]

Claude: [기본 CRUD API 생성]

User: 너무 단순합니다. 페이지네이션과 필터링을 추가해봅시다

Claude: [페이지네이션과 필터링 추가]

User: 더 나은 리소스 관계가 필요합니다

Claude: [HATEOAS 링크 구현]

User: 사실, REST 대신 GraphQL을 시도해봅시다
[사용자가 Esc+Esc를 눌러 "API 설계 전" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 대신 블로그 플랫폼용 GraphQL API를 구현해 주세요

Claude: [GraphQL API 구현]

User: 우리 사용 사례에는 REST가 더 적합한 것 같습니다.
[사용자가 Esc+Esc를 눌러 HATEOAS 이후 checkpoint를 선택하고 "Restore code and conversation" 선택]

User: REST 방식으로 확정합시다.
```

## 예시 6: 설정 관리

### 시나리오
다양한 설정 접근 방식을 테스트합니다.

### 워크플로우

```
User: 설정을 환경 변수로 이전해봅시다
      [Checkpoint "원본 설정" 자동 생성]

Claude: [환경 변수 설정 구현]

User: 개발 환경에서 테스트

Claude: 로컬에서는 작동하지만 프로덕션 배포에서 문제 발생

User: 다른 접근 방식을 시도해봅시다.
[사용자가 Esc+Esc를 눌러 "원본 설정" checkpoint를 선택하고 "Restore code and conversation" 선택]

User: 검증이 포함된 설정 파일 방식을 시도해 주세요

Claude: [JSON schema 검증과 함께 YAML 설정 구현]

User: 개발 환경에서 테스트

Claude: ✅ 잘 작동하고 검증 오류 메시지도 적절함

User: 민감한 값을 위한 환경 변수도 지원할 수 있을까요?

Claude: [비밀값을 위한 환경 변수 오버라이드 추가]

User: 배포 테스트

Claude: ✅ 모든 환경에서 정상 작동

User: 완벽합니다! 이것은 프로덕션 준비 완료입니다.
```

## 예시 7: 테스트 전략

### 시나리오
포괄적인 테스트를 구현합니다.

### 워크플로우

```
User: 인증 모듈에 단위 테스트를 추가해 주세요
      [Checkpoint 자동 생성]

Claude: [Jest 단위 테스트 추가]

User: 테스트 실행

Claude: 45개 테스트 통과, 커버리지 78%

User: 통합 테스트도 추가해봅시다

Claude: [통합 테스트 추가]

User: 테스트 실행

Claude: 89개 테스트 통과, 커버리지 92%, 하지만 테스트가 느림 (3분)

User: 테스트가 너무 느립니다. 최적화해봅시다.

Claude: [테스트 설정 최적화, 병렬 실행 추가]

User: 테스트 실행

Claude: 89개 테스트 통과, 커버리지 92%, 35초 ✅

User: 훌륭합니다! 이제 중요한 경로에 E2E 테스트를 추가해봅시다

Claude: [Playwright E2E 테스트 추가]

User: 모든 테스트 실행

Claude: 112개 테스트 통과, 커버리지 94%, 2분

User: 커버리지와 속도의 완벽한 균형입니다!
```

## 예시 8: Checkpoint에서 요약 기능 사용

### 시나리오
긴 디버깅 세션 후, 컨텍스트를 유지하면서 대화를 압축하고 싶습니다.

### 워크플로우

```
User: [20개 이상의 디버깅 및 탐색 메시지 후]

[사용자가 Esc+Esc를 눌러 초기 checkpoint를 선택하고 "Summarize from here" 선택]
[선택적으로 지침 제공: "시도한 것과 성공한 것에 초점을 맞춰 주세요"]

Claude: [해당 시점부터의 대화 요약 생성]
[원본 메시지는 트랜스크립트에 보존됨]
[요약이 보이는 대화를 대체하여 컨텍스트 창 사용량 감소]

User: 이제 성공한 접근 방식으로 계속 진행합시다.
```

## 주요 시사점

1. **Checkpoint는 자동으로 생성됨**: 사용자 프롬프트마다 checkpoint가 생성됩니다 -- 수동 저장 불필요
2. **Esc+Esc 또는 /rewind 사용**: checkpoint 브라우저에 접근하는 두 가지 방법
3. **올바른 복원 옵션 선택**: 필요에 따라 코드 복원, 대화 복원, 둘 다, 또는 요약 선택
4. **실험을 두려워하지 말 것**: Checkpoint가 과감한 변경도 안전하게 시도할 수 있게 해줌
5. **git과 함께 사용**: 탐색에는 checkpoint, 확정된 작업에는 git 사용
6. **긴 세션 요약**: "Summarize from here"를 사용하여 대화를 관리 가능한 수준으로 유지
