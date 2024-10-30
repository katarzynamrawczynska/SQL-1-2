/*VIEW, SUBSELECT*/
USE HM
GO

/*SUBSELECT*/


SELECT MAX(cena) --, wykonawca + ' - ' + tytul
FROM tbTowary
-- u¿ycie w warunku, przy agregacji - zwalnia czas wykonania, ale jest potrzebne
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary)

-- u¿ycie w warunku z operatorem ANY, ale szybciej zadzia³a, gdy przerobimy na INNER JOIN
SELECT nazwa 
FROM hm.dbo.tbKlienci
WHERE nazwa = ANY(SELECT NazwaFirmy FROM BS.dbo.tblKlienci)

-- u¿ycie w JOIN z prefiltrowaniem - zbêdne dane s¹ odfiltrowane zanim nast¹pi po³¹czenie - mo¿e przyœpieszyæ 
-- czas wykonania, ale komplikuje sk³adnie
SELECT 
    f.IDFaktury,
    f.KlientID,
    pf.TotalCena
FROM 
    tbFaktury f
JOIN 
    (SELECT 
         FakturaID, 
         SUM(CenaSprz) AS TotalCena 
		 FROM tbPozycjeFaktur 
		 WHERE Ilosc > 5  -- Pre-filtrowanie danych
		 GROUP BY  FakturaID
	) pf 
ON f.IDFaktury = pf.FakturaID;

-- u¿ycie subzapytania do wyci¹gniêcia dodatkowej kolumny
SELECT 
    f.IDFaktury,
    f.KlientID,
    (
		SELECT SUM(CenaSprz) 
		FROM tbPozycjeFaktur 
		WHERE FakturaID = f.IDFaktury
	 ) AS TotalCena
FROM 
    tbFaktury f;

/* æwiczenia */
-- 1.  Wyœwietl wszystkie dane faktur wraz z opisem najœwie¿szej i najstarszej faktury w bazie (MAX i MIN data)
SELECT * FROM tbFaktury
WHERE DataSprzed = (SELECT MAX(DataSprzed) FROM tbFaktury) OR DataSprzed = (SELECT MIN(DataSprzed) FROM tbFaktury)
-- 2. W poni¿szym zapytaniu dodaj WHERE, który wybierze tylko te pozycje faktur, w których towar jest na noœniku CD
SELECT pf.FakturaID, SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
JOIN tbTowary t ON pf.TowarID = t.IDTowaru
WHERE t.Nosnik = 'CD'
GROUP BY pf.FakturaID;


-- 3. Napisz zapytanie, które wyci¹ga dane faktur z 2005 roku. Gotowe zapytanie po³¹cz jako subselect z tabel¹ 
-- pozycje faktur, oraz towary. Z podanych wyœwietl datê faktury (z podzapytania z fakturami), nazwê wykonawcy 
-- i albumu(towary), oraz cenê sprzeda¿y (pozycje faktur)
SELECT 
    f2005.DataSprzed, 
    t.Wykonawca, 
    t.Tytul AS Album, 
    pf.CenaSprz
FROM (
    SELECT IDFaktury, DataSprzed 
    FROM tbFaktury 
    WHERE YEAR(DataSprzed) = 2005
) AS f2005
JOIN tbPozycjeFaktur pf ON f2005.IDFaktury = pf.FakturaID
JOIN tbTowary t ON pf.TowarID = t.IDTowaru;



/*VIEWS*/
-- Tworzenie widoku powinno byæ osobn¹ komend¹, ale gdy zaznaczymy tylko t¹ instrukcje / u¿ywamy po niej GO
-- Widok siê utworzy
-- UWAGA! w widoku wszystkie kolumny musz¹ mieæ nazwy

CREATE OR ALTER VIEW avg_sprzedaz AS (SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur order );
GO;
SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur WHERE CenaSprz > (SELECT TOP 1 srednia_sp FROM avg_sprzedaz) -- dlaczego top 1? Czy u¿yæ?

DROP VIEW avg_sprzedaz  -- usuniêcie widoku

-- zmieñmy poni¿sze zapytanie na widok

SELECT f.IDFaktury, f.KlientID, pf.TotalCena
FROM tbFaktury f
JOIN (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
) pf ON f.IDFaktury = pf.FakturaID



/*æwiczenia*/
-- 1. Utwórz widok z numerami faktur, dat¹ sprzeda¿y oraz nazw¹ klienta z fakturami z roku 2004
CREATE VIEW faktury2004 AS(
SELECT NrFaktury, DataSprzed, nazwa 
FROM tbFaktury f
JoIN tbKlienci k ON f.KlientID = k.IDKlienta
WHERE YEAR(DataSprzed) = 2004)


-- 2 Wybierz towary które nie nale¿¹ do kategorii 1 i 2. wyœwietl nazwy i ceny zaokr¹glone do jednego miejsca po przecinku (ROUND)
-- po przetestowaniu zapisz wynik jako widok i napisz SELECT wybieraj¹cy z niego tylko 3 najtañsze produkty.
USE BS
CREATE VIEW TowaryGr1Gr2 AS (
SELECT NazwaTowaru, ROUND(Cena_Katalogowa,1) Cena_Katalogowa FROM tblTowary
WHERE Kategoria_ID IN (1,2)
)

SELECT TOP 3 *
FROM TowaryGr1Gr2
ORDER BY Cena_Katalogowa