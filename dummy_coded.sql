WITH dummy_coded AS (

SELECT
  created_at,
  CASE WHEN visual_authenticity_result = "clear" THEN 1 ELSE 0 END AS visual_authenticity_result,
  CASE WHEN image_integrity_result = "clear" THEN 1 ELSE 0 END AS image_integrity_result,
  CASE WHEN face_detection_result = "clear" THEN 1 ELSE 0 END AS face_detection_result,
  CASE WHEN image_quality_result = "clear" THEN 1 ELSE 0 END AS image_quality_result,
  CASE WHEN supported_document_result = "clear" THEN 1 ELSE 0 END AS supported_document_result,
  CASE WHEN conclusive_document_quality_result = "clear" THEN 1 ELSE 0 END AS conclusive_document_quality_result,
  CASE WHEN colour_picture_result = "clear" THEN 1 ELSE 0 END AS colour_picture_result,
  CASE WHEN data_validation_result = "clear" THEN 1 ELSE 0 END AS data_validation_result,
  CASE WHEN data_consistency_result = "clear" THEN 1 ELSE 0 END AS data_consistency_result,
  CASE WHEN data_comparison_result = "clear" THEN 1 ELSE 0 END AS data_comparison_result,
  CASE WHEN police_record_result = "clear" THEN 1 ELSE 0 END AS police_record_result,
  CASE WHEN compromised_document_result = "clear" THEN 1 ELSE 0 END AS compromised_document_result,
  1 AS total_entries,
  attempt_id,
  user_id
FROM venn_case.doc_check doc_check
ORDER BY created_at

)

SELECT
    DATE_TRUNC(created_at, WEEK) AS created_week,
    (SUM(visual_authenticity_result)) / SUM(total_entries) AS visual_authenticity_result,
    (SUM(image_integrity_result)) / SUM(total_entries) AS image_integrity_result,
    (SUM(face_detection_result)) / SUM(total_entries) AS face_detection_result,
    (SUM(image_quality_result)) / SUM(total_entries) AS image_quality_result,
    (SUM(supported_document_result)) / SUM(total_entries) AS supported_document_result,
    (SUM(conclusive_document_quality_result)) / SUM(total_entries) AS conclusive_document_quality_result,
    (SUM(colour_picture_result)) / SUM(total_entries) AS colour_picture_result,
    (SUM(data_validation_result)) / SUM(total_entries) AS data_validation_result,
    (SUM(data_consistency_result)) / SUM(total_entries) AS data_consistency_result,
    (SUM(data_comparison_result)) / SUM(total_entries) AS data_comparison_result,
    (SUM(police_record_result)) / SUM(total_entries) AS police_record_result,
    (SUM(compromised_document_result)) / SUM(total_entries) AS compromised_document_result,
FROM dummy_coded
GROUP BY 1 
ORDER BY 1