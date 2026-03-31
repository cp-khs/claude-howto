# 빠른 시작 - 브랜드 에셋

## 프로젝트에 에셋 복사

```bash
# 웹 프로젝트에 모든 resources 복사
cp -r resources/ /path/to/your/website/

# 웹용 파비콘만 복사
cp resources/favicons/* /path/to/your/website/public/
```

## HTML에 추가 (복사하여 붙여넣기)

```html
<!-- 파비콘 -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
<meta name="theme-color" content="#000000">
```

## 마크다운/문서에서 사용

```markdown
# Claude How To

![Claude How To Logo](resources/logos/claude-howto-logo.svg)

![Icon](resources/icons/claude-howto-icon.svg)
```

## 권장 크기

| 용도 | 크기 | 파일 |
|---------|------|------|
| 웹사이트 헤더 | 520×120 | `logos/claude-howto-logo.svg` |
| 앱 아이콘 | 256×256 | `icons/claude-howto-icon.svg` |
| 브라우저 탭 | 32×32 | `favicons/favicon-32.svg` |
| 모바일 홈 화면 | 128×128 | `favicons/favicon-128.svg` |
| 데스크톱 앱 | 256×256 | `favicons/favicon-256.svg` |
| 작은 아바타 | 64×64 | `favicons/favicon-64.svg` |

## 색상 값

```css
/* CSS에서 사용 */
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

## 아이콘 디자인 의미

**코드 브래킷이 있는 나침반**:
- 나침반 링 = 탐색, 구조화된 학습 경로
- 초록 북쪽 바늘 = 방향, 진행, 안내
- 검정 남쪽 바늘 = 그라운딩, 탄탄한 기초
- `>` 브래킷 = 터미널 프롬프트, 코드, CLI 컨텍스트
- 눈금 = 정밀함, 구조화된 단계

이는 "명확한 안내로 코드에서 길을 찾는 것"을 상징합니다.

## 어디에 무엇을 사용할지

### 웹사이트
- **헤더**: 로고 (`logos/claude-howto-logo.svg`)
- **파비콘**: 32px (`favicons/favicon-32.svg`)
- **소셜 미리보기**: 아이콘 (`icons/claude-howto-icon.svg`)

### GitHub
- **README 배지**: 아이콘 (`icons/claude-howto-icon.svg`) 64~128px
- **저장소 아바타**: 아이콘 (`icons/claude-howto-icon.svg`)

### 소셜 미디어
- **프로필 사진**: 아이콘 (`icons/claude-howto-icon.svg`)
- **배너**: 로고 (`logos/claude-howto-logo.svg`)
- **썸네일**: 256×256px 아이콘

### 문서
- **챕터 헤더**: 크기에 맞게 조정된 로고 또는 아이콘
- **탐색 아이콘**: 파비콘 (32~64px)

---

전체 문서는 [README.md](README.md)를 참조하세요.
