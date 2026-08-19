-- Goal here is to intelligently collapse this table to just a few columns
-- of probably-relevant features, 1 observation per sos_id: 
-- number of elections voted, time since last election voted, number of
-- primaries voted, preferred vote method, preferred party
WITH summary AS (
    SELECT voter_reg_num
        ,COUNT(*) AS total_elections_voted -- investigate whether this is the correct way to subset the universe of elections voted in
        ,SUM(CASE WHEN UPPER(election_desc) LIKE '%PRIMARY%' THEN 1 ELSE 0 END) AS total_primaries_voted
        ,SUM(CASE WHEN voted_party_desc = 'DEMOCRATIC' THEN 1 ELSE 0 END) AS elections_voted_democratic
        ,SUM(CASE WHEN voted_party_desc = 'REPUBLICAN' THEN 1 ELSE 0 END) AS elections_voted_republican
        ,SUM(CASE WHEN voted_party_desc NOT IN ('DEMOCRATIC', 'REPUBLICAN') THEN 1 ELSE 0 END) AS elections_voted_other
    FROM abstrat.support.vh_upload
    GROUP BY 1
)

, cycle_history AS (
    SELECT voter_reg_num
        ,MAX(EXTRACT(YEAR FROM PARSE_DATE('%m/%d/%Y', election_lbl))) AS most_recent_cycle_voted
    FROM abstrat.support.vh_upload
    WHERE election_lbl LIKE '%/%/%'
        AND election_lbl NOT LIKE '%2024%'
    GROUP BY 1
)

SELECT s.*
    ,c.most_recent_cycle_voted
FROM summary s
    LEFT JOIN cycle_history c USING (voter_reg_num)