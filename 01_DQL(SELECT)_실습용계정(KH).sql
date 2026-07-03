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
-- =============================================================================
/*
칼럼 값에 산술 연산을 적용하여 조회
*/
-- Ex1. 직원 정보중 직원명, 급여 정보를 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- Ex2. 직원명, 연봉 정보를 조회 / 연봉 -> 급여 *12
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- Ex3. 직원명, 급여, 보너스, 연봉, 보너스 포함 연봉 정보를 조회
    --  보너스 포함 연봉: (급여 + (보너스 * 급여))*12
SELECT EMP_NAME, SALARY, BONUS, BONUS * 12 AS 연봉, (SALARY + (BONUS * SALARY))*12 "보너스 포함 연봉"
FROM EMPLOYEE;
-- =============================================================================
/*
    현재 날짜 시간 정보: SYSDATE
    임시 테이블: DUAL
*/

SELECT SYSDATE
FROM DUAL;
-- =============================================================================

-- 근무 일수 조회 (현재 날짜 - 입사일 +1)
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE + 1 AS 근무일수
FROM EMPLOYEE; --FROM keyword not found where expected
-- 날짜데이터 - 날짜데이터 : 일(DAY)로 계산됨 !
-- =============================================================================
/*
    리터럴: 값 자체
    문자 데이터: 작은 따옴표로 표시 ('값')
    숫자 데이터: 숫자만 표시
    
    SELECT 절에서 사용할 경우, 조회된 결과 (Result Set)에 반복적으로 표시됨
*/
-- 직원명, 급여 조회 (급여를 'XXXX원' 형식으로 조회)
SELECT EMP_NAME, SALARY || '원' 급여
FROM EMPLOYEE;

