USE HM

-- Scenariusz 1 - funkcja tabelaryczna

-- Dwa alternatywne rozwi¹zania:
SELECT f.IDFaktury, f.Uwagi, s.value AS IDTowaru, t.*
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
    SELECT TOP 1 p.FakturaID, f.DataSprzed, p.CenaSprz, p.Ilosc
    FROM dbo.tbPozycjeFaktur p
    JOIN dbo.tbFaktury f ON p.FakturaID = f.IDFaktury
    WHERE p.TowarID = t.IDTowaru
    ORDER BY f.DataSprzed DESC
) AS LastSale
ORDER BY t.wykonawca, t.tytul;

-- porównamy wydajnoœæ...



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

-- Po stworzeniu poni¿szej funkcji bêdziemy mieli narzêdzie, które dla podanego klient id zwraca tabele z danymi z faktur 
-- i ich pozycji, ³¹cznie z informacjami o towarze z pozycji

CREATE FUNCTION dbo.fn_FakturyPerKlient (@KlientID INT)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT FakturaID, DataSprzed, TowarID, t.cena
    FROM dbo.tbFaktury f
    JOIN dbo.tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
    JOIN dbo.tbTowary t ON pf.TowarID = t.IDTowaru
    WHERE f.KlientID = @KlientID
);

--Wywy³anie dla jednego z klientów
SELECT * FRoM dbo.fn_FakturyPerKlient(10)

-- Dadaj tabelê zwracan¹ przez powy¿sz¹ funkcjê do tabeli z danymi klienta poprze APPLY




-- PIVOT

USE BS

-- 0. wynik zapytania, na którym chcemy zamieniæ osie
SELECT NazwaKategorii, SUM(Cena_Katalogowa)
FROM tblTowary t
JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
GROUP BY NazwaKategorii


-- 1. wartoœci które maj¹ siê staæ nazwami kolumn
SELECT Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj¹ca kolumnê z tymi wartoœciami, oraz wartoœci¹ do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okreœlenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)) AS pv


--------------------------------------------
SELECT YEAR(DataSprzedazy) rok, SUM(CenaSprzedazy) 
FROM tblOpisSprzedazy os
JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz
GROUP BY YEAR(DataSprzedazy) 

---
SELECT YEAR(DataSprzedazy) as rok, CenaSprzedazy
FROM tblOpisSprzedazy os
JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz

--
SELECT DISTINCT YEAR(DataSprzedazy) FROM tblSprzedaz

--
SELECT *--2012, 2013, 2014, 2015, 2016, 2017
FROM (
	SELECT YEAR(DataSprzedazy) as rok, CenaSprzedazy
	FROM tblOpisSprzedazy os
	JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz
	) AS qr
PIVOT (SUM(CenaSprzedazy) FOR rok IN ([2012], [2013], [2014], [2015], [2016], [2017]) 
) AS pv


-- 1. Wyœwietl jako kolumny nazwy noœników muzyki, i iloœci odpowiadaj¹cych im p³yt:
-- a. Napisz zapytanie, które wyœwietla wynik bez pivotowania
-- b. Sprowad¿ do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, które stan¹ siê kolumnami)
-- c. wstaw w poni¿sze ramy select
USE HM
SELECT * FROM
(
	-- Wybieramy kolumnê z noœnikami
) AS qr
PIVOT ( 
-- agregacja COUNT DLA (nazwy wartoœci - nowych kolumn
) AS pv


-- 2.  Korzystaj¹c z bazy HM wyœwietl tabele, w której kolumny to lata z
-- których pochodz¹ faktury, a w wierszu znajduje siê œrednia wartoœæ faktury w danym roku


