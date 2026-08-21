WITH setup_16 AS (
    SELECT voter_registration_num
        ,application_status
        ,ballot_status
        ,status_reason
        ,application_date
        ,ballot_issued_date
        ,ballot_return_date
        ,ballot_style
        ,challenged_provisional
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
        ) AS record_priority
    FROM abstrat.support.statewide_2016
)

, setup_18 AS (
    SELECT voter_registration_num
        ,application_status
        ,ballot_status
        ,status_reason
        ,application_date
        ,ballot_issued_date
        ,ballot_return_date
        ,ballot_style
        ,challenged_provisional
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
        ) AS record_priority
    FROM abstrat.support.statewide_2018
)

, setup_20 AS (
    SELECT voter_registration_num
        ,application_status
        ,ballot_status
        ,status_reason
        ,application_date
        ,ballot_issued_date
        ,ballot_return_date
        ,ballot_style
        ,challenged_provisional
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
        ) AS record_priority
    FROM abstrat.support.statewide_2020
)

, setup_22 AS (
    SELECT voter_registration_num
        ,application_status
        ,ballot_status
        ,status_reason
        ,application_date
        ,ballot_issued_date
        ,ballot_return_date
        ,ballot_style
        ,challenged_provisional
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
        ) AS record_priority
    FROM abstrat.support.statewide_2022
)

SELECT *
FROM setup_16
WHERE record_priority = 1

UNION ALL

SELECT *
FROM setup_18
WHERE record_priority = 1

UNION ALL

SELECT *
FROM setup_20
WHERE record_priority = 1

UNION ALL

SELECT *
FROM setup_22
WHERE record_priority = 1