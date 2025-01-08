```sql 
USE Northwind;
SELECT 
    MIN(OrderDate) as EarliestOrder,
    MAX(OrderDate) as LatestOrder
FROM dbo.Orders;
```
![[Pasted image 20241223020142.png]]Implémentez le processus ETL sur SSIS 2012 qui permet de charger le DW. Rq1 : Pour la dimension DimTime, créez un fichier Excel contenant les données. L'intervalle de temps de cette dimension doit couvrir les dates contenues dans la tables Orders (commandes) de la BD opérationnelle.

![[Pasted image 20241223020223.png]]

![[Pasted image 20241223020231.png]]Export the data as excel file
![[Pasted image 20241223020343.png]]
2/

Les données des hiérarchies DimState, DimCountry, DimArea sont chargées à partir d'un fichier XML nommé Territories.xml qui commence comme suit :

```sql
-- Declare variable for XML data
DECLARE @xmlData XML

-- Read the XML file content into the variable
SET @xmlData = (
    SELECT CAST(BulkColumn AS XML)
    FROM OPENROWSET(BULK 'C:\Users\amine\Desktop\Territories.xml', SINGLE_BLOB) AS x
)

-- Create a temp table to store Area keys
CREATE TABLE #TempArea (
    AreaKey INT,
    AreaName NVARCHAR(100)
);

-- Get the maximum existing AreaKey
DECLARE @MaxAreaKey INT
SELECT @MaxAreaKey = ISNULL(MAX(AreaKey), 0) FROM DimArea

-- First load temp Area data with generated keys
INSERT INTO #TempArea (AreaKey, AreaName)
SELECT 
    ROW_NUMBER() OVER (ORDER BY Area.value('(AreaName)[1]', 'nvarchar(100)')) + @MaxAreaKey,
    Area.value('(AreaName)[1]', 'nvarchar(100)')
FROM @xmlData.nodes('/Areas/Area') AS XTbl(Area)
WHERE Area.value('(AreaName)[1]', 'nvarchar(100)') IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM DimArea 
    WHERE AreaName = Area.value('(AreaName)[1]', 'nvarchar(100)')
);

-- Load DimArea
INSERT INTO DimArea (AreaKey, AreaName)
SELECT AreaKey, AreaName
FROM #TempArea;

-- Create a temp table to store Country keys
CREATE TABLE #TempCountry (
    CountryKey INT,
    CountryName NVARCHAR(100),
    CountryCode NVARCHAR(2),
    CountryCapital NVARCHAR(100),
    Population INT,
    Subdivision NVARCHAR(500),
    AreaKey INT
);

-- Get the maximum existing CountryKey
DECLARE @MaxCountryKey INT
SELECT @MaxCountryKey = ISNULL(MAX(CountryKey), 0) FROM DimCountry

-- Load temp Country data with generated keys
INSERT INTO #TempCountry (
    CountryKey,
    CountryName,
    CountryCode,
    CountryCapital,
    Population,
    Subdivision,
    AreaKey
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY Country.value('(CountryName)[1]', 'nvarchar(100)')) + @MaxCountryKey,
    Country.value('(CountryName)[1]', 'nvarchar(100)'),
    Country.value('(CountryCode)[1]', 'nvarchar(2)'),
    COALESCE(Country.value('(CountryCapital)[1]', 'nvarchar(100)'), 'Unknown'),
    COALESCE(TRY_CAST(Country.value('(Population)[1]', 'varchar(20)') AS int), 0),
    COALESCE(Country.value('(Subdivision)[1]', 'nvarchar(500)'), 'No subdivision information'),
    COALESCE(ta.AreaKey, 
             (SELECT AreaKey FROM DimArea WHERE AreaName = Area.value('(AreaName)[1]', 'nvarchar(100)'))
    )
FROM @xmlData.nodes('/Areas/Area') AS AreaTbl(Area)
CROSS APPLY Area.nodes('Country') AS CountryTbl(Country)
LEFT JOIN #TempArea ta ON ta.AreaName = Area.value('(AreaName)[1]', 'nvarchar(100)')
WHERE Country.value('(CountryName)[1]', 'nvarchar(100)') IS NOT NULL
    AND Country.value('(CountryCode)[1]', 'nvarchar(2)') IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM DimCountry 
        WHERE CountryName = Country.value('(CountryName)[1]', 'nvarchar(100)')
    );

-- Load DimCountry
INSERT INTO DimCountry (
    CountryKey,
    CountryName,
    CountryCode,
    CountryCapital,
    Population,
    Subdivision,
    AreaKey
)
SELECT 
    CountryKey,
    CountryName,
    CountryCode,
    CountryCapital,
    Population,
    Subdivision,
    AreaKey
FROM #TempCountry;

-- Load DimState (without StateKey since it's an identity column)
INSERT INTO DimState (
    StateName,
    EnglishStateName,
    StateType,
    StateCode,
    StateCapital,
    RegionName,
    RegionCode,
    CountryKey
)
SELECT 
    State.value('(StateName)[1]', 'nvarchar(100)'),
    COALESCE(State.value('(EnglishStateName)[1]', 'nvarchar(100)'), 
             State.value('(StateName)[1]', 'nvarchar(100)')),
    COALESCE(State.value('@type', 'nvarchar(50)'), 'state'),
    State.value('(StateCode)[1]', 'nvarchar(2)'),
    COALESCE(State.value('(StateCapital)[1]', 'nvarchar(100)'), 'Unknown'),
    COALESCE(State.value('(RegionName)[1]', 'nvarchar(100)'), 'No Region'),
    COALESCE(State.value('(RegionCode)[1]', 'nvarchar(10)'), 'N/A'),
    COALESCE(tc.CountryKey, 
             (SELECT CountryKey FROM DimCountry WHERE CountryName = CN.CountryName)
    )
FROM @xmlData.nodes('/Areas/Area/Country/State') AS StateTbl(State)
CROSS APPLY (
    SELECT State.value('(../CountryName)[1]', 'nvarchar(100)') as CountryName
) AS CN
LEFT JOIN #TempCountry tc ON tc.CountryName = CN.CountryName
WHERE State.value('(StateName)[1]', 'nvarchar(100)') IS NOT NULL
    AND State.value('(StateCode)[1]', 'nvarchar(2)') IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM DimState 
        WHERE StateName = State.value('(StateName)[1]', 'nvarchar(100)')
        AND StateCode = State.value('(StateCode)[1]', 'nvarchar(2)')
    );

-- Clean up temp tables
DROP TABLE #TempArea;
DROP TABLE #TempCountry;
```

![[Pasted image 20241223020434.png]]
![[Pasted image 20241223020444.png]]