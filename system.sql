-- c##을 사용하지 않도록 섥정
-- 오라클 버전이 업데이트되면서 사용자 아이디 앞에 c##을 붙이도록 설정되어있음
-- hr 사용자 생성 => c##hr
ALTER SESSION SET "_oracle_script"=TRUE;

--@C:\Users\soldesk\Downloads\db-sample-schemas-main\db-sample-schemas-main\human_resources\hr_install.SQL
--@C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.sql
-- sys as sysdba

-- 권한부여 : GRANT
GRANT CREATE VIEW TO SCOTT;

GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;


-- 사용자
-- 데이터베이스에 접속하여 데이터 관리하는 계정

-- 오라클 데이터베이스
-- 테이블, 뷰, 인덱스, 시퀀스... => 업무별 사용자 생성 후 객체 생성 할 수있는 권한 부여

-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;

-- SQL Error [65096] [99999]: ORA-65096: 공통 사용자 또는 롤 이름이 부적합합니다. => C## 접두어 필요
CREATE USER TEST1 IDENTIFIED BY 12345; 
CREATE USER C##TEST1 IDENTIFIED BY 12345; 

CREATE USER TEST2 IDENTIFIED BY 12345; 

-- 사용자 TEST2는 CREATE SESSION 권한을 가지고 있지 않음; 로그온이 거절되었습니다
GRANT CREATE SESSION TO TEST2;

-- 개별 권한 묶어서 관리 => 롤
GRANT CONNECT, RESOURCE TO TEST2;

-- 테이블스페이스 'USERS'에 대한 권한이 없습니다.
-- ALTER USER TEST2 DEFAULT TABLESPACE USERS QUOTA 2M IN USERS;


-- 사용자 생성 --------------------------
-- 아이디 대소문자 구별안함 / 비밀번호만 구별함 --
ALTER SESSION SET "_oracle_script"=TRUE;

CREATE USER TEST3 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO TEST3;
-------------------------------------

--사용자 삭제
-- SQL Error [1922] [42000]: ORA-01922: 'TEST2'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
DROP USER test2 CASCADE;
DROP USER test3 CASCADE;

-- 권한 취소
--REVOKE 취소할권한이름 FROM 사용자명
REVOKE CREATE SESSION FROM test2;

-- 비밀번호 변경
-- ALTER USER test3 IDENTIFIED BY 변경할 비밀번호;