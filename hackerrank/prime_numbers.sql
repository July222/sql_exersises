/*
MS SQL Server
https://www.hackerrank.com/challenges/print-prime-numbers/problem

Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line,
and use the ampersand character as your separator (instead of a space).

 */
 
DECLARE @result nvarchar(4000) = '2&';
DECLARE @number int = 3;
DECLARE @is_prime int = 1;
DECLARE @compare int = 2;

WHILE (@number<=1000)
BEGIN
    WHILE (@compare<@number)
    BEGIN
        IF @number % @compare = 0
        BEGIN
            SET @is_prime = 0;
            BREAK
        END
        ELSE
            SET @compare+=1;
    END
    IF @is_prime = 1
        SET @result+=CAST(@number AS nvarchar(3))+'&'
    ELSE
        SET @is_prime = 1
    SET @compare = 2;
    SET @number+=1;
END
PRINT LEFT(@result,len(@result)-1);
