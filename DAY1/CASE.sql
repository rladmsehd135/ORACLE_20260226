--CASE ~ WHEN : DECODE보다 좀더 복잡한 IF 가독성 있게 처리 가능
SELECT SAL
    SAL,
    CASE
        WHEN SAL> 4000 THEN '고소득'
        WHEN SAL BETWEEN 2000 AND 4000 THEN '적당히 받음'
        ELSE '홧팅'
    END 급여정보
FROM EMP;