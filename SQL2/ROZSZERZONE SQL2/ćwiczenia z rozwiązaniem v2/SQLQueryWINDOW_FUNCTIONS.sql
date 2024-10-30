USE HM
-- u�ycie OVER - PARTITION BY - ORDER BY z funkcjami agreguj�cymi

-- Agregacja z grupowaniem
SELECT 
	nosnik, 
	MAX(cena) max_cena 
FROM tbTowary
GROUP BY nosnik
ORDER BY nosnik

-- Alternatywne rozwi�zanie z u�yciem funkcji OKNA
SELECT  -- DISTINCT    
	nosnik,
	MAX(cena) OVER(PARTITION BY nosnik ORDER BY nosnik) MaxCena 
FROM tbTowary

-- Przyk�ad 2
SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS CenaFaktury
FROM dbo.tbPozycjeFaktur
GROUP BY FakturaID;

SELECT DISTINCT -- dane nie s� zagregowane, distict usuwa duplikaty
    FakturaID, --*,   -- dzi�ki OVER, zamiast grupowania mamy dost�p do wszystkich p�l zapytania, a nie tylko tych zagregowanych i zgrupowanych
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS CenaFaktury
FROM dbo.tbPozycjeFaktur;

SELECT DISTINCT
    FakturaID, *, -- dane si� nie agreguj�, mo�emy wy�wietli� wszystkie kolumny
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID ORDER BY FakturaID) AS TotalAmount
FROM dbo.tbPozycjeFaktur

SELECT  TowarID,
	CenaSprz*Ilosc AS Wartosc, 
	CenaSprz *Ilosc - AVG(CenaSprz*Ilosc) OVER (ORDER BY FakturaID) AS OdchylenieOdAVG
FROM dbo.tbPozycjeFaktur





SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(ORDER BY p.CenaSprz) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    ROW_NUMBER() OVER(ORDER BY p.FakturaID) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK()       OVER(ORDER BY p.CenaSprz) AS 'RangaCeny',
    DENSE_RANK() OVER(ORDER BY p.CenaSprz) AS 'G�staRangaCeny',
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
    DENSE_RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'G�staRangaCeny',
    NTILE(4) OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY 
    f.IDFaktury, p.CenaSprz DESC;



/* �wiczenia */
-- 1. U�yj OVER, aby policzy� klient�w z podzia�em na miasta. *** - Zwr�� uwag�, �e w tabeli z klientami mamy dwa sposoby zapisu: "Krak�w" i Krak�w. 

SELECT -- DISTINCT
miasto, COUNT(IDKlienta) OVER (PARTITION BY miasto)
FROM tbKlienci

-- Spr�buj wymy�li� jak znormalizowa� te zapisy, aby oba sposoby dla tego samego miasta grupowa�y si� razem (mo�na to zrobi� jedn� funkcj� skalarn�)

SELECT -- DISTINCT
REPLACE(miasto,'"','' ) , COUNT(IDKlienta) OVER (PARTITION BY REPLACE(miasto,'"','' ))
FROM tbKlienci

-- 2. a. zmie� partycjonowanie poni�sze zapytania na ID klienta - dodaj do wynik�w nazw� klienta - nale�y do��czy�  INNER JOIN tabel� tbKlienci
-- b. nast�pnie zmie� order po cenie, na order po ilo�ci. Zmie� sortowania tak, aby mie� rosn�ce pozycje ranking�w w danej grupie

SELECT * FROM tbKlienci
SELECT 
    f.IDFaktury,
    p.CenaSprz,
	k.nazwa,
	p.ilosc,
    ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'G�staRangaCeny',
    NTILE(4) OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON k.IDKlienta = f.KlientID  
ORDER BY 
    f.KlientID, p.Ilosc DESC;

-- 3. Do zapytania poni�ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u�ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo�u

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


---


/*FETCH OFFSET TOP WITH TIES*/
-- Wybieranie z wyniku wierszy 6-15 
USE BS
SELECT *
FROM tblPracownicy
ORDER BY Nazwisko
OFFSET 5 ROWS        -- Pomi� pierwsze 5 wierszy
FETCH NEXT 10 ROWS ONLY; -- Nast�pnie pobierz 10 wierszy

