<picture>
  <source media="(prefers-color-scheme: dark)" srcset="logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="logos/claude-howto-logo.svg">
</picture>

# Claude How To - 브랜드 에셋

Claude How To 프로젝트의 로고, 아이콘, 파비콘 전체 컬렉션입니다. 모든 에셋은 V3.0 디자인을 사용합니다: 코드 탐색 가이드를 표현하는 코드 브래킷(`>`) 기호가 있는 나침반으로, 밝은 초록(#22C55E) 강조색과 함께 검정/흰색/회색 팔레트를 사용합니다.

## 디렉토리 구조

```
resources/
├── logos/
│   ├── claude-howto-logo.svg       # 메인 로고 - 라이트 모드 (520×120px)
│   └── claude-howto-logo-dark.svg  # 메인 로고 - 다크 모드 (520×120px)
├── icons/
│   ├── claude-howto-icon.svg       # 앱 아이콘 - 라이트 모드 (256×256px)
│   └── claude-howto-icon-dark.svg  # 앱 아이콘 - 다크 모드 (256×256px)
└── favicons/
    ├── favicon-16.svg              # 파비콘 - 16×16px
    ├── favicon-32.svg              # 파비콘 - 32×32px (기본)
    ├── favicon-64.svg              # 파비콘 - 64×64px
    ├── favicon-128.svg             # 파비콘 - 128×128px
    └── favicon-256.svg             # 파비콘 - 256×256px
```

`assets/logo/`의 추가 에셋:
```
assets/logo/
├── logo-full.svg       # 마크 + 워드마크 (가로형)
├── logo-mark.svg       # 나침반 심볼만 (120×120px)
├── logo-wordmark.svg   # 텍스트만
├── logo-icon.svg       # 앱 아이콘 (512×512, 둥근 모서리)
├── favicon.svg         # 16×16 최적화
├── logo-white.svg      # 어두운 배경용 흰색 버전
└── logo-black.svg      # 단색 검정 버전
```

## 에셋 개요

### 디자인 컨셉 (V3.0)

**코드 브래킷이 있는 나침반** — 안내와 코드의 만남:
- **나침반 링** = 탐색, 길 찾기
- **북쪽 바늘 (초록)** = 방향, 학습 경로에서의 진행
- **남쪽 바늘 (검정)** = 그라운딩, 탄탄한 기초
- **`>` 브래킷** = 터미널 프롬프트, 코드, CLI 컨텍스트
- **눈금** = 정밀함, 구조화된 학습

### 로고

**파일**:
- `logos/claude-howto-logo.svg` (라이트 모드)
- `logos/claude-howto-logo-dark.svg` (다크 모드)

**사양**:
- **크기**: 520×120 px
- **목적**: 워드마크가 있는 메인 헤더/브랜딩 로고
- **사용처**:
  - 웹사이트 헤더
  - README 배지
  - 마케팅 자료
  - 인쇄 자료
- **형식**: SVG (완전히 확장 가능)
- **모드**: 라이트 (흰색 배경) & 다크 (#0A0A0A 배경)

### 아이콘

**파일**:
- `icons/claude-howto-icon.svg` (라이트 모드)
- `icons/claude-howto-icon-dark.svg` (다크 모드)

**사양**:
- **크기**: 256×256 px
- **목적**: 애플리케이션 아이콘, 아바타, 썸네일
- **사용처**:
  - 앱 아이콘
  - 프로필 아바타
  - 소셜 미디어 썸네일
  - 문서 헤더
- **형식**: SVG (완전히 확장 가능)
- **모드**: 라이트 (흰색 배경) & 다크 (#0A0A0A 배경)

**디자인 요소**:
- 주요 및 중간 눈금이 있는 나침반 링
- 초록 북쪽 바늘 (방향/안내)
- 검정 남쪽 바늘 (기초)
- 중앙의 `>` 코드 브래킷 (터미널/CLI)
- 초록 중심 점 강조

### 파비콘

웹 사용을 위한 다양한 크기의 최적화 버전:

| 파일 | 크기 | DPI | 사용처 |
|------|------|-----|-------|
| `favicon-16.svg` | 16×16 px | 1x | 브라우저 탭 (구형 브라우저) |
| `favicon-32.svg` | 32×32 px | 1x | 표준 브라우저 파비콘 |
| `favicon-64.svg` | 64×64 px | 1x-2x | 고DPI 디스플레이 |
| `favicon-128.svg` | 128×128 px | 2x | Apple 터치 아이콘, 북마크 |
| `favicon-256.svg` | 256×256 px | 4x | 최신 브라우저, PWA 아이콘 |

**최적화 참고사항**:
- 16px: 최소 기하학 — 링, 바늘, 쉐브론만
- 32px: 주요 눈금 추가
- 64px+: 중간 눈금까지 완전한 세부 묘사
- 모두 메인 아이콘과 시각적 일관성 유지
- SVG 형식으로 모든 크기에서 선명한 표시 보장

## HTML 통합

### 기본 파비콘 설정

```html
<!-- 브라우저 파비콘 -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

<!-- Apple 터치 아이콘 (모바일 홈 화면) -->
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

<!-- PWA 및 최신 브라우저 -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
```

### 완전한 설정

```html
<head>
  <!-- 기본 파비콘 -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

  <!-- Apple 터치 아이콘 -->
  <link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

  <!-- PWA 아이콘 -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">

  <!-- Android -->
  <link rel="shortcut icon" href="/resources/favicons/favicon-256.svg">

  <!-- PWA manifest 참조 (manifest.json 사용 시) -->
  <meta name="theme-color" content="#000000">
</head>
```

## 색상 팔레트

### 주요 색상
- **검정**: `#000000` (주요 텍스트, 선, 남쪽 바늘)
- **흰색**: `#FFFFFF` (밝은 배경)
- **회색**: `#6B7280` (보조 텍스트, 작은 눈금)

### 강조색
- **밝은 초록**: `#22C55E` (북쪽 바늘, 중심 점, 강조 선 — 하이라이트 전용, 배경 사용 불가)

### 다크 모드
- **배경**: `#0A0A0A` (거의 검정)

### CSS 변수
```css
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

### Tailwind 설정
```js
colors: {
  brand: {
    primary: '#000000',
    secondary: '#6B7280',
    accent: '#22C55E',
  }
}
```

### 사용 가이드라인
- 주요 텍스트와 구조적 요소에 검정 사용
- 보조/지원 요소에 회색 사용
- 초록은 **하이라이트 전용** — 바늘, 점, 강조 선
- 초록을 배경색으로 절대 사용 금지
- WCAG AA 대비 유지 (최소 4.5:1)

## 디자인 가이드라인

### 로고 사용
- 흰색 또는 어두운 (#0A0A0A) 배경에 사용
- 비율 유지하며 확장
- 로고 주변 여백 유지 (최소: 로고 높이 / 2)
- 적절한 배경에 맞는 라이트/다크 변형 사용

### 아이콘 사용
- 표준 크기 사용: 16, 32, 64, 128, 256px
- 나침반 비율 유지
- 비율 유지하며 확장

### 파비콘 사용
- 컨텍스트에 맞는 적절한 크기 사용
- 16~32px: 브라우저 탭, 북마크
- 64px: 파비콘 사이트 아이콘
- 128px+: Apple/Android 홈 화면

## SVG 최적화

모든 SVG 파일은 그라디언트나 필터 없는 플랫 디자인:
- 깔끔한 선 기반 기하학
- 내장 래스터 없음
- 최적화된 경로
- 반응형 viewBox

웹 최적화:
```bash
# 품질을 유지하면서 SVG 압축
svgo --config='{
  "js2svg": {
    "indent": 2
  },
  "plugins": [
    "convertStyleToAttrs",
    "removeRasterImages"
  ]
}' input.svg -o output.svg
```

## PNG 변환

구형 브라우저 지원을 위한 SVG에서 PNG로 변환:

```bash
# ImageMagick 사용
convert -density 300 -background none favicon-256.svg favicon-256.png

# Inkscape 사용
inkscape -D -z --file=favicon-256.svg --export-png=favicon-256.png
```

## 접근성

- 높은 색상 대비 비율 (WCAG AA 준수 — 최소 4.5:1)
- 모든 크기에서 인식 가능한 깔끔한 기하학적 형태
- 확장 가능한 벡터 형식
- 아이콘에 텍스트 없음 (텍스트는 워드마크에 별도 추가)
- 의미 전달에 빨강-초록 색상 의존성 없음

## 저작권

이 에셋들은 Claude How To 프로젝트의 일부입니다.

**라이선스**: MIT (프로젝트 LICENSE 파일 참조)

## 버전 이력

- **v3.0** (2026년 2월): 검정/흰색/회색 + 초록 강조 팔레트를 사용한 나침반-브래킷 디자인
- **v2.0** (2026년 1월): 에메랄드 팔레트를 사용한 Claude 영감의 12선 별 디자인
- **v1.0** (2026년 1월): 원래의 육각형 기반 진행 아이콘 디자인

---

**마지막 업데이트**: 2026년 2월
**현재 버전**: 3.0 (나침반-브래킷)
**모든 에셋**: 프로덕션 준비 SVG, 완전히 확장 가능, WCAG AA 접근성 준수
