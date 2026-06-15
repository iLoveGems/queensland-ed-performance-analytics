SELECT
    ed.year,
    ed.facility_code,
    pg.remoteness,
    ed.facility_name,

    ROUND (
        SUM(ed.ed_stay_within_4_hours_percent * ed.number_of_attendances)
        / NULLIF(SUM(ed.number_of_attendances), 0),
        1
    ) AS weighted_ed_stay_within_4_hours_pct,

    ROUND (
        SUM(ed.patients_admitted_from_ed_percent * ed.number_of_attendances)
        / NULLIF(SUM(ed.number_of_attendances), 0),
        1
    ) AS weighted_admitted_from_ed_pct,

    ROUND(
        SUM(ed.admission_to_hospital_within_4_hours_percent 
        * (ed.number_of_attendances * ed.patients_admitted_from_ed_percent / 100.0))
            / NULLIF(SUM(ed.number_of_attendances * ed.patients_admitted_from_ed_percent / 100.0), 0
        ), 1
    ) AS weighted_admitted_to_hospital_within_4_hours_pct,

    SUM(ed.number_of_attendances) AS total_attendances
FROM
    ed_master AS ed
INNER JOIN
    hospital_peer_groups AS pg
    ON ed.facility_code = pg.facility_code
WHERE
    ed.triage_category = 'ALL'
    AND
    ed.facility_code <> 99999
GROUP BY
    ed.year,
    ed.facility_code,
    pg.remoteness,
    ed.facility_name
ORDER BY
    ed.year,
    pg.remoteness,
    ed.facility_name;
-- 3.1: Average reporting-period percentage by facility and year.




SELECT
    ed.year,
    ed.facility_code,
    pg.remoteness,
    ed.facility_name,
    SUM(ed.number_of_attendances) AS total_attendances,

    ROUND(
        SUM(ed.number_did_not_wait_for_treatment) * 100.0
        / NULLIF(SUM(ed.number_of_attendances), 0),
        1
    ) AS calculated_did_not_wait_for_treatment_pct,

    SUM(ed.number_did_not_wait_for_treatment)
        AS number_did_not_wait_for_treatment,

    ROUND(
        SUM(ed.number_left_after_treatment_commenced) * 100.0
        / NULLIF(SUM(ed.number_of_attendances), 0),
        1
    ) AS calculated_left_after_treatment_commenced_pct,

    SUM(ed.number_left_after_treatment_commenced)
        AS number_left_after_treatment_commenced

FROM
    ed_master AS ed
INNER JOIN
    hospital_peer_groups AS pg
ON
    ed.facility_code = pg.facility_code
WHERE
    ed.triage_category = 'ALL'
    AND ed.facility_code <> 99999
GROUP BY
    ed.year,
    ed.facility_code,
    pg.remoteness,
    ed.facility_name
ORDER BY
    ed.year,
    pg.remoteness,
    ed.facility_name;
-- Query to investigate: Did-not-wait and left-after-treatment metrics by year and facility
