# 리팩토링 카탈로그

Martin Fowler의 *리팩토링* (2판)에서 선별된 리팩토링 기법 카탈로그입니다. 각 리팩토링에는 동기, 단계별 메커니즘, 예시가 포함됩니다.

> "리팩토링은 그 메커니즘으로 정의됩니다 — 변경을 수행하기 위해 따르는 정확한 단계의 순서입니다." — Martin Fowler

---

## 이 카탈로그 사용 방법

1. **코드 스멜 식별** - 코드 스멜 참조 사용
2. **매칭 리팩토링 찾기** - 이 카탈로그에서 검색
3. **메커니즘을 단계별로 따르기**
4. **각 단계 후 테스트** - 동작이 보존되었는지 확인

**황금 규칙**: 어떤 단계든 10분 이상 걸린다면, 더 작은 단계로 나누세요.

---

## 가장 일반적인 리팩토링

### 메서드 추출

**사용 시기**: 긴 메서드, 중복 코드, 개념에 이름을 붙여야 할 때

**동기**: 코드 조각을 그 목적을 설명하는 이름의 메서드로 만들기.

**메커니즘**:
1. 무엇을 하는지(어떻게가 아닌)로 이름지은 새 메서드 생성
2. 코드 조각을 새 메서드로 복사
3. 조각에서 사용되는 지역 변수 스캔
4. 지역 변수를 파라미터로 전달 (또는 메서드에 선언)
5. 반환 값 적절히 처리
6. 원래 조각을 새 메서드 호출로 교체
7. 테스트

**이전**:
```javascript
function printOwing(invoice) {
  let outstanding = 0;

  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");

  // 미결제액 계산
  for (const order of invoice.orders) {
    outstanding += order.amount;
  }

  // 세부 사항 출력
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

**이후**:
```javascript
function printOwing(invoice) {
  printBanner();
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice, outstanding);
}

function printBanner() {
  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");
}

function calculateOutstanding(invoice) {
  return invoice.orders.reduce((sum, order) => sum + order.amount, 0);
}

