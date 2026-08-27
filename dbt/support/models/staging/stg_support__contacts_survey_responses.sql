SELECT contacts_survey_response_id
    ,myv_van_id
    ,contacts_contact_id
    ,survey_question_id
    ,survey_response_id
    ,TIMESTAMP(datetime_canvassed) AS datetime_canvassed
    ,CASE 
        WHEN survey_response_id IN ('2102006','2114703','2102007','2114704') THEN 1
        WHEN survey_response_id IN ('2102009','2114706','2102010','2114710','2114700','2114712') THEN 0
        ELSE NULL END AS binomial_support
FROM {{ source('support', 'contacts_survey_responses_myv') }}
WHERE survey_question_id IN ('514051','517214')