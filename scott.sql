-- sql 구문은 대소문자를 구별하지않는다!
-- 단, 비밀번호는 구별함!

-- 조회(select)
-- select 컬럼명
-- from 테이블명
-- where 조건절
-- group by
-- having
-- order by 컬럼명 desc or asc
-- 해석 순서 from, where, group by, having, select, order by

-- emp(사원) 테이블
-- empno(사번) : number(4, 0) => 숫자, 4자리, 소숫점 아래 자릿수는 0
-- emane(이름) : varchar2(10)
-- job(직무) : varchar2(9)
-- mgr(매니저-상사 사번)
-- hiredate(입사일) : date
-- sal(급여) : number(7,2) =) 숫자, 7자리, 소숫점 아래 2자리까지 가능
-- comm(수당)
-- deptno(부서번호)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)


-- 조회 기본 구문
--SELECT 보고싶은열이름... FROM 테이블명;
--SELECT 보고싶은열이름... FROM 테이블명 WHERE 조건 나열;

-- 1) 전체 사원 조회 시 사원의 모든 정보 추출
SELECT * FROM EMP e;

-- 2) 정체 사원 조회 시 사원의 이름만 추출
SELECT ename FROM EMP e;

-- 3) 정체 사원 조회 시 사번, 사원명, 부서번호만 추출
SELECT empno, ename, deptno FROM EMP e;

-- 4) 전체 사원 조회 시 부서번호만 추출
SELECT deptno FROM EMP e;

-- 5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거(DISTINCT)!
SELECT DISTINCT deptno FROM EMP e;

-- 6) alais(별칭) "" 선택사항
SELECT ename "사원명" FROM EMP e;
SELECT ename 사원명 FROM EMP e;
SELECT ename AS "사원명" FROM EMP e;
-- SQL Error [923] [42000]: ORA-00923: FROM 키워드가 필요한 위치에 없습니다.
-- SELECT ename AS 사원 이름 FROM EMP e;
-- 중간에 공백이 있으면 "" 가 필수!
SELECT ename AS "사원 이름" FROM EMP e;

-- 7) 연봉 구하기( sal * 12 + comm )
SELECT empno, sal * 12 + comm AS "연봉" FROM EMP e;


-- 정렬
-- 오름차순, 내림차순 : ORDER BY 정렬기준 열이름... ASC(오름차순) OR DESC(내림차순)
-- 급여의 오름차순 정렬
SELECT * FROM emp ORDER BY sal ASC;
SELECT * FROM emp ORDER BY sal;
-- 급여의 내림차순 정렬
SELECT * FROM emp ORDER BY sal DESC;
-- 급여의 내림차순, 이름의 오름차순
SELECT * FROM emp ORDER BY sal DESC, ename ASC;

-- [실습]
-- empno : employee_no
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno : department_no
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름의 오름차순
SELECT
	empno employee_no ,
	ename employee_name,
	mgr manager,
	sal salary,
	comm commission,
	deptno department_no
FROM
	EMP
ORDER BY
	deptno DESC ,
	ename ASC;

-- 부서번호 30번인 사원정보 조회
-- = (같다),/ 문자열 표현 ''이며 값의 대소문자는 구별한다. / and / or
SELECT * FROM emp WHERE deptno = 30;
-- 사번이 7698인 사원정보 조회
SELECT * FROM emp WHERE empno = 7698;
-- 부서번호가 30번, 사원직책이 salesman인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN';
-- 부서번호가 30번이거나 사원직책이 analyst인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 OR job = 'ANALYST';

-- 연산자
-- +, -. *, /
-- =, >, <, >=, <=, and, or, 같지않다 => !=, <>, ^=
-- in, between A and B (~ 이상 ~이하)
-- like

-- 연봉이 36000인 사원 조회
SELECT * FROM EMP e WHERE sal*12 = 36000;

-- 급여가 3000 초과인 사원 조회
SELECT * FROM EMP e WHERE sal > 3000;

