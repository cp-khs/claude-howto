<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Checkpoints와 Rewind

Checkpoints를 사용하면 대화 상태를 저장하고 Claude Code 세션의 이전 시점으로 되돌아갈 수 있습니다. 다양한 접근 방식을 탐색하거나, 실수를 복구하거나, 대안적인 해결책을 비교할 때 매우 유용합니다.

## 개요

Checkpoints를 사용하면 대화 상태를 저장하고 이전 시점으로 되돌아가, 안전하게 실험하고 여러 접근 방식을 탐색할 수 있습니다. Checkpoint는 다음을 포함한 대화 상태의 스냅샷입니다:
- 주고받은 모든 메시지
- 수행된 파일 수정 내역
- 도구 사용 기록
- 세션 컨텍스트

Checkpoints는 다양한 접근 방식을 탐색하거나, 실수를 복구하거나, 대안적인 해결책을 비교할 때 매우 유용합니다.

## 주요 개념

| 개념 | 설명 |
|---------|-------------|
| **Checkpoint** | 메시지, 파일, 컨텍스트를 포함한 대화 상태의 스냅샷 |
| **Rewind** | 이전 checkpoint로 돌아가며 이후 변경 사항을 폐기 |
| **Branch Point** | 여러 접근 방식을 탐색하는 출발점이 되는 checkpoint |

## Checkpoints 접근 방법

두 가지 주요 방법으로 checkpoint를 확인하고 관리할 수 있습니다:

### 키보드 단축키 사용
`Esc`를 두 번 누르면(`Esc` + `Esc`) checkpoint 인터페이스가 열리며 저장된 checkpoint를 탐색할 수 있습니다.

### Slash 명령어 사용
빠른 접근을 위해 `/rewind` 명령어(별칭: `/checkpoint`)를 사용하세요:

```bash
# rewind 인터페이스 열기
/rewind

# 또는 별칭 사용
/checkpoint
```

## Rewind 옵션

Rewind 시 다섯 가지 옵션이 있는 메뉴가 표시됩니다:

1. **Restore code and conversation** -- 파일과 메시지 모두를 해당 checkpoint로 복원
2. **Restore conversation** -- 메시지만 되돌리고, 현재 코드는 그대로 유지
3. **Restore code** -- 파일 변경 사항만 복원하고, 전체 대화 기록은 유지
4. **Summarize from here** -- 해당 시점부터의 대화를 폐기하는 대신 AI가 생성한 요약으로 압축합니다. 원본 메시지는 트랜스크립트에 보존됩니다. 선택적으로 특정 주제에 초점을 맞추도록 지시할 수 있습니다.
5. **Never mind** -- 취소하고 현재 상태로 돌아가기

## 자동 Checkpoints

Claude Code는 자동으로 checkpoint를 생성합니다:

- **사용자 프롬프트마다** - 사용자 입력이 있을 때마다 새 checkpoint가 생성됨
- **지속성** - Checkpoint는 세션 간에도 유지됨
- **자동 정리** - Checkpoint는 30일 후 자동으로 정리됨

즉, 몇 분 전부터 며칠 전까지 대화의 어떤 이전 시점으로도 항상 되돌아갈 수 있습니다.

## 활용 사례

| 시나리오 | 워크플로우 |
|----------|----------|
| **접근 방식 탐색** | 저장 → 방법 A 시도 → 저장 → Rewind → 방법 B 시도 → 비교 |
| **안전한 리팩토링** | 저장 → 리팩토링 → 테스트 → 실패 시: Rewind |
| **A/B 테스트** | 저장 → 디자인 A → 저장 → Rewind → 디자인 B → 비교 |
| **실수 복구** | 문제 발견 → 마지막으로 좋았던 상태로 Rewind |

## Checkpoints 사용법

### 확인 및 Rewind

`Esc`를 두 번 누르거나 `/rewind`를 사용하여 checkpoint 브라우저를 엽니다. 타임스탬프와 함께 사용 가능한 모든 checkpoint 목록이 표시됩니다. 원하는 checkpoint를 선택하여 해당 상태로 되돌아가세요.

### Checkpoint 상세 정보

각 checkpoint에는 다음 정보가 표시됩니다:
- 생성된 시각의 타임스탬프
- 수정된 파일 목록
- 대화의 메시지 수
- 사용된 도구 목록

## 실제 예시

### 예시 1: 다양한 접근 방식 탐색

