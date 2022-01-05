/*
MS SQL Server
https://www.hackerrank.com/challenges/symmetric-pairs/problem

You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.


 */

SELECT DISTINCT
    f1.X,
    f1.Y
FROM 
    (SELECT X, Y, ROW_NUMBER() OVER (ORDER BY X, Y) rown1 FROM Functions)  f1
LEFT JOIN
    (SELECT X, Y, ROW_NUMBER() OVER (ORDER BY X, Y) rown2 FROM Functions) f2
    ON f1.X=f2.Y AND f1.Y=f2.X
WHERE f1.X<=f1.Y AND f1.rown1<>f2.rown2
ORDER BY X ASC;
