WITH weekly_pass_counts AS (

SELECT
  DATE_TRUNC(doc_check.created_at, WEEK) AS created_at,
  CASE WHEN result = "clear" THEN 1
    ELSE 0 END as doc_result, 
  CASE WHEN result_facial = "clear" THEN 1
    ELSE 0 END as face_result, 
  1 AS total_entries,
FROM venn_case.doc_check doc_check
JOIN venn_case.face_check face_check
  ON doc_check.user_id = face_check.user_id

)

SELECT
    DATE_TRUNC(created_at, WEEK) AS created_week,
    (SUM(doc_result) + SUM(face_result)) / SUM(total_entries) AS pass_rate,
    (SUM(doc_result)) / SUM(total_entries) AS doc_rate,
    (SUM(face_result)) / SUM(total_entries) AS face_rate,
FROM weekly_pass_counts
GROUP BY 1 
ORDER BY 1