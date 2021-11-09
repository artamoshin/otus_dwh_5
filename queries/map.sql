WITH countries_visits AS (
    SELECT
        regionToCountry(RegionID) AS "CountryID",
        count()                   AS "Visits"
    FROM visits_v1
    WHERE {{date}}
    GROUP BY CountryID
)
SELECT
    Alpha2 AS "Country",
    Visits
FROM countries_visits
LEFT OUTER JOIN url(
        'https://gist.githubusercontent.com/tadast/8827699/raw/f5cac3d42d16b78348610fc4ec301e9234f82821/countries_codes_and_coordinates.csv',
        CSVWithNames,
        'Country String, Alpha2 String, Alpha3 String, NumericCode String, Latitude Float32, Longitude Float32'
    ) AS codes ON codes.Country == regionToName(CountryID, 'en')
ORDER BY Visits DESC