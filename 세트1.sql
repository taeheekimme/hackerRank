Weather Observation Station 17 : https://www.hackerrank.com/challenges/weather-observation-station-17/problem

- lat_n�� 38.7780���ٴ� ū �͵��� ���� long_w�� ����
SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N >38.7780
ORDER BY LAT_N
LIMIT 1


Contest Leaderboard : https://www.hackerrank.com/challenges/contest-leaderboard/problem

��Ŀ���� ���� ��� : ������ ���� ū ������ ���� / ������������Ͽ� ������ ����ū���� ������, ���ο��� �ջ�
SELECT B.hacker_id, b.name, sum(score) as score
FROM (SELECT hacker_id, challenge_id,max(score) as score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
    ORDER BY hacker_id) A
INNER JOIN hackers B
ON A.hacker_id = B.hacker_id
GROUP BY B.hacker_id, b.name
HAVING score != 0 
ORDER BY score DESC, B.hacker_id #�׷�ȭ ������� ���� ���͸��̹Ƿ� where�� �ƴ� having




New Companies : https://www.hackerrank.com/challenges/the-company/problem
Join�� ������� ���� �ٸ� ������� Ǯ�� ������.

��å�� ������ ����/ SELECT�� �����������


SELECT a.company_code, a.founder,

    (SELECT COUNT(DISTINCT lead_manager_code)
      FROM Lead_Manager
     WHERE company_code = a.company_code), #a.compamy_code�� ���ϴ� �͵鸸 ���͸�
                                           #lead manager ����

    (SELECT COUNT(DISTINCT senior_manager_code)  #senior manager ����
      FROM senior_Manager
     WHERE company_code = a.company_code),
     
      (SELECT COUNT(DISTINCT manager_code)     #manager ����
      FROM Manager
     WHERE company_code = a.company_code),
     
      (SELECT COUNT(DISTINCT employee_code)     #employee ����
      FROM Employee
     WHERE company_code = a.company_code)


FROM Company a
ORDER BY company_code


@����
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

�������� �̸�ǥ�� / �ǹ����� ��ȯ


SELECT MIN(CASE WHEN occupation = 'Doctor' THEN Name ELSE NULL END) doctor,
       # NULL�� ��¾��Ϸ��� MIN ��� --> �� �Լ����� NULL�� �����ϴϱ�
       
        MIN(CASE WHEN occupation = 'Professor' THEN Name ELSE NULL END) Professor,
        
         MIN(CASE WHEN occupation = 'Singer' THEN Name ELSE NULL END) Singer,
         
          MIN(CASE WHEN occupation = 'Actor' THEN Name ELSE NULL END) Actor
FROM (SELECT occupation, name,
           ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) rn
           # �������Լ� ����ؼ� ������ �̸� ����
           # ��ŷ�� ���̸� �������� ù��° ����� ���Ⱑ�� --> ��ŷ�� 1�λ������ ù���̵�
           # �̰� ����Į������ �ؼ� �׷���̷� �Ǻ�����
     FROM Occupations) a

GROUP BY rn
ORDER BY rn



GROUP BY�� ���� ���ؼ���

SELECT���� �־�� ����� �� �ִ°ɷ� �ƴµ�

����1�� 4������ OccupationsǮ�̸� ����

SELECT������ rn�� ������ ���ڵ尡 �Ǵ� ������ �ñ��մϴ�.
GROUP BY�� ����ϱ� ���ؼ��� SELECT ���� �׷�ȭ�� �׸���� ���Խ��Ѿ� �մϴ�. ������, ����1�� 4�� ������ ���� GROUP BY�� ����ϴ� ��ſ� ROW_NUMBER() �Լ��� ����Ͽ� ��ũ�� �ο��ϰ�, ��ũ�� 2�� ���� ����ϴ� ���Դϴ�.

��, �� ��쿡�� GROUP BY�� ������� �ʰ�, SELECT ������ rn(��ũ) �׸� �������ָ� �ǹǷ� rn�� �����ص� �������� �۵��մϴ�.

���� GROUP BY�� ����Ѵٸ� ���õǴ� �׸���� �޶��� �� ���� ���Դϴ�.



MIN�� MAX ��� SUM�� ����ϸ� SUM�� ���ڿ������ ���ؼ� ��Ŀ��ũ������ Ʋ���Ե�(�Ʒ� �Ǻ����̺� �����ϸ��)
https://www.inflearn.com/course/lecture?tab=curriculum&volume=1.00&courseSlug=%ED%8C%90%EB%8B%A4%EC%8A%A4-%EA%B3%B5%EC%8B%9D-%EB%AC%B8%EC%84%9C&unitId=79952



SQL �ʱ޿��� GROUP BY �� ����� ����, �׷�ȭ�� ������ �Ǵ� �÷��� SELECT ������ �ݵ�� ������� ����� ������ ����մϴ�
GROUP BY �� �ϴ� ������ � ����(�÷�)���� �����͸� ������, �� �׸񺰷� ���踦 �ϱ� �����Դϴ�.
�׷��� �� ������ ���� ������ �ʴ´ٸ� ����� �����Ͱ� ������ �ش��ϴ� ������ �˱Ⱑ ��ƽ��ϴ�.
�׷��� ������ ������ �Ǵ� �÷��� SELECT ���� ���������ν� ������� ��µǵ��� �ϴ� ��찡 �Ϲ����Դϴ�.
�ٸ�, SELECT ���� ���Ե��� �ʴ´ٰ� �ؼ� ���� ��ü�� �۵����� �ʴ� ���� �ƴմϴ�. 
�� ���������� �Ǻ� ���̺� ���¸� ����� ������ ���� GROUP BY�� ����߰�, output�� ��ŷ�� �ش��ϴ� �÷��� ���Ե��� �ʱ⸦ �䱸�߽��ϴ�. 
��ó�� ���ϴ� ������ ���¿� �°� ������ �ۼ��Ͻø� �ǰڽ��ϴ�. 
