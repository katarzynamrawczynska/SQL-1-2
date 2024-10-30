
USE BS
GO


/* z³¹czenie poziome - JOIN*/

SELECT * FROM tblPracownicy; -- id 2 - nie przypisany do sprzeda¿y
SELECT * FROM tblSprzedaz; -- id 6, 11, 20, 39, 141 - brak przypisanego pracownika

-- INNER JOIN: co najmniej jeden dopasowany rekord w obu tabelach
SELECT  * -- p.*, s.*, s.ID_Sprzedaz, p.IDPracownika
FROM dbo.tblPracownicy AS p
INNER JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;
-- TODO Dodajmy WHERE

-- LEFT JOIN: wiersze z lewej tabeli i dopasowane z prawej
SELECT *
FROM dbo.tblPracownicy AS p
LEFT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;
-- TODO dodajmy warunek key IS NULL

-- RIGHT JOIN: wiersze z prawej tabeli i dopasowane z lewej
SELECT *
FROM dbo.tblPracownicy AS p
RIGHT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;

-- FULL JOIN (FULL OUTER JOIN): wiersze z lewej i prawej tabeli
SELECT p.*, s.DataSprzedazy
FROM dbo.tblPracownicy AS p
FULL JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;



SELECT * 
/*
	 sp.ID_Sprzedaz, 
	sp.DataSprzedazy,   
	o_sp.Ilosc,
	o_sp.Towar_ID,
	k.NazwaFirmy,
	p.Nazwisko
*/
FROM tblSprzedaz sp -- wiele JOIN -- Czy s¹ jakieœ zasady co do kolejnoœci ?
JOIN tblOpisSprzedazy o_sp ON sp.ID_Sprzedaz = o_sp.Sprzedaz_ID
JOIN tblKlienci k ON k.ID_Klient = sp.Klient_ID
JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID



/* UNIONS */
SELECT UPPER(Miasto) M, 1 sort_col
FROM tblPracownicy
 --UNION 
  UNION ALL -- (dane siê duplikuj¹, jeœli wystêpuj¹ w obu wynikach)
  --INTERSECT 
 --EXCEPT 
SELECT UPPER(Miasto) , 2 sort_col
FROM tblKlienci
ORDER BY sort_col,M;

