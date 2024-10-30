
SELECT * FROM BS.dbo.tblKlienci



USE HM
SELECT 
-- TOP 1 -- WITH TIES
-- *, k.*, pf.*
-- FakturaID -- TYLKO je�li w tabelach ta nazwa jest jednoznaczna, lepiej odnie�� si� przez nazw�/alias tabeli, jak ni�ej
pf.FakturaID, SUM(CenaSprz) AS warto��, k.Nazwa AS "Nazwa Klienta"
FROM tbPozycjeFaktur pf
JOIN tbFaktury f 
	ON f.IDFaktury = pf.FakturaID
JOIN tbKlienci k 
	ON f.KlientID = k.IDKlienta 
WHERE pf.FakturaID NOT IN (1,4,8)
	AND k.Nazwa LIKE '%' 
	AND k.miasto IS NOT NULL
GROUP BY k.Nazwa, pf.FakturaID -- czy zadzia�a tak samo, je�li zamieni� na pole f.IDFaktury (pole posiada te same warto�ci)?
HAVING SUM(pf.CenaSprz)  > 33 -- czy mo�na zamieni� SUM(pf.CenaSprz)  na alias warto�� ?
ORDER BY k.Nazwa  -- czy mo�na zamieni� SUM(pf.CenaSprz)  na alias "Nazwa Klienta" ?


USE BS
/* FUNKCJE SKALARNE */
SELECT 
LTRIM(NazwaTowaru), NazwaTowaru, ID_Towar + Kategoria_ID
FROM tblTowary
WHERE LTRIM(NazwaTowaru) like 'Czekolada%'
ORDER BY ID_Towar + Kategoria_ID;

SELECT 
ROUND(15.193, 1) AS zaokr�glenie,  
POWER(3, 2) as pot�ga,  
FLOOR(15.7) AS pod�oga,  
CEILING(15.7) AS sufit;

SELECT 
LEN('Hello World') AS d�ugo��_napisu,
LEFT('Hello World', 5) AS lewa_cz��_napisu,
RIGHT('Hello World', 5) AS prawa_cz��_napisu,
SUBSTRING('Hello World',1, 3) AS wycinek,
REPLACE('Hello World', 'World', 'DB2') AS napis_z_zast�pieniem,
UPPER('Hello World') AS wielkie_litery,
LOWER('Hello World') AS ma�e_litery;

SELECT (Imie + ' ' + Nazwisko) AS pe�ne_imi� FROM tblPracownicy; 

SELECT NazwaFirmy,
		Telefon,
		COALESCE(TelefonKomorkowy, 'brak numeru kom�rkowego') AS TelefonKomorkowy
FROM tblKlienci;

SELECT 
CAST(GETDATE() AS DATE) AS aktualna_data, 
CAST(GETDATE() AS TIME) AS aktualny_czas,
'Data: ' + CAST(GETDATE() AS VARCHAR) AS data_napis,
GETDATE() AS aktualna_data_i_czas,
MONTH(GETDATE()) AS miesi�c, -- to samo z YEAR, DAY
-- datename zawsze zwraca napisy, datepart numery
DATENAME(year, GETDATE()) AS rok,
DATENAME(day, GETDATE()) AS dzien,
DATENAME(weekday, GETDATE()) AS nazwa_dnia,
DATEPART(weekday, GETDATE()) AS numer_dnia_tygodnia,
CAST('2023-03-15' AS DATE) AS zmiana_napisu_na_dat�;

SELECT 
ID_Sprzedaz, 
DATEDIFF(day, DataSprzedazy, GETDATE()) AS roznica_dni,
DATEDIFF(month, DataSprzedazy, GETDATE()) AS r�nica_miesi�cy  
FROM tblSprzedaz;