function printDetails(invoice, outstanding) {
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

---

### 메서드 인라인

**사용 시기**: 메서드 본문이 이름만큼 명확할 때, 과도한 위임

**동기**: 메서드가 가치를 추가하지 않을 때 불필요한 간접 참조 제거.

**메커니즘**:
1. 메서드가 다형적이지 않은지 확인
2. 메서드에 대한 모든 호출 찾기
3. 각 호출을 메서드 본문으로 교체
4. 각 교체 후 테스트
5. 메서드 정의 제거

**이전**:
```javascript
function getRating(driver) {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
  return driver.numberOfLateDeliveries > 5;
}
```

**이후**:
```javascript
function getRating(driver) {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

---

### 변수 추출

**사용 시기**: 이해하기 어려운 복잡한 표현식

**동기**: 복잡한 표현식의 일부에 이름 부여.

**메커니즘**:
1. 표현식에 사이드 이펙트가 없는지 확인
2. 불변 변수 선언
3. 표현식 (또는 일부) 결과로 설정
4. 원래 표현식을 변수로 교체
5. 테스트

**이전**:
```javascript
return order.quantity * order.itemPrice -
  Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
  Math.min(order.quantity * order.itemPrice * 0.1, 100);
```

**이후**:
```javascript
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
const shipping = Math.min(basePrice * 0.1, 100);
return basePrice - quantityDiscount + shipping;
```

---

### 변수 인라인

**사용 시기**: 변수 이름이 표현식보다 더 많은 것을 전달하지 않을 때

**동기**: 불필요한 간접 참조 제거.

**메커니즘**:
1. 우변에 사이드 이펙트가 없는지 확인
2. 변수가 불변이 아니라면 불변으로 만들고 테스트
3. 첫 번째 참조를 찾아 표현식으로 교체
4. 테스트
5. 모든 참조에 대해 반복
6. 선언 및 할당 제거
7. 테스트

---

### 변수 이름 변경

**사용 시기**: 이름이 목적을 명확히 전달하지 않을 때

**동기**: 좋은 이름이 깨끗한 코드에 필수적입니다.

**메커니즘**:
1. 변수가 널리 사용된다면 캡슐화 고려
2. 모든 참조 찾기
3. 각 참조 변경
4. 테스트

**팁**:
- 의도를 드러내는 이름 사용
- 약어 피하기
- 도메인 용어 사용

```javascript
// 나쁨
const d = 30;
const x = users.filter(u => u.a);

// 좋음
const daysSinceLastLogin = 30;
const activeUsers = users.filter(user => user.isActive);
```

---

### 함수 선언 변경

**사용 시기**: 함수 이름이 목적을 설명하지 않을 때, 파라미터 변경이 필요할 때

**동기**: 좋은 함수 이름이 코드를 자기 문서화하게 만듭니다.

**메커니즘 (간단)**:
1. 필요 없는 파라미터 제거
2. 이름 변경
3. 필요한 파라미터 추가
4. 테스트

**메커니즘 (마이그레이션 - 복잡한 변경의 경우)**:
1. 파라미터를 제거하는 경우, 사용되지 않는지 확인
2. 원하는 선언으로 새 함수 생성
3. 이전 함수가 새 함수를 호출하도록 함
4. 테스트
5. 호출자가 새 함수를 사용하도록 변경
6. 각각 테스트
7. 이전 함수 제거

**이전**:
```javascript
function circum(radius) {
  return 2 * Math.PI * radius;
}
```

**이후**:
```javascript
function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

---

### 변수 캡슐화

**사용 시기**: 여러 곳에서 데이터에 직접 접근

**동기**: 데이터 조작을 위한 명확한 접근 포인트 제공.

**메커니즘**:
1. getter 및 setter 함수 생성
2. 모든 참조 찾기
3. 읽기를 getter로 교체
4. 쓰기를 setter로 교체
5. 각 변경 후 테스트
6. 변수 가시성 제한

**이전**:
```javascript
let defaultOwner = { firstName: "Martin", lastName: "Fowler" };

// 많은 곳에서 사용
spaceship.owner = defaultOwner;
```

**이후**:
```javascript
let defaultOwnerData = { firstName: "Martin", lastName: "Fowler" };

function defaultOwner() { return defaultOwnerData; }
function setDefaultOwner(arg) { defaultOwnerData = arg; }

spaceship.owner = defaultOwner();
```

---

### 파라미터 객체 도입

**사용 시기**: 자주 함께 사용되는 여러 파라미터

**동기**: 자연스럽게 함께 속하는 데이터 그룹화.

**메커니즘**:
1. 그룹화된 파라미터를 위한 새 클래스/구조 생성
2. 테스트
3. 함수 선언 변경으로 새 객체 추가
4. 테스트
5. 그룹의 각 파라미터에 대해 함수에서 제거하고 새 객체 사용
6. 각각 테스트

**이전**:
```javascript
function amountInvoiced(startDate, endDate) { ... }
function amountReceived(startDate, endDate) { ... }
function amountOverdue(startDate, endDate) { ... }
```

**이후**:
```javascript
class DateRange {
  constructor(start, end) {
    this.start = start;
    this.end = end;
  }
}

function amountInvoiced(dateRange) { ... }
function amountReceived(dateRange) { ... }
function amountOverdue(dateRange) { ... }
```

---

### 함수를 클래스로 묶기

**사용 시기**: 여러 함수가 같은 데이터에서 동작할 때

**동기**: 함수를 그들이 동작하는 데이터와 함께 그룹화.

**메커니즘**:
1. 공통 데이터에 레코드 캡슐화 적용
2. 각 함수를 클래스로 이동
3. 각 이동 후 테스트
4. 데이터 인수를 클래스 필드 사용으로 교체

**이전**:
```javascript
function base(reading) { ... }
function taxableCharge(reading) { ... }
function calculateBaseCharge(reading) { ... }
```

**이후**:
```javascript
class Reading {
  constructor(data) { this._data = data; }

  get base() { ... }
  get taxableCharge() { ... }
  get calculateBaseCharge() { ... }
}
```

---

### 단계 분리

**사용 시기**: 코드가 두 가지 다른 일을 처리할 때

**동기**: 코드를 명확한 경계를 가진 구별된 단계로 분리.

**메커니즘**:
1. 두 번째 단계를 위한 두 번째 함수 생성
2. 테스트
3. 단계 간 중간 데이터 구조 도입
4. 테스트
5. 첫 번째 단계를 자체 함수로 추출
6. 테스트

**이전**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = quantity * shippingPerCase;
  return basePrice - discount + shippingCost;
}
```

**이후**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const priceData = calculatePricingData(product, quantity);
  return applyShipping(priceData, shippingMethod);
}

function calculatePricingData(product, quantity) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  return { basePrice, quantity, discount };
}

function applyShipping(priceData, shippingMethod) {
  const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = priceData.quantity * shippingPerCase;
  return priceData.basePrice - priceData.discount + shippingCost;
}
```

