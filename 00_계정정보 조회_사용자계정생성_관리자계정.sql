SELECT * FROM DBA_USERS;

--명령문 실행; 상단의 재생 버튼 또는 CTRL +ENTER


--사용자 계정 추가 생성

--C##KH/KH 계정 새성
CREATE USER C##KH IDENTIFIED BY KH;

-- 사용자 계정 생성 후 권한 부여(최소한의 권한 : 접속 데이터관리

GRANT CONNECT, RESOURCE TO C##KH;

--CONNECT 연결권한

--RESOURCE DB에서 객체 생성권한

--테이블 스페이스 설정
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;