# SQL

비 절차적 언어 → 어떻게 보다는 ‘무엇’에 집중 SQL은 어떻게 작업을 수행할 것인가 보다는 어떤 데이터를 구하고 삭제하고 삽입할것인가 서술

| 명령어 | 종류 | 명령어 |
| --- | --- | --- |
| DML | SELECT  INSERT UPDATE DELETE | 데이터베이스의 데이터를 조회하거나 검색하기 위한 모음 RETRIEVE 라고도 함 데이터베이스 테이블의 데이터에 변형을 가하는 종류(삽입, 수정, 삭제)등의 질의어 |
| DDL | CREATE ALTER DROP RENAME TRUNCATE | 테이블, 뷰 , 저장 프로시저등의데이터 구조를 정의하는데 사용되는 명령어 생성, 변경 ,삭제, 이름변경 등의 데이터 구조와 관련된 질의어 |
| DCL | GRANT REVOKE DENY | 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 질의어 |
| TCL | COMMIT ROLLBACK SAVEPOINT | 논리적인 잡업 단위를 묶어서 DML에 의해 조작된 결과를 트랜잭션별로 제어하는 질의어 |

### DDL

데이터 정의 언어 → 관계 데이터베이스의 구조를 정의

- CREATE → 릴레이션(테이블), 뷰, 인덱스, 저장 프로시저 등 데이터베이스 객체 생성
- DROP → 존재하는 데이터 베이스 객체 삭제
- ALTER→ 존재하는 데이터베이스 객체 수정
- TRUNCATE→ 테이블 내 데이터의 완전 삭제 where절을 지정할수 없다. 삭제시 외래키 무결성 확인하지 않는다. Oracle,MySQL에서는 TRUCATE문을 롤백할수 없다.

```sql
CREATE [데이터베이스 객체 형식] [객체 이름][객체의 종류에 따른 정의]
```

```sql
DROP [데이터베이스 객체 형식] [객체 이름]
```

```sql
ALTER [데이터베이스 객체 형식] [객체 이름][객체의 종류에 따른 정의]
```

```sql
TRUNCATE [TABLE] 테이블 이름 [, 테이블 이름]
```

### CREATE

```sql
CREATE TABLE Product (
    ProductNo 	int,
    SerialKey	char(12)		NOT NULL,
    ProductName	nvarchar(30)	NOT NULL,
    Price		int		NOT NULL,
    State		nvarchar(4)	NOT NULL,
    Detail		text,
    Stock		int		DEFAULT 0,
    TaxRate		int		NOT NULL CHECK(TaxRate >= 10 AND TaxRate < 20),
    CategoryNo	int,

    CONSTRAINT pk_Product PRIMARY KEY(ProductNo),
    CONSTRAINT uq_ProductSerial UNIQUE(SerialKey),
    CONSTRAINT ch_State CHECK (State IN ('신상','중고','전시')),
    CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
);
```

제약조건을 아래처럼 표현가능

```sql
CREATE TABLE Product{
ProductNo int PRIMARY KEY,
SerialKey	char(12)    UNIQUE,
State		nvarchar(4)	NOT NULL CHECK (State IN (‘신상’,’중고’,’전시’));
```

### ALTER

```sql
ALTER TABLE Product MODIFY COLUMN ProductName nvarchar(40);
```

필드의 데이터 타입 변경

```sql
ALTER TABLE Product ADD Column ModelNo nvarchar(20);
```

필드를 추가

```sql
ALTER TABLE Product MODIFY ModelNo varchar(20) AFTER SerialKey;
```

필드의 순서 변경

```sql
ALTER TABLE Product ALTER COLUMN TaxRate SET DEFAULT 10;
```

컬럼의 기본값 변경

```sql
ALTER TABLE Product MODIFY COLUMN Detail text NOT NULL;
```

필드에 not null 설정

```sql
ALTER TABLE Product CHANGE ModelNo ModelNumber nvarchar(20);
```

필드의 이름 변경

```sql
ALTER TABLE Product RENAME Products;
```

테이블 이름을 변경

```sql
RENAME TABLE Products TO Product;
```

테이블 이름 변경

### DROP

```sql
ALTER TABLE Product DROP CONSTRAINT uq_ProductSerial;
```

unique 제약 조건을 샂게

```sql
ALTER TABLE Product DROP COLUMN ModelNumber;
```

컬럼 삭제

```sql
DROP TABLE Product;
```

테이블 삭제

- "varchar": "varchar" 데이터 형식은 가변 길이 문자열을 저장하는 데 사용됩니다. 이는 ASCII 문자 또는 기타 단일 문자 인코딩을 사용하는 문자열에 적합합니다. 즉, 1바이트로 표현되는 문자열 데이터를 저장할 때 사용됩니다.
- "nvarchar": "nvarchar" 데이터 형식은 유니코드 문자열을 저장하는 데 사용됩니다. 유니코드는 다양한 언어와 문자 집합을 지원하며, 문자당 2바이트로 표현됩니다. 따라서 멀티바이트 문자열 데이터를 저장할 때 사용됩니다.

