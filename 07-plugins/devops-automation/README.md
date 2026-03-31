<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# DevOps Automation 플러그인

배포, 모니터링, 장애 대응을 위한 완전한 DevOps 자동화입니다.

## 기능

✅ 자동화 배포
✅ 롤백 절차
✅ 시스템 상태 모니터링
✅ 장애 대응 워크플로우
✅ Kubernetes 통합

## 설치

```bash
/plugin install devops-automation
```

## 포함 항목

### Slash Commands
- `/deploy` - 프로덕션 또는 스테이징에 배포
- `/rollback` - 이전 버전으로 롤백
- `/status` - 시스템 상태 확인
- `/incident` - 프로덕션 장애 처리

### Subagents
- `deployment-specialist` - 배포 운영
- `incident-commander` - 장애 대응 조율
- `alert-analyzer` - 시스템 상태 분석

### MCP Servers
- Kubernetes 통합

### Scripts
- `deploy.sh` - 배포 자동화
- `rollback.sh` - 롤백 자동화
- `health-check.sh` - 상태 확인 유틸리티

### Hooks
- `pre-deploy.js` - 배포 전 검증
- `post-deploy.js` - 배포 후 작업

## 사용법

### 스테이징 배포
```
/deploy staging
```

### 프로덕션 배포
```
/deploy production
```

### 롤백
```
/rollback production
```

### 상태 확인
```
/status
```

### 장애 처리
```
/incident
```

## 요구 사항

- Claude Code 1.0+
- Kubernetes CLI (kubectl)
- 클러스터 접근 설정 완료

## 설정

Kubernetes 설정을 구성하세요:
```bash
export KUBECONFIG=~/.kube/config
```

## 예제 워크플로우

```
User: /deploy production

Claude:
1. pre-deploy hook 실행 (kubectl, 클러스터 연결 검증)
2. deployment-specialist subagent에 위임
3. deploy.sh 스크립트 실행
4. Kubernetes MCP를 통해 배포 진행 상황 모니터링
5. post-deploy hook 실행 (파드 대기, 스모크 테스트)
6. 배포 요약 제공

결과:
✅ 배포 완료
📦 버전: v2.1.0
🚀 Pods: 3/3 ready
⏱️  소요 시간: 2분 34초
```
