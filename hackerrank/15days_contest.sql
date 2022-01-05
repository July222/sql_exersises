/*
MS SQL Server
https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem

Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date
was March 15, 2016.

Write a query to print total number of unique hackers who made at least 1 submission each day
(starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of
submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id.
The query should print this information for each day of the contest, sorted by the date.

 */
 
SELECT
    t5.submission_date,
    t6.quan,
    h.hacker_id,
    h.name
FROM
    (SELECT
        submission_date,
        hacker_id,
        ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY quan DESC, hacker_id ASC) AS h_rank
    FROM
        (SELECT
            submission_date,
            hacker_id,
            COUNT(submission_id) as quan
         FROM submissions
         GROUP BY submission_date, hacker_id
        ) t4
    ) t5
LEFT JOIN Hackers h ON t5.hacker_id=h.hacker_id
LEFT JOIN    
    (
        SELECT
            submission_date,
            COUNT(DISTINCT hacker_id) quan
        FROM
            (
            SELECT
                *,
                COUNT(hacker_id) as quan
            FROM
                (SELECT
                    s1.submission_date as submission_date,
                    s1.hacker_id hacker_id,
                    DENSE_RANK() OVER(ORDER BY s1.submission_date ASC) AS date_rank
                FROM
                (SELECT DISTINCT submission_date, hacker_id FROM Submissions) s1,
                (SELECT DISTINCT submission_date, hacker_id FROM Submissions) s2
                WHERE s1.hacker_id=s2.hacker_id AND s1.submission_date>=s2.submission_date) t
            GROUP BY submission_date, hacker_id, date_rank
            HAVING count(hacker_id)=date_rank) tmp
        GROUP BY submission_date
    ) t6
on t5.submission_date=t6.submission_date
WHERE h_rank = 1
ORDER BY t5.submission_date;
