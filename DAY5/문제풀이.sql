-- 5. 각 부서별 평균 금여를 구한 후 평균 급여를 기준으로 내림차순 하시오. ( 10점 )
-- 사용테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 부서 이름, 평균 급여
SELECT DEPT_NAME,AVG(SALARY) AVG_SAL
FROM TBL_EMP E
INNER JOIN TBL_DEPT D ON E.DEPT_ID = D.DEPT_ID
GROUP BY DEPT_NAME
ORDER BY AVG_SAL DESC;
-- 6. 모든 부서장들의 급여 평균보다 높은 급여를 받는 직원들을 출력하시오. ( 10점 )
-- 사용 테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 직원 이름, 급여, 부서장들의 평균 급여


SELECT EMP_NAME,  SALARY, AVG_SAL
FROM TBL_EMP,(
SELECT AVG(SALARY) AVG_SAL
FROM TBL_EMP E
INNER JOIN TBL_DEPT D ON E.EMP_ID = D.HEAD_ID)
WHERE AVG_SAL < SALARY;
-- 7. '모바일 앱 개발' 프로젝트에 배정된 직원들중 가장 높은 급여를 받는 직원을 출력하시오. ( 5점 )
-- 사용 테이블 : TBL_EMP, TBL_PROJECT, TBL_ASSIGNMENT
-- 출력 컬럼 : 직원 이름, 직급, 급여
SELECT * FROM TBL_EMP;
SELECT * FROM TBL_PROJECT;
SELECT * FROM TBL_ASSIGNMENT;
SELECT EMP_NAME, JOB_TITLE,SALARY
FROM TBL_EMP E
INNER JOIN TBL_ASSIGNMENT A ON E.EMP_ID = A.EMP_ID
INNER JOIN TBL_PROJECT P ON A.PROJ_ID = P.PROJ_ID
WHERE PROJ_NAME = '모바일 앱 개발' AND E.SALARY = (
    SELECT MAX(E.SALARY)
    FROM TBL_EMP E
    INNER JOIN TBL_ASSIGNMENT A 
        ON E.EMP_ID = A.EMP_ID
);
-- 8. 각 직원의 부하직원의 수(자신의 emp_id를 manager_id로 가지고 있는 사람 수)를 구하시오. 단, 없으면 0으로 출력하시오. ( 5점 )
-- 사용 테이블 : TBL_EMP
-- 출력 컬럼 : 직원 이름, 직급, 부하직원 수
SELECT E1.EMP_NAME,E1.JOB_TITLE,COUNT(E2.EMP_ID) 
FROM TBL_EMP E1
INNER JOIN TBL_EMP E2 ON E1.EMP_ID = E2.MANAGER_ID
GROUP BY E1.EMP_NAME,E1.JOB_TITLE;


SELECT * FROM TBL_EMP;
SELECT * FROM TBL_DEPT;
SELECT * FROM TBL_PROJECT;
SELECT * FROM TBL_ASSIGNMENT;