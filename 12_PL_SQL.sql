/*
    <PL / SQL>
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL���� ������ ������ ����, ����(IF), �ݺ�(FOR, WHILE)���� �����Ͽ� SQL������ ����
    �ټ��� SQL���� �ѹ��� ���డ��
    
    *PL/SQL ����
    -[�����] : DECLARE�� ����, ������ ����� ����� �ʱ�ȭ�ϴ� �κ�
    -����� :  BEGIN���� ����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�
    -[����ó����] : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ����� ����
*/

SET SERVEROUTPUT ON;

-- HELLO ORACLE���
BEGIN
    --SYSTEM.OUT.PRINTLN("HELLO ORACLE")�ڹ�
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
--------------------------------------------------------------
/*
    1. DECLARE �����
        ���� �� ��� ���� �ϴ� ����(����� ���ÿ� �ʱ�ȭ�� ����)
        �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
        
    1_1)�Ϲ�Ÿ�� ���� ����� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��];
        
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 800;
    ENAME := '������';
    
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
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :' || PI);
END;
/

-------------------------------------------------------------
--1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(����̺��� ��÷��� ������Ÿ���� �����ؼ� �� Ÿ������ ����)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := 800;
    --ENAME := '������';
    --SAL := 1000000;
    
    --����� 200���� ����� ���, �����, �޿���ȸ�ؼ� �� ������ ����
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
    --ENAME := '������';
    --SAL := 1000000;
    
    --����� 200���� ����� ���, �����, �޿���ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL :' || SAL);
END;
/

------------------------------�ǽ�-------------------------------\
/*
    �����彺Ÿ�Ժ����� EID, ENAME, JCODEM, SALM, DTITLE�� �����ϰ�
    �� �ڷ��� EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY), DEPARTMENT(DEPT_TITLE)���� �����ϵ���
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� ������ ��� ���
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
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODEM :' || JCODEM);
    DBMS_OUTPUT.PUT_LINE('SALM :' || SALM);
    DBMS_OUTPUT.PUT_LINE('DTITLE :' || DTITLE);
END;
/

-----------------------------------------------------------------------
--1_3) ROWŸ�� ���� ����
--     ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--     [ǥ����] ������ ���̺��%ROWTYPE;



-----------------------------------------------
--2. BEGIN �����
--<���ǹ�>
-- 1) IF ���ǽ� THEN ���೻�� END IF; (IF���� �ܵ����� ����� ��)

--�Է¹��� ����� �ش��ϴ� ����� ���, �̸�, �޿�, ���ʽ� ���
--��, ���ʽ��� �������� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� ���� ����Դϴ�' ���






---------------------�ǽ�-------------------------

--DECLARE
--  ���۷���Ÿ�Ժ���(EIDM ENAME, DTITLE, NCODE)
--        �����÷�(EMP_IDM EMP_NAME, DEPT_TITLE, NATIOCAL_CODE)
--     �Ϲ�Ÿ�Ժ���(TEAM ���ڿ�) < == �̵��� ������ , �ؿ��� �и��ؼ� ���� ����
--BEGIN
--   ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
--
--      NCODE���� KO�� ��� --> TEAM --> '������' ����
--          �װ� �ƴҰ��  --> TEAM --> "�ؿ���' EODLQ
--
--      ���, �̸�, �μ�, �Ҽӿ� ���ؼ� ���
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
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� :' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� :' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� :' || TEAM);
END;
/

--------------------------�Ǽ�-----------------------------------
--����ڿ��� �Է¹��� ����� ����� �޿��� ��ȸ�ؼ� SAL���� ����
--500���� �̻��̸� '���'
--400���� �̻��̸� '�߱�'
--300���� �̻��̸� '�ʱ�'
--'�ش� ����� �޿������ XX�Դϴ�.'

--DECLARE
--    
--    SAL EMPLOYEE.SALARY%TYPE;
--    GRADE VARCHAR2(10);
--BEGIN
--    SELECT SALARY
--    INTO SAL
--    FROM EMPLOYEE
--    WHERE EMP_ID = &���;
--    
--    IF SAL >= 5000000 THEN GRADE := '���'
--    ELSIF SAL >= 4000000 THEN GRADE := '�߱�'
--    ELSIF SAL >= 3000000 THEN GRADE := '�ʱ�'
--    ELSE GRADE := '����'
--    END IF;
--    
--    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ ' || GRADE ||'�Դϴ�');
--    
--END;
--/

/*
    2) FOR LOOP��
    [ǥ����]
    FOR ���� IN [REVERSE] �ʱⰪ....������
    
    LOOP   
        �ݺ������� ������ ����;
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
    WHILE LOOP��
    
    [ǥ����]
    WHERE �ݺ����� ����� ����
    LOOP
        �ݺ������ϴ� ����
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
    3. ����ó����
    ����(EXCEPYION) : ���� �� �߻��ϴ� ����
    
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        
        *�ý��� ����(����Ŭ���� �̸� �����ص� ����)
        -NO_DATE_FOUND : SELECT�� ����� ���൵ ���� ��
        -TOO_MANY_ROWS : SELECT�� ����� �������� ���
        -ZERO_DIVIDE : 0���� ������
        -DUP_VAL_ON_INDEX : UNIQUE�������ǿ� ����Ǿ��� ���
        
        
*/

DECLARE
    RESULT NUMER;
BEGIN    
    RESULT := 10/ &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� ����.');
END;
/

BEGIN
    UPDATE EMP_OYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/
    