-- 조건 처리
-- NVL : NULL값에 대한 처리

SELECT NAME, PAY, BONUS, PAY+BONUS 
FROM PROFESSOR;

SELECT NAME, PAY, NVL(BONUS, 0), PAY + NVL(BONUS, 0)
FROM PROFESSOR;

SELECT NAME, BONUS, NVL2(BONUS, 10000, 0)
FROM PROFESSOR;

-- DECODE : 자바의 조건문(IF)
-- DECODE(컬럼명, '조건값', '조건이랑 같을 때 출력', '조건이랑 다를 때 출력')
-- DECODE(컬럼명, '조건값1', '조건1 만족할 때 출력', '조건2', '조건2 만족할 때 출력', '조건 1~2 모두 만족 안했을 때')

SELECT 
    NAME,
    DECODE(GRADE, 4, '졸업반', GRADE || '학년'),
    DECODE(GRADE, 4, '졸업반', '3', '고학년', '저학년')
FROM STU;

SELECT * FROM PROFESSOR;ㄴ