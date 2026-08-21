SELECT contacts_survey_response_id
    ,myv_van_id
    ,contacts_contact_id
    ,survey_question_id
    ,survey_response_id
    ,datetime_canvassed
FROM abstrat.support.contacts_survey_responses_myv
WHERE survey_question_id IN ('514051','517214')