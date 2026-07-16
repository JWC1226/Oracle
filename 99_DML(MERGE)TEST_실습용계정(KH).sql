    -- DML 중 MERGE 는 과연 트랜잭션 처리가 필요한지 확인
    -- 테이블 복제
    DROP TABLE TB_TEST;
    CREATE TABLE TB_TEST
    AS SELECT * FROM EMPLOYEE;
    
    DROP TABLE TB_EMP;
    CREATE TABLE TB_EMP
    AS SELECT * FROM EMPLOYEE;
    
    INSERT INTO TB_EMP(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SALARY)
                VALUES (500, '테스트', '060714-3000000', 'J2', 2000000);
                
    COMMIT;
    SELECT COMMIT(*) FROM TB_TEST;
    SELECT COMMIT(*) FROM TB_EMP;
    
    MERGE INTO TB_TEST T
    USING TB_EMP E
    ON (T.EMP_ID = E.EMP_ID)
    WHEN MACHED THEN
        UPDATE SET T.SALARY = E.SALARY,
                T. BONUS = E.BONUS
    WHEN NOT MACHED THEN 
        INSERT (T.EMP_ID, T.EMP_NO, T.EMP_NAME, T.JOB_CODE, T.SALARY)
        VALUES (E.EMP_ID, E.EMP_NO, E.EMP_NAME, E.JOB_CODE, E.SALARY);
    
    ROLLBACK;
    -- ⇒ MERGE 명령어도 트랜잭션 처리가 필요하다