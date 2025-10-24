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