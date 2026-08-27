SELECT survey_question_id
    ,survey_question_type
    ,survey_question_name
    ,survey_question_text
FROM {{ source('support', 'survey_questions') }}
WHERE survey_question_id IS NOT NULL
    AND state_code = 'GA'
    AND survey_question_cycle = '2022'