-- 이름이 'F' 이후의 문자로 시작하는 사원 조회
SELECT  * FROM EMP e  WHERE e.ENAME >= 'F';

-- 직무가 manager, salesman, clerk인 사원 조회
SELECT  * FROM EMP e  WHERE e.JOB = 'MANAGER' OR e.JOB = 'SALESMAN' OR e.JOB = 'CLERK';

-- 급여가 3000이 아닌 사원 조회
SELECT  * FROM EMP e  WHERE e.SAL != 3000;
SELECT  * FROM EMP e  WHERE e.SAL <> 3000;
SELECT  * FROM EMP e  WHERE e.SAL ^= 3000;

-- 직무가 manager, salesman, clerk인 사원 조회 + IN 연산자
SELECT  * FROM EMP e  WHERE e.JOB IN ('MANAGER','SALESMAN','CLERK')

-- 직무가 manager, salesman, clerk가 아닌 사원 조회 + NOT IN 연산자
SELECT  * FROM EMP e  WHERE e.JOB NOT IN ('MANAGER','SALESMAN','CLERK')

-- 부서번호가 10, 20번인 사원 조회(OR, IN)
SELECT  * FROM EMP e  WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT  * FROM EMP e  WHERE e.DEPTNO  IN (10, 20);

-- between A and B
-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT *
FROM
	EMP e
WHERE
	e.sal >= 2000
	AND e.sal <= 3000;

SELECT *
FROM
	EMP e
WHERE
	e.sal BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT *
FROM
	EMP e
WHERE
	e.sal NOT BETWEEN 2000 AND 3000;


-- LIKE + 와일드카드(%, _)
-- % : 길이와 상관없이 (문자없는 경우도 포함) 모든 문자 데이터를 의미
-- _ : 한개의 문자 데이터를 의미
-- 사원명이 S로 시작하는 사원들의 정보를 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE 'S%';

-- 사원명의 두번째 글자가 L인 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '_L%';

-- 사원명에 AM이 포함된 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';

-- 사원명에 AM이 포함되지않은 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';


-- null 값
-- null 값은 비교시 = or != 사용하지 않음
SELECT * FROM EMP e WHERE e.COMM IS NULL;
SELECT * FROM EMP e WHERE e.COMM IS NOT NULL;


-- 집합 연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)
-- 합집합 : 출력하려는 열의 개수와 자료형이 일치해야한다.
-- UNION : 중복 제거
-- DRPTNO = 10 UNION DEPTNO = 20
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 20;

-- UNION ALL
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- MINUS
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
MINUS
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- INTERSECT 
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
INTERSECT 
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- 실습
-- 1. 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%S';
-- 2. 30번 부서에 근무하고있는 사원 중에 JOB이 SALESMAN인 사원의 사번, 이름, 직책, 급여, 부서번호 조회
SELECT e.EMPNO, e.ENAME , e.JOB , e.SAL , e.DEPTNO FROM EMP e WHERE e.DEPTNO = 30 AND e.JOB = 'SALESMAN';

-- 3. 20번, 30번 부서에 근무하고있는 사원 중 급여가 2000 초과인 사원을 다음 두 방식의 SELECT 문을 사용하여
-- 사번, 이름, 직책, 급여, 부서번로를 출력
-- 집합연산자를 사용하는 방식
SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO FROM EMP e WHERE e.SAL > 2000 AND e.DEPTNO = 20
UNION
SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO FROM EMP e WHERE e.SAL > 2000 AND e.DEPTNO = 30; 
-- 집합연산자를 사용하지 않는 방식
SELECT  e.EMPNO , e.ENAME , e.SAL , e.DEPTNO FROM EMP e WHERE e.SAL > 2000 AND e.DEPTNO IN (20,30);

-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여열이 2000 이상 3000이하 범위 이외의 값을 가진 데이터 조회
SELECT * FROM EMP e WHERE e.SAL < 2000 AND e.SAL > 3000;

