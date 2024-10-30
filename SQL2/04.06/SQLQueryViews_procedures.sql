/*VIEWS*/
-- Tworzenie widoku powinno byæ osobn¹ komend¹, ale gdy zaznaczymy tylko t¹ instrukcje / u¿ywamy po niej GO
-- Widok siê utworzy
-- UWAGA! w widoku wszystkie kolumny musz¹ mieæ nazwy
-- U¿ycie OR ALTER pozwala na zmianê ju¿ istniej¹cego widoku
USE HM
CREATE OR ALTER VIEW avg_sprzedaz AS (
	SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur 
);
GO

SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur 
WHERE CenaSprz > (SELECT srednia_sp FROM avg_sprzedaz)

DROP VIEW avg_sprzedaz  -- usuniêcie widoku

CREATE VIEW zestawienie_towarow AS (
	SELECT 
		p.TowarID, 
		p.FakturaID, 
		SUM(p.CenaSprz) AS SumaCen
	FROM 
		tbPozycjeFaktur p
	GROUP BY 
		p.TowarID, p.FakturaID
);

/*æwiczenia*/
-- 1. Zmodyfikuj widok zestawienie_towarow, aby grupowanie by³o prezeprowadzone z poleceniem grouping sets.
-- U¿yj select by po³¹czyæ ten widok za pomoc¹ join z towarami i wyœwietl dodatkowo wykonawce i tytu³
-- 2. Utwórz widok pokazuj¹cy wszystkich klientów z Bazy HM wraz z wykonawcami i tytu³ami towarów, które kupili
-- 3. Poni¿ej mamy zapytanie z CTE. Zapisz zawartoœæ CTE jako widok i odpowiednio przerób poni¿sze wyra¿enie, aby
-- korzysta³o z tego widoku zamiast CTE


USE HM

;WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena  --- Stwórz VIEW z tego zapytania
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID -- do³¹cz widok zamiast CTE



/* Procedura z parametrami */
-- umo¿liwia wykonywanie zapytania podaj¹c mu zmienne wartoœci, które maj¹ byæ w nie wstawione


-- utworzenie
CREATE OR ALTER PROCEDURE test @param1 nvarchar(6), @param2 int, @param3 date
AS
BEGIN
SELECT @param1, @param2, @param3 
END

--wywo³anie
EXECUTE test 'napis', 55, '2022-01-03'


SELECT
	Wykonawca, 
	rok_wydania,
    tytul,
	nosnik
FROM tbTowary
WHERE nosnik = 'CD' --, DVD, VHS ...?     
ORDER BY rok_wydania

CREATE OR ALTER PROCEDURE filtr_nosnik @nosnik nvarchar(6) -- Wa¿ne! typy varchar, nvarchar musz¹ posiadaæ okreœlin¹ d³ugoœæ
AS
BEGIN
	SELECT
		Wykonawca, 
		rok_wydania,
		tytul,
		nosnik
	FROM tbTowary
	WHERE nosnik = @nosnik  
	ORDER BY rok_wydania
END

EXECUTE filtr_nosnik N'CD'



--					nazwa procedury				parametr typ,			parametr typ
CREATE OR ALTER PROCEDURE PobierzStatystykiKlientow  @MinSumaZakupow MONEY, @MinLiczbaTransakcji INT -- nazwa procedury parametr typ, parametr typ
AS
BEGIN
    WITH StatystykiKlienta AS (
        SELECT  f.KlientID,  SUM(pf.CenaSprz) AS SumaZakupow,  
		COUNT(DISTINCT pf.FakturaID) AS LiczbaTransakcji
        FROM tbPozycjeFaktur pf
        JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
        GROUP BY f.KlientID
    )
    SELECT 
        k.IDKlienta, 
        k.Nazwa, 
        sk.SumaZakupow, 
        sk.LiczbaTransakcji
    FROM tbKlienci k
    JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
    WHERE sk.SumaZakupow > @MinSumaZakupow AND sk.LiczbaTransakcji > @MinLiczbaTransakcji
	ORDER BY LiczbaTransakcji
END;
GO

EXECUTE PobierzStatystykiKlientow 10, 1
GO


/*æwiczenia*/
-- 1. Do poni¿szego zapytania dopisz warunek, który okreœla zakres dat (data od, data do) dla których
-- chcemy wyœwietliæ wyniki. Zapisz zapytanie jako procedurê dodaj¹c do niej parametry data_od i data_do

SELECT f.DataSprzed, t.wykonawca, t.tytul, pf.Ilosc, pf.CenaSprz
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
JOIN tbTowary t ON t.IDTowaru = pf.TowarID
-- WHERE ....... uzupe³nij

--utwórz procedurê ()


/*Procedura z dynamicznym SQL*/

CREATE OR ALTER PROCEDURE PobierzStatystykiKlientow @NazwaKolumny NVARCHAR(128), 
    @KierunekSortowania NVARCHAR(4)
AS
BEGIN
    WITH StatystykiKlienta AS (
        SELECT  f.KlientID,  SUM(pf.CenaSprz) AS SumaZakupow,  
		COUNT(DISTINCT pf.FakturaID) AS LiczbaTransakcji
        FROM tbPozycjeFaktur pf
        JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
        GROUP BY f.KlientID
    )
    SELECT 
        k.IDKlienta, 
        k.Nazwa, 
        sk.SumaZakupow, 
        sk.LiczbaTransakcji
    FROM tbKlienci k
    JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
	ORDER BY @NazwaKolumny --- to samo z desc/asc
END;
GO

EXECUTE PobierzStatystykiKlienta 'nazwa', 'ASC'
GO



/*Ca³y na bia³o, dynamiczny SQL*/

CREATE OR ALTER PROCEDURE StatystykiKlientaSort @NazwaKolumny NVARCHAR(128), 
    @KierunekSortowania NVARCHAR(4)
AS
BEGIN
DECLARE @SQLQuery AS NVARCHAR(MAX); -- zmienna w której skleimy zaptanie
SET @SQLQuery =  N'WITH StatystykiKlienta AS (
        SELECT  f.KlientID,  SUM(pf.CenaSprz) AS SumaZakupow,  
		COUNT(DISTINCT pf.FakturaID) AS LiczbaTransakcji
        FROM tbPozycjeFaktur pf
        JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
        GROUP BY f.KlientID
    )
    SELECT *
    FROM tbKlienci k
    JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
ORDER BY ' + QUOTENAME(@NazwaKolumny) + ' ' + @KierunekSortowania;
PRINT @SQLQuery -- Dodatkowo wyœwietlamy ca³oœæ zapytania
EXEC sp_executesql @SQLQuery -- wywo³a n ie ca³oœci zapytania przygotowanego w zmiennej
END;
GO


EXECUTE StatystykiKlientaSort
    @NazwaKolumny = 'nazwa', 
    @KierunekSortowania = 'ASC';