-- 직원 정보 조회 ( {직원번호}{직원명}{급여} 형식으로 조회 )
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- {직원명}의 급여는 {급여|원입니다. 형식으로 조회
SELECT EMP_NAME || '의 급여는 ' || SALARY || '원 입니다'
FROM EMPLOYEE;
-- =============================================================================
-- 직원 정보 중 직급 코드를 조회
SELECT JOB_CODE
FROM EMPLOYEE;

/*
    중복 데이터 제거: DISTINCT
    중복되는 데이터가 있을 경우, 중복을 제거하여 결과로 표시해준다
*/
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 부서 코드, 직급 코드를 중복 제거한 상태로 조회 (부서별 직급 현황)
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
    -- (DEPT_CODE, JOB_CODE) 한 쌍으로 해서 중복을 제거해준다
    /*
    SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
    FROM EMPLOYEE;
    DISTINICT는 한 번만 사용이 가능하다
    SELECT DISTINCT DEFT_CODE FROM EMPLOYEE; (라는 형태로 개별 처리해주어야 한다)
    */
-- =============================================================================
/*
    조건절: WHERE
    : 조회하고자 하는 데이터를 특정 조건에 따라 추출하여 조회할 때 사용
    SELECT 컬럼 정보, 연산식
    FROM 테이블명
    WHERE 조건;
*/
/*
    비교 연산자: 동등 비교 / 대소 비교
    동등 비교: 같은가? (=), 다른가? (!= <>)
    대소 비교: (> < >= <=)
*/
-- 직원 중에 부서 코드가 D1인 직원들의 직원명, 급여, 부서 코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 직원 중 부서코드가 D1이 아닌 직원들의 정보 조회 (이름, 급여, 부서 코드)
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
WHERE DEPT_CODE <> 'D1'; -- != 는 <> 과 같은 의미를 갖고있다

-- 급여가 400만원 이상인 직원의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 연봉이 3000만원 이상인 직원의 직원명, 부서 코드, 연봉 조회
SELECT EMP_NAME AS "직원 이름", DEPT_CODE "부서 코드", SALARY 급여, SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000;
-- =============================================================================
-- /* === 실습 문제 === */ --
-- 연봉 계산 시, 보너스 제외
-- 별칭 반드시 적용

-- 1. 급여가 300만원 이상인 직원들의 직원명, 급여, 입사일, 연봉 조회
SELECT EMP_NAME 직원명, SALARY 급여, HIRE_DATE 입사일, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5000만원 이상인 직원들의 직원명, 급여, 연봉, 부서 코드 조회
SELECT EMP_NAME 직원명, SALARY 급여, SALARY*12 연봉, DEPT_CODE "부서 코드"
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;

-- 3. 직급 코드가 J3가 아닌 직원들의 직원 번호, 직원명, 직급 코드, 퇴사 여부를 조회
SELECT EMP_ID "직원 번호", EMP_NAME 직원명, JOB_CODE "직급 코드", ENT_YN "퇴사 여부"
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. 급여가 350만원 이상, 600만원 이하인 모든 직원의 직원 번호, 직원명, 급여를 조회
SELECT EMP_ID "직원 번호", EMP_NAME 직원명, SALARY 급여
FROM EMPLOYEE
-- WHERE 3500000 <= SALARY AND SALARY <= 6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;   -- 결과는 윗줄과 동일하다
-- =============================================================================
/*
    BETWEEN A AND B : A 이상, B 이하 범위의 조건을 제시할 때 사용한다
    비교대상컬럼 BETWEEN 최소값 AND 최대값
        비교대상컬럼 >= 최소값 AND 비교대상컬럼 <= 최대값
*/
/*
    NOT : 논리 부정 연산자
*/
-- 급여가 350만원 미만 OR 600만원 초과인 직원의 정보 조회 (직원 번호, 직원명, 급여)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;
-- 위의 SQL문을 NOT을 사용하여 작성한다면? NOT (SALARY >= 3500000 AND SALARY <= 6000000);

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE NOT (SALARY >= 3500000 AND SALARY <= 6000000);
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
    -- 위의 OR 문과 동일한 값을 출력하는 다른 방안들

/*
    IN : 제시한 값들 중에 일치하는 값이 하나라도 있는 경우 선택
    비교대상컬럼  IN (값1, 값2, 값3, ...)
*/
-- 부서 코드가 D6 OR D5인 직원 정보 조회 (직원명, 부서 코드, 급여)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D9' OR DEPT_CODE = 'D5';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- =============================================================================
/*
    LIKE : 제시한 특정 패턴을 만족하는 경우, 선택 (조회)
    비교대상컬럼 LIKE '패턴'
    '패턴' 내에 와일드 카드( % _ ) 사용
        % : 0글자 이상
        Ex. 비교대상컬럼 LIKE '문자%' : '문자'로 "시작"되는 것을 조회
            비교대상컬럼 LIKE '%문자' : '문자'로 "끝"나는 것을 조회
            비교대상컬럼 LIKE '%문자%': '문자'가 "포함"되는 것을 조회
            
        _ : 1글자 이상
        Ex. 비교대상컬럼 LIKE '_문자' : '문자' 앞에 무조건 한 글자가 있는 경우 조회
            비교대상컬럼 LIKE '__문자': '문자' 앞에 무조건 두 글자가 있는 경우 조회
            비교대상컬럼 LIKE _문자_' : '문자' 앞, 뒤로 무조건 한 글자가 있는 경우를 조회
*/
-- 직원들중 성이 전씨인 직원의 이름과 급여를 조회
SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
-- WHERE EMP_NAME LIKE '전__';
WHERE EMP_NAME LIKE '전%';

-- 직원 이름에 '하'가 포함된 직원의 이름, 연락처 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE'%하%';

-- 직원의 연락처 정보에서 3번째 자리가 1인 직원 정보 조회 (이름, 연락처)
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 직원 이메일 정보에서 4번째 자리가 _인 직원 정보 조회 (직원 번호, 이름, 이메일)
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
    -- '__(기호)_%' ESCAPE '(기호)'; = (기호) 부분은 자유 선택이 가능하다

/*
    IS NULL / IS NOT NULL
    컬럼 값에 NULL이 있을 경우 NULL 값을 비교할 때 사용하는 연산자
    대상컬럼 IS NULL     -> 컬럼의 값이 NULL이 아닌 행만 선택 (조회)
    대상컬럼 IS NOT NULL -> 컬럼의 값이 NULL이 아닌 행만 선택 (조회)
*/
-- 보너스(BONUS)를 받는 직원 조회 -> NULL값이 아닌 직원만 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 보너스를 받지 않는 직원 조회 -> NULL 값인 직원만 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 사수 (MANAGER_ID)가 없는 직원을 조회 (직원 번호, 이름, 사수 번호)
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서 배치를 받지는 않았지만, 보너스를 받고 있는 직원 조회 (직원명, 보너스, 부서코드)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
-- =============================================================================
/*
    연산자 우선순위
    [0] ( )
    [1] 산술 연산자 : * / + -
    [2] 연결 연산자 : ||
    [3] 비교 연산자 : > < >= <= = != <>
    [4] IS NULL , IS NOT NULL / LIKE '패턴' / IN
    [5] BETWEEN A AND B
    [6] NOT 
    [7] AND
    [8] OR
*/
-- 직급 코드가 J7 OR J2인 직원들중 급여가 200만원 이상인 직원 조회 (모든 정보)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND JOB_CODE IN ('J7', 'J2');
-- =============================================================================
/*
    ORDER BY : SELECT 문의 가장 마지막 부분에 작성, 실행 순서도 마지막에 실행 !
    SELECT 조회할 컬럼...
    FROM 테이블명
    WHERE 조건
    OREDER BY {정렬 기준이 되는 컬럼} {정렬 방식} {NULL 값 여부};
    
        정렬 기준이 되는 컬럼: 컬럼명, 별칭, 컬럼 순번(SELECT 절에 나열한 순서 번호)
        정렬방식
        - 오름차순 (ASC): 오름차순 정렬 (기본값)
        - 내림차순 (DESC): 내림차순 정렬
        NULL에 대한 옵션
        - NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 앞에 위치 (DESC인 경우 기본값)
        - NULLS LAST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 뒤에 위치 (ASC인 경우 기본값)
*/
-- 모든 직원의 직원명, 연봉 조회 (연봉 내림차순 정렬)
SELECT EMP_NAME 직원명, SALARY*12 연봉
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC;   --연산식 (컬럼)
-- ORDER BY 연봉 DESC;        --별칭
ORDER BY 2 DESC;          -- 컬럼 순번

-- 보너스 내림차순 정렬 (모든 정보)
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS DESC;      -- DESC > NULL에 대한 처리: NULLS  FIRST
-- ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC NULLS LAST, SALARY DESC;

-- 보너스율이 높은 순서로 조회하되, 동일한 값이면 급여 기분으로 내림차순 정렬
SELECT *
FROM EMPLOYEE
