/*

SELECT : 데이터를 추출하기윈한 명령어

SELECT 조회하고자하는 정보(컬럼)

FROM 테이블명

--EMPLOYEE 직원테이블

모든 직원의 정보를 조회 

*/
SELECT * 
FROM employee;

---JOB 직급테이블  조회
--모든 직급정보를 조회

SELECT *
FROM JOB;

--DEPARTMENT 부서테이블 조회

SELECT *
FROM DEPARTMENT;

--모든 직원의 이름 주민번호 연락처 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;


--모든 직원의  직원명 , 이메일  연락처 입사일 급여정보를 조회

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;



---컬럼값에 산술 연산을 적용하여 조회
--직원 정보 중 직원명 급여 정보를 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

---직원명 연봉 조회
--- 연봉 => 급여 * 12

SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

--- 직원명 급여 보너스 연봉 보너스 포함 연봉 정보를 조회
--- 보너스 포함 연봉  ==> 급여 + (보너스*급여)*12

SELECT EMP_NAME, SALARY, BONUS, SALARY*12 AS 연봉, (SALARY + (BONUS*SALARY))*12 "보너스 포함 연봉"

FROM EMPLOYEE;

/*
현재시간 정보 :SYSDATE
임시테이블 : DUAL

*/
SELECT SYSDATE
FROM DUAL;

--근무일수 조회(현재 날짜 - 입사일+1)
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE+1 AS 근무일수
FROM EMPLOYEE;

--- 날짜데이터 - 날짜데이터  일로 계산됨

--리터럴 : 값자체
--문자 데이터 = '값'로 표현됨
--숫자 데이터 = 숫자만 표시
--=> SELECT 절에서 사용될 경우 조회된 결과(RESULT SET)에 반복적으로 표현됨

