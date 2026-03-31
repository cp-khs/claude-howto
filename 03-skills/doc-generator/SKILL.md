---
name: api-documentation-generator
description: Generate comprehensive, accurate API documentation from source code. Use when creating or updating API documentation, generating OpenAPI specs, or when users mention API docs, endpoints, or documentation.
---

# API 문서 생성기 스킬

## 생성 항목

- OpenAPI/Swagger 명세
- API 엔드포인트 문서
- SDK 사용 예시
- 통합 가이드
- 에러 코드 참조
- 인증 가이드

## 문서 구조

### 각 엔드포인트에 대해

```markdown
## GET /api/v1/users/:id

### 설명
이 엔드포인트가 하는 일에 대한 간략한 설명

### 파라미터

| 이름 | 타입 | 필수 여부 | 설명 |
|------|------|----------|-------------|
| id | string | 필수 | 사용자 ID |

### 응답

**200 성공**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 찾을 수 없음**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "User does not exist"
}
```

### 예시

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```
```