-- 1. Wy�wietl inicja�y pracownik�w (LEFT, + )
-- 2. Wy�wietl nazw� firmy i napis "Numer Telefonu: [Telefon], Kom�rka [TelefonKomorkowy]". 
-- Je�li brak danych TelefonKomorkowy wy�wietl zamiast tego "brak". Ogranicz wyniki do firm, kt�rych 
--		kod jest 2 znakowy  (+, COALESCE, LEN)
-- 3. Z tabeli z opisem sprzeda�y wy�wietl warto�� sprzeda�y - (cena * ilosc) "zaokr�glone w d�" (FLOOR)
--		do liczb ca�kowitych
-- 4. Sprawd� ile dni up�yn�o od '2020-01-01' (DATEDIFF, nie trzeba u�ywa� FROM)
-- 5. Wy�wietl Wszystkie dane towar�w, ale zamiast numeru z id kategorii wy�wietl id_kat: 3 pierwsze litery nazwy kategorii

/* dodatkowe */
-- 6. wy�wietl id i daty sprzeda�y posortowane po dniu tygodnia tej sprzeda�y (weekday)
--		je�li b�d� takie same dni posortuj po dniu miesi�ca (day)
-- 7. Wy�wietl pracownik�w kt�rzy b�d� obchodzi� rocznic� zatrudnienia w ci�gu najbli�szych 30 dni 
--(musisz zmieni� rok w dacie zatrudnienia, by por�wna� z aktualn� dat�)



SELECT *, DATEDIFF(DAY, GETDATE(), '2024-'+DATENAME(month,DataZatrudnienia)+'-'+DATENAME(day,DataZatrudnienia))
FROM tblPracownicy
WHERE DATEDIFF(DAY, GETDATE(), '2024-'+DATENAME(month,DataZatrudnienia)+'-'+DATENAME(day,DataZatrudnienia))  BETWEEN 0 AND 30



USE HM
-- u�ycie OVER - PARTITION BY - ORDER BY 
SELECT 
	nosnik, 
	MAX(cena) max_cena 
FROM tbTowary
GROUP BY nosnik
ORDER BY nosnik

SELECT  -- DISTINCT    
	nosnik,
	MAX(cena) OVER(PARTITION BY nosnik ORDER BY nosnik) MaxCena 
FROM tbTowary

SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS TotalAmount
FROM dbo.tbPozycjeFaktur
GROUP BY FakturaID;

SELECT DISTINCT -- dane nie s� zagregowane, distict usuwa duplikaty
    FakturaID, --*,   -- dzi�ki OVER, zamiast grupowania mamy dost�p do wszystkich p�l zapytania, a nie tylko tych zagregowanych i zgrupowanych
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS CenaFaktury
FROM dbo.tbPozycjeFaktur;



/* OVER, FUNKCJE RANKINGOWE  baza danych HM */
-- GRUPOWANIE
SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS TotalAmount
FROM tbPozycjeFaktur
GROUP BY FakturaID;
-- Alternatywa z u�yciem OVER
SELECT DISTINCT
    FakturaID, -- *, -- dane si� nie agreguj�, mo�emy wy�wietli� wszystkie kolumny
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS TotalAmount
FROM dbo.tbPozycjeFaktur;



SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(ORDER BY p.CenaSprz) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK()       OVER(ORDER BY p.CenaSprz) AS 'RangaCeny',
    DENSE_RANK() OVER(ORDER BY p.CenaSprz) AS 'G�staRangaCeny',
    NTILE(4)     OVER(ORDER BY p.CenaSprz) AS 'KwartyleCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY 
    p.CenaSprz ;

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
-- 1. U�yj OVER, aby policzy� klient�w z podzia�em na miasta. *** - Zwr�� uwag�, �e w tabeli z klientami mamy dwa sposoby zapisu: "Krak�w" i Krak�w. 
-- Spr�buj wymy�li� jak znormalizowa� te zapisy, aby oba sposoby dla tego samego miasta grupowa�y si� razem (mo�na to zrobi� jedn� funkcj� skalarn�)

SELECT REPLACE(miasto,'"','' ) , COUNT(IDKlienta) OVER (PARTITION BY REPLACE(miasto,'"','' ))
FROM tbKlienci


