
/* FUNKCJE AGREGUJ¥CE, GRUPOWANIE */
USE HM
GO

SELECT 
    AVG(CenaSprz) AS ŒredniaCena,
    SUM(CenaSprz) AS SumaWszystkichCen,
    COUNT(1) AS IloœæWierszy,
    MAX(CenaSprz) AS MaksymalnaCena,
    MIN(CenaSprz) AS MinimalnaCena,
    ROUND(AVG(CenaSprz), 2) AS ŒredniaCenaZaokr¹glona, -- zaokr¹glenie wyniku
    AVG(COALESCE(CenaSprz, 0)) AS ŒredniaCenaZNull -- jeœli w danych mog¹ pojawiæ siê wartoœci NULL
FROM 
    tbPozycjeFaktur;

SELECT STRING_AGG(nazwa, ', ')
FROM tbKlienci


SELECT pf.FakturaID, SUM(CenaSprz) AS wartosc
FROM tbPozycjeFaktur pf
JOIN tbFaktury f ON f.IDFaktury = pf.FakturaID
--where
GROUP BY pf.FakturaID  -- f.IDFaktury 
--HAVING SUM(CenaSprz)  > 33
ORDER BY SUM(CenaSprz) 

USE BS
GO
SELECT k.NazwaKategorii + ': ' + STRING_AGG(t.NazwaTowaru, ', ') + '.'
FROM tblTowary t
JOIN tblKategorie k ON k.ID_Kategoria = t.Kategoria_ID
WHERE k.NazwaKategorii != 'owoce'
GROUP BY NazwaKategorii, Kategoria_ID -- Czy oba te pola s¹ potrzebne?


/* æwiczenia */
-- 1. Baza HM: Œrednia i suma cen albumów ka¿dego wykonawcy, z wy³¹czeniem œredniej < 35
SELECT wykonawca, AVG(cena) AS SredniaCena, SUM(cena) AS SumaCen
FROM tbTowary
GROUP BY wykonawca
HAVING AVG(cena) >= 35
ORDER BY wykonawca;

-- 2. Baza Sprzeda¿: Nazwa i iloœæ zamówieñ dla ka¿dego klienta, posortowane po iloœci zamówieñ
SELECT k.NazwaFirmy, COUNT(s.ID_Sprzedaz) AS IloscZamowien
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
GROUP BY k.NazwaFirmy
ORDER BY IloscZamowien DESC;

-- 3. Baza Sprzeda¿: Nazwiska pracowników oddzielone przecinkami, pogrupowane wed³ug stanowiska
SELECT Stanowisko, STRING_AGG(Nazwisko, ', ') AS Pracownicy
FROM tblPracownicy
GROUP BY Stanowisko;



/* ROLLUP CUBE GROUPING SETS */

-- ROLLUP: Generuje agregacje na wielu poziomach hierarchii. 
USE HM
GO
SELECT 
    p.TowarID, 
    p.FakturaID, 
    SUM(p.CenaSprz) AS SumaCen
FROM 
    tbPozycjeFaktur p
GROUP BY 
    ROLLUP(p.TowarID, p.FakturaID)
ORDER BY  p.FakturaID, p.TowarID;


SELECT
	Wykonawca, 
	YEAR(datasprzed ) as Rok,
	DATEPART(q, Datasprzed) as Kwartal,
    SUM(ilosc) as IloscRazem
FROM	tbPozycjeFaktur INNER JOIN
	tbTowary ON tbPozycjeFaktur.TowarID = tbTowary.IDTowaru INNER JOIN
	tbFaktury ON tbPozycjeFaktur.FakturaID = tbFaktury.IDFaktury
GROUP BY 
	ROLLUP (YEAR(datasprzed ), DATEPART(q, Datasprzed), wykonawca) 
ORDER BY Rok, Kwartal, IloscRazem desc 


-- CUBE: Generuje wszystkie mo¿liwe agregacje dla podanych kolumn.
-- Zwraca podsumowanie dla ka¿dego TowarID, ka¿dej FakturaID, obu razem oraz ogólne podsumowanie.
SELECT 
    p.TowarID, 
    p.FakturaID, 
    SUM(p.CenaSprz) AS SumaCen
FROM 
    tbPozycjeFaktur p
GROUP BY 
    CUBE(p.TowarID, p.FakturaID)
ORDER BY  p.FakturaID, p.TowarID;


SELECT  YEAR(datasprzed ) as Rok,
	DATEPART(q, Datasprzed) as Kwartal,
    Wykonawca, SUM(ilosc) as IloscRazem
FROM	tbPozycjeFaktur INNER JOIN
	tbTowary ON tbPozycjeFaktur.TowarID = tbTowary.IDTowaru INNER JOIN
	tbFaktury ON tbPozycjeFaktur.FakturaID = tbFaktury.IDFaktury
GROUP BY CUBE (YEAR(datasprzed ), DATEPART(q, Datasprzed), wykonawca) -- grupowanie w nawiasie
ORDER BY Rok, Kwartal, IloscRazem desc 


-- GROUPING SETS: Pozwala okreœliæ wiele zestawów grupowania w jednym zapytaniu.
-- Mo¿emy grupowaæ wszystko,  oddzielnie po TowarID, po FakturaID oraz po obu naraz. 
SELECT 
    p.TowarID, 
    p.FakturaID, 
    SUM(p.CenaSprz) AS SumaCen
FROM 
    tbPozycjeFaktur p
GROUP BY 
    GROUPING SETS( -- TUTAJ WSZYSTKIE MO¯LEWE GRUPOWANIA, MO¯NA USUN¥Æ DOWOLNE
		(),
        (p.TowarID),
        (p.FakturaID),
        (p.TowarID, p.FakturaID)
    )
ORDER BY  p.FakturaID, p.TowarID;



SELECT YEAR(datasprzed ) as Rok,
	DATEPART(q, Datasprzed) as Kwartal,
    Wykonawca, SUM(ilosc) as IloscRazem
	FROM	tbPozycjeFaktur 
	INNER JOIN 	tbTowary ON tbPozycjeFaktur.TowarID = tbTowary.IDTowaru 
	INNER JOIN tbFaktury ON tbPozycjeFaktur.FakturaID = tbFaktury.IDFaktury
GROUP BY GROUPING sets (
	(),
	(YEAR(datasprzed)),
	(YEAR(datasprzed),DATEPART(q, Datasprzed)),
	(YEAR(datasprzed),DATEPART(q, Datasprzed), wykonawca) 
	)
ORDER BY Rok, Kwartal, IloscRazem DESC 


/*æwiczenia*/
-- 1. Po³¹czenie tabel Sprzeda¿ i Opis sprzeda¿y, grupowanie z u¿yciem ROLLUP
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY ROLLUP (s.ID_Sprzedaz, o.Towar_ID);

-- 2. Podobne grupowanie z u¿yciem CUBE
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY CUBE (s.ID_Sprzedaz, o.Towar_ID);

-- 3. Grupowanie z u¿yciem GROUPING SETS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY GROUPING SETS (
    (s.ID_Sprzedaz),
    (o.Towar_ID),
    ()
);