SELECT TOP 1 * FROM tblOpisSprzedazy ORDER BY Ilosc -- zawsze zwr�ci jeden wiersz 
SELECT TOP 1 WITH TIES * FROM tblOpisSprzedazy ORDER BY Ilosc -- zwr�ci WSZYSTKIE wiersze z minimaln� ilo�ci� - TOP WITH TIES ZAWSZE musi wyst�powa� z ORDER BY - to dla tej kolumny zwr�ci remisy 

-- Zamiast u�ywa� subsapytania by wyci�gn�� pe�ne dane o wierszach z warto�c� minimaln�/maksymaln� mo�emy u�yc TOP 1 WITH TIES:
 
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
--R�nica dat sprzeda�y
SELECT 
    s.ID_Sprzedaz,
    s.Klient_ID,
    s.DataSprzedazy,
    s.Pracownik_ID,
    LAG(s.DataSprzedazy) OVER (/*PARTITION BY s.Klient_ID*/ ORDER BY s.DataSprzedazy) AS PreviousSaleDate,
    LEAD(s.DataSprzedazy) OVER (/*PARTITION BY s.Klient_ID*/ ORDER BY s.DataSprzedazy) AS NextSaleDate,
	CUME_DIST() OVER (/*PARTITION BY s.Klient_ID */ ORDER BY s.DataSprzedazy ) *100 AS ProceNtWartPowyzej, 
	PERCENT_RANK() OVER (/*PARTITION BY s.Klient_ID */ ORDER BY s.DataSprzedazy ) *100 AS ProceNtWartPowyzej, 
	DATEDIFF(day, DataSprzedazy, LEAD(s.DataSprzedazy) OVER (/*PARTITION BY s.Klient_ID*/ ORDER BY s.DataSprzedazy)) AS roznica_dni
FROM 
    tblSprzedaz s
ORDER BY 
    --s.Klient_ID, 
    DataSprzedazy


/*LAG LEAD*/
--R�nica dat sprzeda�y
SELECT 
    s.ID_Sprzedaz,
    s.Klient_ID,
    s.DataSprzedazy,
    s.Pracownik_ID,
    LAG(s.DataSprzedazy) OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy) AS PreviousSaleDate,
    LEAD(s.DataSprzedazy) OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy) AS NextSaleDate,
	CUME_DIST() OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy ) AS ProceNtWartPowyzej, 
	PERCENT_RANK() OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy ) AS ProceNtWartPowyzej, 
	DATEDIFF(day, DataSprzedazy, LEAD(s.DataSprzedazy) OVER (PARTITION BY s.Klient_ID ORDER BY s.DataSprzedazy)) AS roznica_dni
FROM 
    tblSprzedaz s
ORDER BY 
    s.Klient_ID, 
    DataSprzedazy

-- zmienno�� cen
SELECT 
    os.ID_OpisSprzedazy,
    os.Towar_ID,
    os.CenaSprzedazy,
    LEAD(os.CenaSprzedazy) OVER (PARTITION BY os.Towar_ID ORDER BY os.ID_OpisSprzedazy) AS KolejnaCena,
    (LEAD(os.CenaSprzedazy) OVER (PARTITION BY os.Towar_ID ORDER BY os.ID_OpisSprzedazy) - os.CenaSprzedazy) AS Ro�nicaKolejnychCen
FROM 
    tblOpisSprzedazy os
ORDER BY 
    os.Towar_ID, 
    os.ID_OpisSprzedazy;




/*�wiczenia*/

-- 1. Do zapytania poni�ej dodaj Dat� kolejnej sprzeda�y (z podzia�em na klient�w) oraz r�nic� tych dat w dniach (funkcja DATADIFF)
-- 2. Za pomoc� TOP WITH TIES wybierz te dane tylko dla klienta z pierwszym /* ***ostatnim */ ID w bazie. Pomi� sortowanie po Dacie
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
    --sp.DataSprzedazy;





 /*�wiczenia dodatkowe */
-- 1. wy�wietl pierwsze 3 litery nazwy i ceny towar�w posortowane po cenie malej�co. W wyniku pomi� pierwsze 3 wiersze i poka� kolejne 7 (trzeba u�y� JOIN)
