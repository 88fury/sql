/*
    <PL / SQL>
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    SQL문장 내에서 변수의 정의, 조건(IF), 반복(FOR, WHILE)등을 지원하여 SQL단점을 보완
    다수의 SQL문을 한번에 실행가능
    
    *PL/SQL 구조
    -[선언부] : DECLARE로 시작, 변수나 상수를 선언및 초기화하는 부분
    -실행부 :  BEGIN으로 시작, SQL문 또는 제어문(조건문, 반복문)등의 로직을 기술하는 부분
    -[예외처리부] : EXCEPTION으로 시작, 예외발생시 해결하기위한 구문
*/

SET SERVEROUTPUT ON;

-- HELLO ORACLE출력
BEGIN
    --SYSTEM.OUT.PRINTLN("HELLO ORACLE")자바
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
--------------------------------------------------------------
/*
    1. DECLARE 선언부
        변수 및 상수 선언 하는 공간(선언과 동시에 초기화도 가능)
        일반타입변수, 레퍼런스타입변수, ROW타입변수
        
    1_1)일반타입 변수 선언및 초기화
        [표현식] 변수명 [CONSTANT] 자료형 [:= 갑];
        
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 800;
    ENAME := '진영재';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :' || PI);
END;
/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := &번호;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :' || PI);
END;
/

-------------------------------------------------------------
--1_2) 레퍼런스 타입 변수 선언 및 초기화(어떤테이블의 어떤컬럼의 테이터타입을 참조해서 그 타입으로 지정)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := 800;
    --ENAME := '진영재';
    --SAL := 1000000;
    
    --사번이 200번인 사원의 사번, 사원명, 급여조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = 200;
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL :' || SAL);
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := 800;
    --ENAME := '진영재';
    --SAL := 1000000;
    
    --사번이 200번인 사원의 사번, 사원명, 급여조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL :' || SAL);
END;
/

------------------------------실습-------------------------------\
/*
    레퍼헌스타입변수로 EID, ENAME, JCODEM, SALM, DTITLE을 선언하고
    각 자료형 EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY), DEPARTMENT(DEPT_TITLE)등을 참조하도록
    사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명 조회 후 각 변수에 담아 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODEM EMPLOYEE.JOB_CODE%TYPE;
    SALM EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODEM, SALM, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODEM :' || JCODEM);
    DBMS_OUTPUT.PUT_LINE('SALM :' || SALM);
    DBMS_OUTPUT.PUT_LINE('DTITLE :' || DTITLE);
END;
/

-----------------------------------------------------------------------
--1_3) ROW타입 변수 선언
--     테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--     [표현식] 변수명 테이블명%ROWTYPE;



-----------------------------------------------
--2. BEGIN 실행부
--<조건문>
-- 1) IF 조건식 THEN 실행내용 END IF; (IF문만 단독으로 사용할 때)

--입력받은 사번의 해당하는 사원의 사번, 이름, 급여, 보너스 출력
--단, 보너스를 받지않은 사원은 보너스율 출력 전 '보너스를 지급받지 않은 사원입니다' 출력






---------------------실습-------------------------

--DECLARE
--  레퍼런스타입변수(EIDM ENAME, DTITLE, NCODE)
--        참조컬럼(EMP_IDM EMP_NAME, DEPT_TITLE, NATIOCAL_CODE)
--     일반타입변수(TEAM 문자열) < == 이따가 국내팀 , 해외팀 분리해서 담을 예정
--BEGIN
--   사용자가 입력한 사번의 사원의 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입
--
--      NCODE값이 KO일 경우 --> TEAM --> '국내팀' 대입
--          그게 아닐경우  --> TEAM --> "해외팀' EODLQ
--
--      사번, 이름, 부서, 소속에 대해서 출력
--END;
--/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE; 
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO'
        THEN TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 :' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 :' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 :' || TEAM);
END;
/

--------------------------실숩-----------------------------------
--사용자에게 입력받은 사번의 사원의 급여를 조회해서 SAL변수 대입
--500만원 이상이면 '고급'
--400만원 이상이명 '중급'
--300만원 이상이면 '초급'
--'해당 사원의 급여등급은 XX입니다.'

--DECLARE
--    
--    SAL EMPLOYEE.SALARY%TYPE;
--    GRADE VARCHAR2(10);
--BEGIN
--    SELECT SALARY
--    INTO SAL
--    FROM EMPLOYEE
--    WHERE EMP_ID = &사번;
--    
--    IF SAL >= 5000000 THEN GRADE := '고급'
--    ELSIF SAL >= 4000000 THEN GRADE := '중급'
--    ELSIF SAL >= 3000000 THEN GRADE := '초급'
--    ELSE GRADE := '인턴'
--    END IF;
--    
--    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE ||'입니다');
--    
--END;
--/

/*
    2) FOR LOOP문
    [표현식]
    FOR 변수 IN [REVERSE] 초기값....최종값
    
    LOOP   
        반복적으로 실행할 문장;
    END LOOP;
*/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.put_line(I);
    END LOOP;
END;
/

--DROP TABLE TEST
--
--CREATE TABLE TEST(
--    TNO NUMBER PRIMARY KEY,
--    TDATE DATE
--);

------------------------------------------------------------

/*
    WHILE LOOP문
    
    [표현식]
    WHERE 반복문이 수행될 조건
    LOOP
        반복수행하는 문장
    END LOOP;
    
*/

--CDECLARE
--    NUMBER := 1;
--BEGIN
--    WHILE I < 6
--    LOOP
--        DBM_OUPUT.PUT_LINE(I);
--        I := I + 1;
--    END LOOP;
--END;
--/

/*
    3. 예외처리부
    예외(EXCEPYION) : 실행 중 발생하는 오류
    
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ...
        
        *시스템 예외(오라클에서 미리 정의해둔 예외)
        -NO_DATE_FOUND : SELECT한 결과가 한행도 없을 때
        -TOO_MANY_ROWS : SELECT한 결과가 여러행일 경우
        -ZERO_DIVIDE : 0으로 나눌때
        -DUP_VAL_ON_INDEX : UNIQUE제약조건에 위배되었을 경우
        
        
*/

DECLARE
    RESULT NUMER;
BEGIN    
    RESULT := 10/ &숫자;
    DBMS_OUTPUT.PUT_LINE('결과 : ' || RESULT);
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없다.');
END;
/

BEGIN
    UPDATE EMP_OYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME = '노옹철';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/
    