### DML

SELECT→ 관계대수에서 프로젝션(Projection) 연산과 일치, 결과에 나타날 속성을 나열하는데 사용 , 중복된 튜플이 릴레이션에 나타날수 있다. 제거하고 싶은 경우 DISTINCT

FROM→ 카티션 프로덕트에 해당 질의에서 조회할 릴레이션을 나열

WHERE → 관계대수에서 셀렉션 연산과 일치 

```sql
SELECT [DISTINCT] A1, A2 … An
FROM r1, r2… rm
WHERE P
```

```sql
SELECT PassengerName AS 승객이름
FROM Passenger
```

```sql
SELECT SUM(Age)
FROM Passenger;
```

```sql
SELECT COUNT(PassengerNo)
FROM Passenger
WHERE Age >= 40;
```

count는 null의 값을 튜플의 수로 계산하지 않는다.

```sql
SELECT AVG(Age)
FROM Passenger
```

INNER JOIN 활용법

```sql
SELECT FlightDate
FROM Aircraft AS A INNER JOIN Flight AS F ON A.AircraftNo = F.AircraftNo
WHERE A.AircraftNo = 101;
```

관계 대수식의 합집합 ⇒ UNION       중복허용 → UNION ALL

관계 대수식의 교집합 ⇒ INTERSECT     중복허용 → INTERSECT ALL

관계 대수식의 차집합 ⇒ EXCEPT.     중복허용 → EXCEPT ALL

### subquery

```sql
SELECT PassengerName
FROM
	Passenger
WHERE
	PassengerNo IN
     (SELECT PassengerNo
     FROM Reservation
     WHERE FlightNo IN
		(SELECT FlightNo
              FROM Flight
              WHERE Arrival = '샌프란시스코'));
```

![스크린샷 2023-10-19 오후 1.42.56.png](SQL%20ab9297721f434f65b23e19f804bf0124/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-10-19_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_1.42.56.png)

![스크린샷 2023-10-19 오후 1.43.11.png](SQL%20ab9297721f434f65b23e19f804bf0124/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-10-19_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_1.43.11.png)

![Untitled](SQL%20ab9297721f434f65b23e19f804bf0124/Untitled.png)

![Untitled](SQL%20ab9297721f434f65b23e19f804bf0124/Untitled%201.png)

![Untitled](SQL%20ab9297721f434f65b23e19f804bf0124/Untitled%202.png)

![Untitled](SQL%20ab9297721f434f65b23e19f804bf0124/Untitled%203.png)

서브쿼리 → Where절에서 셀렉션 연산의 값을 산출하기 위한 질의

인라인 뷰→ From절에서 질의의 결과를 테이블처럼 사용하기 위한 질의

스칼라 서브쿼리→ Select 문에서 사용되는 서브쿼리 계산의 결과값을 쿼리 결과에 포함시키기 위한 질의

Count([DISTINCT] A )

SUM([DISTINCT] A)

AVG([DISTINCT] A) → A필드에 있는 [유일한] 값들로 계산

Group By

→ 컬럼의 값을 기준으로 튜플을 그룹화 

Having

→ 그룹에 대한 조건식을 지정

전체적인 연산의 구문

```sql
SELECT [DISTINCT]	select-list
FROM			from-list
WHERE			conditional statement
GROUP BY		grouping-list
HAVING		group conditional statement
```

정렬

```sql
SELECT PassengerName, Grade, Age
FROM Passenger
ORDER BY age DESC // 내림차순
LIMIT 1; // 최상위 1열 산출
```

index를 사용한 정렬

```sql
CREATE INDEX idx_passenger_grade ON Passenger(grade);
```

```sql
SELECT PassengerName, Grade, Age
FROM Passenger
WHERE Grade > 0;
```

INSERT

```sql
INSERT INTO Passenger
(PassengerNo, PassengerName, Grade)
VALUES (9, ‘이외수’, 9);
```

하나의 INSERT문으로 여러 튜블 삽입하기

```sql
INSERT INTO Aircraft
(AircraftNo, KindOfAircraft, Airline)
VALUES
(106, '에어버스 A330', '대한항공'),
(107, '에어버스 A321', '아시아나 항공'),
(108, '보잉 737', '제주항공');
```

SELECT 쿼리의 반환결과를 바로 테이블에 삽입하기

```sql
CREATE TABLE tempPassenger
SELECT P.PassengerNo, PassengerName Grade, Age, FlightNo, ReservedDate
FROM Passenger AS P INNER JOIN Reservation AS R ON P.PassengerNo = R.PassengerNo;
```

UPDATE

```sql
UPDATE Passenger SET
Grade = 9
WHERE PassengerNo = 3;
```

DELETE

```sql
DELETE FROM Passenger
WHERE Age >= 60;
```