-- 5. 사원 이름에 E가 포함된 30번 부서의 사원중 급여가 1000~2000 사이가 아닌 사원명, 사번, 급여, 부서번호 조회
SELECT
	e.ENAME ,
	e.EMPNO ,
	e.SAL ,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.ENAME LIKE '%E'
	AND e.DEPTNO = 30
	AND e.SAL NOT BETWEEN 1000 AND 2000;

--6. 추가 수당이 없고 상급자가 있고 직책이 MANAGER, CLREK인 사원 중에서 사원이름의 두번째 글자가 L이 아닌
-- 사원의 정보를 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND e.MGR IS NOT NULL
	AND e.JOB IN ('MANAGER', 'CLERK')
	AND e.ENAME NOT LIKE '_L%';


-- 함수
-- 1. 문자함수
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) : 첫글자는 대문자, 나머지 문자는 소문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 바이트 길이
-- SUBSTR(문자열데이터, 시작위치, 추출길이) : 문자열 부분추출
-- INSTR(대상문자열, 위치를 찾으려는 문자, 위치찾기 시작위치, 찾으려는 문자가 몇 번째인지) : 문자열 데이터 안에서 트정 문자 위치 찾기
-- REPLACE(문자열, 찾는문자, 바꿀문자)
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합치기
-- TRIM(삭제옵션(선택), 삭제할 문자(선택), FROM 원본 문자열)
-- 1) 삭제옵션 : LEADING OR TRAILING OR BOTH
-- LTRIM(원본 문자열, 삭제할 문자열) : 좌
-- RTRIM(원본 문자열, 삭제할 문자열) : 우


SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP e;

SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME)
FROM EMP e;

-- DUAL(SYS 소유의 테이블, 더미 테이블)
-- 임시연산이나 함수의 결과값 확인 용도!
-- xe21 (한글 한자당 3Byte 사용)
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;

-- 사원명 길이가 5 이상인 사원조회
SELECT * FROM EMP e WHERE LENGTH(e.ENAME) >= 5; 
-- 직택명이 6자 이상인 사원조회
SELECT * FROM EMP e WHERE LENGTH(e.JOB) >= 6; 

SELECT
	e.JOB,
	SUBSTR(e.JOB, 1, 2),
	SUBSTR(e.JOB , 3, 2),
	SUBSTR(e.JOB, 5)
FROM
	EMP e;

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME , SUBSTR(e.ENAME, 3) FROM EMP e; 

SELECT
	e.JOB,
	SUBSTR(e.JOB, -LENGTH(e.JOB)),
	SUBSTR(e.JOB, -LENGTH(e.JOB), 2),
	SUBSTR(e.JOB, -3)
FROM
	EMP e;

SELECT INSTR('HELLO, ORACLE', 'L') AS 첫번째, INSTR('HELLO, ORACLE', 'L', 5) AS 두번째, INSTR('HELLO, ORACLE', 'L', 2, 2) AS 세번째
FROM DUAL;

-- 사원명에 문자S가 포함된 사원 조회
-- 1) LIKE 2) INSTR
SELECT * FROM  EMP e WHERE INSTR(e.ENAME,'S') > 0;

-- 010-4526-7858 => 010 4526 7858 OR 01045267858
SELECT '010-4526-7858' AS BEFORE, REPLACE('010-4526-7858', '-', ' ') AS REPLACE1, REPLACE('010-4526-7858', '-') AS REPLACE2 FROM DUAL;

-- concat() or ||
-- EMPNO, ENAME 합치기
SELECT CONCAT(e.EMPNO , e.ENAME), CONCAT(e.EMPNO , CONCAT(':', e.ENAME)), e.EMPNO || ':' || e.ENAME  FROM EMP e; 

-- TRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH
FROM
	DUAL;

SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS trim,
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM('<_Oracle_>','_<') || ']' AS LTRIM2,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2
FROM
	DUAL;


