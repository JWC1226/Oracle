/*
[1] SELECT: 데이터를 조회(추출)
Ex. SELECT 조회하고자 하는 정보 (컬럼)
Ex. FROM 테이블명;
*/

-- EMPLOYEE: 직원 테이블
-- Ex1. 모든 직원의 정보를 조회
SELECT * 
FROM EMPLOYEE;

-- Ex2. 직급 테이블 / 모든 직급 정보를 조회
SELECT * 
FROM JOB;

-- DEPARTMENT: 부서 테이블
-- Ex3. 모든 부서 정보를 조회
SELECT *
FROM DEPARTMENT;

-- Ex4. 모든 직원의 이름, 주민번호, 연락처를 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;
-- SELECT 하나만으로는 실행이 되지 않으므로, FROM까지는 작성해야 정상 작동이 이루어진다

-- Ex5. 모든 직원의 이름, 이메일, 연락처, 입사일, 급여 정보를 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;