```
User: API에 캐싱 레이어를 추가해봅시다

Claude: API 엔드포인트에 Redis 캐싱을 추가하겠습니다...
[checkpoint A에서 변경 수행]

User: 사실, 인메모리 캐싱을 대신 시도해 봅시다

Claude: 다른 접근 방식을 탐색하기 위해 rewind하겠습니다...
[사용자가 Esc+Esc를 눌러 checkpoint A로 rewind]
[checkpoint B에서 인메모리 캐싱 구현]

User: 이제 두 가지 접근 방식을 비교할 수 있습니다
```

### 예시 2: 실수 복구

```
User: 인증 모듈을 JWT를 사용하도록 리팩토링해 주세요

Claude: 인증 모듈을 리팩토링하겠습니다...
[광범위한 변경 수행]

User: 잠깐, OAuth 통합이 깨졌습니다. 되돌아가겠습니다.

Claude: 리팩토링 이전으로 rewind하는 것을 도와드리겠습니다...
[사용자가 Esc+Esc를 눌러 리팩토링 이전 checkpoint 선택]

User: 이번에는 더 보수적인 접근 방식을 시도해 봅시다
```

### 예시 3: 안전한 실험

```
User: 이것을 함수형 스타일로 재작성해 봅시다
[실험 전에 checkpoint 생성]

Claude: [실험적인 변경 수행]

User: 테스트가 실패합니다. Rewind하겠습니다.
[사용자가 Esc+Esc를 눌러 checkpoint로 rewind]

Claude: 변경 사항을 되돌렸습니다. 다른 접근 방식을 시도해 보겠습니다.
```

### 예시 4: 접근 방식 분기

```
User: 두 가지 데이터베이스 설계를 비교하고 싶습니다
[checkpoint 메모 - "시작"이라고 부릅시다]

Claude: 첫 번째 설계를 생성하겠습니다...
[스키마 A 구현]

User: 이제 돌아가서 두 번째 접근 방식을 시도해봅시다
[사용자가 Esc+Esc를 눌러 "시작"으로 rewind]

Claude: 이제 스키마 B를 구현하겠습니다...
[스키마 B 구현]

User: 훌륭합니다! 이제 선택할 수 있는 두 가지 스키마가 생겼습니다
```

## Checkpoint 보존 기간

Claude Code는 자동으로 checkpoint를 관리합니다:

- Checkpoint는 사용자 프롬프트마다 자동으로 생성됨
- 이전 checkpoint는 최대 30일 동안 보존됨
- 무제한 저장 증가를 방지하기 위해 자동으로 정리됨

## 워크플로우 패턴

### 탐색을 위한 분기 전략

여러 접근 방식을 탐색할 때:

```
1. 초기 구현 시작 → Checkpoint A
2. 접근 방식 1 시도 → Checkpoint B
3. Checkpoint A로 Rewind
4. 접근 방식 2 시도 → Checkpoint C
5. B와 C의 결과 비교
6. 최적의 접근 방식 선택 후 계속
```

### 안전한 리팩토링 패턴

중요한 변경을 할 때:

```
1. 현재 상태 → Checkpoint (자동 생성)
2. 리팩토링 시작
3. 테스트 실행
4. 테스트 통과 시 → 계속 작업
5. 테스트 실패 시 → Rewind 후 다른 접근 방식 시도
```

## 모범 사례

Checkpoint는 자동으로 생성되므로 상태를 수동으로 저장하는 것을 걱정하지 않고 작업에 집중할 수 있습니다. 단, 다음 사항을 염두에 두세요:

### Checkpoints를 효과적으로 활용하기

✅ **해야 할 것:**
- Rewind 전에 사용 가능한 checkpoint 검토
- 다른 방향을 탐색하고 싶을 때 rewind 사용
- 다양한 접근 방식 비교를 위해 checkpoint 유지
- 각 rewind 옵션이 무엇을 하는지 이해 (코드와 대화 복원, 대화 복원, 코드 복원, 요약)

❌ **하지 말 것:**
- 코드 보존을 위해 checkpoint에만 의존
- Checkpoint가 외부 파일 시스템 변경을 추적한다고 기대
- Checkpoint를 git 커밋의 대체제로 사용

## 설정

설정에서 자동 checkpoint를 켜거나 끌 수 있습니다:

```json
{
  "autoCheckpoint": true
}
```

- `autoCheckpoint`: 사용자 프롬프트마다 자동 checkpoint 생성을 활성화 또는 비활성화 (기본값: `true`)

## 제한 사항

Checkpoints에는 다음과 같은 제한 사항이 있습니다:

- **bash 명령어 변경은 추적되지 않음** - 파일 시스템에서 `rm`, `mv`, `cp` 등의 작업은 checkpoint에 캡처되지 않음
- **외부 변경은 추적되지 않음** - Claude Code 외부(편집기, 터미널 등)에서 수행된 변경 사항은 캡처되지 않음
- **버전 관리 대체 불가** - 코드베이스의 영구적이고 감사 가능한 변경은 git을 사용할 것

