
USE BS
GO


/* z��czenie poziome - JOIN*/

SELECT * FROM tblPracownicy; -- id 2 - nie przypisany do sprzeda�y
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

-- Kolejno�� ��czenia ma znaczenie gdy pojawiaj� si� ��czenia inne ni� INNER JOIN


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
	 -- UNION ALL  --(dane si� duplikuj�, je�li wyst�puj� w obu wynikach)
	 INTERSECT 
	  -- EXCEPT 
SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblKlienci


SELECT * FROM
	(SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblPracownicy
	 --UNION 
	 -- UNION ALL  --(dane si� duplikuj�, je�li wyst�puj� w obu wynikach)
	 INTERSECT 
	  -- EXCEPT 
	SELECT DISTINCT UPPER(Miasto) miasto
	FROM tblKlienci) qu
ORDER BY miasto



-- Agregacja wynik�w 10 najta�szych towar�w sprzeda�y

-- ZWR��MY UWAG� na Funkcje  2x CAST, 2x nvarchar !!! - poni�ej analiza tego, co dzieje si� z typami w union
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

-- Tworzenie tabeli tymczasowej na potrzeby zapisu wynik�w
SELECT STRING_AGG(CAST(Sprzedaz_ID AS varchar), ', ') AS ID_Sprzedazy_Agg, 
       ROUND(SUM(s.WartoscSprzedazy), 2) AS WartoscSprzedazy -- WartoscSprzedazy	6	float	15	8
INTO TymczasowaTabela
FROM (
    -- Pierwsza cz�� zapytania UNION z ograniczeniem OFFSET...FETCH NEXT
    SELECT Sprzedaz_ID, CenaSprzedazy * Ilosc AS WartoscSprzedazy
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    ORDER BY WartoscSprzedazy
    OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY
) AS s

UNION 

-- Druga cz�� zapytania UNION z ograniczeniem OFFSET
SELECT CAST(Sprzedaz_ID AS nvarchar) AS ID_Sprzedazy_Agg, 
       CenaSprzedazy * Ilosc AS WartoscSprzedazy
FROM tblSprzedaz sp
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = sp.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 10 ROWS;

-- Wy�wietlenie wynik�w tabeli tymczasowej dla sprawdzenia typ�w danych
EXEC sp_columns TymczasowaTabela;


SELECT STRING_AGG(CAST(Sprzedaz_ID AS varchar), ', ') AS ID_Sprzedazy_Agg,  -- WartoscSprzedazy	6	float	15	8
       ROUND(SUM(s.WartoscSprzedazy), 2) AS WartoscSprzedazy
INTO TymczasowaTabela2
FROM (
    -- Pierwsza cz�� zapytania UNION z ograniczeniem OFFSET...FETCH NEXT
    SELECT Sprzedaz_ID, CenaSprzedazy * Ilosc AS WartoscSprzedazy
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    ORDER BY WartoscSprzedazy
    OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY
) AS s



-- Wy�wietlenie wynik�w tabeli tymczasowej dla sprawdzenia typ�w danych
EXEC sp_columns TymczasowaTabela2;



-- Tworzenie tabeli tymczasowej na podstawie drugiej cz�ci zapytania
SELECT 
    CAST(Sprzedaz_ID AS nvarchar) AS ID_Sprzedazy_Agg,  --WartoscSprzedazy	7	real	7	4
    CenaSprzedazy * Ilosc AS WartoscSprzedazy
INTO TymczasowaTabela3
FROM tblSprzedaz sp
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = sp.ID_Sprzedaz
ORDER BY WartoscSprzedazy
OFFSET 10 ROWS;

-- Wy�wietlenie struktury tabeli tymczasowej, aby sprawdzi� typy kolumn
EXEC sp_columns TymczasowaTabela3;

-- Wycofanie transakcji, je�li nie chcesz zapisa� zmian

-- Opcjonalnie: ROLLBACK TRANSACTION, aby wycofa� zmiany
ROLLBACK TRANSACTION;

-- Je�eli chcesz zatwierdzi� transakcj�, zamie� ROLLBACK TRANSACTION na:
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

-- Co gdy u�yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*�wiczenie*/
-- 1. W tabeli klient�w mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s� postaci xxxxx.
	-- a. u�ywaj�c funkcji wbudowanych zmi� format kod�w w tabeli z klientami do formatu xxxxx 
	-- (u�yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klient�w, oraz kodach pracownik�w

USE BS
SELECT DISTINCT REPLACE(kod, '-', '') FROM tblKlienci

SELECT DISTINCT KodPocztowy FROM tblPracownicy


/* Praca na obu bazach przez podanie pe�nej lokalizacji tabel -> nazwa_bazy.schemat.nazwa_tabeli */
SELECT DataSprzed FROM hm.dbo.tbFaktury
	UNION
SELECT DataSprzedazy FROM bs.dbo.tblSprzedaz



-- 2 Wy�wietl wszystkie dane, kt�re s� wsp�lne dla klient�w z obu baz. Dadaj dodatkow� kolumn� z informacj� z kt�rej bazy ('BS', 'HM') pochodzi klient .
-- Posortuj po nazwie bazy oraz nazwie klienta
-- *** 2b. Uwzgl�dnij tylko tych klient�w dla kt�rych by�a jakakolwiek faktura/brali udzia� w sprze�y.