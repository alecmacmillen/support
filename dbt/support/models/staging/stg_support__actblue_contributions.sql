SELECT id AS actblue_contribution_id
    ,donor_firstname AS actblue_firstname
    ,donor_lastname AS actblue_lastname
    ,donor_city AS actblue_city
    ,donor_state AS actblue_state
    ,donor_zip AS actblue_zip
    ,donor_employerdata_employer AS actblue_employer
    ,donor_employerdata_occupation AS actblue_occupation
    ,contribution_isrecurring AS actblue_isrecurring
    ,contribution_recurringduration AS actblue_recurringduration
    ,contribution_recurringperiod AS actblue_recurringperiod
    ,lineitems_amount AS actblue_amount
    ,lineitems_recurringamount AS actblue_recurring_amount
    ,DATE(lineitems_paidat) AS actblue_date_received
FROM {{ source('support', 'actblue_source_extract') }}
WHERE donor_state = 'GA'