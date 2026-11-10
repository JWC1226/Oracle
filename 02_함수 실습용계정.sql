/*
함수 (FUNTCION) :전달된 값을(컬럼값)을 실행한 결과를 반환
단일행 함수 N개의 값을 읽어서 N개의 결과값으로 반환
행마다 함수의 결과를 반환
그룹함수 N개의 값을 읽어서 1개의 결과값으로 반환
그룹을 지어 그룹별로 함수의 결과를 반환

함수식을 사용할 수 있는 위치 : SELECT절 WHERE절 ORDER BY절 GROUP BY절 HAVING절
SELECT 절에 단일행 함수와 그룹 함수를 함께 사용할수 없음
*/

--단일 행 함수

-- 문자타입의 데이터 처리 함수
-- 문자타입 : CHAR, VARCHAR2
--LENGTH(값) :값의 길이를 반환
--LENGTHB : 값의 BYTE수를 반환
--영문자 숫자 특수문자 글자당 1BYTE 한글은 3BYTE
--오라클 이라는 단어의 글자수와 바이트 수를 확인

SELECT LENGTH('오라클') 글자수, LENGTHB('오라클') 바이트수
FROM DUAL;

SELECT LENGTH('ORACLE') 글자수, LENGTHB('ORACLE') 바이트수
FROM DUAL;

--직원명 글자수 바이트수]
-- 이메일의 글자수 바이트 수

SELECT EMP_NAME, LENGTH(EMP_NAME)"직원명글자수", LENGTHB(EMP_NAME)"직원명바이트수", EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;


/*
INSTR 문자열로부터  특정 문자의 시작위치를 반환

INSTR(문자열 특정문자[,찾을위치의 시작값,순번]) = > 결과는 숫자 타입


*/

SELECT INSTR('AABAACAABBAA','B') FROM DUAL; --앞에서 부터 첫번째 B위치 3
SELECT INSTR('AABAACAABBAA','B','1') FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; 찾을위치를 음수로 지정하면 뒤에서부터 찾는다
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL;

---직원 정보 중 이메일의 _첫번째 위치 @ 첫번째위치 조회
SELECT EMAIL, INSTR(EMAIL,'_',1,1)"언더바의위치", INSTR(EMAIL,'@')"@의 위치"
FROM EMPLOYEE;

-------------------

/*
SUBSTR : 문자열에서 특정 문자열을 추출하여 반환 => 결과는 문자타입

SUBSTR(문자열, 시작위치[,길이]
=> 길이를 지정하지않으면 문자열 끝까지


*/
SELECT SUBSTR('ORACLE SQL DEVELOPER',10) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER',8,3) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER',-8) FROM DUAL;

--직원 이름 주민번호
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE;

---여직원 정보만 조회 남직원 조회
SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE  SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE  SUBSTR(EMP_NO,8,1) IN('1','3')
ORDER BY EMP_NO ASC;

---직원 정보를 조회 이름 이메일 아이디
함수를 중첩
SELECT EMP_NAME, EMAIL INSTR(EMAIL,'@')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) "ID"
FROM EMPLOYEE;

/*
LPAD / RPAD 문자열을 조회할때 통일감있게 조회하고자 할때 사용
            문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종길이만큼 문자열을 반환
            => 결과는 문자 타입
    LAPD(문자열,최종길이[,덧붙일문자]) => 왼쪽에 덧붙일 문자를 채움
    RPAD(문자열 최종길이[,덧붙일문자]) => 오른쪽에 덧붙일 문자를 채움
    => 덧붙일 문자가 생략될 경우 공백으로 채움

*/
SELECT EMP_NAME, LPAD(EMP_NAME,20)
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMP_NAME,20)
FROM EMPLOYEE;

SELECT EMAIL, LPAD(EMAIL,20)"이메일"
FROM EMPLOYEE;

---주민번호 뒷자리르 숨겨서 조회

SELECT RPAD('050706-3', 14,'*') 
FROM DUAL;

SELECT EMP_NAME,SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*')"주민번호"
FROM EMPLOYEE;

/*
LTRIM/RTRIM 문자열에서 특정 문자를 제거한후 나머지를 반환
LTRIM(문자열[,제거하고자하는 문자들)=> 왼쪽에서 제거
RTRIM 오른쪽에서 제거
=>제거할문자 생략시 공백을 제거함

*/

SELECT LTRIM('    H I') FROM DUAL;
SELECT RTRIM('    H I     ') FROM DUAL;
SELECT LTRIM('123123HI123','123') FROM DUAL;

