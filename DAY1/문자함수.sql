--문자 함수
--1) CONCAT : 문자열 결합
SELECT CONCAT(STU_NO, STU_NAME) AS ZZ
FROM STUDENT;
--1-1) || : 문자열 결합
SELECT STU_NO || ' ' || STU_NAME AS ZZ
FROM STUDENT;

--2) LENGTH : 문자열 길이
SELECT ID, LENGTH(ID)
FROM PROFESSOR;

--3) SUBSTR : 문자열 자르기
SELECT NAME, SUBSTR(JUMIN,1,6)
FROM STU;
-- DECODE : 자바의 IF문 같은거
SELECT 
NAME, 
SUBSTR(JUMIN,7,1),
DECODE(SUBSTR(JUMIN,7,1), 1, '남자', '여자')
FROM STU;

--4) UPPER , LOWER  : 대,소문자로 변경
SELECT 
    UPPER('Hello oraCle'),
    LOWER('Hello oraCle')
FROM DUAL;

--5) INSTR : 특정 문자열이 몇번째에 처음으로 나오는지
SELECT EMAIL ,
    INSTR(EMAIL, '@'),
    SUBSTR(EMAIL, INSTR(EMAIL, '@') + 1)
FROM PROFESSOR;
--6) REPLACE : 문자열을 다른 문자열로 대체
SELECT
    EMAIL,
    REPLACE(EMAIL, 'net', 'com')
FROM PROFESSOR;

--7) TRIM, LTRIM , RTRIM : 공백제거
SELECT
    TRIM('  HELLO ORACLE  '),
    LTRIM('      HELLO ORACLE          '),
    RTRIM('      HELLO ORACLE       ')
FROM DUAL;

--8) LPAD,RPAD  : 지정한 길이 만큼 특정 문자 채우기
SELECT 
    RPAD(ID, 10, '*')
FROM PROFESSOR;

-- 아이디의 마지막 3글자만 *로 표시
SELECT
    RPAD(SUBSTR(ID, 1, LENGTH(ID)-3), LENGTH(ID), '*') AS ID,
    SUBSTR(ID, 1, LENGTH(ID)-3) || '***'
FROM PROFESSOR;
    



