/*
시퀀스
자동으로 번호를 발생시켜주는 객체
점수를 순차적으로 일정한 값마다 증가시키면서 생성
EX) 사원번호 회원번호 도서번호.... -> 중복되면 안되는 기본키 PRIMARY KEY 컬럼에 주로 사용

*/
--시퀀스 생성
--DDL 사용 CREATE SEQUENCE 시퀀스명
-- [START WITH 시작번호] -- 처음발생시킬 시작값 지정 생략시 기본값 1
--INCREMENT BY 증가값 --얼마만큼식 증가시킬것인지에 대한 값 지정
-- MAXVALUE 최댓값 -- 최댓값 (생략시 엄청큰수)
--MINVALUE -- 최솟값 생략시 기본값 1
-- CYCLE , NOCYCLE 값의 순환여부 기본 NOCYCLE 
--CYCLE 최대값에 도달하면 최소값부터 다시시작 NOCYCLE 최대값 도달시 더이상 증가하지 않고 오류발생
--NOCACHE, CACHE  --- 캐시메모리 할당여부 (기본값 CACHE 20)
--CACHE 번호를 미리 메모리에  '숫자'만큼 만들어둠
--주의 컴퓨터가 꺼지면 메모리에 있던 번호가 날라가 건너뛰는 현상 발생
--NOCACHE 필요할때마다  그때그때 번호를 생성
--참고 이름 규치 관례 
--테이블 TB_XXX 뷰 VW_XX 시퀀스 SEQ_XX 트리거 TRG_XXX


--기본값으로 시퀀스를 생성 : SEQ_TEST

CREATE SEQUENCE SEQ_TEST;

SELECT* FROM USER_SEQUENCES;

--SEQ EMPNO 시퀀스 생성
-- 시작번호 300 증가값 5 최대값 310 순환X 캐시메모리 X
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
    INCREMENT BY 5
    MAXVALUE 310
    NOCYCLE
    NOCACHE;

/*
시퀀스 사용 
시퀀스명.NEXTVAL : 다음 시퀀스 값가져오기(호출할때마다 증가)
시퀀스명.CURRVAL :현재 시퀀스값 확인(마지막으로 성공한 NEXTVAL의 결과값)


*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
---NEXTVAL을 한번도 사용하지않고 실행시 오류발생

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

/*
시퀀스 변경
ALTER SEQUENCE 시퀀스명
INCREMENT BY 증가값
    MAXVALUE 최대값
    MINVALUE 최솟값
    NOCYCLE CYCLE
    NOCACHE CACHE
=>START WITH (시작값) 시작값변경 불가
 변경하고자하면 제거후 다시 생성
 
 ALTER SEQUENCE SEQ_EMPNO
 
*/
 ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

--시퀀스 삭제
--DROP SEQUENCE 시퀀스명

DROP SEQUENCE SEQ_EMPNO;


--직원번호용 300시작 1씩증가  캐시사용안함
CREATE SEQUENCE SEQ_ENO
START WITH 300
INCREMENT BY 1
NOCACHE;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_ENO.NEXTVAL,'박이미','882222-1555555','J6',SYSDATE);

SELECT * FROM EMPLOYEE;




