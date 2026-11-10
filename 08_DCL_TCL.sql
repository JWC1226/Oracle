/*

DCL 데이터 제어어  사용자 계정에 시스템 권한 객체 권한을 부여 회수하는 구문

시스템 권한 DB에 접근하는 권한 객체를 생성하는 권한
객체 권한   특정객체들을 조작할수 있는 권한

*/

/*
사용자 계정 생성
CREATE USER 사용자명  INDENTIFIED BY 비밀번호
사용자명 Oracle 12c 버전 이후로 C##이 앞에 붙어야함
비밀번호 대소문자를 구분

권한부여 

GRANT 권한 또는 역할 TO 사용자명

권한종류
CREATE SESSION  접속권한
CREATE TABLE 테이블 생성권한
CREATE VIEW 뷰생성권한
CREATE SEQUENCE 시퀀스 생성권한    
....



*/
---사용자 계정생성

CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;


GRANT CREATE SESSION TO C##SAMPLE;


GRANT CREATE TABLE TO  C##SAMPLE;

ALTER USER C##SAMPLE QUOTA 2M ON USERS;


--테이블생성


CREATE TABLE TEST1 (
TEST_ID NUMBER, 
TEST_NAME VARCHAR2(10) 
);

---TEST 데이터 추가

INSERT INTO TEST1 VALUES(1,'이로드');

SELECT* FROM TEST1;

COMMIT;

/*
객체 권한
종류             ///      접근권한
SELECT                    TABLE VIEW SEQUENCE  조회
INSERT                    TABLE VIEW           추가
UPDATE                    TABLE VIEW           수정
DELETE                    TABLE VIEW           삭제

권한 부여

GRANT 권한종류 ON 특정개체 TO 사용자명
예) TEST 계정 KH계정의 EMPLOYEE 테이블을 조회할수있도록  권한부여
    GRANT SELECT ON KH.EMPLOYEE TO TEST;
    
    GRANT SELECT ON C##KH.EMPLOYEE TO C##TEST;



*/


/*
권한회수
REVOKE 회수할 권한  FROM 사용자명; 시스템권한
REVOKE 종류 ON 객체정보 FROM 사용자명;
예) TEST 계정에 부여했던 KH계정 EMPLOYEE 테이블 조회 권한 회수
REVOKE SELECT ON C##KH.EMPLOYEE FROM C##TEST;

*/
------------------------------------------------------
/*
역할 ROLE 규칙 :특정 권한들을 하나의 집합으로 모아놓은것

-CONNECT : 접소권한 CREATE SESSION
-RESOURCE : 자원(객체) 관리 특정관리객체 생성권한 (CREATE TABLE, CREATE SEQUENCE...)



*/
--역할 조회
SELECT* FROM ROLE_SYS_PRIVS
WHERE ROLE IN('CONNECT','RESOURCE');

-------------------------------------------
/*
TCL (TRANSACTION CONTROL LANGUAGE ) 트렌잭션 제어어
트랜잭션 : 데이터베이스 논리적 연산단위
          데이터의 변경사항(DML사용시)을 하나의 묶음처럼 트랜잭션에 모아둠
          COMMIT 사용하기전까지 변경사항들을 하나의 트랜잭션으로 담게됨
          -> 트랜잭션에 추가되는 SQL(DML)  INSERT/UPDATE/DELETE/
            
            종류
            COMMIT (적용) :트랜잭션에 담겨있는 변경사항을 실제 DB에 적용하겠다
            ROLLBACK(취소):트랜잭션에 담겨있는 변경사항 삭제(취소)하겠다
                          마지막 COMMIT 시점위치로 돌아간다
            SAVEPOINT 포인트 시점저장 : 현재 시점에 변경사항들을 임시로 저장해두는것을 의미한다
                                      ROLLBACK시 시점이름을 같이 입력하면 전체 변경사항을 모두 삭제하지않고 해당위치까지만 삭제한다
                                      = ROLLBACK TO 포인트명
                                      
                            

*/


/*
KH계정으로 접속

테이블 복제 : EMPLOYEE DEPARTMENT 테이블에서 EMP_ID, EMP_NAME, DEPT_TITLE 조회한 결과를 EMP_01테이블에 복제

*/
--DQL
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

DROP TABLE EMP_01;

--DDL
CREATE TABLE EMP_01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);

SELECT * FROM EMP_01;


-- 직원번호가 217, 214인직원삭제

DELETE EMP_01 WHERE EMP_ID IN('217','214');

ROLLBACK;

DELETE EMP_01 WHERE EMP_ID = '217';
DELETE EMP_01 WHERE EMP_ID = '214';

COMMIT;

ROLLBACK;

DELETE FROM EMP_01 WHERE EMP_ID IN ('208','209','210');
SELECT * FROM EMP_01 ORDER BY EMP_ID;

SAVEPOINT SP; --임시저장

INSERT INTO EMP_01 VALUES('500','무지개','인사관리부');

DELETE FROM EMP_01 WHERE EMP_ID = '215';

ROLLBACK TO SP;

COMMIT;

-------------------------------------


--212번 직원 삭제

DELETE FROM EMP01 WHERE EMP_ID = '212';

CREATE TABLE TEST (
TID NUMBER
); --DDL을 사용하게되면  기준 트랜잭션에 저장된것이 무조건 반영 그러기에 사용하기전 트랜잭션 확실히 처리


