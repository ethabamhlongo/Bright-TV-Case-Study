SELECT * FROM WORKSPACE.DEFAULT.VIEWERSHIP ;

 ----------------------------------------------------
 --EDA
 -----------------------------------------------------

-- Counts the total number of records
SELECT COUNT(*) AS Total_Rows
FROM WORKSPACE.DEFAULT.VIEWERSHIP;


-- Shows the column names and their data types
DESCRIBE WORKSPACE.DEFAULT.VIEWERSHIP;


-- Counts missing values in each column
SELECT
    SUM(CASE WHEN User_ID IS NULL THEN 1 ELSE 0 END) AS Missing_User_ID,
    SUM(CASE WHEN Channel IS NULL THEN 1 ELSE 0 END) AS Missing_Channel,
    SUM(CASE WHEN Record_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Record_Date,
    SUM(CASE WHEN Duration IS NULL THEN 1 ELSE 0 END) AS Missing_Duration
FROM WORKSPACE.DEFAULT.VIEWERSHIP;


-- Finds duplicate records
SELECT
    User_ID,
    Channel,
    Record_Date,
    Duration,
    COUNT(*) AS Duplicate_Count
FROM WORKSPACE.DEFAULT.VIEWERSHIP
GROUP BY User_ID, Channel, Record_Date, Duration
HAVING COUNT(*) > 1;


-- Shows all different channels
SELECT DISTINCT Channel
FROM WORKSPACE.DEFAULT.VIEWERSHIP;

-- Finds the earliest and latest viewing dates
SELECT
    MIN(Record_Date) AS Earliest_Date,
    MAX(Record_Date) AS Latest_Date
FROM WORKSPACE.DEFAULT.VIEWERSHIP;

-- Shows the minimum, maximum and average viewing duration
SELECT
    MIN(Duration) AS Minimum_Duration,
    MAX(Duration) AS Maximum_Duration,
    AVG(Duration) AS Average_Duration
FROM WORKSPACE.DEFAULT.VIEWERSHIP;
---------------------------------------------------------------------

SELECT
    -- USER PROFILE INFORMATION
    p.User_ID,
    p.Name,
    p.Surname,
    p.Gender,
    p.Race,
    p.Age,
    p.Province,
    
    -- VIEWERSHIP INFORMATION
    v.Channel AS Channel,
    v.Record_Date AS UTC_DateTime,
    v.Duration AS Duration,
    
    -- CONVERT UTC TIME TO SOUTH AFRICAN TIME
    from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg') 
        AS South_Africa_DateTime,
    
    -- DATE FUNCTIONS
    DATE(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS South_Africa_Date,
    
    YEAR(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Year,
    
    MONTH(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Month_Number,
    
    MONTHNAME(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Month_Name,
    
    DAYOFWEEK(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Day_Number,
    
    DATE_FORMAT(
        from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg'),
        'EEEE'
    ) AS Day_Name,
    
    QUARTER(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Quarter,
    
    HOUR(from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')) 
        AS Hour,
    
    -- CONVERT DURATION INTO TOTAL SECONDS
    HOUR(
        v.Duration
    ) * 3600
    +
    MINUTE(
        v.Duration
    ) * 60
    +
    SECOND(
        v.Duration
    ) AS Total_Watch_Seconds,
    
    -- CONVERT DURATION INTO MINUTES
    (
        HOUR(
            v.Duration
        ) * 3600
        +
        MINUTE(
            v.Duration
        ) * 60
        +
        SECOND(
            v.Duration
        )
    ) / 60.0 AS Total_Watch_Minutes,
    
    -- CASE: WEEKDAY VS WEEKEND
    CASE
        WHEN DAYOFWEEK(
            from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')
        ) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    
    -- CASE: TIME OF DAY
    CASE
        WHEN HOUR(
            from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')
        ) BETWEEN 0 AND 5
        THEN 'Early Morning'
        
        WHEN HOUR(
            from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')
        ) BETWEEN 6 AND 11
        THEN 'Morning'
        
        WHEN HOUR(
            from_utc_timestamp(TO_TIMESTAMP(v.Record_Date, 'yyyy/MM/dd HH:mm'), 'Africa/Johannesburg')
        ) BETWEEN 12 AND 17
        THEN 'Afternoon'
        
        ELSE 'Evening'
    END AS Time_of_Day,
    
    -- CASE: AGE GROUP
    CASE
        WHEN p.Age < 18 THEN '0-17'
        WHEN p.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN p.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN p.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN p.Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN p.Age >= 55 THEN '55+'
        ELSE 'Unknown'
    END AS Age_Group,
    
    -- CASE: WATCH-TIME CATEGORY
    CASE
        WHEN (
            HOUR(
                v.Duration
            ) * 3600
            +
            MINUTE(
                v.Duration
            ) * 60
            +
            SECOND(
                v.Duration
            )
        ) < 300
        THEN 'Under 5 Minutes'
        
        WHEN (
            HOUR(
                v.Duration
            ) * 3600
            +
            MINUTE(
                v.Duration
            ) * 60
            +
            SECOND(
                v.Duration
            )
        ) BETWEEN 300 AND 899
        THEN '5-14 Minutes'
        
        WHEN (
            HOUR(
                v.Duration
            ) * 3600
            +
            MINUTE(
                v.Duration
            ) * 60
            +
            SECOND(
                v.Duration
            )
        ) BETWEEN 900 AND 1799
        THEN '15-29 Minutes'
        
        ELSE '30+ Minutes'
    END AS Watch_Time_Category

FROM `WORKSPACE`.`DEFAULT`.`VIEWERSHIP` v

LEFT JOIN `WORKSPACE`.`DEFAULT`.`USER_PROFILES` p
    ON v.User_ID = p.User_ID;




