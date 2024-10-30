USE HM
-- u¿ycie OVER - PARTITION BY - ORDER BY 
SELECT 
	nosnik, 
	MAX(cena) max_cena 
FROM tbTowary
GROUP BY nosnik
ORDER BY nosnik

SELECT  -- DISTINCT    
	nosnik,
	MAX(cena) OVER(PARTITION BY nosnik ORDER BY nosnik) MaxCena 
FROM tbTowary

SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS TotalAmount
FROM dbo.tbPozycjeFaktur
GROUP BY FakturaID;

SELECT DISTINCT -- dane nie s¹ zagregowane, distict usuwa duplikaty
    FakturaID, --*,   -- dziêki OVER, zamiast grupowania mamy dostêp do wszystkich pól zapytania, a nie tylko tych zagregowanych i zgrupowanych
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS CenaFaktury
FROM dbo.tbPozycjeFaktur;


/* OVER, FUNKCJE RANKINGOWE  baza danych HM */
-- GRUPOWANIE
SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS TotalAmount
FROM tbPozycjeFaktur
GROUP BY FakturaID;
-- Alternatywa z u¿yciem OVER
SELECT DISTINCT
    FakturaID, -- *, -- dane siê nie agreguj¹, mo¿emy wyœwietliæ wszystkie kolumny
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS TotalAmount
FROM dbo.tbPozycjeFaktur;


SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(ORDER BY p.CenaSprz) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK()       OVER(ORDER BY p.CenaSprz) AS 'RangaCeny',
    DENSE_RANK() OVER(ORDER BY p.CenaSprz) AS 'GêstaRangaCeny',
    NTILE(4)     OVER(ORDER BY p.CenaSprz) AS 'KwartyleCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY 
    p.CenaSprz ;

SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'GêstaRangaCeny',
    NTILE(4) OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY 
    f.IDFaktury, p.CenaSprz DESC;


/* æwiczenia */
-- 1. U¿yj OVER, aby policzyæ klientów z podzia³em na miasta. *** - Zwróæ uwagê, ¿e w tabeli z klientami mamy dwa sposoby zapisu: "Kraków" i Kraków. 

SELECT -- DISTINCT
miasto, COUNT(IDKlienta) OVER (PARTITION BY miasto)
FROM tbKlienci

-- Spróbuj wymyœliæ jak znormalizowaæ te zapisy, aby oba sposoby dla tego samego miasta grupowa³y siê razem (mo¿na to zrobiæ jedn¹ funkcj¹ skalarn¹)

SELECT  DISTINCT
REPLACE(miasto,'"','' ) , COUNT(IDKlienta) OVER (PARTITION BY REPLACE(miasto,'"','' ))
FROM tbKlienci

-- 2. a. zmieñ partycjonowanie poni¿sze zapytania na ID klienta - dodaj do wyników nazwê klienta - nale¿y do³¹czyæ  INNER JOIN tabelê tbKlienci
-- b. nastêpnie zmieñ order po cenie, na order po iloœci. Zmieñ sortowania tak, aby mieæ rosn¹ce pozycje rankingów w danej grupie

SELECT 
    f.IDFaktury,
    p.CenaSprz,
	k.nazwa,
	p.ilosc,
    ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'GêstaRangaCeny',
    NTILE(4) OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON k.IDKlienta = f.KlientID  
ORDER BY 
    f.KlientID, p.Ilosc DESC;

-- 3. Do zapytania poni¿ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u¿ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo³u

SELECT wykonawca, tytul, cena
-- dodanie funkcji rankingowych
FROM tbTowary

SELECT wykonawca, tytul, cena,
DENSE_RANK() OVER (ORDER BY cena),
RANK() OVER (ORDER BY cena)
FROM tbTowary

SELECT wykonawca, tytul, cena,
DENSE_RANK() OVER (PARTITION BY wykonawca ORDER BY cena),
RANK() OVER (PARTITION BY wykonawca ORDER BY cena)
FROM tbTowary
ORDER BY wykonawca, cena



/*FETCH OFFSET TOP WITH TIES*/
-- Wybieranie z wyniku wierszy 6-15 
USE BS
SELECT *
FROM tblPracownicy
ORDER BY Nazwisko
OFFSET 15 ROWS        -- Pomiñ pierwsze 5 wierszy
FETCH NEXT 10 ROWS ONLY; -- Nastêpnie pobierz 10 wierszy


/* TOP WITH TIES zamiast bardziej sk¹plikowanej kwerendy*/

