
USE BS
GO


/* z³¹czenie poziome - JOIN*/

SELECT * FROM tblPracownicy; -- id 2 - nie przypisany do sprzeda¿y
SELECT * FROM tblSprzedaz; -- id 6, 11, 20, 39, 141 - brak przypisanego pracownika

-- INNER JOIN: co najmniej jeden dopasowany rekord w obu tabelach
SELECT  *-- p.*, s.*, s.ID_Sprzedaz, p.IDPracownika
FROM dbo.tblPracownicy AS p
INNER JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;
-- TODO Dodajmy WHERE

-- LEFT JOIN: wiersze z lewej tabeli i dopasowane z prawej
SELECT *
FROM dbo.tblPracownicy AS p
LEFT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID
-- WHERE s.ID_Sprzedaz IS NULL

-- RIGHT JOIN: wiersze z prawej tabeli i dopasowane z lewej
SELECT *
FROM dbo.tblPracownicy AS p
RIGHT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID
-- WHERE p.IDPracownika  IS NULL

-- FULL JOIN (FULL OUTER JOIN): wiersze z lewej i prawej tabeli
SELECT p.*, s.DataSprzedazy
FROM dbo.tblPracownicy AS p
FULL JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID
WHERE s.ID_Sprzedaz IS NULL OR p.IDPracownika  IS NULL

-- Kolejnoœæ ³¹czenia ma znaczenie gdy pojawiaj¹ siê ³¹czenia inne ni¿ INNER JOIN


USE BS
SELECT sp.ID_Sprzedaz, p.IDPracownika, d.ID_Dzial
FROM tblSprzedaz sp 
LEFT JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID
LEFT JOIN tblDzialy d ON d.ID_Dzial = p.Dzial_ID


SELECT sp.ID_Sprzedaz, p.IDPracownika, d.ID_Dzial
FROM  tblPracownicy p  
LEFT JOIN tblDzialy d ON d.ID_Dzial = p.Dzial_ID
LEFT JOIN tblSprzedaz sp ON p.IDPracownika = sp.Pracownik_ID

/* SELF JOIN */
SELECT p1_przelozony.Imie, p1_przelozony.Nazwisko, p1_przelozony.Stanowisko,  
	   p2_podwladni.Imie, p2_podwladni.Nazwisko, p2_podwladni.Stanowisko
FROM tblPracownicy p1_przelozony
LEFT JOIN tblPracownicy p2_podwladni 
	ON p1_przelozony.IDPracownika = p2_podwladni.Przelozony_ID
	order by p1_przelozony.Dzial_ID



/* UNIONS */

SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblPracownicy
	 --UNION 
	 -- UNION ALL  --(dane siê duplikuj¹, jeœli wystêpuj¹ w obu wynikach)
	 INTERSECT 
	  -- EXCEPT 
SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblKlienci


SELECT * FROM
	(SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblPracownicy
	 --UNION 
	 -- UNION ALL  --(dane siê duplikuj¹, jeœli wystêpuj¹ w obu wynikach)
	 INTERSECT 
	  -- EXCEPT 
	SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblKlienci) qu
ORDER BY miasto



-- Agregacja wyników 10 najtañszych towarów sprzeda¿y

-- ZWRÓÆMY UWAGÊ na Funkcje  2x CAST, 2x nvarchar !!! - poni¿ej analiza tego, co dzieje siê z typami w union
SELECT STRING_AGG(CAST(Sprzedaz_ID AS varchar), ', '),CAST(ROUND(SUM(s.WartoscSprzedazy),2) AS real) WartoscSprzedazy
FROM (
SELECT Sprzedaz_ID, CenaSprzedazy * Ilosc WartoscSprzedazy
FROM tblSprzedaz s
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 0 ROWS  
FETCH NEXT 10 ROWS ONLY
) AS s
UNION 
SELECT CAST(Sprzedaz_ID AS nvarchar), ((CenaSprzedazy * Ilosc ) ) WartoscSprzedazy
FROM tblSprzedaz s
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 10 ROWS  



BEGIN TRANSACTION

-- Tworzenie tabeli tymczasowej na potrzeby zapisu wyników
SELECT STRING_AGG(CAST(Sprzedaz_ID AS varchar), ', ') AS ID_Sprzedazy_Agg, 
       ROUND(SUM(s.WartoscSprzedazy), 2) AS WartoscSprzedazy -- WartoscSprzedazy	6	float	15	8
