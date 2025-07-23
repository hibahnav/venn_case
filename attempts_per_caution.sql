SELECT
  DATE_TRUNC(created_at, WEEK) AS created_week,
  user_id,
  COUNT(attempt_id) AS count_attempts,
  SUM(CASE WHEN sub_result = 'caution' THEN 1 ELSE 0 END) AS caution_sub_results_count
FROM venn_case.doc_check doc_check
GROUP BY created_week, user_id
