USE world;

-- select all cities with population greater than 5 million
SELECT city.Name, city.CountryCode, country.Continent, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.Population > 5000000
ORDER BY (city.Population) DESC;

-- select all military bases in North America
SELECT country.Name AS Country, militarybase.Name AS MilitaryBase
FROM country
JOIN militarybase ON country.code = militarybase.countrycode
WHERE country.continent = 'North America';

-- select all langauges from each country
SELECT countrylanguage.isOfficial AS OfficialLangauge, countrylanguage.Language, country.Code AS CountryCode
FROM countrylanguage
JOIN country ON country.code = countrylanguage.countrycode;

-- select all military bases in the world
SELECT country.Name AS Country, militarybase.Name AS MilitaryBase
FROM country
JOIN militarybase ON country.code = militarybase.countrycode;

-- select all ports in the world
SELECT country.Code AS CountryCode, port.Name AS PortName
FROM country
JOIN port ON country.code = port.CountryCode;

-- show airports and runways of countries that have at least 1 airport
SELECT Country.Name AS Country_Name, Airport.Name AS Airport, Airport.Runways AS Runways
FROM Country, Airport
WHERE EXISTS (SELECT * 
			  FROM Airport 
              WHERE Country.Code = Airport.CountryCode);

-- show number of countries that speak English
SELECT COUNT(Country.Name) AS English_Speaking_Countries
FROM Country
WHERE Country.Name IN (SELECT Country.Name
						FROM CountryLanguage JOIN Country ON CountryLanguage.CountryCode = Country.Code
                        WHERE CountryLanguage.Language = 'English');

-- show military bases and surface area of countries that have at least 1 military base
SELECT Country.Name AS Country_Name, MilitaryBase.Name AS Military_Base, MilitaryBase.SurfaceArea AS Surface_Area
FROM Country, MilitaryBase
WHERE EXISTS (SELECT * 
			  FROM MilitaryBase 
              WHERE Country.Code = MilitaryBase.CountryCode);

-- show ports and docks of countries that have at least 1 port
SELECT Country.Name AS Country_Name, Port.Name AS Port, Port.Docks AS Docks
FROM Country, Port
WHERE EXISTS (SELECT * 
			  FROM Port 
              WHERE Country.Code = Port.CountryCode);

-- show country information for those that have at least 1 airport, 1 military base, and 1 port.
-- this information means the country could be a militaristic threat
SELECT Country.Name AS Country_Name,
	   Country.Continent AS Continent,
       Country.Region AS Region,
       Country.GovernmentForm AS Government_Form,
       Country.HeadOfState AS Head_Of_State
FROM Country
WHERE (SELECT COUNT(*)
	   FROM Airport
	   WHERE Country.Code = Airport.CountryCode) > 0
       AND
       (SELECT COUNT(*)
	   FROM MilitaryBase
	   WHERE Country.Code = MilitaryBase.CountryCode) > 0
       AND
       (SELECT COUNT(*)
	   FROM Port
	   WHERE Country.Code = Port.CountryCode) > 0;