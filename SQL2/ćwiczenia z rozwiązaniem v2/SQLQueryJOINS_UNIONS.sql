
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
LEFT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;
-- TODO dodajmy warunek key IS NULL

-- RIGHT JOIN: wiersze z prawej tabeli i dopasowane z lewej
SELECT *
FROM dbo.tblPracownicy AS p
RIGHT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;

-- FULL JOIN (FULL OUTER JOIN): wiersze z lewej i prawej tabeli
SELECT p.*, s.DataSprzedazy
FROM dbo.tblPracownicy AS p
FULL JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;



SELECT k.*, sp.DataSprzedazy
/*
	 sp.ID_Sprzedaz, 
	sp.DataSprzedazy,   
	o_sp.Ilosc,
	o_sp.Towar_ID,
	k.NazwaFirmy,
	p.Nazwisko
*/
FROM tblSprzedaz sp -- wiele JOIN -- Czy s¹ jakieœ zasady co do kolejnoœci ?
JOIN tblOpisSprzedazy o_sp ON sp.ID_Sprzedaz = o_sp.Sprzedaz_ID
JOIN tblKlienci k ON k.ID_Klient = sp.Klient_ID
JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID



/* UNIONS */

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
SELECT nazwa FROM hm.dbo.tbKlienci
	UNION
SELECT NazwaFirmy FROM bs.dbo.tblKlienci




