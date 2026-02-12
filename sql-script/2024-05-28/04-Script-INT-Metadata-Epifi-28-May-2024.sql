UPDATE ui.metadata
SET vcprefix = new_vcprefix
FROM (
    SELECT itenantid, jsonb_agg(jsonb_build_object(
        'Path', replace(value->>'Path', '.val', ''),
        'Side', value->>'Side'
    )) AS new_vcprefix
    FROM (
        SELECT itenantid, jsonb_array_elements(vcprefix) AS value
        FROM ui.metadata
        WHERE itenantid = 5
    ) subquery
    GROUP BY itenantid
) updated_data
WHERE ui.metadata.itenantid = updated_data.itenantid;