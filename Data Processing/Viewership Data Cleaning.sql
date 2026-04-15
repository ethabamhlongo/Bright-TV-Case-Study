select * from `workspace`.`default`.`viewership` limit 100;

-------------------------------------------------------
---1.FIRST DATE RECORDED : 2016/01/01
SELECT MIN(Record_Date) AS First_Date
FROM WORKSPACE.DEFAULT.VIEWERSHIP ;
---2.LAST DATE RECORDED : 2016/03/31
SELECT MAX(Record_Date)AS Last_Date
FROM WORKSPACE.DEFAULT.VIEWERSHIP;
----------------------------------------------------------
--3.FINDING DISTINCT CHANNELS
SELECT  DISTINCT Channel
FROM WORKSPACE.DEFAULT.VIEWERSHIP;
----------------------------------------------------------
--4.LONGEST(29:28 )AND SHORTEST(00:00) DURATIONS
SELECT MIN(Duration) AS Shortest_duration,
       MAX(Duration) AS Longest_duration
FROM WORKSPACE.DEFAULT.VIEWERSHIP ;   

---------------------------------------------------------
SELECT COUNT(User_ID) AS Total_IDS
FROM WORKSPACE.DEFAULT.VIEWERSHIP ;
---------------------------------------------------------
---5.Most watched Channel :KykNET , Least Watched :Africa Magic
SELECT MAX(Channel)AS Most_watched,
       MIN(Channel)AS Least_watched
       FROM WORKSPACE.DEFAULT.VIEWERSHIP ;
 ------------------------------------------------------
 --6. Time Buckets
SELECT *,
   CASE
      WHEN date_format(Duration,'HH:mm:ss') BETWEEN '00:00:00' AND '00:06:59' THEN 'SHORT DURATION'
      WHEN date_format(Duration,'HH:mm:ss') BETWEEN '00:07:00' AND '00:30:59' THEN 'MEDIUM DURATION'
      ELSE 'LONG DURATION'
      END AS duration_type, 
    
--------------------------------------------------------
---7.TIME OF DAY
Dayname(TO_TIMESTAMP(Record_Date, 'yyyy/MM/dd HH:mm')) AS Day_name,
--- 2nd column
     Monthname(TO_TIMESTAMP(Record_Date, 'yyyy/MM/dd HH:mm')) AS Month_name,
---3rd column
    Dayofmonth(TO_TIMESTAMP(Record_Date, 'yyyy/MM/dd HH:mm')) AS Day_of_month,
--- Determining weekday/weekend
  CASE 
     WHEN Dayname(TO_TIMESTAMP(Record_Date, 'yyyy/MM/dd HH:mm')) IN ('Sun','Sat') THEN 'Weekend'
     ELSE 'Weekday'
     END AS Day_classification
     FROM WORKSPACE.DEFAULT.VIEWERSHIP ;
    
       
--------------------------------------------------------
--8.MOST POPULAR CHANNELS -IMPO
SELECT 
  Channel,
  COUNT(User_ID) AS total_views
  FROM WORKSPACE.DEFAULT.VIEWERSHIP 
GROUP BY Channel
ORDER BY total_views ASC
LIMIT 5 ;

------------------------------------------------------------
--9.PEAK VIEWING TIME
SELECT
  HOUR(TO_TIMESTAMP(Record_Date, 'yyyy/MM/dd HH:mm')) AS Peak_Time,
  COUNT(*) AS total_views
  FROM WORKSPACE.DEFAULT.VIEWERSHIP 
GROUP BY Peak_Time
ORDER BY total_views DESC;
---------------------------------------------------------
--11.VIEWERSHIP BY PROVINCE
SELECT 
  u.Province,
  COUNT(*) AS total_viewers
FROM WORKSPACE.DEFAULT.VIEWERSHIP AS v
JOIN  WORKSPACE.DEFAULT.USER_PROFILES AS u
ON v.User_ID = u.User_ID
GROUP BY u.Province
ORDER BY total_viewers DESC;