INTO TymczasowaTabela
FROM (
    -- Pierwsza czêœæ zapytania UNION z ograniczeniem OFFSET...FETCH NEXT
    SELECT Sprzedaz_ID, CenaSprzedazy * Ilosc AS WartoscSprzedazy
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    ORDER BY WartoscSprzedazy
    OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY
) AS s

UNION 

-- Druga czêœæ zapytania UNION z ograniczeniem OFFSET
SELECT CAST(Sprzedaz_ID AS nvarchar) AS ID_Sprzedazy_Agg, 
       CenaSprzedazy * Ilosc AS WartoscSprzedazy
FROM tblSprzedaz sp
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = sp.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 10 ROWS;

-- Wyœwietlenie wyników tabeli tymczasowej dla sprawdzenia typów danych
EXEC sp_columns TymczasowaTabela;


SELECT STRING_AGG(CAST(Sprzedaz_ID AS varchar), ', ') AS ID_Sprzedazy_Agg,  -- WartoscSprzedazy	6	float	15	8
       ROUND(SUM(s.WartoscSprzedazy), 2) AS WartoscSprzedazy
INTO TymczasowaTabela2
FROM (
    -- Pierwsza czêœæ zapytania UNION z ograniczeniem OFFSET...FETCH NEXT
    SELECT Sprzedaz_ID, CenaSprzedazy * Ilosc AS WartoscSprzedazy
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    ORDER BY WartoscSprzedazy
    OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY
) AS s



-- Wyœwietlenie wyników tabeli tymczasowej dla sprawdzenia typów danych
EXEC sp_columns TymczasowaTabela2;



-- Tworzenie tabeli tymczasowej na podstawie drugiej czêœci zapytania
SELECT 
    CAST(Sprzedaz_ID AS nvarchar) AS ID_Sprzedazy_Agg,  --WartoscSprzedazy	7	real	7	4
    CenaSprzedazy * Ilosc AS WartoscSprzedazy
INTO TymczasowaTabela3
FROM tblSprzedaz sp
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = sp.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 10 ROWS;

-- Wyœwietlenie struktury tabeli tymczasowej, aby sprawdziæ typy kolumn
EXEC sp_columns TymczasowaTabela3;

-- Wycofanie transakcji, jeœli nie chcesz zapisaæ zmian

-- Opcjonalnie: ROLLBACK TRANSACTION, aby wycofaæ zmiany
ROLLBACK TRANSACTION;

-- Je¿eli chcesz zatwierdziæ transakcjê, zamieñ ROLLBACK TRANSACTION na:
-- COMMIT TRANSACTION;




/** ORDER BY
USE HM
(SELECT TOP 1 WITH TIES * 
FROM tbFaktury
ORDER BY DataSprzed)
UNION
(SELECT TOP 1 WITH TIES * FROM tbFaktury
ORDER BY DataSprzed DESC)
*/

-- Co gdy u¿yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*æwiczenie*/
-- 1. W tabeli klientów mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s¹ postaci xxxxx.
	-- a. u¿ywaj¹c funkcji wbudowanych zmiñ format kodów w tabeli z klientami do formatu xxxxx 
	-- (u¿yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klientów, oraz kodach pracowników

USE BS
SELECT DISTINCT REPLACE(kod, '-', '') FROM tblKlienci

SELECT DISTINCT KodPocztowy FROM tblPracownicy


/* Praca na obu bazach przez podanie pe³nej lokalizacji tabel -> nazwa_bazy.schemat.nazwa_tabeli */
SELECT DataSprzed FROM hm.dbo.tbFaktury
	UNION
SELECT DataSprzedazy FROM bs.dbo.tblSprzedaz



-- 2 Wyœwietl wszystkie dane, które s¹ wspólne dla klientów z obu baz. Dadaj dodatkow¹ kolumnê z informacj¹ z której bazy ('BS', 'HM') pochodzi klient .
-- Posortuj po nazwie bazy oraz nazwie klienta
-- *** 2b. Uwzglêdnij tylko tych klientów dla których by³a jakakolwiek faktura/brali udzia³ w sprze¿y.