
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
LEFT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;
-- TODO dodajmy warunek key IS NULL

-- RIGHT JOIN: wiersze z prawej tabeli i dopasowane z lewej
SELECT *
FROM dbo.tblPracownicy AS p
RIGHT JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;

-- TODO - co gdy zmienimy kolejno�� tabel?


-- FULL JOIN (FULL OUTER JOIN): wiersze z lewej i prawej tabeli
SELECT p.*, s.DataSprzedazy
FROM dbo.tblPracownicy AS p
FULL JOIN dbo.tblSprzedaz AS s ON p.IDPracownika = s.Pracownik_ID;



SELECT * 
/*
	 sp.ID_Sprzedaz, 
	sp.DataSprzedazy,   
	o_sp.Ilosc,
	o_sp.Towar_ID,
	k.NazwaFirmy,
	p.Nazwisko
*/
FROM tblSprzedaz sp -- wiele JOIN -- Czy s� jakie� zasady co do kolejno�ci ?
JOIN tblOpisSprzedazy o_sp ON sp.ID_Sprzedaz = o_sp.Sprzedaz_ID
JOIN tblKlienci k ON k.ID_Klient = sp.Klient_ID
JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID
-- TODO dodajmy pozosta�e tabele


/* �wiczenia */
-- 1. Wyci�gnij imiona i nazwiska WSZYSTKICH pracownik�w, oraz id i dat� sprzedarzy, je�li brali w niej udzia�
-- 2. Wy�wietl opisy sprzeda�y (ca�e dane) wraz z nazwami sprzedanych produkt�w
-- 3. do punktu 2. dodaj nazwy kategorii produkt�w, wyniki ogranicz do towar�w z kategorii 2,3,4.
-- wyci�gnij dane wszystkich pracownik�w, kt�rzy nie brali udzia�u w �adnej sprzedarzy
--		(w warunku b�dzie potrzebne id sprzeda�y o warto�ci NULL)


/* UNIONS */
SELECT UPPER(Miasto)
FROM tblPracownicy
 -- UNION 
 -- UNION ALL (dane si� duplikuj�, je�li wyst�puj� w obu wynikach)
 -- INTERSECT 
 -- EXCEPT 
SELECT UPPER(Miasto)
FROM tblKlienci;

-- Co gdy u�yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*�wiczenie*/
-- 1. W tabeli klient�w mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s� postaci xxxxx.
	-- a. u�ywaj�c funkcji wbudowanych zmi� format kod�w w tabeli z klientami do formatu xxxxx 
	-- (u�yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klient�w, oraz kodach pracownik�w


/* FUNKCJE RANKINGOWE  baza danych HM */
USE HM
GO
/* Praca na obu bazach przez podanie pe�nej lokalizacji tabel -> nazwa_bazy.schemat.nazwa_tabeli */
SELECT nazwa FROM hm.dbo.tbKlienci
	UNION
SELECT NazwaFirmy FROM BS.dbo.tblKlienci


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
-- 1. zmie� partycjonowanie wynik�w na ID klienta - dodaj do wynik�w nazw� klienta - nale�y do��czy� tabel�
-- 2. zmie� sortowanie w partycjach na Ilo�� na fakturze, zamiast ceny
-- 3. Do zapytania poni�ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u�ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo�u oraz rownum
	-- c. Usu� partycjonowanie, dodaj kwartyl bez partycjonowania


