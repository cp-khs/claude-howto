# 코드 리뷰 발견 사항 템플릿

코드 리뷰 중 발견된 각 이슈를 문서화할 때 이 템플릿을 사용하세요.

---

## 이슈: [제목]

### 심각도
- [ ] Critical (배포 차단)
- [ ] High (머지 전 수정 필요)
- [ ] Medium (조만간 수정 필요)
- [ ] Low (있으면 좋음)

### 분류
- [ ] 보안
- [ ] 성능
- [ ] 코드 품질
- [ ] 유지보수성
- [ ] 테스트
- [ ] 디자인 패턴
- [ ] 문서화

### 위치
**파일:** `src/components/UserCard.tsx`

**라인:** 45-52

**함수/메서드:** `renderUserDetails()`

### 이슈 설명

**무엇:** 이슈가 무엇인지 설명하세요.

**왜 중요한가:** 영향도와 수정이 필요한 이유를 설명하세요.

**현재 동작:** 문제가 있는 코드 또는 동작을 보여주세요.

**기대 동작:** 대신 어떻게 되어야 하는지 설명하세요.

### 코드 예시

#### 현재 (문제 있음)

```typescript
// N+1 쿼리 문제를 보여줌
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // 사용자마다 쿼리 발생!
  renderUserPosts(posts);
});
```

#### 수정 제안

```typescript
// JOIN 쿼리로 최적화
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### 영향도 분석

| 측면 | 영향 | 심각도 |
|--------|--------|----------|
| 성능 | 사용자 20명에 100개 이상의 쿼리 | High |
| 사용자 경험 | 페이지 로드 느림 | High |
| 확장성 | 규모 확장 시 장애 발생 | Critical |
| 유지보수성 | 디버깅 어려움 | Medium |

### 관련 이슈

- `AdminUserList.tsx` 120번째 줄에도 유사한 이슈 존재
- 관련 PR: #456
- 관련 이슈: #789

### 추가 참고 자료

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)

### 리뷰어 노트

- 이 코드베이스에서 자주 보이는 패턴임
- 코드 스타일 가이드에 추가하는 것을 고려할 것
- 헬퍼 함수를 만들 가치가 있을 수 있음

### 작성자 피드백 (코드 작성자가 작성)

*코드 작성자가 작성:*

- [ ] 수정 커밋: `abc123`
- [ ] 수정 상태: 완료 / 진행 중 / 논의 필요
- [ ] 질문 또는 우려 사항: (설명)

---

## 발견 사항 통계 (리뷰어용)

여러 발견 사항을 리뷰할 때 추적하세요:

- **발견된 총 이슈 수:** X
- **Critical:** X
- **High:** X
- **Medium:** X
- **Low:** X

**권고 사항:** ✅ 승인 / ⚠️ 수정 요청 / 🔄 논의 필요

**전체 코드 품질:** 1-5점
