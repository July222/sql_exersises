/*
MS SQL Server
https://www.hackerrank.com/challenges/sql-projects/problem

You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed
that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
If the End_Date of the tasks are consecutive, then they are part of the same project.
Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete
the project in ascending order. If there is more than one project that have the same number of completion days,
then order by the start date of the project.
 */
 
SELECT
    Start_Date,
    End_Date
FROM
    (SELECT
        Start_Date,
        ROW_NUMBER() OVER (ORDER BY Start_Date) rn
    FROM Projects
    WHERE Start_Date NOT IN (SELECT DISTINCT End_Date FROM Projects)
    ) t1
INNER JOIN
    (SELECT
        End_Date,
        ROW_NUMBER() OVER (ORDER BY Start_Date) rn
    FROM Projects
    Where End_Date NOT IN (SELECT DISTINCT Start_Date FROM Projects)
    ) t2
ON t1.rn=t2.rn
ORDER BY DATEDIFF(d, Start_Date, End_Date) ASC, Start_Date ASC;
