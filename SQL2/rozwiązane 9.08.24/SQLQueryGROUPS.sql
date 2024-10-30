
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
--where
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
--HAVING k.NazwaKategorii != 'owoce'

/* �wiczenia */
-- 1. Baza HM: dla ka�dego wykonawcy wy�wietl nazwa, �redni� cene, oraz sum� cen jego album�w (HM -> tbTowary). 
--		Posortuj wyniki po nazwie wykonawcy, a nast�pnie usu� z wyniku te zespo�y, dla kt�rych �rednia jest mniejsza od 35
USE HM
SELECT wykonawca, AVG(cena) as �rednia_cena, SUM(cena) suma_cen
FROM tbTowary 
GROUP BY wykonawca
HAVING AVG(cena) >= 35
ORDER BY wykonawca
-- 2. Baza Sprzeda�: Wy�wietl nazw� i ilo�� zam�wie� (tab sprzeda�) dla ka�dego klienta. Posortuj po ilo�ci zam�wie�
USE BS
SELECT  NazwaFirmy, COUNT(ID_Sprzedaz) ilosc_zamowien
FROM tblSprzedaz s
JOIN tblKlienci k ON s.Klient_ID = k.ID_Klient 
GROUP BY Klient_ID, NazwaFirmy 
ORDER BY ilosc_zamowien

-- 3. Baza Sprzeda�: wy�wietl w jednym polu, oddzielone przecinkami, nazwiska pracownik�w z podzia�em na stanowiska. 

SELECT Stanowisko, STRING_AGG(Nazwisko, ', ')
FROM tblPracownicy
GROUP BY Stanowisko


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
	(YEAR(datasprzed),DATEPART(q, Datasprzed)),
	(YEAR(datasprzed),DATEPART(q, Datasprzed), wykonawca),
	(wykonawca)
	)
ORDER BY Rok, Kwartal, IloscRazem DESC 


USE BS
-- 1. Po��cz tabele Sprzeda� i Opis sprzeda�y.  Wy�wietl ID Sprzeda�y, ID towaru, oraz COUNT(1).
-- Pogrupuj i wyniki po ID Sprzeda�y, a nast�pnie po ID TOWARU z u�yciem rollup.

-- 2. Zastosuj podobne grupowanie z u�yciem CUBE, sprawd� czy zmienia to ilo�� wynik�w

-- 3. Zastosuj podobne grupowanie przez grouping SET, najpierw utw�rz wszystkie mo�liwe SETY (wynik jak przy CUBE),
-- a nast�pnie pomi� te, kt�re dotycz� jednocze�nie Sprzedaz_ID i Towar_ID (zostan� tylko te podsumowywuj�ce)


USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY s.ID_Sprzedaz, o.Towar_ID;



USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY ROLLUP (s.ID_Sprzedaz, o.Towar_ID)


USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY CUBE (s.ID_Sprzedaz, o.Towar_ID)
ORDER BY s.ID_Sprzedaz, o.Towar_ID


USE BS
SELECT s.ID_Sprzedaz, o.Towar_ID, COUNT(1) AS Ilosc
FROM tblSprzedaz s
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY GROUPING SETS(
(),
(s.ID_Sprzedaz),
(o.Towar_ID)--,
--(s.ID_Sprzedaz, o.Towar_ID)

);
