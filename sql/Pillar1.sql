SELECT 
    year,
    health_service,
    SUM (number_of_attendances) AS total_attendances
FROM
    ed_master
WHERE
    facility_code <> '99999'
    AND
    triage_category = 'ALL'
GROUP BY
    year,
    health_service
ORDER BY
    year,
    total_attendances DESC;
-- 1.1: Total attendance by health service from 2015-2025




WITH yearly_attendance AS (
    SELECT
        year,
        health_service,
        SUM(number_of_attendances) AS total_attendances
    FROM
        ed_master
    WHERE
        triage_category = 'ALL'
        AND facility_code <> 99999
    GROUP BY
        year,
        health_service
), 

yearly_change AS (
    SELECT
        year,
        health_service,
        total_attendances,
        LAG(total_attendances) OVER (
            PARTITION BY health_service
            ORDER BY
                year
        ) AS previous_year_attendances
    FROM yearly_attendance
)

SELECT
    year,
    health_service,
    total_attendances,
    previous_year_attendances,
    total_attendances - previous_year_attendances AS attendance_change,
    ROUND (((total_attendances - previous_year_attendances) * 100.0 / previous_year_attendances), 1) AS attendance_change_percent
FROM 
    yearly_change;
-- 1.2: Total attendance by HHS, and yearly change.




SELECT
    year,
    facility_name,
    SUM(number_of_attendances) AS total_attendances
FROM
    ed_master
WHERE
    facility_code <> '99999'
    AND 
    triage_category = 'ALL'
GROUP BY
    year,
    facility_name
ORDER BY
    year,
    total_attendances DESC;
-- 1.4: Total attendance by facility from 2015-2025



SELECT
    year,
    triage_category,
    SUM(number_of_attendances) AS total_attendances
FROM
    ed_master
WHERE 
    facility_code = '99999'
    AND
    triage_category <>'ALL'
GROUP BY
    year,
    triage_category
ORDER BY
    year,
    triage_category;
-- 1.5: Total attendance by triage category from 2015-2025