-- 숫자함수
-- ROUND(숫자, 반올림 위치) : 반올림
-- TRUNC(숫자, 버림 위치) : 버림
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환
-- MOD(숫자, 니눌 숫자) : 지정된 숫자를 나눈 나머지 반환

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND0,
	ROUND(1234.5678, 1) AS ROUND1,
	ROUND(1234.5678, 2) AS ROUND2,
	ROUND(1234.5678,-1) AS ROUND_MINUS1,
	ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM
	DUAL;

SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
	TRUNC(1234.5678,-2) AS TRUNC_MINUS2
FROM
	DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;

-- 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 반환
-- 날짜 데이터 + 날짜 데이터 : 연산불가
-- 날짜 데이터 _ 날짜 데이터 : 두 날짜 데이터 간의 일수 차이 반환
-- ADD_MONTHS(날짜데이터, 더할 개월수)
-- MONTHS_BETWEEN(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터1, 요일문자)
-- LAST_DAT(날짜데이터)

-- 오라클에서 시스템 날짜 출력 : SYSDATE
-- CURRENT_DATE
SELECT SYSDATE, SYSDATE + 1, SYSDATE -1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사 50주년이 되는 날짜 구하기
SELECT e.HIREDATE, ADD_MONTHS(e.HIREDATE, 600)
FROM EMP e ;

-- 입사한지 40년이 넘은 사원을 조회
SELECT e.HIREDATE
FROM EMP e WHERE ADD_MONTHS(e.HIREDATE, 480) < SYSDATE;

SELECT
	e.EMPNO ,
	e.HIREDATE ,
	SYSDATE,
	MONTHS_BETWEEN(e.HIREDATE , SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, e.HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, e.HIREDATE)) AS MONTH3
FROM
	EMP e;
	
SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;


-- 형변환 함수
-- TO_CHAR() : 날짜, 숫자 데이터를 문자로 변환
-- TO_NUMBER() : 문자 데이터를 숫자로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'),
	TO_CHAR(SYSDATE, 'DY'),
	TO_CHAR(SYSDATE, 'DAY')
FROM
	DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
	TO_CHAR(SYSDATE, 'HH:MI:SS P.M.')
FROM
	DUAL;

-- 자동형변환
SELECT e.EMPNO , e.ENAME , e.EMPNO + '500'
FROM EMP e 
WHERE e.ENAME = 'SMITH';

--SELECT e.EMPNO , e.ENAME , e.EMPNO + 'ABCD'
--FROM EMP e 
--WHERE e.ENAME = 'SMITH';

SELECT e.SAL, TO_CHAR(e.sal, '$999,999'), TO_CHAR(e.sal, 'L999,999')
FROM EMP e 

SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;
SELECT '1300' - '1500', '1300' + 1500
FROM DUAL;

-- SQL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
SELECT '1,300' - '1500', '1300' + 1500
FROM DUAL;

SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999'), '1300' + 1500
FROM DUAL;

SELECT TO_DATE('20251027','YYYY-MM-DD'), TO_DATE('20251027','YYYY/MM/DD')
FROM DUAL;

SELECT TO_DATE('2025-10-27') - TO_DATE('2025-09-23')
FROM DUAL;

-- null 처리 함수
-- 1. NVL(NULL에 해당하는 열, 반환할 데이터) : NULL인 경우만 반환할 데이터로 돌아옴
-- 2. NVL2(NULL에 해당하는 열, NULL이 아닐때 반환할 데이터, 반환할 데이터)
-- NULL + NULL
-- 숫자 + NULL = NULL
SELECT EMPNO, ENAME, SAL, COMM, COMM + SAL FROM EMP;
SELECT EMPNO, ENAME, SAL, COMM, NVL(COMM,0) + SAL FROM EMP;
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM,'O','X'),NVL2(COMM, SAL * 12 + COMM ,SAL*12) FROM EMP;

