# General Notes

The `abstrat.support_staging.stg_support__vote_history_summary` table orders multiple records per `sos_id` value on a ranking criteria that puts ballots further along in the absentee process higher in priority, then selects the best record per id per cycle. The cycle datasets are then full-outer-joined together to maximally preserve ID values, creating null values for ballot return columns in cycles where the voter didn't vote absentee. This is a "wide" dataset with exactly as many unique `sos_id` values as rows.

The `abstrat.support_marts.full_set` dataset is created using the `full_set.sql` model and merges all the data sources together using a few assumptions:

- `myv_van_id` is used to merge survey responses in `stg_support__contacts_survey_responses` to the registered voter file base in `stg_support__voter_file_base`
- `sos_id` is used to merge `stg_support__vote_history_summary` onto the full set
- `myv_van_id` is used to merge `stg_support__ngp_contributions` onto the full set
- A composite key of `first_name`, `last_name`, `city` and `zip` (*mailing* values from the voter file base) is used to merge `stg_support__actblue_contributions` onto the full set

```sql
SELECT COUNT(*), SUM(CASE WHEN person_id IS NOT NULL THEN 1 ELSE 0 END), COUNT(DISTINCT person_id)
FROM abstrat.support_marts.full_set
```

Above query results shows there are 410,348 total rows, 409,322 non-null `person_id` values, and 366,647 unique/distinct `person_id` values.

```sql
SELECT person_id, COUNT(*) ct
FROM abstrat.support_marts.full_set
GROUP BY 1
HAVING ct > 1
ORDER BY 2 DESC
```

Shows the specific dupes. Will have to investigate what is causing dupes and add logic to `full_set.sql` for handling them; otherwise we will end up having errors when we write dbt tests for uniqueness in primary keys.