---

## 기능 이동

### 메서드 이동

**사용 시기**: 메서드가 자신의 클래스보다 다른 클래스의 기능을 더 많이 사용할 때

**동기**: 함수를 가장 많이 사용하는 데이터와 함께 배치.

**메커니즘**:
1. 클래스에서 메서드가 사용하는 모든 프로그램 요소 검사
2. 메서드가 다형적인지 확인
3. 대상 클래스에 메서드 복사
4. 새 컨텍스트에 맞게 조정
5. 원래 메서드가 대상으로 위임하도록 함
6. 테스트
7. 원래 메서드 제거 고려

---

### 필드 이동

**사용 시기**: 필드가 다른 클래스에서 더 많이 사용될 때

**동기**: 데이터를 사용하는 함수와 함께 유지.

**메커니즘**:
1. 아직 캡슐화되지 않았다면 필드 캡슐화
2. 테스트
3. 대상에 필드 생성
4. 대상 필드를 사용하도록 참조 업데이트
5. 테스트
6. 원래 필드 제거

---

### 함수 내로 문 이동

**사용 시기**: 함수 호출과 항상 같은 코드가 나타날 때

**동기**: 반복되는 코드를 함수로 이동하여 중복 제거.

**메커니즘**:
1. 반복되는 코드를 아직 함수로 추출하지 않았다면 추출
2. 해당 함수로 문 이동
3. 테스트
4. 호출자에 더 이상 독립 문이 필요 없다면 제거

---

### 호출자로 문 이동

**사용 시기**: 호출자 간에 공통 동작이 다를 때

**동기**: 동작이 달라야 할 때 함수에서 꺼내기.

**메커니즘**:
1. 이동할 코드에 메서드 추출 사용
2. 원래 함수에 메서드 인라인 사용
3. 이제 인라인된 호출 제거
4. 추출된 코드를 각 호출자로 이동
5. 테스트

---

## 데이터 구성

### 기본 타입을 객체로 교체

**사용 시기**: 데이터 항목에 단순 값보다 더 많은 동작이 필요할 때

**동기**: 데이터를 동작과 함께 캡슐화.

**메커니즘**:
1. 변수 캡슐화 적용
2. 간단한 값 클래스 생성
3. setter가 새 인스턴스를 생성하도록 변경
4. getter가 값을 반환하도록 변경
5. 테스트
6. 새 클래스에 더 풍부한 동작 추가

**이전**:
```javascript
class Order {
  constructor(data) {
    this.priority = data.priority; // 문자열: "high", "rush" 등
  }
}

// 사용
if (order.priority === "high" || order.priority === "rush") { ... }
```

**이후**:
```javascript
class Priority {
  constructor(value) {
    if (!Priority.legalValues().includes(value))
      throw new Error(`Invalid priority: ${value}`);
    this._value = value;
  }

  static legalValues() { return ['low', 'normal', 'high', 'rush']; }
  get value() { return this._value; }

  higherThan(other) {
    return Priority.legalValues().indexOf(this._value) >
           Priority.legalValues().indexOf(other._value);
  }
}

// 사용
if (order.priority.higherThan(new Priority("normal"))) { ... }
```

---

### 임시값을 쿼리로 교체

**사용 시기**: 임시 변수가 표현식의 결과를 보유할 때

**동기**: 표현식을 함수로 추출하여 코드를 더 명확하게 만들기.

**메커니즘**:
1. 변수가 한 번만 할당되는지 확인
2. 할당의 우변을 메서드로 추출
3. temp에 대한 참조를 메서드 호출로 교체
4. 테스트
5. temp 선언 및 할당 제거

**이전**:
```javascript
const basePrice = this._quantity * this._itemPrice;
if (basePrice > 1000) {
  return basePrice * 0.95;
} else {
  return basePrice * 0.98;
}
```

**이후**:
```javascript
get basePrice() {
  return this._quantity * this._itemPrice;
}

// 메서드에서
if (this.basePrice > 1000) {
  return this.basePrice * 0.95;
} else {
  return this.basePrice * 0.98;
}
```

---

