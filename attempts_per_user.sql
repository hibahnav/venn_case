SELECT
  DATE_TRUNC(created_at, WEEK) AS created_week,
  user_id,
  COUNT(attempt_id) AS count_attempts
FROM venn_case.doc_check doc_check
GROUP BY created_week, user_id
