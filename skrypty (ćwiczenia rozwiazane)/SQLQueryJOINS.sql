
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

-- TODO - co gdy zmienimy kolejnoœæ tabel?


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
FROM tblSprzedaz sp -- wiele JOIN -- Czy s¹ jakieœ zasady co do kolejnoœci ?
JOIN tblOpisSprzedazy o_sp ON sp.ID_Sprzedaz = o_sp.Sprzedaz_ID
JOIN tblKlienci k ON k.ID_Klient = sp.Klient_ID
JOIN tblPracownicy p ON p.IDPracownika = sp.Pracownik_ID
-- TODO dodajmy pozosta³e tabele


/* æwiczenia */
-- 1. Wyci¹gnij imiona i nazwiska WSZYSTKICH pracowników, oraz id i datê sprzedarzy, jeœli brali w niej udzia³
-- 2. Wyœwietl opisy sprzeda¿y (ca³e dane) wraz z nazwami sprzedanych produktów
-- 3. do punktu 2. dodaj nazwy kategorii produktów, wyniki ogranicz do towarów z kategorii 2,3,4.
-- wyci¹gnij dane wszystkich pracowników, którzy nie brali udzia³u w ¿adnej sprzedarzy
--		(w warunku bêdzie potrzebne id sprzeda¿y o wartoœci NULL)
-- 1. Imiona i nazwiska WSZYSTKICH pracowników oraz id i datê sprzeda¿y, jeœli brali w niej udzia³
SELECT p.Imie, p.Nazwisko, s.ID_Sprzedaz, s.DataSprzedazy
FROM tblPracownicy p
LEFT JOIN tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID;

-- 2. Opisy sprzeda¿y (ca³e dane) wraz z nazwami sprzedanych produktów
SELECT os.*, t.NazwaTowaru
FROM tblOpisSprzedazy os
JOIN tblTowary t ON os.Towar_ID = t.ID_Towar;

-- 3. Opisy sprzeda¿y z nazwami produktów i ich kategorii, ograniczone do kategorii 2, 3, 4
SELECT os.*, t.NazwaTowaru, k.NazwaKategorii
FROM tblOpisSprzedazy os
JOIN tblTowary t ON os.Towar_ID = t.ID_Towar
JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
WHERE t.Kategoria_ID IN (2, 3, 4);

-- 4. Dane wszystkich pracowników, którzy nie brali udzia³u w ¿adnej sprzeda¿y
SELECT *
FROM tblPracownicy p
LEFT JOIN tblSprzedaz s ON s.Pracownik_ID = p.IDPracownika
WHERE s.ID_Sprzedaz IS NULL



/* UNIONS */
SELECT UPPER(Miasto)
FROM tblPracownicy
 -- UNION 
 -- UNION ALL (dane siê duplikuj¹, jeœli wystêpuj¹ w obu wynikach)
 -- INTERSECT 
 -- EXCEPT 
SELECT UPPER(Miasto)
FROM tblKlienci;

-- Co gdy u¿yjemy union/ union all, a w obu zapytaniach wstawimy DISTINCT

/*æwiczenie*/
-- 1. W tabeli klientów mamy kody pocztowe w formacie xx-xxx, w tabeli z pracownikami kody s¹ postaci xxxxx.
	-- a. u¿ywaj¹c funkcji wbudowanych zmiñ format kodów w tabeli z klientami do formatu xxxxx 
	-- (u¿yj funkcji left i right - parametry: napis, znak_od, znak_do)
	-- b. wykonaj union oraz union all na sformatowanych kodach klientów, oraz kodach pracowników
-- 1a. Zmiana formatu kodów pocztowych klientów na xxxxx
-- 1b. Wykonanie UNION oraz UNION ALL na sformatowanych kodach klientów oraz kodach pracowników
SELECT REPLACE(Kod, '-', '') AS SformatowanyKod
FROM tblKlienci
UNION -- UNION ALL
SELECT KodPocztowy
FROM tblPracownicy;

/* FUNKCJE RANKINGOWE  baza danych HM */
USE BS
GO
USE HM
GO


SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'GêstaRangaCeny',
    NTILE(4) OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY f.IDFaktury, p.CenaSprz DESC;

/* æwiczenia */
-- 1. zmieñ partycjonowanie wyników na ID klienta - dodaj do wyników nazwê klienta - nale¿y do³¹czyæ tabelê
-- 2. zmieñ sortowanie w partycjach na Iloœæ na fakturze, zamiast ceny
-- 3. Do zapytania poni¿ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u¿ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo³u oraz rownum
	-- c. Usuñ partycjonowanie, dodaj kwartyl bez partycjonowania

-- 1. Zmiana partycjonowania wyników na ID klienta z dodaniem nazwy klienta
SELECT f.IDFaktury, k.Nazwa, p.CenaSprz,
       ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.CenaSprz DESC) AS NumerPozycji
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON f.KlientID = k.IDKlienta;

-- 2. Zmiana sortowania w partycjach na Iloœæ na fakturze
SELECT f.IDFaktury, k.Nazwa, p.Ilosc,
       ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.Ilosc DESC) AS NumerPozycji
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON f.KlientID = k.IDKlienta;

-- 3a. Dodanie DENSE_RANK i RANK bez partycjonowania
SELECT f.IDFaktury, p.CenaSprz,
       DENSE_RANK() OVER(ORDER BY p.CenaSprz DESC) AS GestoscRangi,
       RANK() OVER(ORDER BY p.CenaSprz DESC) AS RangaCeny
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID;

-- 3b. Dodanie partycjonowania po nazwie zespo³u oraz ROW_NUMBER
-- Zak³adaj¹c, ¿e istnieje tabela zespo³ów (tbZespoly) i jest powi¹zana z tbPozycjeFaktur
SELECT t.wykonawca, p.CenaSprz,
       ROW_NUMBER() OVER(PARTITION BY t.wykonawca ORDER BY p.CenaSprz DESC) AS NumerPozycji
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbTowary t ON t.IDTowaru = p.TowarID

-- 3c. Usuniêcie partycjonowania, dodanie kwartylu bez partycjonowania
SELECT f.IDFaktury, p.CenaSprz,
       NTILE(4) OVER(ORDER BY p.CenaSprz DESC) AS KwartylCeny
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID;

