/*
    DCL (DATA CONTROL LANGUAGE, 데이터 제어어)
    : 사용시 계정에 시스템 권한/객체 권한을 부여(GRANT)하거나, 회수(REMOVE)하는 구문
    
    - 시스템 권한: 
    - 객체 권한: 특정 객체들을 조작할 수 있는 권한
-- =============================================================================
    -- 사용자 계정 생성
    CREATE USER 사용자명 IDENTIFIED BY 비밀번호;
        - 사용자명: Oracle 12c 버전 이후로 C##이 앞에 붙어야 한다 !
        - 비밀번호: 대소문자를 구분하므로 잘 작성해주어야 한다 !
        
    -- 권한 부여
    GRANT 권한 또는 역할 TO 사용자명;
        -- 권한 종류
        + CREATE SESSION  : 접속 권한
        + CRETAE TABLE    : 테이블 생성 권한
        + CREATE VIEW     : 뷰 생성 권한
        + CREATE SEQUENCE : 시퀀스 생성 권한
*/
    -- 사용자 계정 생성: SAMPLE / SAMPLE
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- ⇒ 현재 계정(KH)은 사용자 생성 권한이 없으므로, 관리자 계정으로 생성해야 한다!
-- ⇒ 접속 시도시 권한이 부여되어 있지 않아, CREATE SESSION 권한이 없다고 오류 발생 !
-- ⇒ SAMPLE 계정에 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- ⇒ 접속 성공 후, 테이블을 생성하려고 했으나, 권한이 불충분하여 실패 (오류 발생!)
    -- ⇒ SAMPLE 계정에 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO C##SAMPLE;

-- ⇒ 테이블 생성 후, 데이터를 추가하려고 했으나 테이블 스페이스 관련 권한이 없다고 실패
    -- ⇒ SAMPLE 계정에 테이블 스페이스 할당
ALTER USER C##SAMPLE QUOTA 2M ON USERS;  -- ⇒ 2M 정도 테이블 스페이스 공간을 할당
-- =============================================================================
/*
    객체 권한
    종류         | 접근 객체
-- =============================================================================
   SELECT       | TABLE, VIEW, SEQUENCE         -- 조회
   INSERT       | TABLE, VIEW                   -- 추가
   UPDATE       | TABLE, VIEW                   -- 수정
   DELETE       | TABLE, VIEW                   -- 삭제
-- =============================================================================

    -- 권한 부여
    GRANT 권한 종류 ON 특정 객체 TO 사용자명;
    Ex. TEST 계정에 KH계정의 EMPLOYEE 테이블을 조회할 수 있도록 권한 부여
        GRANT SELECT ON KH.EMPLOYEE TO TEST;        -- Oracle 12c 이전 버전
        
        GRANT SELECT ON C##KH.EMPLOYEE TO C##TEST;  -- 현재 사용되는 버전
        
    -- 권한 회수
    REVOKE 회수할_권한 FROM 사용자명;        -- 시스템 권한
    REVOKE 종류 ON 객체정보 FROM 사용자명;    -- 객체 접근 권한
    
    Ex. TEST 계정에 부여했던 KH 계정의 EMPLOYEE 테이블 조회 권한 회수
        REVOKE SELECT ON C##KH.EMPLOYEE FROM C##TEST;
-- =============================================================================
    -- 역할(ROLE, 규칙): 특정 권한들을 하나의 집합으로 모아놓은 것
        CONTACT  : 접촉 권한 (CREATE SESSION)
        RESOURCE : 자원(객체) 관리, 특정 객체 생성 권한
                   (CREATE TABLE, CREATE SEQUENCE, ...)
*/
    -- 역할 조회
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');
-- =============================================================================
/*
    TCL (TRANSACTION CONTROL LANGUAGE, 트랜잭션 제어어)
    -- 트랜잭션: 데이터베이스의 논리적 연산 단위
                데이터의 변경사항(DML 사용시)을 하나의 묶음처럼 트랜잭션에 모아둔다
                COMMIT 사용하기 전까지의 변경사항들을 하나의 트랜잭션으로 담게된다
                ⇒ 트랜잭션에 추가되는 SQL: INSERT / UPDATE / DELETE
                
    -- 종류
        - COMMIT (적용)   : 트랜잭션에 담겨져있는 변경사항들을 실제 DB에 적용
        - ROLLBACK (취소) : 트랜잭션에 담겨져있는 변경사항들을 삭제(취소)
                            마지막 COMMIT 시점(위치)로 돌아간다
        - SAVEPOINT 포인트명(시점 저장)
                    : 현재 시점의 변경사항들을 임시 저장하는 것을 의미
                        ROLLBACK시, 시점이름을 같이 입력하면, 전체 변경 사항을 모두 삭제하지 않고,
                        해당 위치까지만 삭제한다. ⇒ ROLBACK TO 포인트명
*/
-- 실습용 KH 계정으로 접속
    -- 테이블 복제: EMPLOYEE, DEPARTMENT 테이블에서 EMP_ID, EMP_NAME, DEPT_TITLE
    --              조회한 결과를 EMP01 테이블에 복제
    
    -- 데이터 조회 (DQL)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

    -- 테이블 삭제, 생성 (DDL)
DROP TABLE EMP01;       -- 테이블 삭제
CREATE TABLE EMP01      -- 테이블 복제 (생성)
AS (
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
);
SELECT * FROM EMP01;

    -- 직원 번호가 217, 214 인 직원 정보 삭제
DELETE FROM EMP01 WHERE EMP_ID IN ('217', '214');   -- ⇒ 트랜잭션 시작 ...
ROLLBACK;       -- ⇒ 변경사항 취소 (삭제 이전으로 복구), 트랜잭션 종료(삭제)
-- =============================================================================
DELETE FROM EMP01 WHERE EMP_ID = '217';
DELETE FROM EMP01 WHERE EMP_ID = '214';
COMMIT;         -- ⇒ 변경사항 적용 (디스크에 반영, 트랜잭션 종료)
-- =============================================================================
ROLLBACK;       -- ⇒ 변경사항 취소 (마지막 COMMIT 시점으로 복구 - 순서상 의미없음
-- =============================================================================
DELETE FROM EMP01 WHERE EMP_ID IN ('208', '209', '210');
SELECT * FROM EMP01 ORDER BY EMP_ID;

SAVEPOINT SP;   -- ⇒ 임시저장. SP라는 이름으로 시점을 저장
INSERT INTO EMP01 VALUES ('500', '무지개', '인사관리부');
DELETE FROM EMP01 WHERE EMP_ID = '215';
ROLLBACK TO SP; -- ⇒ SP 저장 위치까지만 작업을 취소 (복구)
COMMIT;         -- ⇒ SAVEPOINT 위치로 롤백했기 때문에, DELETE 208, 209, 210 변경사항만 DB에 적용
-- =============================================================================
    -- 212번 직원 삭제
DELETE FROM EMP01 WHERE EMP_ID = '212';
CREATE TABLE TEST (
    TID NUMBER
);

ROLLBACK;
SELECT * FROM EMP01 WHERE EMP_ID = 212;
    -- ⇒ DDL(CREATE, ALTER , DROP)을 사용하게 되면 기존 트랜잭션에 지정된 변경사항들은 무조건 반영된다 (COMMIT)
    -- ⇒ DDL을 사용하기 전에는 DML(INSERT, UPDATEM DELETE)로 작성된 쿼리문이 있다면
    -- ⇒ 확실하게 트랜잭션 처리(COMMIT, ROLLBACK)한 후에 DDL을 실행해야한다 ~!