/*
TRIM 문자열 앞뒤 양쪽에 지정한 문자를 제거한후 반환
결과는 문자타입
TRIM([LEADING TRALLING BOTH] [제거할문자 FROM] 문자열)
=>제거할 문자 생략시 공백제거
=> 위치 옵션 생갹시 양쪽에서 제거

*/

SELECT TRIM('  H I  ')FROM DUAL;   
SELECT TRIM('L'FROM 'LLLLLHLLLLLLL')FROM DUAL;   
SELECT TRIM(LEADING'L'FROM 'LLLLLHLLLLLLL')FROM DUAL;   
SELECT TRIM(TRAILING'L'FROM 'LLLLLHLLLLLLL')FROM DUAL;   
SELECT TRIM(BOTH'L'FROM 'LLLLLHLLLLLLL')FROM DUAL;   


/*
LOWER UPPER INITCAP

LOWER(문자열) 알파벳을 소문자로 변환
UPPER(문자열) 알파벨을 대문자로 변환
INITCAP (문자열) 공백을 기준으로  첫 글자마다 대문자로 변경

*/

--NO pain no gain

SELECT LOWER('NO pain no gain') FROM DUAL;
SELECT UPPER('NO pain no gain') FROM DUAL;
SELECT INITCAP('NO pain no gain') FROM DUAL;
/*
CONCAT 문자열 두 개를 하나의 문자열로 합쳐서 반환
CONCAT(문자열1, 문자열2)

*/
SELECT 'KH' || '  C 강의장' FROM DUAL;

SELECT CONCAT('KH', ' C강의장')FROM DUAL;

SELECT CONCAT('2층', CONCAT('KH', '  C 강의장')) FROM DUAL;

SELECT CONCAT (EMP_NAME,EMP_ID) 

FROM EMPLOYEE;

----------------

/*
REPLACE 문자열에서 특정 부분을  다른값으로 교체하여 반환
REPLACE(문자열 특정부분(문자열) 교체할값(문자열)
*/
SELECT REPLACE('서울시 강남구 역삼동','역삼동','삼성동') FROM DUAL;

---직원들의 이멜에서 '@kh.or.kr부분을 @gmail.com으로 변경조회
SELECT EMAIL, REPLACE(EMAIL,'@kh.or.kr','@gamail.com')
FROM EMPLOYEE;

--===================================


/*
숫자타입의 데이터 처리 함수

ABS 숫자의 절대값을 반환

ABS(숫자)


*/
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-12.34) FROM DUAL;

/*
*MOD : 두수를 나눈 나머지 값을 구해주는 함수

MOD(수자1, 숫자2 --> 숫자 1 % 숫자2)



*/

SELECT MOD(10,3) FROM DUAL;

SELECT MOD(10.9,3) FROM DUAL;

/*
ROUND :반올림한 값을 반환

ROUND(숫자[, 위치])
위치 생략시 소수점 첫째자리에서 반올림
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456,2) FROM DUAL;

SELECT ROUND(123.456,-2) FROM DUAL;

/*
CEIL 올림처리

CEIL(숫자)


*/
SELECT CEIL(123.456) FROM DUAL;

/*
FLOOR 버림 처리

*/
SELECT FLOOR(123.456) FROM DUAL;

/*
TRUNC 버림처리 위치지정
TRUNC (숫자[,위치]
*/
SELECT TRUNC (123.456,1) FROM DUAL;

/*
날짜 타입의 데이터 처리 함수
*/

SELECT SYSDATE FROM DUAL; ---시스템 기준 현재 날짜 시간 정보
/*
MONTHS_BETWEEN 두 날짜의 개월 수 반환

MONTHS_BETWEEN(날짜1, 날짜2) : 날짜1 - 날짜2 개월수)
*/
/*
직원의 근속개월수
*/
SELECT EMP_NAME, HIRE_DATE, CEIL MONTHS_BETWEEN(SYSDATE,HIRE_DATE))"근속 개월 수"
FROM EMPLOYEE;

----공부한지 몇개월차
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '26/6/11')) FROM DUAL;
--수료까지 몇개월? '26/12/16'

SELECT FLOOR(MONTHS_BETWEEN('26/12/16', SYSDATE)) FROM DUAL;

------------

/*
ADD_MONTHS : 특정 날짜의 N개월 수를 더해서 반환

ADD_MONTHS(날짜, 더할개월수)
*/
--현재 날짜로 3개월뒤

SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;

---직원들의 수습 종료일 조회 (이름 입사일 입사일+3)
SELECT EMP_NAME, HIRE_DATE,ADD_MONTHS(HIRE_DATE,3)"수습종료일"
FROM EMPLOYEE;

/*
NEXT_DAY : 특정 날짜 이후 지정 요일의 가장 가까운 날짜를 반환

NEXT_DAY(날짜,요일)
=> 요일 문자 또는 숫자
1 일 2 월 3 화 4 수 5 목 6금 7토

*/
---현재 날짜 기준으로 가장 가까운 금요일의 날짜조회

SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;



SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;


ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;

-------------------------


/*
LAST_DAY 해당월의 마지막 날짜를 구해주는 함수

LAST_DAY(날짜)

*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

---- 직원 정보 조회 이름 입사일 입사한달의 마직막 날짜 입사한달의 근무일수

SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)"입사한달의 마지막 날짜",LAST_DAY(HIRE_DATE)- HIRE_DATE +1 "근무일수"
FROM EMPLOYEE;


-
/*
EXTRACT 특정 날짜로부터 연도월일 값을 추출해서 반환

EXTRACT(YEAR FROM 날짜) 연도 추출

EXTRACT(MONTH FROM 날짜) 월추출

EXTRACT (DAY FROM 날짜) 일 추출


*/
SELECT EXTRACT(YEAR FROM SYSDATE)"연도"
, EXTRACT(MONTH FROM SYSDATE)
,EXTRACT(DAY FROM SYSDATE)

FROM DUAL;

-- 직원 정보 조회 이름 입사년도 입사월 입사일 정렬 오름차순 입사년도>입사월

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)"입사년도"
, EXTRACT(MONTH FROM HIRE_DATE)
,CEIL(EXTRACT(DAY FROM HIRE_DATE))"입사일"
FROM EMPLOYEE
ORDER BY EXTRACT(YEAR FROM HIRE_DATE),EXTRACT(MONTH FROM HIRE_DATE),EXTRACT(DAY FROM HIRE_DATE); 

/*
형변환 함수
문자 숫자 날짜

TO_CHAR :숫자 또는 날짜 타입 값을 문자타입으로 반환하는 함수

TO_CHAR[데이터(,포맷)]

숫자 --> 문자

*/
SELECT 1234 "숫자 타입", TO_CHAR(1234)"문자 타입 데이터" FROM DUAL;

SELECT TO_CHAR(1234), TO_CHAR(1234,'999999') FROM DUAL;

--'9'만큼 개수만큼 자릿수를 확보 빈칸은 공백으로 채움

