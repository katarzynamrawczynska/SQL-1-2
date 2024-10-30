
/* FUNKCJE AGREGUJ�CE, GRUPOWANIE */
USE HM
GO

SELECT 
    AVG(CenaSprz) AS �redniaCena,
    SUM(CenaSprz) AS SumaWszystkichCen,
    COUNT(1) AS Ilo��Wierszy,
    MAX(CenaSprz) AS MaksymalnaCena,
    MIN(CenaSprz) AS MinimalnaCena,
    ROUND(AVG(CenaSprz), 2) AS �redniaCenaZaokr�glona, -- zaokr�glenie wyniku
    AVG(COALESCE(CenaSprz, 0)) AS �redniaCenaZNull -- je�li w danych mog� pojawi� si� warto�ci NULL
FROM 
    tbPozycjeFaktur;

SELECT STRING_AGG(nazwa, ', ')
FROM tbKlienci


SELECT pf.FakturaID, SUM(CenaSprz) AS wartosc
FROM tbPozycjeFaktur pf
JOIN tbFaktury f ON f.IDFaktury = pf.FakturaID
where FakturaID > 6
GROUP BY pf.FakturaID  -- f.IDFaktury 
HAVING SUM(CenaSprz)  > 33
ORDER BY wartosc 

USE BS
GO
SELECT k.NazwaKategorii + ': ' + STRING_AGG(t.NazwaTowaru, ', ') + '.'
FROM tblTowary t
JOIN tblKategorie k ON k.ID_Kategoria = t.Kategoria_ID
WHERE k.NazwaKategorii != 'owoce'
GROUP BY NazwaKategorii, Kategoria_ID -- Czy oba te pola s� potrzebne?


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


-- CUBE: Generuje wszystkie mo�liwe agregacje dla podanych kolumn.
-- Zwraca podsumowanie dla ka�dego TowarID, ka�dej FakturaID, obu razem oraz og�lne podsumowanie.
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


-- GROUPING SETS: Pozwala okre�li� wiele zestaw�w grupowania w jednym zapytaniu.
-- Mo�emy grupowa� wszystko,  oddzielnie po TowarID, po FakturaID oraz po obu naraz. 
SELECT 
    p.TowarID, 
    p.FakturaID, 
    SUM(p.CenaSprz) AS SumaCen
FROM 
    tbPozycjeFaktur p
GROUP BY 
    GROUPING SETS( -- TUTAJ WSZYSTKIE MO�LEWE GRUPOWANIA, MO�NA USUN�� DOWOLNE
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
	--(YEAR(datasprzed),DATEPART(q, Datasprzed))
	(YEAR(datasprzed),DATEPART(q, Datasprzed), wykonawca) 
	)
ORDER BY Rok, Kwartal, IloscRazem DESC 



-- 1. Po��cz tabele Sprzeda� i Opis sprzeda�y.  Wy�wietl ID Sprzeda�y, ID towaru, oraz COUNT(1).
-- Pogrupuj i wyniki po ID Sprzeda�y, a nast�pnie po ID TOWARU z u�yciem rollup.

-- 2. Zastosuj podobne grupowanie z u�yciem CUBE, sprawd� czy zmienia to ilo�� wynik�w

-- 3. Zastosuj podobne grupowanie przez grouping SET, najpierw utw�rz wszystkie mo�liwe SETY (wynik jak przy CUBE),
-- a nast�pnie pomi� te, kt�re dotycz� jednocze�nie Sprzedaz_ID i Towar_ID (zostan� tylko te podsumowywuj�ce)

USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY ROLLUP (s.ID_Sprzedaz, o.Towar_ID);

USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY CUBE (s.ID_Sprzedaz, o.Towar_ID);



USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY GROUPING SETS(
(),
(s.ID_Sprzedaz),
(o.Towar_ID)
--(s.ID_Sprzedaz, o.Towar_ID)

);