-- Co gdy u¿yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*æwiczenie*/
-- 1. W tabeli klientów mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s¹ postaci xxxxx.
	-- a. u¿ywaj¹c funkcji wbudowanych zmiñ format kodów w tabeli z klientami do formatu xxxxx 
	-- (u¿yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klientów, oraz kodach pracowników

USE BS
SELECT  REPLACE(kod, '-', '') FROM tblKlienci 
UNION
SELECT  KodPocztowy FROM tblPracownicy

USE BS
SELECT DISTINCT REPLACE(kod, '-', '') FROM tblKlienci 
UNION ALL
SELECT DISTINCT KodPocztowy FROM tblPracownicy




SELECT * FROM
(	SELECT TOP 1 WITH TIES
		sp.ID_Sprzedaz,
		sp.Klient_ID,
		sp.DataSprzedazy,
		LAG(sp.DataSprzedazy) OVER (PARTITION BY sp.Klient_ID ORDER BY sp.DataSprzedazy) AS PreviousSaleDate,
		LEAD(sp.DataSprzedazy) OVER (PARTITION BY sp.Klient_ID ORDER BY sp.DataSprzedazy) AS NextSaleDate,
		DATEDIFF(DAY, LAG(sp.DataSprzedazy) OVER (PARTITION BY sp.Klient_ID ORDER BY sp.DataSprzedazy), sp.DataSprzedazy) AS DaysFromPreviousSale,
		DATEDIFF(DAY, sp.DataSprzedazy, LEAD(sp.DataSprzedazy) OVER (PARTITION BY sp.Klient_ID ORDER BY sp.DataSprzedazy)) AS DaysToNextSale
	FROM 
		tblSprzedaz sp
	ORDER BY 
		sp.Klient_ID ASC
) result order by result.DataSprzedazy 




/* APPLY */

USE HM

CREATE TABLE SplitString (string NVARCHAR(100))

INSERT INTO SplitString VALUES ('2022-11-24')
INSERT INTO SplitString VALUES ('2022-04-01')

SELECT * FROM SplitString

SELECT '2022-04-01', * FROM STRING_SPLIT('2022-04-01','-')

SELECT * FROM SplitString s
CROSS APPLY STRING_SPLIT(s.string, '-')

-- Scenariusz 1 - funkcja tabelaryczna
-- Wykonaæ procedurê 

SELECT * FROM  STRING_SPLIT('a;f;e;y', ';') as s

-- Dwa alternatywne rozwi¹zania:
SELECT f.IDFaktury, f.Uwagi, s.value AS IDTowaru , t.*
FROM tbFaktury f
--JOIN  STRING_SPLIT(f.Uwagi, ';') AS s
CROSS APPLY STRING_SPLIT(f.Uwagi, ';') AS s
JOIN tbTowary t ON t.IDTowaru = CAST(s.value AS INT)

-- Dla przyk³adu, mniej wydajne, te¿ wymaga APPLY
;WITH SplitData AS (
    SELECT f.IDFaktury, s.value AS IDTowaru
    FROM tbFaktury f
    CROSS APPLY STRING_SPLIT(f.Uwagi, ';') AS s
)
SELECT f.IDFaktury, f.Uwagi, t.IDTowaru, t.*
FROM tbFaktury f
JOIN SplitData sd ON f.IDFaktury = sd.IDFaktury
JOIN tbTowary t ON t.IDTowaru = CAST(sd.IDTowaru AS INT)
WHERE f.Uregulowana = 0

/*Dlaczego tylko APPLY mo¿e byæ tutaj stosowane?
Funkcje tabelaryczne, szczególnie te parametryzowane, które zwracaj¹ ró¿ne wyniki w zale¿noœci od przekazywanych parametrów, 
s¹ typowym przypadkiem u¿ycia dla APPLY. Standardowe JOINy nie obs³uguj¹ bezpoœrednio wywo³ania funkcji dla ka¿dego wiersza z innego zestawu danych, co
czyni APPLY jedynym rozwi¹zaniem do realizacji tego typu zapytañ.*/


-- Scenariusz 2. chcemy mieæ informacje na temat ostatniej sprzeda¿y ka¿dego produktu. 
-- Potrzebujemy danych z tbFaktury i tbPozycjeFaktur by od produktu dojœæ do ceny i daty sprzeda¿y
-- Podejœcie 1 -  wymaga dwukrotnego u¿ycia subselect w select, co jest mega niewydajne
SELECT 
    t.nosnik, t.wykonawca, t.tytul, t.rok_wydania, t.dystrybutor, t.cena,
    (SELECT TOP 1 p.CenaSprz
     FROM dbo.tbPozycjeFaktur p
     JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
     WHERE p.TowarID = t.IDTowaru
     ORDER BY f.DataSprzed DESC) AS LastSalePrice,
    (SELECT TOP 1 f.DataSprzed
     FROM dbo.tbPozycjeFaktur p
     JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
     WHERE p.TowarID = t.IDTowaru
     ORDER BY f.DataSprzed DESC) AS LastSaleDate
FROM dbo.tbTowary t
ORDER BY t.wykonawca, t.tytul;

-- Podejœcie 2 - lepiej, bo robimy to raz, dziêki CTE
;WITH LatestSales AS (
    SELECT 
        p.TowarID,
        p.CenaSprz,
        f.DataSprzed,
        ROW_NUMBER() OVER (PARTITION BY p.TowarID ORDER BY f.DataSprzed DESC) as RN
    FROM dbo.tbPozycjeFaktur p
    JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
)
SELECT 
    t.nosnik, t.wykonawca, t.tytul, t.rok_wydania, t.dystrybutor, t.cena,
    ls.CenaSprz AS LastSalePrice,
    ls.DataSprzed AS LastSaleDate
FROM dbo.tbTowary t
LEFT JOIN LatestSales ls ON t.IDTowaru = ls.TowarID AND ls.RN = 1
ORDER BY t.wykonawca, t.tytul;

-- Podejœcie 3 - OUTER APPLY
SELECT 
    t.nosnik, t.wykonawca, t.tytul, t.rok_wydania, t.dystrybutor, t.cena, LastSale.*
FROM dbo.tbTowary t
OUTER APPLY (
    SELECT TOP 1 p.FakturaID, f.DataSprzed, p.CenaSprz
    FROM dbo.tbPozycjeFaktur p
    JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
    WHERE p.TowarID = t.IDTowaru
    ORDER BY f.DataSprzed DESC
) AS LastSale
ORDER BY t.wykonawca, t.tytul;

-- porównamy wydajnoœæ...




USE HM
CREATE OR ALTER FUNCTION dbo.fn_HistoriaZakupow (@KlientID INT, @DataStart DATE, @DataKoniec DATE)
RETURNS TABLE
AS
RETURN (
    SELECT 
        f.IDFaktury,
        f.NrFaktury,
        f.DataSprzed,
        f.Uregulowana
    FROM tbFaktury f
    WHERE f.KlientID = @KlientID
      AND f.DataSprzed BETWEEN @DataStart AND @DataKoniec
)

SELECT * FROM fn_HistoriaZakupow (1, '2000-02-02', '2010-02-02')

USE HM
SELECT 
    k.IDKlienta,
    k.nazwa,
    h.IDFaktury,
    h.NrFaktury,
    h.DataSprzed,
    h.Uregulowana
FROM dbo.tbKlienci k
OUTER APPLY dbo.fn_HistoriaZakupow(k.IDKlienta, '2005-01-01', '2005-12-31') AS h
ORDER BY k.IDKlienta, h.DataSprzed DESC;



-- Zadanie 1 - analogicznie do scenariusza 2

-- Wyœwietlanie nazwy ka¿dego klienta i danych jego ostatnich/ostatniej faktury, jeœli taka by³a. Posortuj po nazwie
-- dla ka¿dego klienta

-- a. Wykonaj zapytanie, które dla jednego klienta, np o id = 10 tworzy liste faktur i sortuje je malej¹co po dacie.
-- Dodaj TOP 1  WITH TIES 

-- b. U¿ywaj¹c APPLY do³¹cz wynik zapytania do tabeli klienci, zamieñ warunek WHERE tak, by wynik z pkt 1 by³ powi¹zany z aktualnie przetwarzanym klientem


-- Zadanie 2 
-- funkcja poni¿ej zwraca dla ka¿dego klienta wszystkie noœniki jakie u nas kupowa³. Po³¹cz te dane z nazwami klientów
USE HM


CREATE FUNCTION dbo.fn_NosnikiPerKlient (@KlientID INT)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT t.nosnik
    FROM dbo.tbFaktury f
    JOIN dbo.tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
    JOIN dbo.tbTowary t ON pf.TowarID = t.IDTowaru
    WHERE f.KlientID = @KlientID
);
SELECT
    k.IDKlienta,
    k.nazwa,
    m.nosnik
