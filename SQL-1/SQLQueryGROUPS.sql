
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
--HAVING SUM(CenaSprz)  > 200
ORDER BY SUM(CenaSprz) DESC

USE BS
GO
SELECT k.NazwaKategorii + ': ' + STRING_AGG(t.NazwaTowaru, ', ') + '.'
FROM tblTowary t
JOIN tblKategorie k ON k.ID_Kategoria = t.Kategoria_ID
WHERE k.NazwaKategorii != 'owoce'
GROUP BY NazwaKategorii, Kategoria_ID -- Czy oba te pola s¹ potrzebne?

USE HM
GO
SELECT 
    p.TowarID, 
    p.FakturaID, 
    SUM(p.CenaSprz) AS SumaCen
FROM 
    tbPozycjeFaktur p
GROUP BY 
    p.TowarID, p.FakturaID
ORDER BY  p.FakturaID, p.TowarID;

/* æwiczenia */
-- 1. Baza HM: dla ka¿dego wykonawcy wyœwietl nazwa, œredni¹ cene, oraz sumê cen jego albumów (HM -> tbTowary). 
--		Posortuj wyniki po nazwie wykonawcy, a nastêpnie usuñ z wyniku te zespo³y, dla których œrednia jest mniejsza od 35
-- 2. Baza Sprzeda¿: Wyœwietl nazwê i iloœæ zamówieñ (tab sprzeda¿) dla ka¿dego klienta. Posortuj po iloœci zamówieñ
-- 3. Baza Sprzeda¿: wyœwietl w jednym polu, oddzielone przecinkami, nazwiska pracowników z podzia³em na stanowiska. 



