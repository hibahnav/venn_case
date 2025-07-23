WITH sub_result AS (

SELECT
  created_at,
  CASE WHEN sub_result = "clear" THEN 1 ELSE 0 END AS count_clear,
  CASE WHEN sub_result = "rejected" THEN 1 ELSE 0 END AS count_rejected,
  CASE WHEN sub_result = "suspected" THEN 1 ELSE 0 END AS count_suspected,
  CASE WHEN sub_result = "caution" THEN 1 ELSE 0 END AS count_caution,
  1 AS total_entries,
  attempt_id,
  user_id
FROM venn_case.doc_check doc_check
)

SELECT
    DATE_TRUNC(created_at, WEEK) AS created_week,
    (SUM(count_clear)) / SUM(total_entries) AS percent_clear,
    (SUM(count_rejected)) / SUM(total_entries) AS percent_rejected,
    (SUM(count_suspected)) / SUM(total_entries) AS percent_suspected,
    (SUM(count_caution)) / SUM(total_entries) AS percent_caution,
FROM sub_result
GROUP BY 1 
ORDER BY 1