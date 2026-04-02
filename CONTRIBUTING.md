<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude How To 기여 가이드

이 프로젝트에 기여해 주셔서 감사합니다! 이 가이드는 효과적으로 기여하는 방법을 안내합니다.

## 이 프로젝트에 대해

Claude How To는 Claude Code에 대한 시각적이고 예제 중심의 가이드입니다. 다음을 제공합니다:
- **Mermaid 다이어그램** — 기능 동작 원리 설명
- **바로 사용 가능한 프로덕션 수준 템플릿**
- **컨텍스트와 모범 사례가 포함된 실제 예제**
- **초급부터 고급까지의 점진적 학습 경로**

## 기여 유형

### 1. 새로운 예제 또는 템플릿
기존 기능(Slash Commands, Skills, Hooks 등)의 예제를 추가합니다:
- 바로 복사해 사용할 수 있는 코드
- 작동 방식에 대한 명확한 설명
- 활용 사례 및 이점
- 문제 해결 팁

### 2. 문서 개선
- 혼란스러운 섹션 명확화
- 오탈자 및 문법 수정
- 누락된 정보 추가
- 코드 예제 개선

### 3. 기능 가이드
새로운 Claude Code 기능에 대한 가이드 작성:
- 단계별 튜토리얼
- 아키텍처 다이어그램
- 일반적인 패턴과 안티패턴
- 실제 워크플로우

### 4. 버그 리포트
발견한 문제를 보고합니다:
- 예상한 동작 설명
- 실제 발생한 동작 설명
- 재현 단계 포함
- 관련 Claude Code 버전 및 OS 추가

### 5. 피드백 및 제안
가이드 개선을 도와주세요:
- 더 나은 설명 제안
- 내용 부족한 부분 지적
- 새로운 섹션이나 재구성 권장

## 시작하기

### 1. 포크 및 클론
```bash
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto
```

### 2. 브랜치 생성
설명적인 브랜치 이름을 사용하세요:
```bash
git checkout -b add/feature-name
git checkout -b fix/issue-description
git checkout -b docs/improvement-area
```

### 3. 환경 설정

Pre-commit Hooks는 커밋 전마다 CI와 동일한 검사를 로컬에서 실행합니다. PR이 수락되기 전에 네 가지 검사를 모두 통과해야 합니다.

**필수 의존성:**

```bash
# Python 도구 (uv는 이 프로젝트의 패키지 매니저)
pip install uv
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# Markdown 린터 (Node.js)
npm install -g markdownlint-cli

# Mermaid 다이어그램 검증기 (Node.js)
npm install -g @mermaid-js/mermaid-cli

# pre-commit 설치 및 Hooks 활성화
uv pip install pre-commit
pre-commit install
```

**설정 확인:**

```bash
pre-commit run --all-files
```

모든 커밋에서 실행되는 Hooks:

