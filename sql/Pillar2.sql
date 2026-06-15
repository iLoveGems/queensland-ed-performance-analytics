SELECT
    year,
    health_service,
    facility_name,
    ROUND (AVG(median_waiting_time_minutes), 1) AS avg_median_waiting_time_minutes
FROM
    ed_master
WHERE
    facility_code <> 99999
    AND
    triage_category = 'ALL'
GROUP BY
    year,
    health_service,
    facility_name
ORDER BY
    year,
    avg_median_waiting_time_minutes DESC;
-- 2.1: Median waiting time to treatment by year and facility ordered by the highest waiting facility.



SELECT
    year,
    health_service,
    triage_category,
    ROUND(
        SUM(patients_seen_within_recommended_times_percent * number_of_attendances)
        / NULLIF(SUM(number_of_attendances),0), 
        1
        ) AS weighted_seen_within_recommended_times_percent,
    SUM(number_of_attendances) AS total_attendances
FROM
    ed_master
WHERE
    triage_category <> 'ALL'
    AND
    facility_code <> 99999
GROUP BY
    year,
    health_service,
    triage_category
ORDER BY
    year,
    health_service,
    triage_category;
-- 2.2: Patients seen within clinically recommended times. Sorted by hospital and triage category



SELECT
    year,
    triage_category,
    ROUND(
        AVG(patients_seen_within_recommended_times_percent), 
        1 
        ) AS qld_seen_within_recommended_times_perecent,
    SUM(number_of_attendances) AS total_attendances
FROM
    ed_master
WHERE
    triage_category <> 'ALL'
    AND
    facility_code = 99999
GROUP BY
    year,
    triage_category
ORDER BY
    year,
    triage_category;
-- 2.3: Queensland performance based off of triage categories.



