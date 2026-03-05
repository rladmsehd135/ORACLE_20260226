-- 프로시저


CREATE OR REPLACE PROCEDURE TEST_PROC
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello oracle');
END;
/


SET SERVEROUTPUT ON;

EXEC TEST_PROC;

CREATE OR REPLACE PROCEDURE EMPINFO_PROC(I_EMPNO IN EMP.EMPNO%TYPE)
IS
    O_ENAME EMP.ENAME%TYPE;
    O_SAL EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, SAL
    INTO O_ENAME, O_SAL
    FROM EMP
    WHERE MEPNO = I_EMPNO;
    
     DBMS_OUTPUT.PUT_LINE(O_ENAME || '님의 급여는' || O_SAL || '입니다.');
END;
/

EXEC EMPSAL_PROC(7654,100);

CREATE OR REPLACE PROCEDURE EMPSAL_PROC(
    I_EMPNO IN EMP.EMPNO%TYPE,
    I_SAL IN EMP.SAL%TYPE
)
IS
    O_COUNT NUMBER;
BEGIN
    UPDATE EMP
    SET 
        SAL = SAL + I_SAL
    WHERE EMPNO = I_EMPNO;
    O_COUNT := SQL%ROWCOUNT;
    
    IF O_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('사번을 확인해주세요');
    ELSIF O_COUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('수정되었습니다!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('2개 이상의 데이터가 저장되었습니다.');
    END IF; 
    COMMIT;
END;
/

SELECT * FROM EMP;
EXEC EMPSAL_PROC(7654,100);

SELECT * FROM ENROL;
--포로시저 호출
--ENROL_PROC('학번','과목번호','수정할 점수')
---1없는 학번이나 없는 과목번호를 입력하면 정보를 다시 확인해주세요 출력
--2. 점수가 0미만, 100초과일 경우 '점수의 범위는 1~100 입니다 ' 출력
--3.학번,과목번호에 해당하는 점수는 3번째 인자값으로 변경
CREATE OR REPLACE PROCEDURE ENROL_PROC
    (
        I_STUNO IN ENROL.STU_NO%TYPE, 
        I_SUBNO IN ENROL.SUB_NO%TYPE,
        I_GRADE IN ENROL.ENR_GRADE%TYPE
    )
IS
    O_COUNT NUMBER;
BEGIN
    
    IF I_GRADE BETWEEN 0 AND 100 THEN
        UPDATE ENROL
        SET
            ENR_GRADE = I_GRADE
        WHERE STU_NO = I_STUNO AND SUB_NO = I_SUBNO;
        O_COUNT := SQL%ROWCOUNT;  
        
        IF O_COUNT = 0 THEN
             DBMS_OUTPUT.PUT_LINE('정보를 다시 확인해주셈');
        ELSIF O_COUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('수정되었습니다!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('2개 이상의 데이터가 저장되었습니다.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('점수의 범위는 1~100입니다.');        
    END IF;
    COMMIT;
END;
/

SELECT * FROM ENROL;

EXEC ENROL_PROC(20131001, 101, 90);