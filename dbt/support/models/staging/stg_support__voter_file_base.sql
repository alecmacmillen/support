SELECT person_id
    ,myv_van_id
    ,sos_id
    ,first_name
    ,last_name
    ,ethnicity_combined
    ,gender_combined
    ,age_combined
    ,age_bucket
    ,county_name
    ,metro_region
    ,media_market
    ,van_precinct_id
    ,voting_address_id
    ,voting_address_type
    ,voting_address_multi_tennant
    ,mailing_address_id
    ,mailing_city
    ,mailing_zip
    ,us_cong_district_latest
    ,state_senate_district_latest
    ,state_house_district_latest
FROM {{ source('support', 'reg_voter_base') }}