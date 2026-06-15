CREATE DATABASE
    ed_portfolio;



CREATE TABLE 
    ed_master (
        facility_code INTEGER,
        health_service TEXT,
        facility_name TEXT,
        last_month_in_qtr DATE,
        month INTEGER,
        quarter INTEGER,
        year INTEGER,
        triage_category TEXT,
        number_of_attendances INTEGER,
        variation_attendance_percent NUMERIC,
        patients_seen_within_recommended_times_percent NUMERIC,
        median_waiting_time_minutes NUMERIC,
        patients_did_not_wait_for_treatment_percent NUMERIC,
        patients_admitted_from_ed_percent NUMERIC,
        admission_to_hospital_within_4_hours_percent NUMERIC,
        ed_stay_within_4_hours_percent NUMERIC,
        number_left_after_treatment_commenced INTEGER,
        percent_left_after_treatment_commenced NUMERIC,
        number_did_not_wait_for_treatment INTEGER
);
--Creating table corresponding with Master_ED_FINAL



CREATE TABLE
    hospital_peer_groups (
        facility_code INTEGER PRIMARY KEY,
        facility_name TEXT,
        peer_group TEXT,
        remoteness TEXT
    );
-- Creating table to include category of facility's remoteness