-- DECODE(), CASE() : 상황에 따라 다른 데이터를 반환
-- 직책이 MANAGER인 사원은 급여의 10%, SALESMAN인 사원은 급여의 5%, ANALYST인 사원은 그대로, 나머지는 3%만큼 인상된 급여 구하기
-- DECODE(검사 대상이 될 열 또는 데이터,
-- 조건1, 조건1과 일치 할 때 반환할 데이터,
-- 조건2, 조건2과 일치 할 때 반환할 데이터,
-- [위에 나열한 조건과 일치하지 않는 경우 반환할 결과])

-- CASE : 각 조건에 사용되는 데이터가 서로 상관없어도 됨
-- 		  동등(=) 외에 다양한 조건 사용가능!
-- CASE 검사 대상이 될 열 또는 데이터
-- WHEN 조건1 THEN 조건1과 일치할 때 반환할 결과
-- WHEN 조건2 THEN 조건2과 일치할 때 반환할 결과
-- WHEN 조건3 THEN 조건3과 일치할 때 반환할 결과
-- ELSE [위에 나열한 조건과 일치하지 않는 경우 반환할 결과]
-- END


SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL,
	DECODE(e.JOB,
	'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALYST', e.SAL ,
	e.SAL * 1.03) AS 급여
FROM
	EMP e;

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL,
	CASE e.JOB
		WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS 급여
FROM
	EMP e;

-- COMM이 NULL인 경우에는 해당없음, 0인 경우에는 수당없음, 0보다 큰 경우에는 현재 수당 : 800
SELECT
	e.EMPNO,
	e.ENAME,
	e.COMM,
	CASE
		WHEN e.COMM IS NULL THEN '해당없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM
	END AS COMM_TEXT
FROM
	EMP e;	

-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루 급여(DAY_PAY) 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 첫째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT
	TRUNC(e.SAL / 21.5, 1) AS DAY_PAY ,
	ROUND(e.SAL / 21.5 / 8 , 2) AS TIME_PAY
FROM
	EMP e; 


-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원이 정직원이 되는 날짜(R_JOB)을
-- YYYY-MM-DD 형식으로 출력. 단, 추가수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력
SELECT
	e.EMPNO ,
	e.ENAME ,
	TO_CHAR(e.HIREDATE, 'YYYY/MM/DD') AS HIRE_DATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY/MM/DD') AS R_JOB,
	NVL(TO_CHAR(e.COMM), 'N/A') AS COMM
FROM
	EMP e ;


