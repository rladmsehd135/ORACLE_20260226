SELECT * FROM MEMBER;
SELECT * FROM MEMBER_POINT;
SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT_ORDERS;

--1. 아래 조건에 맞게 쿼리를 작성하고 실행하시오.
--(사용 테이블 : MEMBER)
-- 1-1) 아이디가 'test123', 비밀번호가 '1234', 이름이 '홍길동'인 레코드 추가 (INSERT)
 INSERT INTO MEMBER(MEMBER_ID, PASSWORD,MEMBER_NAME)
 VALUES ('test123','1234','홍길동');
-- 1-2) 1-1에서 추가한 사용자의 이메일을 test@test.com 으로 수정 (UPDATE)
UPDATE MEMBER SET
EMAIL = 'test@test.com'
WHERE MEMBER_ID = 'test123';
 --1-3) 1-1에서 추가한 레코드를 삭제 (DELETE)
DELETE FROM MEMBER WHERE MEMBER_ID = 'test123';
--. 주문 내역에서 '인천' 지역에서 주문 사용자의 내역 조회
--(
	--사용 테이블 : PRODUCT_ORDERS
	--출력 컬럼 : 주문자 아이디, 가격, 주소
--)
SELECT MEMBER_ID,ORDER_PRICE,DELIVERY_ADDR
FROM PRODUCT_ORDERS
WHERE DELIVERY_ADDR LIKE '%인천%';
 
--3. 이메일에서 메일 아이디만 따로 출력 하시오
--(ex, abcde@naver.com -> abcde / 즉, @ 이전 문자만 출력)
--(
	--사용 테이블 : MEMBER
	--출력 컬럼 : 이름, 메일 아이디
--)
SELECT EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM MEMBER;

--4. 아래 조건에 맞게 VIEW를 만들고, 검색해 보시오.
--(사용 테이블 : MEMBER_POINT)
--조건 1) VIEW 이름은 POINT_VIEW
--조건 2) DESCRIPTION이 '리뷰'인 레코드만 검색
--조건 3) 읽기 전용으로 만들 것
SELECT * FROM MEMBER_POINT;
CREATE OR REPLACE VIEW POINT_VIEW AS
SELECT *
FROM MEMBER_POINT
WHERE DESCRIPTION = '리뷰';
WITH READ ONLY;

--5. 고객 아이디, 이름, 주문한 제품 명, 배송 주소를 출력하시오.
--(
	--사용 테이블 : MEMBER, PRODUCT, PRODUCT_ORDERS
	--출력 컬럼 : 고객 아이디, 이름, 주문한 제품 명, 배송 주소
    SELECT M.MEMBER_ID, MEMBER_NAME,PRODUCT_NAME,DELIVERY_ADDR
    FROM MEMBER M
    INNER JOIN PRODUCT_ORDERS PO ON M.MEMBER_ID = PO.MEMBER_ID
    INNER JOIN PRODUCT P ON PO.PRODUCT_ID = P.PRODUCT_ID;

--6. 누적된 포인트가 가장 많은 고객의 아이디, 이름, 누적 포인트량 을 출력하시오.
--(
--	사용 테이블 : PRODUCT_POINT, MEMBER
--	출력 컬럼 : 아이디, 이름, 누적 포인트량

SELECT M.MEMBER_ID,MEMBER_NAME,POINT_AMOUNT
FROM MEMBER M
INNER JOIN MEMBER_POINT MP ON M.MEMBER_ID = MP.MEMBER_ID
WHERE POINT_AMOUNT = (
SELECT MAX(POINT_AMOUNT)
FROM MEMBER M
INNER JOIN MEMBER_POINT MP ON M.MEMBER_ID = MP.MEMBER_ID);



--7. 가장 많은 제품을 구매한 고객의 아이디, 이름, 주문 개수를 출력하시오.
--(
	--사용 테이블 : MEMBER, PRODUCT_ORDERS
	--출력 컬럼 : 고객 아이디, 이름, 주문 개수
--)

SELECT M.MEMBER_ID,MEMBER_NAME,COUNT(*)
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS O ON M.MEMBER_ID = O.MEMBER_ID
GROUP BY M.MEMBER_ID,MEMBER_NAME
HAVING COUNT(*) = (
SELECT MAX(COUNT(*))
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS O ON M.MEMBER_ID = O.MEMBER_ID
GROUP BY M.MEMBER_ID);


--8. 고객이 주문한 금액의 총합이 가장 큰 사람과 가장 적은 사람의 차이를 구하시오.
--(
	--사용 테이블 : PRODUCT_ORDERS
--	출력 컬럼 : 주문한 금액의 총합이 가장 큰 사람과 가장 적은 사람의 차이
--)
SELECT ABS(MAX_OP-MIN_OP) AS 차이
FROM(
SELECT MAX(ORDER_PRICE)MAX_OP
FROM PRODUCT_ORDERS),(
SELECT MIN(ORDER_PRICE) MIN_OP
FROM PRODUCT_ORDERS);

--9. 전체 주문 금액의 평균보다 주문 금액의 평균이 더 큰 고객의 아이디, 이름, 주문 금액 평균액을 출력하시오.
--(
	--사용 테이블 : MEMBER, PRODUCT_ORDERS
	--출력 컬럼 : 아이디, 이름, 주문 금액 평균액
--)
SELECT * FROM PRODUCT_ORDERS;
SELECT * FROM MEMBER;

SELECT M.MEMBER_ID,MEMBER_NAME,ROUND(AVG(ORDER_PRICE))
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS PO ON M.MEMBER_ID = PO.MEMBER_ID
GROUP BY M.MEMBER_ID,MEMBER_NAME
HAVING AVG(ORDER_PRICE) > (SELECT AVG(ORDER_PRICE) AVG_OP
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS PO ON M.MEMBER_ID = PO.MEMBER_ID);


--10. 부하직원이 가장 많은 사원의 사번, 이름, 부하직원 수를 구하시오.
--(
--	사용 테이블 : EMP
--	출력 컬럼 : 사번, 이름, 부하직원 수
--)
SELECT E1.EMPNO,E1.ENAME,COUNT(*) AS 부하직원
FROM EMP E1
INNER JOIN EMP E2 ON E1.EMPNO = E2.MGR
GROUP BY E1.EMPNO,E1.ENAME
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM EMP E1
INNER JOIN EMP E2 ON E1.EMPNO = E2.MGR
GROUP BY E1.EMPNO);

SELECT * FROM STU;
--11. 본인보다 높은 학년인 사람의 학생 수 구하고, 아래 이미지와 같이 결과를 도출하시오.
--(사용 테이블 : STU)

????????????????????????????????????????????????


--12.학생들의 성별(남,여) 인원수를 구하고, 아래 이미지와 같이 결과를 도출하시오.
--(사용 테이블 : STU)
--
SELECT 성,COUNT(*)
FROM(
SELECT 
NAME, 
SUBSTR(JUMIN,7,1),
DECODE(SUBSTR(JUMIN,7,1), 1, '남자', '여자') AS 성
FROM STU)
GROUP BY 성;