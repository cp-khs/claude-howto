<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# EPUB 빌더 스크립트

Claude How-To 마크다운 파일들로부터 EPUB 전자책을 빌드합니다.

## 기능

- 폴더 구조(01-slash-commands, 02-memory 등)에 따라 챕터 구성
- Kroki.io API를 통해 Mermaid 다이어그램을 PNG 이미지로 렌더링
- 비동기 동시 처리 — 모든 다이어그램을 병렬로 렌더링
- 프로젝트 로고로부터 커버 이미지 생성
- 내부 마크다운 링크를 EPUB 챕터 참조로 변환
- 엄격 오류 모드 — 다이어그램 렌더링 실패 시 빌드 중단

## 요구 사항

- Python 3.10+
- [uv](https://github.com/astral-sh/uv)
- Mermaid 다이어그램 렌더링을 위한 인터넷 연결

## 빠른 시작

```bash
# 가장 간단한 방법 — uv가 모든 것을 처리합니다
uv run scripts/build_epub.py
```

## 개발 환경 설정

```bash
# 가상 환경 생성
uv venv

# 활성화 및 의존성 설치
source .venv/bin/activate
uv pip install -r requirements-dev.txt

# 테스트 실행
pytest scripts/tests/ -v

# 스크립트 실행
python scripts/build_epub.py
```

## 커맨드라인 옵션

```
usage: build_epub.py [-h] [--root ROOT] [--output OUTPUT] [--verbose]
                     [--timeout TIMEOUT] [--max-concurrent MAX_CONCURRENT]

options:
  -h, --help            도움말 메시지 표시 후 종료
  --root, -r ROOT       루트 디렉토리 (기본값: 저장소 루트)
  --output, -o OUTPUT   출력 경로 (기본값: claude-howto-guide.epub)
  --verbose, -v         상세 로깅 활성화
  --timeout TIMEOUT     API 타임아웃 (초, 기본값: 30)
  --max-concurrent N    최대 동시 요청 수 (기본값: 10)
```

## 예시

```bash
# 상세 출력으로 빌드
uv run scripts/build_epub.py --verbose

# 출력 위치 지정
uv run scripts/build_epub.py --output ~/Desktop/claude-guide.epub

# 동시 요청 수 제한 (속도 제한 시)
uv run scripts/build_epub.py --max-concurrent 5
```

## 출력

저장소 루트 디렉토리에 `claude-howto-guide.epub`을 생성합니다.

EPUB에 포함되는 내용:
- 프로젝트 로고가 적용된 커버 이미지
- 중첩 섹션이 있는 목차
- EPUB 호환 HTML로 변환된 모든 마크다운 콘텐츠
- PNG 이미지로 렌더링된 Mermaid 다이어그램

## 테스트 실행

```bash
# 가상 환경 사용 시
source .venv/bin/activate
pytest scripts/tests/ -v

# 또는 uv로 직접 실행
uv run --with pytest --with pytest-asyncio \
    --with ebooklib --with markdown --with beautifulsoup4 \
    --with httpx --with pillow --with tenacity \
    pytest scripts/tests/ -v
```

## 의존성

PEP 723 인라인 스크립트 메타데이터로 관리됩니다:

| 패키지 | 용도 |
|---------|---------|
| `ebooklib` | EPUB 생성 |
| `markdown` | 마크다운을 HTML로 변환 |
| `beautifulsoup4` | HTML 파싱 |
| `httpx` | 비동기 HTTP 클라이언트 |
| `pillow` | 커버 이미지 생성 |
| `tenacity` | 재시도 로직 |

## 문제 해결

**네트워크 오류로 빌드 실패**: 인터넷 연결과 Kroki.io 상태를 확인하세요. `--timeout 60`을 시도해 보세요.

**속도 제한**: `--max-concurrent 3`으로 동시 요청 수를 줄이세요.

**로고 없음**: `claude-howto-logo.png`를 찾을 수 없으면 텍스트 전용 커버를 생성합니다.