| Hook | 검사 항목 |
|------|---------------|
| `markdown-lint` | Markdown 포맷 및 구조 |
| `cross-references` | 상대 링크, 앵커, 코드 펜스 |
| `mermaid-syntax` | 모든 ` ```mermaid ` 블록이 올바르게 파싱되는지 |
| `link-check` | 외부 URL 접근 가능 여부 |
| `build-epub` | `.md` 변경 시 EPUB 생성 오류 없이 완료되는지 |

## 디렉토리 구조

```
├── 01-slash-commands/      # 사용자 호출 단축키
├── 02-memory/              # 지속적 컨텍스트 예제
├── 03-skills/              # 재사용 가능한 기능
├── 04-subagents/           # 특화된 AI 어시스턴트
├── 05-mcp/                 # Model Context Protocol 예제
├── 06-hooks/               # 이벤트 기반 자동화
├── 07-plugins/             # 묶음 기능 패키지
├── 08-checkpoints/         # 세션 스냅샷
├── 09-advanced-features/   # Planning, Thinking, 백그라운드 작업
├── 10-cli/                 # CLI 레퍼런스
├── scripts/                # 빌드 및 유틸리티 스크립트
└── README.md               # 메인 가이드
```

## 예제 기여 방법

### Slash Command 추가
1. `01-slash-commands/`에 `.md` 파일을 만드세요
2. 다음을 포함하세요:
   - 수행하는 작업에 대한 명확한 설명
   - 활용 사례
   - 설치 지침
   - 사용 예제
   - 커스터마이즈 팁
3. `01-slash-commands/README.md` 업데이트

### Skill 추가
1. `03-skills/`에 디렉토리를 만드세요
2. 다음을 포함하세요:
   - `SKILL.md` - 주요 문서
   - `scripts/` - 필요한 경우 헬퍼 스크립트
   - `templates/` - 프롬프트 템플릿
   - README에 사용 예제
3. `03-skills/README.md` 업데이트

### Subagent 추가
1. `04-subagents/`에 `.md` 파일을 만드세요
2. 다음을 포함하세요:
   - 에이전트 목적 및 기능
   - 시스템 프롬프트 구조
   - 사용 사례 예제
   - 연동 예제
3. `04-subagents/README.md` 업데이트

### MCP 설정 추가
1. `05-mcp/`에 `.json` 파일을 만드세요
2. 다음을 포함하세요:
   - 설정 설명
   - 필요한 환경 변수
   - 설정 지침
   - 사용 예제
3. `05-mcp/README.md` 업데이트

### Hook 추가
1. `06-hooks/`에 `.sh` 파일을 만드세요
2. 다음을 포함하세요:
   - Shebang 및 설명
   - 로직을 설명하는 명확한 주석
   - 에러 처리
   - 보안 고려 사항
3. `06-hooks/README.md` 업데이트

## 작성 가이드라인

### Markdown 스타일
- 명확한 헤딩 사용 (섹션에는 H2, 하위 섹션에는 H3)
- 단락을 짧고 집중적으로 유지
- 목록에는 불릿 포인트 사용
- 언어 명시와 함께 코드 블록 포함
- 섹션 사이에 빈 줄 추가

### 코드 예제
- 바로 복사해 사용할 수 있게 작성
- 명확하지 않은 로직에 주석 달기
- 간단한 버전과 고급 버전 모두 포함
- 실제 사용 사례 제시
- 잠재적 문제 강조

### 문서화
- "무엇"이 아닌 "왜"를 설명
- 사전 조건 포함
- 문제 해결 섹션 추가
- 관련 주제에 링크
- 초급자 친화적으로 유지

### JSON/YAML
- 적절한 들여쓰기 사용 (2칸 또는 4칸으로 일관성 유지)
- 설정을 설명하는 주석 추가
- 유효성 검사 예제 포함

### 다이어그램
- 가능하면 Mermaid 사용
- 다이어그램을 단순하고 읽기 쉽게 유지
- 다이어그램 아래에 설명 포함
- 관련 섹션에 링크

## 커밋 가이드라인

Conventional Commit 형식을 따르세요:
```
type(scope): description

[optional body]
```

유형:
- `feat`: 새로운 기능 또는 예제
- `fix`: 버그 수정 또는 수정
- `docs`: 문서 변경
- `refactor`: 코드 재구성
- `style`: 포맷 변경
- `test`: 테스트 추가 또는 변경
- `chore`: 빌드, 의존성 등

예제:
```
feat(slash-commands): Add API documentation generator
docs(memory): Improve personal preferences example
fix(README): Correct table of contents link
docs(skills): Add comprehensive code review skill
```

## 제출 전 확인 사항

### 체크리스트
- [ ] 코드가 프로젝트 스타일과 규칙을 따름
- [ ] 새로운 예제에 명확한 문서 포함
- [ ] README 파일 업데이트 (로컬 및 루트 모두)
- [ ] 민감한 정보 없음 (API 키, 자격 증명)
- [ ] 예제가 테스트되어 작동함
- [ ] 링크가 확인되어 올바름
- [ ] 파일에 적절한 권한 있음 (스크립트는 실행 가능)
- [ ] 커밋 메시지가 명확하고 설명적임

### 로컬 테스트
```bash
# 모든 pre-commit 검사 실행 (CI와 동일한 검사)
pre-commit run --all-files