SELECT TOP 1 * FROM tblOpisSprzedazy ORDER BY Ilosc DESC  -- zawsze zwróci jeden wiersz 
SELECT TOP 1 WITH TIES * FROM tblOpisSprzedazy ORDER BY Ilosc DESC -- zwróci WSZYSTKIE wiersze z minimaln¹ iloœci¹ - TOP WITH TIES ZAWSZE musi wystêpowaæ z ORDER BY - to dla tej kolumny zwróci remisy 

-- Zamiast u¿ywaæ subsapytania by wyci¹gn¹æ pe³ne dane o wierszach z wartoœc¹ minimaln¹/maksymaln¹ mo¿emy u¿yc TOP 1 WITH TIES:
 
SELECT TOP 1  WITH TIES
    t.ID_Towar,
    t.Kategoria_ID,
    t.NazwaTowaru,
    t.Cena_Katalogowa,
    COUNT(os.ID_OpisSprzedazy) AS LiczbaSprzedazy
FROM 
    tblOpisSprzedazy os
JOIN 
    tblTowary t ON os.Towar_ID = t.ID_Towar
GROUP BY 
    t.ID_Towar,
    t.Kategoria_ID,
    t.NazwaTowaru,
    t.Cena_Katalogowa
ORDER BY LiczbaSprzedazy

-- Alternatywa z subquery (mniej wydajne)
SELECT 
    t.ID_Towar,
    t.Kategoria_ID,
    t.NazwaTowaru,
    t.Cena_Katalogowa,
    t.LiczbaSprzedazy
FROM (
    SELECT 
        t.ID_Towar,
        t.Kategoria_ID,
        t.NazwaTowaru,
        t.Cena_Katalogowa,
        COUNT(os.ID_OpisSprzedazy) AS LiczbaSprzedazy,
        MAX(COUNT(os.ID_OpisSprzedazy)) OVER () AS MaxLiczbaSprzedazy
    FROM 
        tblOpisSprzedazy os
    JOIN 
        tblTowary t ON os.Towar_ID = t.ID_Towar
    GROUP BY 
        t.ID_Towar,
        t.Kategoria_ID,
        t.NazwaTowaru,
        t.Cena_Katalogowa
) t
WHERE 
    t.LiczbaSprzedazy = t.MaxLiczbaSprzedazy
ORDER BY 
    t.LiczbaSprzedazy DESC;




/*LAG LEAD*/
--Ró¿nica dat sprzeda¿y
SELECT 
    s.ID_Sprzedaz,
    s.Klient_ID,
    s.DataSprzedazy,
    s.Pracownik_ID,
    LAG(s.DataSprzedazy) OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy) AS PreviousSaleDate,
    LEAD(s.DataSprzedazy) OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy) AS NextSaleDate,
	DATEDIFF(day, DataSprzedazy, LEAD(s.DataSprzedazy) OVER (/*PARTITION BY s.Klient_ID*/ ORDER BY s.DataSprzedazy)) AS roznica_dni
FROM 
    tblSprzedaz s
ORDER BY 
    s.Klient_ID, 
    DataSprzedazy

-- zmiennoœæ cen
SELECT 
    os.ID_OpisSprzedazy,
    os.Towar_ID,
    os.CenaSprzedazy,
    LEAD(os.CenaSprzedazy) OVER (PARTITION BY os.Towar_ID ORDER BY os.ID_OpisSprzedazy) AS KolejnaCena,
    (LEAD(os.CenaSprzedazy) OVER (PARTITION BY os.Towar_ID ORDER BY os.ID_OpisSprzedazy) - os.CenaSprzedazy) AS Ro¿nicaKolejnychCen
FROM 
    tblOpisSprzedazy os
ORDER BY 
    os.Towar_ID, 
    os.ID_OpisSprzedazy;




/*æwiczenia*/

-- 1. Do zapytania poni¿ej dodaj Datê kolejnej sprzeda¿y (z podzia³em na klientów) oraz ró¿nicê tych dat w dniach (funkcja DATADIFF)
-- 2. Za pomoc¹ TOP WITH TIES wybierz te dane tylko dla klienta z pierwszym /* ***ostatnim */ ID w bazie. Pomiñ sortowanie po Dacie
/*æwiczenia*/

-- 1. Do zapytania poni¿ej dodaj Datê kolejnej sprzeda¿y (z podzia³em na klientów) oraz ró¿nicê tych dat w dniach (funkcja DATADIFF)
-- 2. Za pomoc¹ TOP WITH TIES wybierz te dane tylko dla klienta z pierwszym /* ***ostatnim */ ID w bazie. Pomiñ sortowanie po Dacie
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
		sp.Klient_ID DESC
) result order by result.DataSprzedazy 