## 문제 해결

### Checkpoint 누락

**문제**: 예상한 checkpoint를 찾을 수 없음

**해결 방법**:
- Checkpoint가 지워졌는지 확인
- 설정에서 `autoCheckpoint`가 활성화되어 있는지 확인
- 디스크 공간 확인

### Rewind 실패

**문제**: Checkpoint로 rewind할 수 없음

**해결 방법**:
- 커밋되지 않은 변경 사항이 충돌하지 않는지 확인
- Checkpoint가 손상되었는지 확인
- 다른 checkpoint로 rewind 시도

## Git과의 통합

Checkpoints는 git을 보완하지만 대체하지는 않습니다:

| 기능 | Git | Checkpoints |
|---------|-----|-------------|
| 범위 | 파일 시스템 | 대화 + 파일 |
| 지속성 | 영구적 | 세션 기반 |
| 세분성 | 커밋 | 임의 시점 |
| 속도 | 느림 | 즉시 |
| 공유 | 가능 | 제한적 |

두 가지를 함께 사용하세요:
1. 빠른 실험에는 checkpoint 사용
2. 확정된 변경에는 git 커밋 사용
3. git 작업 전에 checkpoint 생성
4. 성공적인 checkpoint 상태를 git에 커밋

## 빠른 시작 가이드

### 기본 워크플로우

1. **정상적으로 작업** - Claude Code가 자동으로 checkpoint를 생성합니다
2. **되돌아가고 싶을 때?** - `Esc`를 두 번 누르거나 `/rewind` 사용
3. **Checkpoint 선택** - 목록에서 rewind할 checkpoint 선택
4. **복원 내용 선택** - 코드와 대화 복원, 대화 복원, 코드 복원, 여기서 요약, 또는 취소 중 선택
5. **작업 계속** - 해당 시점부터 다시 시작

### 키보드 단축키

- **`Esc` + `Esc`** - Checkpoint 브라우저 열기
- **`/rewind`** - Checkpoint에 접근하는 대안적 방법
- **`/checkpoint`** - `/rewind`의 별칭

## Rewind 시점 알기: 컨텍스트 모니터링

Checkpoints를 사용하면 되돌아갈 수 있지만, *언제* 되돌아가야 할지는 어떻게 알 수 있을까요? 대화가 길어지면 Claude의 컨텍스트 창이 채워지고 모델 품질이 조용히 저하됩니다. 자신도 모르는 사이에 반맹(半盲) 상태의 모델이 생성한 코드를 배포하고 있을 수도 있습니다.

**[cc-context-stats](https://github.com/luongnv89/cc-context-stats)**는 Claude Code 상태 표시줄에 실시간 **컨텍스트 구간**을 추가하여 이 문제를 해결합니다. 컨텍스트 창에서 현재 위치를 추적합니다 — **Plan** (초록, 계획 및 코딩에 안전)에서 **Code** (노랑, 새 계획 시작 자제), **Dump** (주황, 마무리 후 rewind)까지. 구간이 바뀌는 것을 보면, 저하된 출력을 계속 밀어붙이는 대신 checkpoint를 만들고 새로 시작할 때임을 알 수 있습니다.

## 관련 개념

- **[고급 기능](../09-advanced-features/)** - 플래닝 모드 및 기타 고급 기능
- **[메모리 관리](../02-memory/)** - 대화 기록 및 컨텍스트 관리
- **[Slash 명령어](../01-slash-commands/)** - 사용자가 직접 호출하는 단축키
- **[Hooks](../06-hooks/)** - 이벤트 기반 자동화
- **[Plugins](../07-plugins/)** - 번들된 확장 패키지

## 추가 리소스

- [공식 Checkpointing 문서](https://code.claude.com/docs/en/checkpointing)
- [고급 기능 가이드](../09-advanced-features/) - Extended thinking 및 기타 기능

## 요약

Checkpoints는 Claude Code의 자동 기능으로, 작업을 잃을 걱정 없이 안전하게 다양한 접근 방식을 탐색할 수 있게 해줍니다. 사용자 프롬프트마다 자동으로 새 checkpoint가 생성되므로 세션의 어떤 이전 시점으로도 되돌아갈 수 있습니다.

주요 이점:
- 여러 접근 방식을 두려움 없이 실험
- 실수를 빠르게 복구
- 다양한 해결책을 나란히 비교
- 버전 관리 시스템과 안전하게 통합

기억하세요: checkpoint는 git의 대체제가 아닙니다. 빠른 실험에는 checkpoint를, 영구적인 코드 변경에는 git을 사용하세요.
