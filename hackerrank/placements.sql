/*
MS SQL Server
https://www.hackerrank.com/challenges/placements/problem

You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains
two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary
(offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them.
Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students
got same salary offer.
 */
 
SELECT
    s.Name
FROM Students s
INNER JOIN Friends f ON s.ID=f.ID
LEFT JOIN Packages p1 ON s.ID=p1.ID
LEFT JOIN Packages p2 ON f.Friend_ID=p2.ID
WHERE p2.Salary>p1.Salary
ORDER BY p2.Salary;