-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)을 아래의 조건을 기준으로 변환해서 CHG_MGR열에 출력
-- 조건
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 앞 두자리가 75 일때 5555
-- 직속 상관의 사원번호 앞 두자리가 76 일때 6666
-- 직속 상관의 사원번호 앞 두자리가 77 일때 7777
-- 직속 상관의 사원번호 앞 두자리가 78 일때 8888
-- 그 외 직속 상관 사원 번호일때 : 본래 직속 상관의 사원번호 그대로 출력
SELECT
	e.EMPNO ,
	e.ENAME,
	e.HIREDATE,
	CASE SUBSTR(TO_CHAR(NVL(e.MGR, 0)),1,2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;


-- 다중행 함수
-- SUM, AVG, COUNT, MAX, MIN

SELECT SUM(e.SAL), AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(e.SAL)
FROM EMP e ;

SELECT SUM(DISTINCT e.SAL), AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(*)
FROM EMP e ;

-- SQL Error [937] [42000]: ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--SELECT SUM(e.SAL), e.ENAME
--FROM EMP e ;

-- 10번 부서의 급여총계, 평균 구하기
SELECT SUM(e.SAL), AVG(e.SAL)
FROM EMP e WHERE e.DEPTNO = 10;

-- 20번 부서의 제일 오래된 입사일
SELECT MIN(e.HIREDATE)
FROM EMP e WHERE e.DEPTNO = 20;

-- 20번 부서의 제일 최신 입사일
SELECT MAX(e.HIREDATE)
FROM EMP e WHERE e.DEPTNO = 20;




-- GROUP BY : 결과값을 원하는 열로 묶어서 출력
-- 부서별 급여 평균
-- 다중행 함수 옆에 올 수 있는 칼럼은 GROUP BY에 사용한 컬럼만 가능!!!
SELECT
	e.DEPTNO ,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO;

-- 부서별, 직무별 급여 평균 조회
SELECT
	e.DEPTNO ,
	e.JOB ,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
ORDER BY
	e.DEPTNO,
	e.JOB;

-- 부서별 추가 수당 평균
SELECT
	e.DEPTNO ,
	AVG(NVL(e.COMM, 0))
FROM
	EMP e
GROUP BY
	e.DEPTNO

-- GROUP BY 열이름 HAVING 출력그룹제한
-- 부서별, 직무별 급여 평균 조회(단, 평균이 2000이상인 그룹 조회)
--SELECT
--	e.DEPTNO ,
--	e.JOB ,
--	AVG(e.SAL)
--FROM
--	EMP e
--WHERE AVG(e.SAL) > 2000
--GROUP BY
--	e.DEPTNO,
--	e.JOB
--ORDER BY
--	e.DEPTNO,
--	e.JOB;

SELECT
	e.DEPTNO ,
	e.JOB ,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	AVG(e.SAL) > 2000
ORDER BY
	e.DEPTNO,
	e.JOB;

-- WHERE와 HAVING의 비교
SELECT
	e.DEPTNO ,
	e.JOB ,
	AVG(e.SAL)
FROM
	EMP e
WHERE
	e.SAL <= 3000
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	AVG(e.SAL) > 2000
ORDER BY
	e.DEPTNO,
	e.JOB;

-- emp 테이블을 이용하여 부서번호, 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL0, 사원수(CNT) 조회
-- 단, 평균 급여 출력시 소수점을 제외하고 각 부서번호별로 출력
SELECT
	e.DEPTNO ,
	FLOOR(AVG(e.SAL)) AS AVG_SAL,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	e.DEPTNO
ORDER BY
	e.DEPTNO;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	e.JOB,
	COUNT(e.EMPNO) AS CNT
FROM
	EMP e
GROUP BY
	e.JOB
HAVING
	COUNT(e.EMPNO) >= 3;

-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- TO_CHAR(1981-09-28, 'yyyy')
SELECT
	e.DEPTNO,
	TO_CHAR(e.HIREDATE, 'YYYY'),
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	TO_CHAR(e.HIREDATE, 'YYYY'),
	e.DEPTNO;

	
-- 조회 : join / subquery
-- join : 여러 테이블을 하나의 테이블처럼 사용
-- 1. 내부조인(INNER JOIN)
-- 2. 외부조인(OUTER JOIN)
-- 		1) LEFT OUTER JOIN
-- 		2) RIGHT OUTER JOIN
-- 		3) FULL OUTER JOIN : left join union right join

-- 사원정보 + 부서정보 조회
-- 내부조인 + 등가조인
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.DEPTNO ,
	d.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO;


SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.DEPTNO ,
	d.DNAME
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
	AND e.sal >= 2000;

-- 비등가 조인 + 내부 조인
SELECT *
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 셀프조인
-- 
SELECT e1.EMPNO , e1.ENAME , e1.MGR , e2.ENAME AS 매니저명
FROM EMP e1 JOIN EMP e2 ON e1.MGR = e2.EMPNO ;

-- 외부조인
SELECT e1.EMPNO , e1.ENAME , e1.MGR , e2.ENAME AS 매니저명
FROM EMP e1 LEFT JOIN EMP e2 ON e1.MGR = e2.EMPNO ;

SELECT e1.EMPNO , e1.ENAME , e1.MGR , e2.ENAME AS 매니저명
FROM EMP e1 RIGHT JOIN EMP e2 ON e1.MGR = e2.EMPNO ;

-- + 부서명
SELECT
	e.DEPTNO ,
	d.DNAME ,
	FLOOR(AVG(e.SAL)) AS AVG_SAL,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY
	e.DEPTNO, d.DNAME
ORDER BY
	e.DEPTNO;