# 변경 사항 검토
git diff
```

## Pull Request 프로세스

1. **명확한 설명과 함께 PR 생성**:
   - 이것이 무엇을 추가/수정하나요?
   - 왜 필요한가요?
   - 관련 이슈 (있는 경우)

2. **관련 세부 정보 포함**:
   - 새 기능? 활용 사례 포함
   - 문서? 개선 사항 설명
   - 예제? 변경 전/후 제시

3. **이슈에 링크**:
   - `Closes #123`을 사용해 관련 이슈 자동 닫기

4. **리뷰에 인내심 갖기**:
   - 관리자가 개선 사항을 제안할 수 있습니다
   - 피드백에 따라 반복하세요
   - 최종 결정은 관리자에게 있습니다

## 코드 리뷰 프로세스

리뷰어가 확인하는 항목:
- **정확성**: 설명대로 작동하나요?
- **품질**: 프로덕션 수준인가요?
- **일관성**: 프로젝트 패턴을 따르나요?
- **문서화**: 명확하고 완전한가요?
- **보안**: 취약점이 있나요?

## 이슈 보고

### 버그 리포트
다음을 포함하세요:
- Claude Code 버전
- 운영 체제
- 재현 단계
- 예상 동작
- 실제 동작
- 해당하는 경우 스크린샷

### 기능 요청
다음을 포함하세요:
- 해결하려는 활용 사례 또는 문제
- 제안된 해결책
- 고려한 대안
- 추가 컨텍스트

### 문서 이슈
다음을 포함하세요:
- 혼란스럽거나 누락된 내용
- 제안된 개선 사항
- 예제 또는 참고 자료

## 프로젝트 정책

### 민감한 정보
- API 키, 토큰, 자격 증명을 절대 커밋하지 마세요
- 예제에서 플레이스홀더 값을 사용하세요
- 설정 파일에는 `.env.example`을 포함하세요
- 필수 환경 변수를 문서화하세요

### 코드 품질
- 예제를 집중적이고 읽기 쉽게 유지하세요
- 솔루션을 과도하게 엔지니어링하지 마세요
- 명확하지 않은 로직에는 주석을 달아주세요
- 제출 전 철저히 테스트하세요

### 지적 재산
- 원본 콘텐츠는 저자 소유
- 프로젝트는 교육적 라이선스 사용
- 기존 저작권 존중
- 필요한 경우 출처 표시

## 도움 받기

- **질문**: GitHub 이슈에서 토론 열기
- **일반 도움**: 기존 문서 확인
- **개발 도움**: 유사한 예제 검토
- **코드 리뷰**: PR에서 관리자 태그하기

## 인정

기여자는 다음에서 인정됩니다:
- README.md 기여자 섹션
- GitHub 기여자 페이지
- 커밋 기록

## 보안

예제와 문서를 기여할 때는 안전한 코딩 관행을 따라주세요:

- **시크릿이나 API 키를 하드코딩하지 마세요** — 환경 변수 사용
- **보안 영향에 대해 경고하세요** — 잠재적 위험 강조
- **안전한 기본값 사용** — 기본적으로 보안 기능 활성화
- **입력 검증** — 적절한 입력 검증 및 살균 방법 제시
- **보안 노트 포함** — 보안 고려 사항 문서화

보안 이슈의 경우 취약점 보고 프로세스는 [SECURITY.md](SECURITY.md)를 참고하세요.

## 행동 강령

우리는 환영받고 포용적인 커뮤니티를 제공하기 위해 노력합니다. 전체 커뮤니티 표준은 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)를 읽어주세요.

요약:
- 서로 존중하고 포용하세요
- 피드백을 겸손하게 수용하세요
- 다른 사람이 배우고 성장할 수 있도록 도우세요
- 괴롭힘이나 차별을 피하세요
- 문제는 관리자에게 보고하세요

모든 기여자는 이 행동 강령을 지키고 서로를 친절하고 존중하는 태도로 대할 것으로 기대됩니다.

## 라이선스

이 프로젝트에 기여함으로써, 귀하의 기여는 MIT 라이선스로 배포될 것에 동의합니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.

## 질문이 있으신가요?

- [README](README.md) 확인
- [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md) 검토
- 기존 예제 살펴보기
- 토론을 위한 이슈 열기

기여해 주셔서 감사합니다! 🙏
