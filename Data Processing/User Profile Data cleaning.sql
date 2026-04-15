select * from `workspace`.`default`.`User_Profiles` limit 100;

----------------------------------------------------------------
--1. FINDING DIFFERENT PROVINCES
SELECT DISTINCT Province
FROM WORKSPACE.DEFAULT.USER_PROFILES;
---------------------------------------------------
--2. FINDING DIFFERENT RACES
SELECT DISTINCT Race
FROM WORKSPACE.DEFAULT.USER_PROFILES ;
--------------------------------------------------------------------
---3.HOW MANY USERS
SELECT COUNT(User_ID) AS Number_of_users
FROM WORKSPACE.DEFAULT.USER_PROFILES ;

---------------------------------------------------------------------
--1.COUNT OF USERS PER AGE
SELECT 
  CASE 
    WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '50+'
  END AS age_group,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES 
GROUP BY age_group;

-----------------------------------------------------------------------
--2.USERS PER PROVINCE
SELECT 
  Province,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY Province
ORDER BY total_users DESC;

------------------------------------------------------------------------
--3.GENDER DISTRIBUTION
SELECT 
  Gender,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY Gender;

-------------------------------------------------------------------------
--4.
SELECT 
  TRIM(LOWER(Province)) AS clean_province,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY clean_province;
--------------------------------------------------------------------------
--BIG QUERY
--------------------------------------------------------------------------
select * from `workspace`.`default`.`User_Profiles` limit 100;

----------------------------------------------------------------
--1. FINDING DIFFERENT PROVINCES
SELECT DISTINCT Province
FROM WORKSPACE.DEFAULT.USER_PROFILES;
---------------------------------------------------
--2. FINDING DIFFERENT RACES
SELECT DISTINCT Race
FROM WORKSPACE.DEFAULT.USER_PROFILES ;
--------------------------------------------------------------------
---3.HOW MANY USERS
SELECT COUNT(User_ID) AS Number_of_users
FROM WORKSPACE.DEFAULT.USER_PROFILES ;

---------------------------------------------------------------------
--1.COUNT OF USERS PER AGE
SELECT 
  CASE 
    WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '50+'
  END AS age_group,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES 
GROUP BY age_group;

-----------------------------------------------------------------------
--2.USERS PER PROVINCE
SELECT 
  Province,
  COUNT(User_ID) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY Province
ORDER BY total_users DESC;

------------------------------------------------------------------------
--3.GENDER DISTRIBUTION
SELECT 
  Gender,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY Gender;

-------------------------------------------------------------------------
--4.
SELECT 
  TRIM(LOWER(Province)) AS clean_province,
  COUNT(*) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY clean_province;
--------------------------------------------------------------------------
--BIG QUERY
--------------------------------------------------------------------------
SELECT *
FROM WORKSPACE.DEFAULT.USER_PROFILES;
  

SELECT A.User_ID,
       A.Gender,
       A.Race,
       A.Age,
       A.Province,
       B.Channel,
       B.Record_Date,
       B.Duration
FROM WORKSPACE.DEFAULT.USER_PROFILES AS A
FULL OUTER JOIN WORKSPACE.DEFAULT.VIEWERSHIP AS B
ON A.User_ID= B.User_ID  ;
--------------------------------------------------------------------------
SELECT 
  Province,
  COUNT(User_ID) AS total_users
FROM WORKSPACE.DEFAULT.USER_PROFILES
GROUP BY Province
ORDER BY total_users DESC;

------------------------------------------------------------------------------
SELECT Age,
     CASE 
     WHEN Age IS NULL THEN 'UNKNOWN'
     WHEN Age <13 THEN 'PRE TEEN'
     WHEN Age BETWEEN 13 AND 18 THEN 'TEEN'
     WHEN Age BETWEEN 19 AND 30 THEN 'YOUNG ADULT'
     WHEN Age BETWEEN 31 AND 50 THEN 'ADULT'
     WHEN Age BETWEEN 51 AND 65 THEN 'MIDDLE AGED'
     ELSE 'SENIOR'
     END AS AGE_GROUP 
     FROM WORKSPACE.DEFAULT.USER_PROFILES ;

     SELECT 
    User_ID,
    Name,
    Surname,
    Age,
    Province,

    -- AGE GROUP
    CASE 
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS Age_Group,

    -- AGE STAGE (for presentation)
    CASE 
        WHEN Age IS NULL THEN 'UNKNOWN'
        WHEN Age <13 THEN 'PRE TEEN'
        WHEN Age BETWEEN 13 AND 19 THEN 'TEEN'
        WHEN Age BETWEEN 20 AND 34 THEN 'YOUNG ADULT'
        WHEN Age BETWEEN 35 AND 44 THEN 'ADULT'
        WHEN Age BETWEEN 45 AND 54 THEN 'MIDDLE AGED'
        ELSE 'SENIOR'
    END AS Age_Stage,

    -- GENDER GROUP
    CASE 
        WHEN Gender = 'male' THEN 'MALE'
        WHEN Gender = 'female' THEN 'FEMALE'
        ELSE 'UNIDENTIFIED'
    END AS Gender_Group,

    -- RACE GROUP (simplified)
    CASE 
        WHEN Race IN ('black', 'coloured') THEN 'Previously Disadvantaged'
        WHEN Race = 'white' THEN 'White'
        ELSE 'Other'
    END AS Race_Group,

    -- PROVINCE GROUP
    CASE 
        WHEN Province IN ('Gauteng', 'Western Cape') THEN 'Urban'
        WHEN Province IN ('KwaZulu Natal') THEN 'Coastal'
        ELSE 'Other Provinces'
    END AS Province_Group

FROM WORKSPACE.DEFAULT.USER_PROFILES;