## 조건 로직 단순화

### 조건문 분해

**사용 시기**: 복잡한 조건문 (if-then-else)

**동기**: 조건과 행동을 추출하여 의도를 명확히 하기.

**메커니즘**:
1. 조건에 메서드 추출 적용
2. then 분기에 메서드 추출 적용
3. else 분기에 메서드 추출 적용 (있는 경우)

**이전**:
```javascript
if (!aDate.isBefore(plan.summerStart) && !aDate.isAfter(plan.summerEnd)) {
  charge = quantity * plan.summerRate;
} else {
  charge = quantity * plan.regularRate + plan.regularServiceCharge;
}
```

**이후**:
```javascript
if (isSummer(aDate, plan)) {
  charge = summerCharge(quantity, plan);
} else {
  charge = regularCharge(quantity, plan);
}

function isSummer(date, plan) {
  return !date.isBefore(plan.summerStart) && !date.isAfter(plan.summerEnd);
}

function summerCharge(quantity, plan) {
  return quantity * plan.summerRate;
}

function regularCharge(quantity, plan) {
  return quantity * plan.regularRate + plan.regularServiceCharge;
}
```

---

### 조건문 통합

**사용 시기**: 같은 결과를 가진 여러 조건

**동기**: 조건이 단일 검사임을 명확히 하기.

**메커니즘**:
1. 조건에 사이드 이펙트가 없는지 확인
2. `and` 또는 `or`을 사용하여 조건 결합
3. 결합된 조건에 메서드 추출 고려

**이전**:
```javascript
if (employee.seniority < 2) return 0;
if (employee.monthsDisabled > 12) return 0;
if (employee.isPartTime) return 0;
```

**이후**:
```javascript
if (isNotEligibleForDisability(employee)) return 0;

function isNotEligibleForDisability(employee) {
  return employee.seniority < 2 ||
         employee.monthsDisabled > 12 ||
         employee.isPartTime;
}
```

---

### 중첩 조건문을 보호 절로 교체

**사용 시기**: 깊게 중첩된 조건문으로 흐름 파악이 어려울 때

**동기**: 특수 케이스에 보호 절을 사용하여 정상 흐름을 명확히 유지.

**메커니즘**:
1. 특수 케이스 조건 찾기
2. 조기 반환하는 보호 절로 교체
3. 각 변경 후 테스트

**이전**:
```javascript
function payAmount(employee) {
  let result;
  if (employee.isSeparated) {
    result = { amount: 0, reasonCode: "SEP" };
  } else {
    if (employee.isRetired) {
      result = { amount: 0, reasonCode: "RET" };
    } else {
      result = calculateNormalPay(employee);
    }
  }
  return result;
}
```

**이후**:
```javascript
function payAmount(employee) {
  if (employee.isSeparated) return { amount: 0, reasonCode: "SEP" };
  if (employee.isRetired) return { amount: 0, reasonCode: "RET" };
  return calculateNormalPay(employee);
}
```

---

### 조건문을 다형성으로 교체

**사용 시기**: 타입 기반 switch/case, 타입에 따라 다른 조건 로직

**동기**: 객체가 자신의 동작을 처리하도록 하기.

**메커니즘**:
1. 클래스 계층 구조 생성 (없는 경우)
2. 객체 생성을 위한 팩토리 함수 사용
3. 조건 로직을 수퍼클래스 메서드로 이동
4. 각 케이스에 대한 서브클래스 메서드 생성
5. 원래 조건문 제거

**이전**:
```javascript
function plumages(birds) {
  return birds.map(b => plumage(b));
}

function plumage(bird) {
  switch (bird.type) {
    case 'EuropeanSwallow':
      return "average";
    case 'AfricanSwallow':
      return (bird.numberOfCoconuts > 2) ? "tired" : "average";
    case 'NorwegianBlueParrot':
      return (bird.voltage > 100) ? "scorched" : "beautiful";
    default:
      return "unknown";
  }
}
```

**이후**:
```javascript
class Bird {
  get plumage() { return "unknown"; }
}

class EuropeanSwallow extends Bird {
  get plumage() { return "average"; }
}

class AfricanSwallow extends Bird {
  get plumage() {
    return (this.numberOfCoconuts > 2) ? "tired" : "average";
  }
}

class NorwegianBlueParrot extends Bird {
  get plumage() {
    return (this.voltage > 100) ? "scorched" : "beautiful";
  }
}

function createBird(data) {
  switch (data.type) {
    case 'EuropeanSwallow': return new EuropeanSwallow(data);
    case 'AfricanSwallow': return new AfricanSwallow(data);
    case 'NorwegianBlueParrot': return new NorwegianBlueParrot(data);
    default: return new Bird(data);
  }
}
```

