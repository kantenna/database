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