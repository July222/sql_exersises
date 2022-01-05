/*
MS SQL Server
https://www.hackerrank.com/challenges/challenges/problem

Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name,
and the total number of challenges created by each student. Sort your results by the total number of challenges
in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id.
If more than one student created the same number of challenges and the count is less than the maximum number
of challenges created, then exclude those students FROM the result.

 */

 
SELECT
    id,
    name,
    total_num
FROM
    (
        SELECT
            id,
            name,
            total_num,
            RANK() OVER (ORDER BY total_num DESC) AS quan_rank,
            COUNT(id) OVER (PARTITION BY total_num) AS hackers_quan
        FROM
        (
            SELECT
                h.hacker_id id,
                h.name name,
                COUNT(c.challenge_id) AS total_num
            FROM Hackers h
            INNER JOIN Challenges c
                on h.hacker_id = c.hacker_id
            GROUP BY
                     h.hacker_id,
                     h.name
        ) t1
    ) t2
WHERE quan_rank=1 OR hackers_quan=1
ORDER BY
    total_num DESC,
    id;
