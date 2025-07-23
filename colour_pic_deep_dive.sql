WITH colour_pic AS (

SELECT
  created_at,
  CASE WHEN colour_picture_result = "clear" THEN 1 ELSE 0 END AS count_clear,
  CASE WHEN colour_picture_result = "consider" THEN 1 ELSE 0 END AS count_consider,
  1 AS total_entries,
FROM venn_case.doc_check doc_check
)

SELECT
    DATE_TRUNC(created_at, WEEK) AS created_week,
    (SUM(count_clear)) / SUM(total_entries) AS percent_clear,
    (SUM(count_consider)) / SUM(total_entries) AS percent_consider,
FROM colour_pic
GROUP BY 1 
ORDER BY 1