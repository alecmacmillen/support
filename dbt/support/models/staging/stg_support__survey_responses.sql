SELECT survey_question_id
    ,survey_response_id
    ,survey_response_name
FROM {{ source('support', 'survey_responses') }}