---

### 특수 케이스 도입 (Null 객체)

**사용 시기**: 특수 케이스에 대한 반복된 null 검사

**동기**: 특수 케이스를 처리하는 특수 객체 반환.

**메커니즘**:
1. 예상된 인터페이스를 가진 특수 케이스 클래스 생성
2. isSpecialCase 검사 추가
3. 팩토리 메서드 도입
4. null 검사를 특수 케이스 객체 사용으로 교체
5. 테스트

**이전**:
```javascript
const customer = site.customer;
// ... null 확인하는 여러 곳
if (customer === "unknown") {
  customerName = "occupant";
} else {
  customerName = customer.name;
}
```

**이후**:
```javascript
class UnknownCustomer {
  get name() { return "occupant"; }
  get billingPlan() { return registry.defaultPlan; }
}

// 팩토리 메서드
function customer(site) {
  return site.customer === "unknown"
    ? new UnknownCustomer()
    : site.customer;
}

// 사용 - null 검사 불필요
const customerName = customer.name;
```

---

## API 리팩토링

### 쿼리와 수정자 분리

**사용 시기**: 함수가 값을 반환하면서 사이드 이펙트도 있을 때

**동기**: 어떤 작업에 사이드 이펙트가 있는지 명확히 하기.

**메커니즘**:
1. 새 쿼리 함수 생성
2. 원래 함수의 반환 로직 복사
3. 원래 함수가 void를 반환하도록 수정
4. 반환 값을 사용하는 호출 교체
5. 테스트

**이전**:
```javascript
function alertForMiscreant(people) {
  for (const p of people) {
    if (p === "Don") {
      setOffAlarms();
      return "Don";
    }
    if (p === "John") {
      setOffAlarms();
      return "John";
    }
  }
  return "";
}
```

**이후**:
```javascript
function findMiscreant(people) {
  for (const p of people) {
    if (p === "Don") return "Don";
    if (p === "John") return "John";
  }
  return "";
}

function alertForMiscreant(people) {
  if (findMiscreant(people) !== "") setOffAlarms();
}
```

---

### 함수 파라미터화

**사용 시기**: 다른 값으로 비슷한 일을 하는 여러 함수

**동기**: 파라미터를 추가하여 중복 제거.

**메커니즘**:
1. 함수 하나 선택
2. 변하는 리터럴을 위한 파라미터 추가
3. 파라미터를 사용하도록 본문 변경
4. 테스트
5. 파라미터화된 버전을 사용하도록 호출자 변경
6. 이제 사용되지 않는 함수 제거

**이전**:
```javascript
function tenPercentRaise(person) {
  person.salary = person.salary * 1.10;
}

function fivePercentRaise(person) {
  person.salary = person.salary * 1.05;
}
```

**이후**:
```javascript
function raise(person, factor) {
  person.salary = person.salary * (1 + factor);
}

// 사용
raise(person, 0.10);
raise(person, 0.05);
```

---

### 플래그 인수 제거

**사용 시기**: 함수 동작을 변경하는 불리언 파라미터

**동기**: 별도 함수를 통해 동작을 명시적으로 만들기.

**메커니즘**:
1. 각 플래그 값에 대한 명시적 함수 생성
2. 각 호출을 적절한 새 함수로 교체
3. 각 변경 후 테스트
4. 원래 함수 제거

**이전**:
```javascript
function bookConcert(customer, isPremium) {
  if (isPremium) {
    // 프리미엄 예약 로직
  } else {
    // 일반 예약 로직
  }
}

bookConcert(customer, true);
bookConcert(customer, false);
```

**이후**:
```javascript
function bookPremiumConcert(customer) {
  // 프리미엄 예약 로직
}

function bookRegularConcert(customer) {
  // 일반 예약 로직
}

bookPremiumConcert(customer);
bookRegularConcert(customer);
```

---

## 상속 다루기

### 상위 메서드 끌어올리기

**사용 시기**: 여러 서브클래스에 같은 메서드가 있을 때

**동기**: 클래스 계층 구조에서 중복 제거.

