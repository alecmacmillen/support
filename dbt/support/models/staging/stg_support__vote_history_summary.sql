WITH setup_16 AS (
    SELECT voter_registration_num AS sos_id
        ,application_status AS application_status_16
        ,ballot_status AS ballot_status_16
        ,status_reason AS status_reason_16
        ,application_date AS application_date_16
        ,ballot_issued_date AS ballot_issued_date_16
        ,ballot_return_date AS ballot_return_date_16
        ,ballot_style AS ballot_style_16
        ,challenged_provisional AS challenged_provisional_16
        ,ROW_NUMBER() OVER (
            PARTITION BY voter_registration_num
            ORDER BY 
                CASE WHEN ballot_status = 'A' THEN 1
                    WHEN ballot_status IN ('C','R') THEN 2
                    WHEN application_status = 'A' THEN 3
                    WHEN application_status = 'R' THEN 4
                    ELSE 5 END
            ,ballot_return_date DESC NULLS LAST
            ,ballot_issued_date DESC NULLS LAST
            ,application_date DESC NULLS LAST
        ) AS record_priority_16
    FROM {{ source('support', 'statewide_2016') }}
)

, setup_18 AS (
    SELECT voter_registration_num AS sos_id
        ,application_status AS application_status_18
        ,ballot_status AS ballot_status_18
        ,status_reason AS status_reason_18
        ,application_date AS application_date_18
        ,ballot_issued_date AS ballot_issued_date_18
        ,ballot_return_date AS ballot_return_date_18
        ,ballot_style AS ballot_style_18
        ,challenged_provisional AS challenged_provisional_18
        ,ROW_NUMBER() OVER (
            PARTITION BY voter_registration_num
            ORDER BY 
                CASE WHEN ballot_status = 'A' THEN 1
                    WHEN ballot_status IN ('C','R') THEN 2
                    WHEN application_status = 'A' THEN 3
                    WHEN application_status = 'R' THEN 4
                    ELSE 5 END
            ,ballot_return_date DESC NULLS LAST
            ,ballot_issued_date DESC NULLS LAST
            ,application_date DESC NULLS LAST
        ) AS record_priority_18
    FROM {{ source('support', 'statewide_2018') }}
)

, setup_20 AS (
    SELECT voter_registration_num AS sos_id
        ,application_status AS application_status_20
        ,ballot_status AS ballot_status_20
        ,status_reason AS status_reason_20
        ,application_date AS application_date_20
        ,ballot_issued_date AS ballot_issued_date_20
        ,ballot_return_date AS ballot_return_date_20
        ,ballot_style AS ballot_style_20
        ,challenged_provisional AS challenged_provisional_20
        ,ROW_NUMBER() OVER (
            PARTITION BY voter_registration_num
            ORDER BY 
                CASE WHEN ballot_status = 'A' THEN 1
                    WHEN ballot_status IN ('C','R') THEN 2
                    WHEN application_status = 'A' THEN 3
                    WHEN application_status = 'R' THEN 4
                    ELSE 5 END
            ,ballot_return_date DESC NULLS LAST
            ,ballot_issued_date DESC NULLS LAST
            ,application_date DESC NULLS LAST
        ) AS record_priority_20
    FROM {{ source('support', 'statewide_2020') }}
)

, setup_22 AS (
    SELECT voter_registration_num AS sos_id
        ,application_status AS application_status_22
        ,ballot_status AS ballot_status_22
        ,status_reason AS status_reason_22
        ,application_date AS application_date_22
        ,ballot_issued_date AS ballot_issued_date_22
        ,ballot_return_date AS ballot_return_date_22
        ,ballot_style AS ballot_style_22
        ,challenged_provisional AS challenged_provisional_22
        ,ROW_NUMBER() OVER (
            PARTITION BY voter_registration_num
            ORDER BY 
                CASE WHEN ballot_status = 'A' THEN 1
                    WHEN ballot_status IN ('C','R') THEN 2
                    WHEN application_status = 'A' THEN 3
                    WHEN application_status = 'R' THEN 4
                    ELSE 5 END
            ,ballot_return_date DESC NULLS LAST
            ,ballot_issued_date DESC NULLS LAST
            ,application_date DESC NULLS LAST
        ) AS record_priority_22
    FROM {{ source('support', 'statewide_2022') }}
)

SELECT COALESCE(s1.sos_id, s2.sos_id, s3.sos_id, s4.sos_id) AS sos_id
  ,s1.* EXCEPT (sos_id)
  ,s2.* EXCEPT (sos_id)
  ,s3.* EXCEPT (sos_id)
  ,s4.* EXCEPT (sos_id)
FROM setup_16 s1
  FULL OUTER JOIN setup_18 s2 USING (sos_id)
  FULL OUTER JOIN setup_20 s3 USING (sos_id)
  FULL OUTER JOIN setup_22 s4 USING (sos_id)
WHERE s1.record_priority_16 = 1
  AND s2.record_priority_18 = 1
  AND s3.record_priority_20 = 1
  AND s4.record_priority_22 = 1
