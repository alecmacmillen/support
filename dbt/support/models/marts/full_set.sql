WITH responses AS (
    SELECT * FROM {{ ref('stg_support__contacts_survey_responses') }}
)

, vfb AS (
    SELECT * FROM {{ ref('stg_support__voter_file_base') }}
)

, vhs AS (
    SELECT * FROM {{ ref('stg_support__vote_history_summary') }}
)

, ngp AS (
    SELECT * FROM {{ ref('stg_support__ngp_contributions') }}
)

, ab AS (
    SELECT * FROM {{ ref('stg_support__actblue_contributions') }}
)

SELECT r.*
    ,vfb.* EXCEPT (myv_van_id, first_name, last_name)
    ,vhs.* EXCEPT (sos_id)
    ,ngp.* EXCEPT (myv_van_id)
    ,ab.*
FROM responses r
    LEFT JOIN vfb ON r.myv_van_id = vfb.myv_van_id
    LEFT JOIN vhs ON vfb.sos_id = vhs.sos_id
    LEFT JOIN ngp ON r.myv_van_id = ngp.myv_van_id
    LEFT JOIN ab ON TRIM(UPPER(vfb.first_name)) = TRIM(UPPER(ab.actblue_firstname)) 
        AND TRIM(UPPER(vfb.last_name)) = TRIM(UPPER(ab.actblue_lastname))
        AND TRIM(UPPER(vfb.mailing_city)) = TRIM(UPPER(ab.actblue_city))
        AND TRIM(UPPER(vfb.mailing_zip)) = TRIM(UPPER(ab.actblue_zip))