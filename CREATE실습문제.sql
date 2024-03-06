--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;
/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(50) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(13)
);    
--���� 3������ ����
INSERT INTO TB_PUBLISHER VALUES(1 , 'AA', '010-1111-2474');
INSERT INTO TB_PUBLISHER VALUES(2 , 'BB', '010-1123-2474');
INSERT INTO TB_PUBLISHER VALUES(3 , 'CC', '010-1142-2474');
INSERT INTO TB_PUBLISHER VALUES(4 , 'DD', '010-1523-2474');

SELECT * FROM TB_PUBLISHER;
/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(30) CONSTRAINT BOOK__NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK__NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT BOOK_FK FOREIGN KEY (BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
);    

--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_BOOK VALUES(100, '�ڹ�������', '������', 100000, 1);
INSERT INTO TB_BOOK VALUES(101, '�ڹ�������2', '������', 100000, 1);
INSERT INTO TB_BOOK VALUES(102, '�ڹ�������3', '������', 200000, 2);
INSERT INTO TB_BOOK VALUES(103, '�ڹ�������4', '������', 300000, 3);
INSERT INTO TB_BOOK VALUES(104, '�ڹ�������5', '������', 300000, 3);

SELECT * FROM TB_BOOK;
/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ_ID UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    CENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(50),
    PHONE CHAR(13)
    STATUS CHAR(
    

--5�� ������ ���� ������ �߰��ϱ�

/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

--3�� ������ ���� ������ �߰��ϱ�



