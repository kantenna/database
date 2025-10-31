-- department(학과)
-- 학과코드(dept_id), 학과명(dept_name)
-- 'A001', '데이터사이언스'
CREATE TABLE department(
	dept_id VARCHAR2(4) PRIMARY KEY,
	dept_name VARCHAR2(50) NOT NULL
	);

-- student(학생)
-- 학번(student_id), 이름(name),키(height null 허용), 학과코드(학과 테이블 참조)
-- '20250001', '홍길동', '163.5'
CREATE TABLE student(
	student_id CHAR(8) PRIMARY KEY,
	name VARCHAR2(20) NOT NULL,
	height NUMBER(5,2),
	dept_id VARCHAR2(4) CONSTRAINT fk_student_department REFERENCES department(dept_id)
	);

-- professor(교수)
-- 교수코드(prof_id), 교수명(prof_name), 학과코드(학과 테이블 참조)
-- 'P001', '김유진'
CREATE TABLE professor(
	prof_id CHAR(4) PRIMARY KEY,
	prof_name VARCHAR2(50) NOT NULL,
	dept_id VARCHAR2(4) CONSTRAINT fk_professor_department REFERENCES department(dept_id)
	);

-- subject(수강과목)
-- 과목코드(subj_id), 교수코드(교수 테이블 참조), 시작일(start_date, 종료일(end_date), 과목명(subj_name)
-- 'S001', '2025-03-01', '2025-06-30', '파이썬'
CREATE TABLE subject(
	subj_id CHAR(8) PRIMARY KEY,
	prof_id CHAR(4) CONSTRAINT fk_subject_professor REFERENCES professor(prof_id),
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	subj_name VARCHAR2(100) NOT NULL
	);

-- enrollment(수강)
-- 수강코드(enroll_id), 학생코드(학생 테이블 참조), 과목코드(과목 테이블 참조), 수강일자(enroll_date)
-- 1(자동증가), '2025-06-30'
CREATE SEQUENCE enroll_seq;

CREATE TABLE enrollment(
	enroll_id NUMBER(8) PRIMARY KEY,
	student_id CHAR(8) CONSTRAINT fk_enrollment_student REFERENCES student(student_id),
	subj_id CHAR(8) CONSTRAINT fk_enrollment_subject REFERENCES subject(subj_id),
	enroll_date DATE NOT NULL
	);



INSERT INTO DEPARTMENT values('A001', '데이터사이언스');
INSERT INTO DEPARTMENT values('A002', '경영학과');

INSERT INTO STUDENT(student_id, name, height, dept_id) values('20250001', '홍길동', 163.5, 'A002');
INSERT INTO STUDENT(student_id, name, dept_id) values('20250002', '성춘향', 'A001');

INSERT INTO PROFESSOR(prof_id, prof_name, dept_id) values('P001', '김유진','A001');

INSERT INTO SUBJECT values('S001', 'P001','2025-03-01', '2025-06-30', '파이썬');

INSERT INTO ENROLLMENT values(enroll_seq.nextval, '20250001', 'S001',sysdate);