FROM dbo.tbKlienci k
CROSS APPLY dbo.fn_NosnikiPerKlient(k.IDKlienta) AS m
ORDER BY k.IDKlienta, m.nosnik;




-- Zadanie 1

-- Wyœwietlanie nazwy ka¿dego klienta i danych jego ostatnich/ostatniej faktury, jeœli taka by³a. Posortuj po nazwie
-- dla ka¿dego klienta


-- a. Wykonaj zapytanie, które dla jednego klienta, np o id = 10 tworzy liste faktur i sortuje je malej¹co po dacie.
-- Dodaj TOP 1  WITH TIES 
SELECT TOP 1 with ties *
FROM tbFaktury
WHERE KlientID = 10
ORDER BY DataSprzed

(SELECT TOP 1 with ties *
FROM tbFaktury
WHERE KlientID = k.IDKlienta
ORDER BY DataSprzed) alias


SELECT *
FROM tbKlienci k 
OUTER APPLY (SELECT TOP 1 with ties *
FROM tbFaktury
WHERE KlientID = k.IDKlienta
ORDER BY DataSprzed) AS tb



-- b. U¿ywaj¹c APPLY do³¹cz wynik zapytania do tabeli klienci, zamieñ warunek WHERE tak, by wynik z pkt 1 by³ powi¹zany z aktualnie przetwarzanym klientem




SELECT * FROM
tbKlienci k
	OUTER APPLY (SELECT TOP 1 with ties *
	FROM tbFaktury
	WHERE KlientID = k.IDKlienta
	ORDER BY DataSprzed) AS f

-- Zadanie 2 
-- funkcja poni¿ej zwraca dla ka¿dego klienta wszystkie noœniki jakie u nas kupowa³. Po³¹cz te dane z nazwami klientów
USE HM


CREATE FUNCTION dbo.fn_NosnikiPerKlient (@KlientID INT)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT t.nosnik
    FROM dbo.tbFaktury f
    JOIN dbo.tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
    JOIN dbo.tbTowary t ON pf.TowarID = t.IDTowaru
    WHERE f.KlientID = @KlientID
);



SELECT
    k.IDKlienta,
    k.nazwa,
    m.nosnik
FROM dbo.tbKlienci k
CROSS APPLY dbo.fn_NosnikiPerKlient(k.IDKlienta) AS m
ORDER BY k.IDKlienta, m.nosnik;

