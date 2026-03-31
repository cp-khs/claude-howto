---
name: Expand Unit Tests
description: Increase test coverage by targeting untested branches and edge cases
tags: testing, coverage, unit-tests
---

# 단위 테스트 확장

프로젝트의 테스트 프레임워크에 맞게 기존 단위 테스트를 확장합니다:

1. **커버리지 분석**: 테스트되지 않은 브랜치, 엣지 케이스, 커버리지가 낮은 영역 파악을 위한 커버리지 리포트 실행
2. **갭 식별**: 논리적 브랜치, 오류 경로, 경계 조건, null/빈 입력에 대한 코드 검토
3. **테스트 작성** (프로젝트 프레임워크 사용):
   - Jest/Vitest/Mocha (JavaScript/TypeScript)
   - pytest/unittest (Python)
   - Go testing/testify (Go)
   - Rust 테스트 프레임워크 (Rust)
4. **특정 시나리오 타겟팅**:
   - 오류 처리 및 예외
   - 경계값 (최솟값/최댓값, 빈 값, null)
   - 엣지 케이스 및 코너 케이스
   - 상태 전이 및 부작용
5. **개선 검증**: 커버리지 재실행, 측정 가능한 향상 확인

새로운 테스트 코드 블록만 제시합니다. 기존 테스트 패턴과 네이밍 컨벤션을 따릅니다.
