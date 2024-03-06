SELECT EMP_ID, EMP_NAME, SALARY ----------- 3
FROM EMPLOYEE        ---------- 1
WHERE DEPT_CODE IS NULL; ----------- 2

/*
   <ORDER BY 절>
   SELECT문 가장 마지막 줄에 작성, 실행순서또한 가장 마지막에 실행한다.
   
   [표현법]
   SELECT 조회할 컬럼....
   FROM 조회할 테이블
   WHERE 조건식
   ORDER BY 정렬기준이 될 컬럼명 | 별칭 | 컬럼순번 [ASC | DESC] [NULL FIRST | NULL LAST]
   
   - ASC : 오름차순(작은 값으로 시작해서 값이 점점 커지는 것) -> 기본값
   - DESC : 내림차순(큰값으로 시작해서 값이 점점 줄어드는 것)
   
   -- NULL은 기본적으로 가장 큰값으로 분류해서 정렬한다.
   - NULLS FIRST : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당데이터 맨 앞에 배치(DESC일때 기본값)
   - NULLS LAST : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당데이터 맨 마지막에 배치(ASC일때 기본값)
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- 기본값이 오름차순
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST 기본
--정렬기준에 컬럼값이 동일할 경우 그다음차순을 위해서 여러개를 제시할 수 있다.
ORDER BY BONUS DESC, SALARY ASC;

--전 사원의 사원명, 연봉(보너스제외) 조회(이 때 연봉별 내림차순 정렬)
SELECT EMP_NAME, SALARY * 12 AS "연봉"
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY 연봉 DESC;
ORDER BY 2 DESC; -- 순번사용가능 오라클은 전부 1부터 시작

--================================================================
/*
    <함수 FUNCTION>
    전달된 컬럼값을 읽어들여서 함수를 실핸한 결과를 반환
    
    -단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴(매행마다 함수실행결과를 반환)
    -그룹함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴(그룹을 지어 그룹별로 함수 실행결과 반환)
    
    >> SELECT 절에 단일행 함수랑 그룹함수를 함계 사용하지 못함!
    왜? 결과 행의 갯수가 다르기 때문에
    
    >>함수식을 기술할 수 있는 위치 : SELECT절 WHERE절 ORDER BY절 GROUP BY절 HAVING절
*/

--=========================<단일행 함수>=================================
/*
    <문자 처리 함수>
    
    *LENGTH(컬럼 | '문자열') : 해당 문자열의 글자수를 반환
    *LENGTHB(컬럼 | '문자열') : 해당 문자열의 바이트수를 반환
    
    '최' '나' 'ㄱ' 한글은 글자당 3BYTE
    영문자, 숫자, 특수문자 글자당 1BYTE
*/

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;


------------------------------------------------------------------

/*
    *INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼 | '문자열', '찾고자하는 문자', ['찾을 위치의 시작값', 순번]) => 결과는 NUMBER 나옴
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 앞쪽에 있는 첫 B는 3번째 위치에 있다고 나옴
-- 찾을 위치 시작값 : 1 , 순번 : 1 => 기본값
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 뒤에서부터 찾지만 읽을 때는 앞으로 읽어서 알려준다.
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 순번을 제시하려면 찾을 위치의 시작값을 표시해야함
SELECT INSTR('AABAACAABBAA', 'B', 1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "LOCATION", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
    *SUBSTR / 자주쓰임
    문자열에서 특정 문자열을 추출해서 반환
    
    [표현법]
    SUBSTR(STRING, POSITION, [LENGTH])
    - STRING : 문자타입의 컬럼 | '문자열'
    - POSITION : 문자열 추출할 시작위치의 값
    - LENGTH : 추출할 문자 갯수(생략하면 끝까지)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째 위치부터 끝까지
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;  --SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

--사원들중 여사원들만 EMP_NAME, EMP_NO 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';

--사원들중 남사원들만 EMP_NAME, EMP_NO 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3'
ORDER BY EMP_NAME;

--함수 중첩사용 가능
--이메일 아이디부분만 추출
-- 사원목록에서 사원명, 이메일, 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM EMPLOYEE;

------------------------------------------------------------------

/*
    *LPAD / RPAD
    문자열을 조회할 때 통일감있게 조히하고자 할 때 사용
    
    [표현법]
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])
    
    문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 N길이만큼의 문자열을 반환
*/

