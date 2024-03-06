/*
    <시퀀스 SEQUENCE>
    자동으로 번호를 발생시켜주는 역할을 하는 객케
    적수값을 순차적으로 일정값씩 증가시키면서 생성해줌
    
    EX) 회원번호, 사원번호, 게시글번호....
    
    [표현식]
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자] --> 처음 발생시킬 시작값 지정[기본값 1]
    [INCREMENT BY 숫자] --> 몇씩 증가시킬 건지[기본값 1]
    [MAXVALUE 숫자] --> 최대값 지정[기본값은 매우 큰수]
    [MINVALUE 숫자] --> 최소값 지정 [기본값 1]
    [CYCLE | NOCYCLE} --> 값의 순환여부 지정 [기본값 NOCYCLE]
    [NOCACHE | CACHE 바이트크기] --> 캐시메모리 할당(기본값 CACHE 20)
    
    *캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
                매번 호출될때마다 새로 번호를 생성하는게 아니라
                캐시메모리 공간에 미리 생성된 값들을 가져다 쓸 수 있다.
    
    테이블명 : TB_
    뷰명 : VW_
    시퀀스 : SEQ_
    트리거 : TRG_
*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;