--직원명 급여 조회 (급여를 "XXXX원"형식으로 조회

SELECT EMP_NAME, SALARY || '원' AS 급여
FROM EMPLOYEE;

---- 직원 정보 조회({직원번호} {직원명} {급여} 형식으로조회)

SELECT EMP_ID || EMP_NAME || SALARY

FROM EMPLOYEE;
---{직원명}의 급여는 {급여}원입니다
SELECT EMP_NAME || '의 급여는' || SALARY||'원 입니다'

FROM EMPLOYEE;

--직원 정보중 직급 코드를 조회

SELECT JOB_CODE 
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

---부서 코드 직급 코드 중복 제거한 상태로 조회(부서별 직급 현황)
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--DISTINCT는 한번만 사용가능

--조건절을 추가
---WHERE :조회하고자 하는 데이터를  특정조건에 따라 추출하여 조회할 때 사용

--SELECT 컬럼정보 연산식
--FROM 테이블명
--WHERE 조건;


--비교연산자
--동등비교 = 다른거 !=, <> 대소 비교  >< >= <=

--직원중 부서코드가 D1인 직원들의 직원명 급여 부서코드 조회
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--직원중 D1이 아닌것

--직원중 부서코드가 D1인 직원들의 직원명 급여 부서코드 조회
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D1';

--급여가 400만 이상인 직원인 부서코드  급여조회

SELECT EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 4000000;

SELECT EMP_NAME AS "직원 이름",SALARY 급여,DEPT_CODE"부서코드", SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY*12  > 30000000;

-- 연봉 계산시 보너스 제외
--별칭 반드시 사용

--급여가 300만원 이상인 직원들의 직원명  급여 입사일  연봉조회
--연봉이 5000만원 이상인 직원들의 직원명 급여 부서코드 조회
-- 직급 코드 J3이 아닌 직원들의 직원번호 직원명  직급 코드  퇴사여부조회
--급여가 350이상 600만원 이하인 모든 직원의 직원번호  직원명  조회

SELECT EMP_NAME AS "직원 이름",SALARY 급여,DEPT_CODE"부서코드",HIRE_DATE 입사일, SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY  > 3000000;

SELECT EMP_NAME AS "직원 이름",SALARY 급여,DEPT_CODE"부서코드", SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY*12  > 50000000;

SELECT EMP_NAME AS "직원 이름", EMP_NO 직원번호, ENT_DATE 퇴사일, DEPT_CODE"부서코드",  JOB_CODE 직급코드
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

SELECT EMP_NAME AS "직원 이름",EMP_NO 직원번호,SALARY 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

/*
BETWEEN A AND B A이상 B이하 범위의 조건을 제시할때 사용
비교대상 컬럼 BETWEEN 최솟값 AND 최대값
=>비교대상컬럼 >= 최솟값 AND <=비교대상 최댓값
*/

--NOT 논리 부정 연산자
--급여가 350만원 미만 또는 600만원  초과인  직원의  정보조회 (직원번호, 직원명 급여)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE NOT(SALARY >= 3500000 AND SALARY<= 6000000);

/*
IN: 제시한 값들 중에 일치하는 값이 하나라도 있은경우 선택
비교대상자 IN(값1,값2,값3)

*/

--부서코드가 D6이거나 D8이거나 D5인 직원 정보 조회(직원명 부서코드 급여)
SELECT EMP_NAME, DEPT_CODE , SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' OR DEPT_CODE ='D8' OR DEPT_CODE='D5';

SELECT EMP_NAME, DEPT_CODE , SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D8','D5');

/*
LIKE 제시한 특정 패턴을 만족하는 경우 선택
비교대상컬럼 LIKE'패턴'
=>'패턴'내에 와일드 카드(%_)사용
%: 0글자 이상 비교대상 LIKE "문자%" 문자로 시작되는 것을 조회
             비교대상 LIKE"%문자로" 문자로 끝나는것을 조회
             비교대상 LIKE"%문자%" '문자'가 '포함'되는것을 조회
_ 1글자
EX) 비교대상커럼 LIKE '_문자' '문자'앞에 무조건 한글자가있는경우 조회
    비교대상컬럼 LIKE '__문자' : '문자' 앞에  무조건  두글자가 있는경우 조회
    비교대상컬럼 LIKE '_문자_': 문자 앞뒤로 무조건 한글자씩있는경우 조회
    
    --직원들 중 성이 전씨인 직원 이름 급여 조회
    

*/

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전__';

-- 직원 이름에 하가 포함된 직원의 이름 연락처 조회

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

SELECT EMP_NO, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '__#_%' ESCAPE '#';

/*
IS NULL // IS NOT NULL
컬럼 값에 NULL이 있을 경우 NULL 값을 비교할때 사용하는 연산자

대상 컬럼 IS NULL => 컬럼값이 NULL인 행을 선택(조회)
대상 컬럼 IS NOT NULL => 컬럼값이 NULL 이 아닌 행만 선택

*/

SELECT EMP_NAME, BONUS
FROM employee
WHERE BONUS IS NOT NULL;

SELECT EMP_NAME, BONUS
FROM employee
WHERE BONUS IS NULL;

-- 사수(MANAGER_ID)가 없는 직원(직원번호 이름 사수번호)
SELECT EMP_NAME, EMP_NO, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--부서배치를 받지 않았지만 보너스를 받고있는 직업 조회 (직원명, 보너스, 부서코드)
--부서코드가 
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*우선순위
()
산술연산자 +/*-
연결연산자 ||
비교연산자 ><>=<= == != <>
IS NULL /IS NOT NULL /IN
BETWEEN A AND B
NOT
AND
OR
*/

-- 

SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE ='J2') AND SALARY >= 2000000;

--ORDER BY :SELECT문의 가장 마지막 부분에 작성 실행 순서도 마지막에 실행

-- SELECT 조회할 컬럼
--FROM 테이블명
-- WHERE 조건
--ORDER BY 정렬방식 NULL에대한 옵션

-- 정렬 기준이 되는 컬럼 : 컬럼명 별칭(SELECT 절에 나열한 순서번호)
--정렬방식
--ASC 오름차순
--DSC 내림차순
--NULL에대한 옵션
--NULLS FIRST 정렬하고자하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 앞에 위치
--NULLS LAST 정렬하고자하느 컬럼의 값이 NULL인 데이터를 맨뒤에 위치

--모든 직원의 직원명 연봉 조회 (연봉 내림차순으로 정렬)

SELECT EMP_NAME, SALARY*12 연봉
FROM EMPLOYEE
--ORDER BY 연봉 DESC;
ORDER BY 2 DESC;

--보너스 내림차순 정렬

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC NULLS LAST, SALARY DESC;