--20만큼의 길이 중 EAMIL컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채운다
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD('910524-1', 14, '*')
FROM DUAL;

--사원들의 사원명 주민등록번호 조회("910524-1" 형식으로)
--SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
--SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '*******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    *LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    LTRIM/RTRIM(STRING, [제거하고자하는 문자들])
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환    
*/

SELECT LTRIM('    K  H') FROM DUAL; -- 앞에서부터 다른문자가 나올때 까지만 공백제거
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- 제거하고자하는 문자는 문자열이아닌 문자들!
SELECT RTRIM('574185KH123', '0123456789') FROM DUAL;

/*
    *TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM([LEADING | TRAILING | BOTH] 제거하고자하는 문자열 FROM 문자열)
*/

SELECT TRIM('      K   H    ') FROM DUAL; -- 양쪽에있는 공백을 제거
SELECT TRIM('Z' FROM 'ZZZZKHZZZZZZZZ') FROM DUAL; -- 양쪽에있는 특정문자 제거

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZZZZZ') FROM DUAL; -- LTRIM유사한 기능
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZZZZZ') FROM DUAL; -- RTRIM유사한 기능
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZZZZZ') FROM DUAL; -- 양쪽에있는 특정문자 제거

--------------------------------------------------------------------------
/*
    *LOWER / UPPER / INITCAP
    
    LOWER : 다 소문자로 변경한 문자열 반환
    UPPER : 다 대문자로 변경한 문자열 반환
    INITCAP : 띄어쓰기 기준 첫 글자마다 대문자로 변경한 문자열 반환
*/
SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;

-------------------------------------------------------------------------------

/*
    *CONCAT
    문자열 두개 전달받아 하나로 합친 후 반환
    CONCAT(STRING1, STRING2)
*/

SELECT CONCAT('가나다', 'ABC') FROM DUAL; -- 두개의 문자열만 가능
SELECT '가나다' || 'ABC' FROM DUAL;

--------------------------------------------------------------------

/*
    *REPLACE
    특정문자열에서 특정부분을 다른부분으로 교체
    REPLACE(문자열, 찾을 문자열, 변경할문자열)
*/
SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------------
/*
    <숫자 처리 함수>
    
    *ABS
    숫자의 절대값을 구해주는 함수
*/

SELECT ABS(-10), ABS(-6.3) FROM DUAL;

----------------------------------------------------------------------------------------

/*
    *MOD
    두 수를 나눈 나머지값을 반환
    MOD(NUMBER, NUMBER)
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------

/*
    *ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER, [위치])
*/

SELECT ROUND(123.456, 0) FROM DUAL; -- 기본자리수는 소수점 첫번째 자리에서 반올림 : 0
SELECT ROUND(123.456, 1) FROM DUAL; -- 양수로 증가할 수록 소수점뒤로 한칸씩 이동
SELECT ROUND(123.456, -1) FROM DUAL; -- 음수로 감소할 수록 소수점 앞자리로 이동

-----------------------------QUIZ------------------------------------------
--검색하고자 하는 내용
--JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고
--BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의
--이름, 주민등록번호, 직급코드, 부서코드, 급여, 보너스를 조회하고싶다.
--정상적으로 조회되면 결과가 2개

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
      AND EMAIL LIKE '___\_%' ESCAPE '\' AND
      BONUS IS NOT NULL AND SUBSTR(EMP_NO, 8, 1) IN ('2','4');
--위 SQL문에서 실행시 원하는 결과가 나오지 않는다
-- 어떤 문제가 있는지 원인을 서술하고, 조치한 코드를 작성하세요.




