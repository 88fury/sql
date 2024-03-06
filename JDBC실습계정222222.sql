CREATE TABLE DEPARTMENT(
DEPTCODE NUMBER PRIMARY KEY,
DEPTNAME NVARCHAR2(10) NOT NULL
);

CREATE TABLE EMPLOYEE
EMPNO NUMBER PRIMARY KEY,
EMPNAME VARCHAR2(10) NOT NULL,
DEPTNO NUMBER REFERENCES DEPARTMENT(DEPTCODE)
);

SELECT EMP_NO, EMP_NAME, DEPT_NO, DEPT_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = EMP_NAME);