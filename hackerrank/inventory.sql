/*
MS SQL Server
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem

Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed
to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power
of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power,
sort the result in order of descending age.
 */

SELECT
    id,
    age,
    coins,
    pow
FROM
    (SELECT
        w.id id,
        p.age age,
        w.coins_needed coins,
        [w].[power] pow,
        row_number() OVER (PARTITION BY p.age, [w].[power] ORDER BY w.coins_needed ASC) AS rank
    FROM Wands w
    LEFT JOIN Wands_Property p
        ON w.code=p.code
    WHERE is_evil=0
    ) t
WHERE t.rank=1
ORDER BY
         pow DESC,
         age DESC;
