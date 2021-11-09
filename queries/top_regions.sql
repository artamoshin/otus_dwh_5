WITH (
    SELECT topK(10)(RegionID)
    FROM visits_v1
    WHERE {{date}}
) AS top10

SELECT
    coalesce(nullIf(regionToName(RegionID), ''), toString(RegionID)) AS "Region",
    count() AS "Visits"
FROM visits_v1
WHERE
    has(top10, RegionID)
    AND {{date}}
GROUP BY RegionID
ORDER BY count() DESC

UNION ALL

SELECT
    NULL,
    count()
FROM visits_v1
WHERE
    NOT has(top10, RegionID)
    AND {{date}}