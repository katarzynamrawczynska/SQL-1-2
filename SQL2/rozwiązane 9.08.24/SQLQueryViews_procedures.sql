/*VIEWS*/
-- Tworzenie widoku powinno byæ osobn¹ komend¹, ale gdy zaznaczymy tylko t¹ instrukcje / u¿ywamy po niej GO
-- Widok siê utworzy
-- UWAGA! w widoku wszystkie kolumny musz¹ mieæ nazwy
-- U¿ycie ALTER pozwala na zmianê ju¿ istniej¹cego widoku
USE HM
CREATE OR ALTER VIEW avg_sprzedaz AS (
	SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur 
);
GO

SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur WHERE CenaSprz > (SELECT TOP 1 srednia_sp FROM avg_sprzedaz) -- dlaczego top 1? Czy u¿yæ?

DROP VIEW avg_sprzedaz  -- usuniêcie widoku

CREATE OR ALTER VIEW zestawienie_towarow AS (
	SELECT 
		p.TowarID, 
		p.FakturaID, 
		SUM(p.CenaSprz) AS SumaCen
	FROM 
		tbPozycjeFaktur p
	GROUP BY 
		p.TowarID, p.FakturaID
);

CREATE OR ALTER view  test AS 
WITH NajdrozszyTowar AS (      -- œrednik przed WITH nie jest konieczny, ale bez niego nie odpalimy poprzedniego zapytania razem z tym
    SELECT MAX(cena) AS MaxCena
    FROM tbTowary
)
(
SELECT cena, wykonawca + ' - ' + tytul as w
FROM tbTowary
WHERE cena = (SELECT MaxCena FROM NajdrozszyTowar)
)


/*æwiczenia*/
-- 2. Utwórz widok pokazuj¹cy wszystkich klientów z Bazy HM wraz z wykonawcami i tytu³ami towarów, które kupili
ALTER  VIEW klienci AS (
SELECT k.*, t.wykonawca, t.tytul
FROM tbKlienci k
LEFT JOIN tbFaktury f ON f.KlientID = k.IDKlienta
LEFT JOIN tbPozycjeFaktur p ON p.FakturaID = f.IDFaktury
LEFT JOIN tbTowary t ON t.IDTowaru = p.TowarID

)
SELECT * FROM klienci
ORDER BY nazwa

-- 3. Poni¿ej mamy zapytanie z CTE. Zapisz zawartoœæ CTE jako widok i odpowiednio przerób poni¿sze wyra¿enie, aby
-- korzysta³o z tego widoku zamiast CTE


USE HM

CREATE VIEW PrefiltrowanePozycje_v AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena  --- Stwórz VIEW z tego zapytania
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)


SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje_v p ON f.IDFaktury = p.FakturaID -- do³¹cz widok zamiast CTE



/* Procedura z parametrami */
-- umo¿liwia wykonywanie zapytania podaj¹c mu zmienne wartoœci, które maj¹ byæ w nie wstawione


-- utworzenie


ALTER PROCEDURE test_proc @param1 nvarchar(6), @param2 int = 2, @param3 date
AS
BEGIN
	SELECT @param1, @param2, @param3 
END

--wykonanie
EXECUTE test_proc 
 @param1 =  'napis',  @param3 = '2022-01-03'


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
EXECUTE PobierzStatystykiKlientow 5, 6
GO


/*æwiczenia*/
-- 1. Do poni¿szego zapytania dopisz warunek, który okreœla zakres dat (data od, data do) dla których
-- chcemy wyœwietliæ wyniki. Zapisz zapytanie jako procedurê dodaj¹c do niej parametry data_od i data_do

SELECT f.DataSprzed, t.wykonawca, t.tytul, pf.Ilosc, pf.CenaSprz
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
JOIN tbTowary t ON t.IDTowaru = pf.TowarID
WHERE DataSprzed BETWEEN '2004-06-06' AND '2005-01-01'


--utwórz procedurê ()
CREATE OR ALTER PROCEDURE faktury_od_do @od date, @do date
AS
BEGIN

SELECT f.DataSprzed, t.wykonawca, t.tytul, pf.Ilosc, pf.CenaSprz
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
JOIN tbTowary t ON t.IDTowaru = pf.TowarID
WHERE DataSprzed BETWEEN @od AND @do

SELECT * FROM tbPozycjeFaktur
END

EXECUTE faktury_od_do '2004-06-06', '2005-01-01'
