/*
MS SQL Server
https://www.hackerrank.com/challenges/interviews/problem

Samantha interviews many candidates FROM different colleges using coding challenges and contests.
Write a query to print the contest_id, hacker_id, name, and the SUMs of total_submissions, total_accepted_submissions,
total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest FROM the result
if all four SUMs are 0.

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds 1
screening contest.


 */

SELECT 
    c.contest_id,
    c.hacker_id,
    c.name, 
    SUM(total_submissions) AS total_submissions,
    SUM(total_accepted_submissions) AS total_accepted_submissions,
    SUM(total_views) AS total_views,
    SUM(total_unique_views) AS total_unique_views
FROM contests c
INNER JOIN colleges col ON c.contest_id=col.contest_id
INNER JOIN challenges cc ON col.college_id=cc.college_id
LEFT JOIN
    (
        SELECT
            challenge_id,
            SUM(total_views) AS total_views,
            SUM(total_unique_views) AS total_unique_views
        FROM View_Stats
        GROUP BY challenge_id
    ) vs
    ON cc.challenge_id=vs.challenge_id
LEFT JOIN
    (
        SELECT
            challenge_id,
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions
        FROM Submission_Stats
        GROUP BY challenge_id
    ) AS ss
    ON cc.challenge_id=ss.challenge_id
GROUP  BY
          c.contest_id,
          c.hacker_id,
          c.name
HAVING NOT (SUM(total_submissions)=0
            AND SUM(total_accepted_submissions)=0
            AND SUM(total_views)=0
            AND SUM(total_unique_views)=0)
order by c.contest_id;
