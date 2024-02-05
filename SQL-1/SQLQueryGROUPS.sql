
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
--HAVING SUM(CenaSprz)  > 200
ORDER BY SUM(CenaSprz) DESC

USE BS
GO
SELECT k.NazwaKategorii + ': ' + STRING_AGG(t.NazwaTowaru, ', ') + '.'
FROM tblTowary t
JOIN tblKategorie k ON k.ID_Kategoria = t.Kategoria_ID
WHERE k.NazwaKategorii != 'owoce'
GROUP BY NazwaKategorii, Kategoria_ID -- Czy oba te pola s� potrzebne?

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

/* �wiczenia */
-- 1. Baza HM: dla ka�dego wykonawcy wy�wietl nazwa, �redni� cene, oraz sum� cen jego album�w (HM -> tbTowary). 
--		Posortuj wyniki po nazwie wykonawcy, a nast�pnie usu� z wyniku te zespo�y, dla kt�rych �rednia jest mniejsza od 35
-- 2. Baza Sprzeda�: Wy�wietl nazw� i ilo�� zam�wie� (tab sprzeda�) dla ka�dego klienta. Posortuj po ilo�ci zam�wie�
-- 3. Baza Sprzeda�: wy�wietl w jednym polu, oddzielone przecinkami, nazwiska pracownik�w z podzia�em na stanowiska. 