SELECT miasto , COUNT(IDKlienta) OVER (PARTITION BY miasto)
FROM tbKlienci
-- 2. a. zmie� partycjonowanie poprzedniego zapytania na ID klienta - dodaj do wynik�w nazw� klienta - nale�y do��czy�  INNER JOIN tabel� tbKlienci
-- b. nast�pnie zmie� sortowanie po cenie, na sortowanie po ilo�ci. Zmie� sortowania tak, aby mie� rosn�ce pozycje ranking�w w danej grupie
SELECT 
    f.IDFaktury,
    p.CenaSprz,
	k.nazwa,
	p.ilosc,
    ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'G�staRangaCeny',
    NTILE(4) OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON k.IDKlienta = f.KlientID  
ORDER BY 
    f.KlientID, p.Ilosc DESC;


-- 3. Do zapytania poni�ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u�ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo�u

SELECT wykonawca, tytul, cena,
DENSE_RANK() OVER (ORDER BY cena),
RANK() OVER (ORDER BY cena)
FROM tbTowary


SELECT wykonawca, tytul, cena,
DENSE_RANK() OVER (PARTITION BY wykonawca ORDER BY cena),
RANK() OVER (PARTITION BY wykonawca ORDER BY cena)
FROM tbTowary

---


/*FETCH OFFSET*/
-- Wybieranie z wyniku wierszy 6-15 
USE BS
SELECT *
FROM tblPracownicy
ORDER BY Nazwisko
OFFSET 5 ROWS        -- Pomi� pierwsze 5 wierszy
FETCH NEXT 10 ROWS ONLY; -- Nast�pnie pobierz 10 wierszy


/*CASE - wy�wietl wed�ug warunk�w*/

SELECT  ID_OpisSprzedazy, 
	Towar_ID, 
	CASE
		WHEN Ilosc <= 5 THEN 'Pojedyncza'
		WHEN Ilosc <= 15 THEN 'Detaliczna'
		ELSE 'Hurtowa'
	END AS typSprzedazy
FROM tblOpisSprzedazy


/*�wiczenia*/

-- 1. Wybierz z tabeli tblSprzedaz id klienta, rok sprzeda�y, miesi�c sprzeda�y, oraz dodatkowe pole kt�re zawiera:
 -- Je�li rok sprzedarzy to 2017 wypisz 'Faktura tegoroczna',
 -- Je�li rok sprzeda�y to 2016, to 'Faktura zesz�oroczna',
 -- W innym przypadku 'Starsza'
-- 2. Wyniki posortuj po latach i miesi�cach, nast�pnie wy�wietl  od wiersza 33 do 44

SELECT 
    Klient_ID,
    YEAR(DataSprzedazy) AS RokSprzedazy,
    MONTH(DataSprzedazy) AS MiesiacSprzedazy,
    CASE 
        WHEN YEAR(DataSprzedazy) = 2017 THEN 'Faktura tegoroczna'
        WHEN YEAR(DataSprzedazy) = 2016 THEN 'Faktura zesz�oroczna'
        ELSE 'Starsza'
    END AS StatusFaktury
FROM tblSprzedaz
ORDER BY RokSprzedazy, MiesiacSprzedazy
OFFSET 32 ROWS        -- Pomi� pierwsze 5 wierszy
FETCH NEXT 12 ROWS ONLY; 

 /*�wiczenia dodatkowe */
-- 1. wy�wietl pierwsze 3 litery nazwy i ceny towar�w posortowane po cenie malej�co. W wyniku pomi� pierwsze 3 wiersze i poka� kolejne 7 (trzeba u�y� JOIN)
-- 2. Z tabeli pracownik�w wybierz wszystkie imiona i nazwiska. Je�li nazwa stanowiska zawiera w sobie s�owo "handlowy" 
-- przy nazwisku wy�wietl napis 'Handlowiec', w innym przypadku wy�wietl napis 'Inne stanowisko'