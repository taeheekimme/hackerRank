Weather Observation Station 17 : https://www.hackerrank.com/challenges/weather-observation-station-17/problem

- lat_n이 38.7780보다는 큰 것들중 작은 long_w를 추출
SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N >38.7780
ORDER BY LAT_N
LIMIT 1


Contest Leaderboard : https://www.hackerrank.com/challenges/contest-leaderboard/problem

해커들의 점수 계산 : 문제당 가장 큰 점수만 선택 / 서브쿼리사용하여 문제당 가장큰점수 선택후, 메인에서 합산
SELECT B.hacker_id, b.name, sum(score) as score
FROM (SELECT hacker_id, challenge_id,max(score) as score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
    ORDER BY hacker_id) A
INNER JOIN hackers B
ON A.hacker_id = B.hacker_id
GROUP BY B.hacker_id, b.name
HAVING score != 0 
ORDER BY score DESC, B.hacker_id #그룹화 결과물로 인한 필터링이므로 where이 아닌 having




New Companies : https://www.hackerrank.com/challenges/the-company/problem
Join을 사용하지 말고 다른 방법으로 풀어 보세요.

직책별 직원수 추출/ SELECT에 서브쿼리사용


SELECT a.company_code, a.founder,

    (SELECT COUNT(DISTINCT lead_manager_code)
      FROM Lead_Manager
     WHERE company_code = a.company_code), #a.compamy_code에 속하는 것들만 필터링
                                           #lead manager 숫자

    (SELECT COUNT(DISTINCT senior_manager_code)  #senior manager 숫자
      FROM senior_Manager
     WHERE company_code = a.company_code),
     
      (SELECT COUNT(DISTINCT manager_code)     #manager 숫자
      FROM Manager
     WHERE company_code = a.company_code),
     
      (SELECT COUNT(DISTINCT employee_code)     #employee 숫자
      FROM Employee
     WHERE company_code = a.company_code)


FROM Company a
ORDER BY company_code


@조인
SELECT C.company_code
     , C.Founder
     , COUNT(DISTINCT LM.lead_manager_code)
     , COUNT(DISTINCT SM.senior_manager_code)
     , COUNT(DISTINCT M.manager_code)
     , COUNT(DISTINCT E.employee_code)
FROM Company C
     LEFT JOIN Lead_Manager LM ON LM.company_code = C.company_code
     LEFT JOIN Senior_Manager SM ON LM.lead_manager_code = SM.lead_manager_code
     LEFT JOIN Manager M ON M.senior_manager_code = SM.senior_manager_code
     LEFT JOIN Employee E ON E.manager_code = M.manager_code
GROUP BY C.company_code, C.Founder
ORDER BY C.company_code




Occupations : https://www.hackerrank.com/challenges/occupations/problem

직업별로 이름표기 / 피벗형태 변환


SELECT MIN(CASE WHEN occupation = 'Doctor' THEN Name ELSE NULL END) doctor,
       # NULL값 출력안하려고 MIN 사용 --> 이 함수들은 NULL을 무시하니까
       
        MIN(CASE WHEN occupation = 'Professor' THEN Name ELSE NULL END) Professor,
        
         MIN(CASE WHEN occupation = 'Singer' THEN Name ELSE NULL END) Singer,
         
          MIN(CASE WHEN occupation = 'Actor' THEN Name ELSE NULL END) Actor
FROM (SELECT occupation, name,
           ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) rn
           # 윈도우함수 사용해서 직업별 이름 나열
           # 랭킹을 붙이면 직업별로 첫번째 사람들 추출가능 --> 랭킹이 1인사람들은 첫행이됨
           # 이거 기준칼럼으로 해서 그룹바이로 피봇형태
     FROM Occupations) a

GROUP BY rn
ORDER BY rn



GROUP BY를 쓰기 위해서는

SELECT절에 있어야 사용할 수 있는걸로 아는데

섹션1의 4번문제 Occupations풀이를 보면

SELECT절에서 rn을 지워도 런코드가 되는 이유가 궁금합니다.
GROUP BY를 사용하기 위해서는 SELECT 절에 그룹화할 항목들을 포함시켜야 합니다. 하지만, 섹션1의 4번 문제의 경우는 GROUP BY를 사용하는 대신에 ROW_NUMBER() 함수를 사용하여 랭크를 부여하고, 랭크가 2인 값만 출력하는 것입니다.

즉, 이 경우에는 GROUP BY을 사용하지 않고, SELECT 절에서 rn(랭크) 항목만 선택해주면 되므로 rn을 제거해도 문제없이 작동합니다.

만약 GROUP BY을 사용한다면 선택되는 항목들이 달라질 수 있을 것입니다.



MIN과 MAX 대신 SUM을 사용하면 SUM은 문자열계산을 못해서 해커랭크에서는 틀린게됨(아래 피봇테이블 이해하면됨)
https://www.inflearn.com/course/lecture?tab=curriculum&volume=1.00&courseSlug=%ED%8C%90%EB%8B%A4%EC%8A%A4-%EA%B3%B5%EC%8B%9D-%EB%AC%B8%EC%84%9C&unitId=79952



SQL 초급에서 GROUP BY 를 사용할 때는, 그룹화의 기준이 되는 컬럼을 SELECT 구문에 반드시 적으라고 배웠던 것으로 기억합니다
GROUP BY 를 하는 이유는 어떤 기준(컬럼)으로 데이터를 나눠서, 각 항목별로 집계를 하기 위함입니다.
그런데 이 기준이 눈에 보이지 않는다면 집계된 데이터가 무엇에 해당하는 것인지 알기가 어렵습니다.
그렇기 때문에 기준이 되는 컬럼도 SELECT 절에 기입함으로써 결과물에 출력되도록 하는 경우가 일반적입니다.
다만, SELECT 절에 포함되지 않는다고 해서 쿼리 자체가 작동하지 않는 것은 아닙니다. 
이 문제에서는 피봇 테이블 형태를 만드는 과정을 위해 GROUP BY를 사용했고, output에 랭킹에 해당하는 컬럼이 포함되지 않기를 요구했습니다. 
이처럼 원하는 데이터 형태에 맞게 쿼리를 작성하시면 되겠습니다. 
