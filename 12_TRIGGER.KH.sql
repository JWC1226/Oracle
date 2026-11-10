/*
TRIGGER 
특정 테이블의 DML(INSERT UPDATE DELETE)문에 의해 변경사항이 발생했을때 
자동으로 매번 실행할 내용을 미리 정의해두는 객체

트리거의 종류
1 실행시기에 따른 분류
BEFORE TRIGGER : 테이블의 데이터가 바뀌기전에 트리거 실행(데이터검증용)
AFTER TRIGGER : 테이블의 데이터가 바뀐후에 트리거실행(대부분 비즈니스로직 처리용)

2 영향을 받는 행에 따른 분류
문장트리거 : SQL문이 실행될때  딱 한번만 트리거실행
행 트리거 : SQL문에 의해 영향받는 행의 개수만큼 매번 트리거 실행 
=> 반드시 FOR EACH ROW 옵션을 작성해야함

가상 변수 (의사 레코드)
OLD => 변경전 데이터 (UPDATE)(수정전) DELETE(삭제) 전데이터)
NEW => 변경 후 데이터 (INSERT(추가), UPDATE(수정) 후 데이터)


*/

/*
트리거 생성
CREATE TRIGGER 트리거명
BEFORE | AFTER
INSERT | UPDATE| DELETE ON 테이블명
FOR EACH ROW 행 트리거 옵션
PL/SQL
DECLARE
BEGIN
EXCEPTION
END;
/
*/

--EMPLOYEE 테이블에 데이터가 추가된 후에 작동하는 행 트리거 생성
--XX님 환영합니다

CREATE OR REPLACE TRIGGER TRG_WELCOME
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN


    DBMS_OUTPUT.PUT_LINE(:NEW.EMP_NAME|| ' 환영합니다 ^^');
    END;
    /
    
    --트리거 동작 확인
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES(SEQ_ENO.NEXTVAL, 'DET','002500-4005000','J4',SYSDATE);
        INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES(SEQ_ENO.NEXTVAL, 'DDET','003500-4006000','J4',SYSDATE);
    
    ROLLBACK;
    
    SELECT *FROM USER_SEQUENCES;
    ------------------------------------------
    
    --상품입고 출고 관련 재고관리시스템
    
    --상품테이블
    CREATE TABLE TB_PRODUCT (
    PNO NUMBER PRIMARY KEY,
    PNAME VARCHAR2(31) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER DEFAULT 0,
    STOCK NUMBER DEFAULT 0
    );
    --상품번호 시퀀스
    CREATE SEQUENCE SEQ_PNO
    START WITH 200
    INCREMENT BY 5
    NOCACHE;
    
    --샘플데이터 추가
    INSERT INTO TB_PRODUCT (PNO,PNAME,BRAND) VALUES(SEQ_PNO.NEXTVAL,'뽕닭','하림');
    INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL,'빠삐코','롯데',1200,20);
    INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL,'토마토마','크라운',1200,10);
    
    SELECT* FROM TB_PRODUCT;
    COMMIT;
    
    CREATE TABLE TB_PDETAIL(
    DNO NUMBER PRIMARY KEY,
    PNO NUMBER REFERENCES TB_PRODUCT,
    DDATE DATE DEFAULT SYSDATE,
    AMOUNT NUMBER NOT NULL,
    DTYPE CHAR(10) CHECK(DTYPE IN ('입고','출고'))
    );
    
    CREATE SEQUENCE SEQ_DNO
    NOCACHE;
    SELECT * FROM TB_PDETAIL;
    
    ----트리거를 사용하지 않은경우---
    --205번 상품이 5개 출고
    --1) 입출고 내역에 테이블 데이터 추가
    INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205,DEFAULT, 5, '출고');
    --2) 상품 테이블의 재고수량 업데이트(수정)
    UPDATE TB_PRODUCT
    SET STOCK = STOCK -5
    WHERE PNO = 205;
    
    ---200번 상품이 10개 입고
    --1) 입출고내역 데이터 추가
    INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 200,SYSDATE,10, '입고');
    --2)상품 테이블 재고수량 업데이트
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
    WHERE PNO = 205;
    
    ROLLBACK;
    
    /*
    트리거 설계(작업내용정리)
    TB_PDETAIL(입출고내역) 테이블에 데이터가 1건 추가될때마다
    추가된 데이터의 상태에 따라 TB_PRODUCT(상품) 테이블재고수량 수정
    
    */
    
CREATE OR REPLACE TRIGGER TRG_PRODUCT
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW

BEGIN
IF :NEW.DTYPE  = '입고' THEN 
UPDATE TB_PRODUCT
SET STOCK = STOCK +:NEW.AMOUNT
WHERE PNO = :NEW.PNO;
ELSE
UPDATE TB_PRODUCT
SET STOCK = STOCK -:NEW.AMOUNT
WHERE PNO = :NEW.PNO;
END IF;
END;
/
SELECT* FROM TB_PRODUCT;

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL,205,SYSDATE,7,'출고');
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL,210,SYSDATE,15,'입고');

INSERT INTO TB_PDETAIL VALUES (
    SEQ_DNO.NEXTVAL, 
    &상품번호, 
    SYSDATE, 
    &수량, 
    '&구분_입고또는출고'
);
    