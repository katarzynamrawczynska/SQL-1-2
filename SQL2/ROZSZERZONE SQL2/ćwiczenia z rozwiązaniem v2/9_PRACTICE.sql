-- 1. Wybierz dane kraju oraz jego miast pomijaj�c miasto kt�re jest stolic�. Zagreguj dane miast do ich ilo�ci
-- oraz sumy ich populacji. Z wyniku usu� kraje dla kt�rych mamy mniej ni� 5 zagregowanych miast.

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


-- 2. Wy�wietl miasta, kt�re maj� wi�ksz� populacje ni� stolica kraju

;WITH CapitalPopulation AS (
	SELECT c.Code, cc.Population CapitalPopulation FROM country c
	JOIN city cc ON c.Code = cc.CountryCode
	WHERE c.Capital = cc.ID )
SELECT * 
FROM city  
JOIN CapitalPopulation ON city.CountryCode = CapitalPopulation.Code
	AND city.Population > CapitalPopulation.CapitalPopulation


-- 3. Wy�wietl nazw� krju, kontynent oraz powierzchnie, a nast�pnie informacje:
-- pozycja w rankingu kraj�w od najmniejszych do najwi�kszych - SurfaceArea
-- r�nica mi�dzy wielko�ci� kraju wzgl�dem poprzedniego kraju w zestawieniu od najmniejszych do najwi�kszych
-- wielko�� wszystkich kraj�w na danym kontynencie

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


-- 4. wy�wietl j�zyki wraz z informacj� w ilu krajach dany j�zyk jest oficjalny i w ilu jest nieoficjalny
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
         
-- 5. Stw�rz rankig  j�zyk�w wzgl�dem ilo�ci ludzi kt�rzy si� nimi pos�uguj�
-- ilo�� to Percentage/100  * CountryPopulation zsumowane ��cznie dla ka�dego kraj�w gdzie j�zyk jest u�ywany.
-- Wy�wietl nazw� j�zyka, ilo�� kraj�w gdzie jest u�ywany i ilo�� ludzie kt�rzy go u�ywaj�


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

-- 6. wy�wietl nazw� oraz populacj� dla kraj�w i miast, gdzie populacja jest wi�ksza ni� �rednia populacja kraju/miasta 
-- na danym kontynencie
-- je�li pojawi si� b��d Arithmetic overflow error converting expression to data type int. 
-- nale�y dane pole zamieni� za pomoc� CAST na bigint, Dodaj kolumn� z oznaczeniem czy to pa�stwo czy miasto.
-- Posortuj ca�o�� po populacji malej�co - miasta i kraje ��cznie

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






