--실습문제 --
--도서관리 프로그램을 만들기 위한 테이블들 만들기--
--이때, 제약조건에 이름을 부여할 것
--   각 컬럼에 주석달기

DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;
/*
    1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
    컬럼 : PUB_NO(출판사 번호) - 기본키(PUBLISHER_PK)
          PUB_NAME(출판사명) -- NOT NULL(PUBLISHER_NN)
          PHONE(출판사전화번호) -- 제약조건없음
*/
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(50) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(13)
);    
--샘플 3개정도 생성
INSERT INTO TB_PUBLISHER VALUES(1 , 'AA', '010-1111-2474');
INSERT INTO TB_PUBLISHER VALUES(2 , 'BB', '010-1123-2474');
INSERT INTO TB_PUBLISHER VALUES(3 , 'CC', '010-1142-2474');
INSERT INTO TB_PUBLISHER VALUES(4 , 'DD', '010-1523-2474');

SELECT * FROM TB_PUBLISHER;
/*
    2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
    컬럼 : BK_NO(도서번호)--기본키(BOOK_PK)
          BK_TITLE(도서명)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(저자명)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(가격)-- 제약조건없음
          BK_PUB_NO(출판사 번호)--외래키(BOOK_FK)(TB_PUBLISHER테이블을 참조)
                                이때 참조하고 있는 부모데이터 삭제시 자식데이터도 삭제 되도록 옵션지정
                                
*/
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(30) CONSTRAINT BOOK__NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK__NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT BOOK_FK FOREIGN KEY (BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
);    

--5개 정도의 샘플 데이터 추가하기
INSERT INTO TB_BOOK VALUES(100, '자바정복기', '최지원', 100000, 1);
INSERT INTO TB_BOOK VALUES(101, '자바정복기2', '최지원', 100000, 1);
INSERT INTO TB_BOOK VALUES(102, '자바정복기3', '최지원', 200000, 2);
INSERT INTO TB_BOOK VALUES(103, '자바정복기4', '최지원', 300000, 3);
INSERT INTO TB_BOOK VALUES(104, '자바정복기5', '최지원', 300000, 3);

SELECT * FROM TB_BOOK;
/*
    3. 회원에 대한 데이터를 담기위한 회원 테이블(TB_MEMBER)
    컬럼명 : MEMBER_NO(회원번호) -- 기본키(MEMBER_PK)
            MEMBER_ID(아이디) -- 중복금지(MEMBER_UQ_ID)
            MEMBER_PWD(비밀번호) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(회원명) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(성별) -- M또는 F로 입력되도록 제한(MEMBER_CK_GEN)
            ADDRESS(주소) -- 제약조건없음
            PHONE(연락처)-- 제약조건없음
            STATUS(탈퇴여부) -- 기본값을 N으로 지정, 그리고 N또는 Y만 입력되도록 제약조건 설정(MEMBER_CK_STA)
            ENROLL_DATE(가입일) -- 기본값으로 SYSDATE, NOT NULL 제약조건(MEMBER_NN_EN)
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
    

--5개 정도의 샘플 데이터 추가하기

/*
    4.어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
    컬럼명 : RENT_NO(대여번호)-- 기본키(RENT_PK)
            RENT_MEM_NO(대여회원번호)-- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_BOOK_NO(대여도서번호)-- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_DATE(대여일) -- 기본값 SYSDATE
*/

--3개 정도의 샘플 데이터 추가하기



