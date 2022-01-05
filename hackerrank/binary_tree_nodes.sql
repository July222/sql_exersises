/*
MS SQL Server
https://www.hackerrank.com/challenges/binary-search-tree-1/problem

You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree,
and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of
the following for each node:

    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node.


 */

SELECT DISTINCT
    BST.N,
    IIF(BST.P IS NULL, 'Root', IIF(BST2.N IS NULL, 'Leaf', 'Inner')) AS Type
FROM BST
LEFT JOIN BST BST2
    ON BST.N=BST2.P;