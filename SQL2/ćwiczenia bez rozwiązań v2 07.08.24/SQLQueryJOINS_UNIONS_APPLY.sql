
USE BS
GO


/* z��czenie poziome - JOIN*/

SELECT * FROM tblPracownicy; -- id 2 - nie przypisany do sprzeda�y
SELECT * FROM tblSprzedaz; -- id 6, 11, 20, 39, 141 - brak przypisanego pracownika

-- INNER JOIN: co najmniej jeden dopasowany rekord w obu tabelach
SELECT  *-- p.*, s.*, s.ID_Sprzedaz, p.IDPracownika
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
FROM tblSprzedaz sp -- wiele JOIN -- Czy s� jakie� zasady co do kolejno�ci ?
JOIN tblOpisSprzedazy o_sp ON sp.ID_Sprzedaz = o_sp.Sprzedaz_ID
JOIN tblKlienci k ON k.ID_Klient = sp.Klient_ID
JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID



/* UNIONS */
SELECT UPPER(Miasto)
FROM tblPracownicy
 -- UNION 
 -- UNION ALL (dane si� duplikuj�, je�li wyst�puj� w obu wynikach)
 -- INTERSECT 
 -- EXCEPT 
SELECT UPPER(Miasto)
FROM tblKlienci;

-- Co gdy u�yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*�wiczenie*/
-- 1. W tabeli klient�w mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s� postaci xxxxx.
	-- a. u�ywaj�c funkcji wbudowanych zmi� format kod�w w tabeli z klientami do formatu xxxxx 
	-- (u�yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klient�w, oraz kodach pracownik�w




/* APPLY */

USE HM

-- Scenariusz 1 - funkcja tabelaryczna
-- Wykona� procedur� 

-- Dwa alternatywne rozwi�zania:
SELECT f.IDFaktury, f.Uwagi, s.value AS IDTowaru, t.*
FROM tbFaktury f
--JOIN  STRING_SPLIT(f.Uwagi, ';') AS s
CROSS APPLY STRING_SPLIT(f.Uwagi, ';') AS s
JOIN tbTowary t ON t.IDTowaru = CAST(s.value AS INT)

-- Dla przyk�adu, mniej wydajne, te� wymaga APPLY
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

/*Dlaczego tylko APPLY mo�e by� tutaj stosowane?
Funkcje tabelaryczne, szczeg�lnie te parametryzowane, kt�re zwracaj� r�ne wyniki w zale�no�ci od przekazywanych parametr�w, 
s� typowym przypadkiem u�ycia dla APPLY. Standardowe JOINy nie obs�uguj� bezpo�rednio wywo�ania funkcji dla ka�dego wiersza z innego zestawu danych, co
czyni APPLY jedynym rozwi�zaniem do realizacji tego typu zapyta�.*/


-- Scenariusz 2. chcemy mie� informacje na temat ostatniej sprzeda�y ka�dego produktu. 
-- Potrzebujemy danych z tbFaktury i tbPozycjeFaktur by od produktu doj�� do ceny i daty sprzeda�y
-- Podej�cie 1 -  wymaga dwukrotnego u�ycia subselect w select, co jest mega niewydajne
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

-- Podej�cie 2 - lepiej, bo robimy to raz, dzi�ki CTE
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

-- Podej�cie 3 - OUTER APPLY
SELECT 
    t.nosnik, t.wykonawca, t.tytul, t.rok_wydania, t.dystrybutor, t.cena, LastSale.*
FROM dbo.tbTowary t
OUTER APPLY (
    SELECT TOP 1 p.FakturaID, f.DataSprzed, p.CenaSprz, p.Ilosc
    FROM dbo.tbPozycjeFaktur p
    JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
    WHERE p.TowarID = t.IDTowaru
    ORDER BY f.DataSprzed DESC
) AS LastSale
ORDER BY t.wykonawca, t.tytul;

-- por�wnamy wydajno��...



/***
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
*/
USE HM
SELECT 
    k.IDKlienta,
    k.nazwa,
    h.IDFaktury,
    h.NrFaktury,
    h.DataSprzed,
    h.Uregulowana
FROM dbo.tbKlienci k
CROSS APPLY dbo.fn_HistoriaZakupow(k.IDKlienta, '2005-01-01', '2005-12-31') AS h
ORDER BY k.IDKlienta, h.DataSprzed DESC;



-- Zadanie 1

-- Wy�wietlanie nazwy ka�dego klienta i danych jego ostatnich/ostatniej faktury, je�li taka by�a. Posortuj po nazwie
-- dla ka�dego klienta

-- a. Wykonaj zapytanie, kt�re dla jednego klienta, np o id = 10 tworzy liste faktur i sortuje je malej�co po dacie.
-- Dodaj TOP 1  WITH TIES 

-- b. U�ywaj�c APPLY do��cz wynik zapytania do tabeli klienci, zamie� warunek WHERE tak, by wynik z pkt 1 by� powi�zany z aktualnie przetwarzanym klientem


-- Zadanie 2 
-- funkcja poni�ej zwraca dla ka�dego klienta wszystkie no�niki jakie u nas kupowa�. Po��cz te dane z nazwami klient�w
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