**메커니즘**:
1. 메서드가 동일한지 확인
2. 시그니처가 같은지 확인
3. 수퍼클래스에 새 메서드 생성
4. 서브클래스 하나의 본문 복사
5. 서브클래스 메서드 하나 삭제, 테스트
6. 다른 서브클래스 메서드 삭제, 각각 테스트

---

### 하위로 메서드 내리기

**사용 시기**: 일부 서브클래스에만 관련된 동작

**동기**: 사용되는 곳에 메서드 배치.

**메커니즘**:
1. 필요한 각 서브클래스에 메서드 복사
2. 수퍼클래스에서 메서드 제거
3. 테스트
4. 필요 없는 서브클래스에서 제거
5. 테스트

---

### 서브클래스를 위임으로 교체

**사용 시기**: 상속이 잘못 사용되거나 더 많은 유연성이 필요할 때

**동기**: 적절할 때 상속보다 구성을 선호.

**메커니즘**:
1. 위임을 위한 빈 클래스 생성
2. 위임을 보유하는 호스트 클래스에 필드 추가
3. 호스트에서 호출되는 위임 생성자 생성
4. 기능을 위임으로 이동
5. 각 이동 후 테스트
6. 상속을 위임으로 교체

---

## 클래스 추출

**사용 시기**: 여러 책임을 가진 거대한 클래스

**동기**: 단일 책임을 유지하기 위해 클래스 분리.

**메커니즘**:
1. 책임을 어떻게 분리할지 결정
2. 새 클래스 생성
3. 원래에서 새 클래스로 필드 이동
4. 테스트
5. 원래에서 새 클래스로 메서드 이동
6. 각 이동 후 테스트
7. 두 클래스 검토 및 이름 변경
8. 새 클래스를 노출하는 방법 결정

**이전**:
```javascript
class Person {
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get officeAreaCode() { return this._officeAreaCode; }
  set officeAreaCode(arg) { this._officeAreaCode = arg; }
  get officeNumber() { return this._officeNumber; }
  set officeNumber(arg) { this._officeNumber = arg; }

  get telephoneNumber() {
    return `(${this._officeAreaCode}) ${this._officeNumber}`;
  }
}
```

**이후**:
```javascript
class Person {
  constructor() {
    this._telephoneNumber = new TelephoneNumber();
  }
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get telephoneNumber() { return this._telephoneNumber.toString(); }
  get officeAreaCode() { return this._telephoneNumber.areaCode; }
  set officeAreaCode(arg) { this._telephoneNumber.areaCode = arg; }
}

class TelephoneNumber {
  get areaCode() { return this._areaCode; }
  set areaCode(arg) { this._areaCode = arg; }
  get number() { return this._number; }
  set number(arg) { this._number = arg; }
  toString() { return `(${this._areaCode}) ${this._number}`; }
}
```

---

## 빠른 참조: 스멜에서 리팩토링으로

| 코드 스멜 | 주요 리팩토링 | 대안 |
|------------|-------------------|-------------|
| 긴 메서드 | 메서드 추출 | 임시값을 쿼리로 교체 |
| 중복 코드 | 메서드 추출 | 상위 메서드 끌어올리기 |
| 거대한 클래스 | 클래스 추출 | 서브클래스 추출 |
| 긴 파라미터 목록 | 파라미터 객체 도입 | 전체 객체 보존 |
| 기능 욕심 | 메서드 이동 | 메서드 추출 + 이동 |
| 데이터 덩어리 | 클래스 추출 | 파라미터 객체 도입 |
| 기본 타입 집착 | 기본 타입을 객체로 교체 | 타입 코드 교체 |
| Switch 문 | 조건문을 다형성으로 교체 | 타입 코드 교체 |
| 임시 필드 | 클래스 추출 | Null 객체 도입 |
| 메시지 체인 | 위임 숨기기 | 메서드 추출 |
| 중간 매개자 | 중간 매개자 제거 | 메서드 인라인 |
| 발산적 변경 | 클래스 추출 | 단계 분리 |
| 산탄총 수술 | 메서드 이동 | 클래스 인라인 |
| 죽은 코드 | 죽은 코드 제거 | - |
| 추측적 일반화 | 계층 구조 축소 | 클래스 인라인 |

---

## 추가 읽기

- Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2nd ed.)
- 온라인 카탈로그: https://refactoring.com/catalog/