-- table 3개 연동
-- 부서번호, 부서병, 사번, 사원명, 매니저번호, 급여, 급여등급
-- 부서명 : dept
-- 사번, 사원명, 매니저번호, 급여, 부서번호 : emp
-- 급여등급 : salgrade
SELECT
	e.DEPTNO ,
	d.DNAME ,
	e.EMPNO ,
	e.ENAME ,
	e.MGR ,
	e.SAL ,
	s.GRADE
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;


-- 서브쿼리 : 메인퀴리 외에 select 구문이 여러개 존재
-- 무조건 괄호 안에 작성한다!
-- 1) 단일행 서브쿼리 : 서브쿠리 실행 결과가 행 하나
-- 		사용가능 연산자 종류 : >, <, >=, <=, <>, !=, ^=, =
-- 2) 다중행 서브쿼리 : 서브쿼리 실핼 경과가 여러 행
-- 		사용가능 연산자 종류 : IN, ANY(= SOME), ALL, EXIST
-- in : 서브쿼리 결과중 하나라도 일치한 데이터가 있다면 true 반환
-- any, some : 서브쿼리 결과가 하나 이상이면 true 반환
-- all : 서브쿼리 결과가 모두 만족하면 true 반환
-- exist : 서브쿼리 결과가 하나라도 존재하면 true 반환

--SELECT e.ENAME , (SELECT * FROM emp e2)
--FROM EMP e JOIN (SELECT )
--WHERE e.DEPTNO = (SELECT )

-- JONES의 급여보다 노ㅠ은 급여를 받는 사원 데이터 조회
SELECT
	*
FROM
	emp e
WHERE
	e.sal > (
	SELECT
		e2.sal
	FROM
		emp e2
	WHERE
		e2.ENAME = 'JONES');

-- SQL Error [1427] [21000]: ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT
	*
FROM
	emp e
WHERE
	e.sal > (
	SELECT
		e2.sal
	FROM
		emp e2
	WHERE
		e2.JOB  = 'MANAGER');

-- WARD 사원볻 빨리 입사한 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.HIREDATE < (
	SELECT
		e2.HIREDATE
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	d.DEPTNO ,
	d.DNAME ,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL >= (
	SELECT
		avg(e2.SAL)
	FROM
		EMP e2);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL IN (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL = ANY (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL = SOME (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

-- < any
-- 30번 부서의 최대급여보다 작은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ANY (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > ANY (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

-- 30번부서의 최소 급여보다 적은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ALL (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

-- 30번 부서의 최대 급여보다 많은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > ALL (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

-- 서브쿼리 결과가 하나 이상 나오면 true 반환
SELECT
	*
FROM
	EMP e
WHERE
	EXISTS (SELECT
		d.DNAME 
	FROM
		DEPT d 
	WHERE
		d.DEPTNO = 30);

-- 다중열 서브쿼리
SELECT * FROM EMP e WHERE (e.DEPTNO, e.SAL) IN (SELECT e2.DEPTNO, max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);

-- from 절 서브쿼리(=인라인 뷰)
SELECT e10.*, d.* 
FROM (SELECT * FROM EMP e WHERE e.DEPTNO  = 10) e10, (SELECT * FROM DEPT) d
WHERE e10.DEPTNO = d.DEPTNO ;

-- select 절 서브쿼리(=스칼라 서브쿼리)
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS salgrade,
	e.DEPTNO,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e;

-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보 조회
-- 정보 : 사번, 이름, 직무, 급여, 부서번호, 부서명
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	e.DEPTNO ,
	d.DNAME
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.JOB = (
	SELECT
		e2.JOB
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'ALLEN');

-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE (e.DEPTNO, e.SAL) IN (SELECT e2.DEPTNO, max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);


-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사번, 이름, 직무, 부서번호, 부서명, 부서위치 조회
SELECT e.EMPNO , e.ENAME , e.JOB , e.DEPTNO , d.DEPTNO , d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 10 AND e.JOB NOT IN (SELECT e2.JOB FROM EMP e2 WHERE e2.DEPTNO = 30);