SELECT TO_CHAR(1234), TO_CHAR(1234,('000000') FROM DUAL;
--->'0' 개수만큼 자릿수를  확복 빈칸은 0으로 채움

SELECT TO_CHAR(1234,'L999999') FROM DUAL;
--L은 화폐단위

--직원정보 조회(이름  급여 연봉) 화폐단위 표시

SELECT EMP_NAME, TO_CHAR(SALARY,'L9,999,999,999') 급여, TO_CHAR(SALARY*12,'L9,999,999,999') 연봉
FROM EMPLOYEE;
--날짜 ---> 문짜

SELECT SYSDATE, TO_CHAR(SYSDATE) FROM DUAL;

/*
YYYY : 연도 네글자
YY : 연도 두글자

MM : 월
DD : 일

HH : 시정보
HH24 ---24시간제

MI 분
SS : 초 
*/
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

/*
DAY 요일정보 X일
DY 요일정보 X
*/
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY DY') FROM DUAL;

/*
MONTH MON 월정보

*/
SELECT TO_CHAR(SYSDATE, 'MONTH MON') FROM DUAL;

--직원정보 조회 이름 입사일 (입사일 몇년 몇월 몇일)

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')
FROM EMPLOYEE;


/*
TO_NUMBER : 문자타입을 숫자로 변환
T0_NUMBER(데이터[,포맷]) 포맷을 지정하는 경우는 기호가 포함되거나 화폐단위가 포함된경우
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '10000'+'500' FROM DUAL;
SELECT '10,000'+'500' FROM DUAL;--오류발생
SELECT TO_NUMBER('10,000','999,999,999')+ TO_NUMBER('500','999,999') FROM DUAL;

/*
TO_DATE 숫자타입 또는 문자 타입을 날짜 타입으로 변환
TO_DATE(데이터)

*/
SELECT TO_DATE(20260706) FROM DUAL;

SELECT TO_DATE(260706) FROM DUAL;

SELECT TO_DATE(960706) FROM DUAL;

--현재 연도 기준으로  50년 미만은 자동으로  50년 미만 데이터는 20XX변환
--50년이상은 19XX으로 변환
SELECT TO_DATE('060706') FROM DUAL;

SELECT TO_DATE('260706 143940', 'YYMMDD HH24MISS') FROM DUAL;
SELECT TO_DATE('260706', 'YYMMDD') FROM DUAL;
/*
NULL 처리 함수
NVL(컬럼명 대체할값)
대체할값 해당값이 NULL인경우 사용

*/

SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, (SALARY+(SALARY*NVL(BONUS,0)))*12
FROM EMPLOYEE;

--NVL2 : 해당컬럼이 NULL일경우  표시할값을 지정 아닐경우 표시할값도 지정
--NVL2(컬럼명,NULL일경우,NULL이아닐경우)

SELECT EMP_NAME, BONUS, NVL2(BONUS,'0','X') FROM EMPLOYEE;
--이름 부서코드 부서배치여부

SELECT EMP_NAME,DEPT_CODE, NVL2(DEPT_CODE,'배정완료','미배정') "부서배치여부"
FROM EMPLOYEE;

/*
NULLIF :두값이 일치하면 NULL, 일치하지 않으면 비교대상 1값을 반환
NULLIF(비교대상1, 비교대상2)

*/
SELECT NULLIF('999','999') FROM DUAL;
SELECT NULLIF('999','777') FROM DUAL;


/*
DECODE(비교대상, 비교값1, 결과값1, 비교값2, 결과값2 ....
비교대상 컬럼 연산식 함수식
자바에서  SWITCH와 유사
SWITCH (비교대상) {
CASE 비교값 1;:
결과값1
break;


*/

SELECT EMP_NAME, EMP_ID, EMP_NO, SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_ID, EMP_NO, DECODE (SUBSTR(EMP_NO,8,1),'1','남','2','여')
FROM EMPLOYEE;

/*
직급이 J7이면 10퍼 J6이면 15퍼 J5 20퍼 그외는 5퍼 인상
*/

SELECT EMP_NAME, SALARY, DECODE(JOB_CODE, 'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2, SALARY*1.05)
FROM EMPLOYEE;

/*
CASE WHEN THEN : 조건식에 따라 결과값을 반환하는 구문(함수)
CASE
WHEN  조건식1 THEN 결과값 1
WHEN 조건식 2 THEN 결과값 2
..
ELSE 결과값
END
*/
--이름 급여 급여에따른 등급 조회

500만원이상 고급
350만원이상 중급
그외 초급
*/

SELECT EMP_NAME, SALARY
,CASE WHEN SALARY >= 5000000 THEN '고급'
WHEN SALARY >= 3500000 THEN '중급'
ELSE '초급'
END "급여에 따른 등급"
FROM EMPLOYEE;

---


/*
그룹 함수

SUM: 해당컬럼값들의 합
SUM(데이터)
=>데이터 숫자 타입

*/
--전체 직원들의 총급여
SELECT SUM(SALARY)"총급여"
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY),'L999,999,999')"총급여"
FROM EMPLOYEE;

SELECT SUM(SALARY)"총급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1','3');

SELECT SUM(SALARY)"총급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
AVG .해당값들의 평균 반환

AVG(데이터)
데이터는 숫자타입
*/

SELECT ROUND(AVG(SALARY)) "평균급여"
FROM EMPLOYEE;

/*
MIN/MAX 가장작은값 가장큰값
MIN/ MAX
데이터는 모든 타입(숫자 날짜 문자)
*/

SELECT MIN(EMP_NAME)"문자타입의 최솟값", MIN(SALARY) "숫자타입최솟값",MIN(HIRE_DATE) "날짜타입의 최솟값"
FROM EMPLOYEE;


/*
COUNT 행의 갯수를 반환(단 조건이 있을경우 해당조건에 맞는 행의 개수 반환)
COUNT(*) 조회된 결과의 모든 행 갯수 반화'
COUNT(컬럼) 해당 컬럼값이 NULL이 아닌 것만 세어서 갯수를 반화
COUNT(DISTINCT 컬럼) 해당 컬럼값의 중복 제거한 후의 갯수 반환
중복제거시 NULL은 포함하지 않고 세어짐

*/

SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1','3');

SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS)
FROM EMPLOYEE; 


