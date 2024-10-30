USE HM

IF NOT EXISTS  (select * from sysobjects where name='SplitString' and xtype='U')
	BEGIN
		CREATE TABLE SplitString (string NVARCHAR(100))
		INSERT INTO SplitString VALUES ('2022-11-24')
		INSERT INTO SplitString VALUES ('2022-04-01')
	END
SELECT * FROM SplitString

-- mo¿emy wywo³aæ tylko dla konkretnej wartoœci, a nie ca³ej tabeli
SELECT '2022-04-01', * FROM STRING_SPLIT('2022-04-01','-')

-- UZYCIE APPLY
SELECT * FROM SplitString s
CROSS APPLY STRING_SPLIT(s.string, '-')


SELECT * FROM tbFaktury
EXEC dbo.OdswiezFakturyUwagi
-- Scenariusz 1 - funkcja tabelaryczna

-- rozwi¹zania których sk³adnia jest niepoprawna
/*
SELECT STRING_SPLIT(f.Uwagi, ';')
FROM tbFaktury

SELECT f.IDFaktury, f.Uwagi, s.value AS IDTowaru, t.*
FROM tbFaktury f
JOIN  STRING_SPLIT(f.Uwagi, ';') AS s ON t.IDTowaru = CAST(s.value AS INT)
*/

-- Rozwi¹zanie:
SELECT f.IDFaktury, f.Uwagi, s.value AS IDTowaru, t.*
FROM tbFaktury f
CROSS APPLY STRING_SPLIT(f.Uwagi, ';') AS s
JOIN tbTowary t ON t.IDTowaru = CAST(s.value AS INT)

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

-- Wyœwietlanie nazwy ka¿dego klienta i danych jego 3 ostatnich faktury, jeœli takie by³y. Posortuj po nazwie
-- dla ka¿dego klienta


-- a. Wykonaj zapytanie, które dla jednego klienta, np o id = 2 tworzy liste faktur i sortuje je malej¹co po dacie.
-- Dodaj TOP 1  WITH TIES 
SELECT TOP 1 with ties *
FROM tbFaktury
WHERE KlientID = 20
ORDER BY DataSprzed


-- b. U¿ywaj¹c APPLY do³¹cz wynik zapytania do tabeli klienci, zamieñ warunek WHERE tak, by wynik z pkt 1 by³ powi¹zany z aktualnie przetwarzanym klientem


SELECT *
FROM tbKlienci k 
OUTER APPLY (SELECT TOP 1 with ties *
FROM tbFaktury
WHERE KlientID = k.IDKlienta
ORDER BY DataSprzed) AS tb

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




-- PIVOT

USE BS

-- 0. wynik zapytania, na którym chcemy zamieniæ osie
SELECT NazwaKategorii, SUM(Cena_Katalogowa)
FROM tblTowary t
JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
GROUP BY NazwaKategorii

SELECT * FROM tblTowary

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
SELECT nosnik, COUNT(1) FROM tbTowary GROUP BY nosnik
-- a. Napisz zapytanie, które wyœwietla wynik bez pivotowania
-- b. Sprowad¿ do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, które stan¹ siê kolumnami)
-- c. wstaw w poni¿sze ramy select
USE HM
SELECT * FROM
(
SELECT nosnik FROM tbTowary
) AS qr
PIVOT ( 
 COUNT(nosnik) FOR nosnik IN ( Analog, CD,DVD,MC,VHS)
) AS pv


-- 2.  Korzystaj¹c z bazy HM wyœwietl tabele, w której kolumny to lata z
-- których pochodz¹ faktury, a w wierszu znajduje siê œrednia wartoœæ faktury w danym roku

Analog, CD,DVD,MC,VHS







