
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
-- HAVING -- filtrowanie zagregowanych danych
ORDER BY  p.FakturaID, p.TowarID;

SELECT pf.FakturaID, SUM(CenaSprz) AS wartosc
FROM tbPozycjeFaktur pf
JOIN tbFaktury f ON f.IDFaktury = pf.FakturaID
--where
GROUP BY pf.FakturaID  -- f.IDFaktury 
--HAVING SUM(CenaSprz)  > 200
ORDER BY wartosc DESC

/* æwiczenia */
-- 1. Baza HM: dla ka¿dego wykonawcy wyœwietl nazwa, œredni¹ cene, oraz sumê cen jego albumów (HM -> tbTowary). 
--		Posortuj wyniki po nazwie wykonawcy, a nastêpnie usuñ z wyniku te zespo³y, dla których œrednia jest mniejsza od 35
SELECT 
    wykonawca, 
    AVG(cena) AS SredniaCena, 
    SUM(cena) AS SumaCen
FROM tbTowary
GROUP BY wykonawca
HAVING AVG(cena) >= 35
ORDER BY wykonawca;


-- 2. Baza Sprzeda¿: Wyœwietl nazwê i iloœæ zamówieñ (tab sprzeda¿) dla ka¿dego klienta. Posortuj po iloœci zamówieñ
USE BS
SELECT 
    K.NazwaFirmy, 
    COUNT(S.ID_Sprzedaz) AS IloscZamowien
FROM tblSprzedaz S
JOIN tblKlienci K ON S.Klient_ID = K.ID_Klient
GROUP BY K.NazwaFirmy
ORDER BY IloscZamowien DESC;

-- 3. Baza Sprzeda¿: wyœwietl w jednym polu, oddzielone przecinkami, nazwiska pracowników z podzia³em na stanowiska. 
SELECT 
    Stanowisko, 
    STRING_AGG(Nazwisko, ', ') AS Pracownicy
FROM tblPracownicy
GROUP BY Stanowisko;


