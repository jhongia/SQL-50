/*
197. Rising Temperature
Solved
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

# Write your MySQL query statement below
WITH CTE AS(
    SELECT
        id,
        recordDate AS curr_recordDate,
        temperature AS curr_temperature,
        LAG(temperature, 1) OVER (ORDER BY recordDate) AS prev_temperature,
        LAG(recordDate, 1) OVER (ORDER BY recordDate) AS prev_recordDate
    FROM Weather
)
SELECT
    id
FROM
    CTE
WHERE
    DATEDIFF(CTE.curr_recordDate, CTE.prev_recordDate) = 1
    AND
    CTE.curr_temperature > CTE.prev_temperature