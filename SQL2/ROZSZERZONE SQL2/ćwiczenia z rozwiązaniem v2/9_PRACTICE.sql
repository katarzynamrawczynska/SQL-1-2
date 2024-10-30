-- 1. Wybierz dane kraju oraz jego miast pomijaj¹c miasto które jest stolic¹. Zagreguj dane miast do ich iloœci
-- oraz sumy ich populacji. Z wyniku usuñ kraje dla których mamy mniej ni¿ 5 zagregowanych miast.

-- to copy - kolumny z country:  c.Code, c.Name, c.Continent, c.Region, c.SurfaceArea, c.IndependenceYear, 
--         c.Population, c.LifeExpectancy, c.GNP, c.GNPOld, c.LocalName, c.GovernmentForm, 
--         c.HeadOfState, c.Capital, c.Code2
USE world
SELECT c.Code, c.Name, c.Continent, c.Region, c.SurfaceArea, c.IndepYear, 
         c.Population, c.LifeExpectancy, c.GNP, c.GNPOld, c.LocalName, c.GovernmentForm, 
         c.HeadOfState, c.Capital, c.Code2, COUNT(cc.ID), SUM(cc.Population)
FROM country c
JOIN city cc ON c.Code = cc.CountryCode
WHERE c.Capital != cc.ID

GROUP BY c.Code, c.Name, c.Continent, c.Region, c.SurfaceArea, c.IndepYear, 
         c.Population, c.LifeExpectancy, c.GNP, c.GNPOld, c.LocalName, c.GovernmentForm, 
         c.HeadOfState, c.Capital, c.Code2
HAVING COUNT(cc.ID) >= 5


-- 2. Wyœwietl miasta, które maj¹ wiêksz¹ populacje ni¿ stolica kraju

;WITH CapitalPopulation AS (
	SELECT c.Code, cc.Population CapitalPopulation FROM country c
	JOIN city cc ON c.Code = cc.CountryCode
	WHERE c.Capital = cc.ID )
SELECT * 
FROM city  
JOIN CapitalPopulation ON city.CountryCode = CapitalPopulation.Code
	AND city.Population > CapitalPopulation.CapitalPopulation


-- 3. Wyœwietl nazwê krju, kontynent oraz powierzchnie, a nastêpnie informacje:
-- pozycja w rankingu krajów od najmniejszych do najwiêkszych - SurfaceArea
-- ró¿nica miêdzy wielkoœci¹ kraju wzglêdem poprzedniego kraju w zestawieniu od najmniejszych do najwiêkszych
-- wielkoœæ wszystkich krajów na danym kontynencie

SELECT 
    Name AS CountryName,
	Continent,
	SurfaceArea,
    ROW_NUMBER() OVER (ORDER BY SurfaceArea ASC) AS RankSurfaceArea,
    LAG(SurfaceArea) OVER (ORDER BY SurfaceArea ASC) AS PreviousCountrySurfaceArea,
    SurfaceArea - LAG(SurfaceArea) OVER (ORDER BY SurfaceArea ASC) AS DifferenceWithPreviousCountry,
	SUM(SurfaceArea) OVER (PARTITION BY Continent) as ContinentArea
FROM country
ORDER BY SurfaceArea


-- 4. wyœwietl jêzyki wraz z informacj¹ w ilu krajach dany jêzyk jest oficjalny i w ilu jest nieoficjalny
SELECT official.Language,official,notOfficial FROM
(
SELECT Language, count(IsOfficial) official FROM countrylanguage
WHERE IsOfficial = 'T'
group by Language
) official
JOIN
(
SELECT Language, count(IsOfficial) notOfficial FROM countrylanguage
WHERE IsOfficial = 'F'
GROUP BY Language
) notOfficial
ON official.Language = notOfficial.Language
         
-- 5. Stwórz rankig  jêzyków wzglêdem iloœci ludzi którzy siê nimi pos³uguj¹
-- iloœæ to Percentage/100  * CountryPopulation zsumowane ³¹cznie dla ka¿dego krajów gdzie jêzyk jest u¿ywany.
-- Wyœwietl nazwê jêzyka, iloœæ krajów gdzie jest u¿ywany i iloœæ ludzie którzy go u¿ywaj¹


SELECT --*,
	Language, CountryCount, PeopleCount,
	RANK() OVER (ORDER BY PeopleCount DESC) rank
FROM (
SELECT Language, COUNT(CountryCode) AS CountryCount,
	SUM(Population * Percentage/100) AS PeopleCount
FROM countrylanguage l
JOIN country c ON c.Code = l.CountryCode
GROUP BY Language

)  AS _
ORDER BY PeopleCount DESC

-- 6. wyœwietl nazwê oraz populacjê dla krajów i miast, gdzie populacja jest wiêksza ni¿ œrednia populacja kraju/miasta 
-- na danym kontynencie
-- jeœli pojawi siê b³¹d Arithmetic overflow error converting expression to data type int. 
-- nale¿y dane pole zamieniæ za pomoc¹ CAST na bigint, Dodaj kolumnê z oznaczeniem czy to pañstwo czy miasto.
-- Posortuj ca³oœæ po populacji malej¹co - miasta i kraje ³¹cznie

SELECT * FROM (
SELECT 'Country' as mark, Name, population FROM country 
WHERE Population > (SELECT AVG(CAST(Population AS bigint)) 
					FROM country country_in 
					WHERE country_in.Continent = country.Continent)

	UNION
SELECT 'City' AS mark, cc.Name, cc.population 
	FROM city cc JOIN country c ON cc.CountryCode = c.Code
	WHERE cc.Population > ( SELECT AVG(cc.Population) 
						FROM city cc 
						JOIN country country_in ON cc.CountryCode = country_in.Code
						WHERE country_in.Continent = c.Continent)
)  AS query ORDER BY population DESC






