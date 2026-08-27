SELECT contactscontributionid AS ngp_contribution_id
    ,vanid AS myv_van_id
    ,amount AS ngp_amount
    ,DATE(datereceived) AS ngp_date_received
FROM {{ source('support', 'ngp_reporting_base_table') }}