/*
MS SQL Server
https://www.hackerrank.com/challenges/full-score/problem

Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one
challenge. Order your output in descending order by the total number of challenges in which the hacker earned
a full score. If more than one hacker received full scores in same number of challenges,
then sort them by ascending hacker_id.

 */

SELECT
    h.hacker_id,
    h.name
FROM Submissions s
INNER JOIN Challenges c
    ON s.challenge_id=c.challenge_id
INNER JOIN Difficulty d
    ON c.difficulty_level=d.difficulty_level
           AND s.score=d.score
LEFT JOIN hackers h
    ON s.hacker_id = h.hacker_id
GROUP BY
         h.hacker_id,
         h.name
HAVING COUNT(DISTINCT s.challenge_id)>1
ORDER BY
         COUNT(DISTINCT s.challenge_id) DESC,
         h.hacker_id ASC;
