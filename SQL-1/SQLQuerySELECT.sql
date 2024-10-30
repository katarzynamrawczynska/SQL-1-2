
USE BS
GO
/* SELECT - PODSTAWY */

-- nie nadu¿ywaj gwazdki, bo poczekasz d³u¿ej
SELECT TOP 3 *
FROM tblKategorie
ORDER BY NazwaKategorii; -- DESC 

SELECT ID_Kategoria AS identyfikator, -- AS nie jest konieczne
	NazwaKategorii AS "nazwa kategorii"
FROM tblKategorie;

SELECT * FROM tblPracownicy
ORDER BY Miasto DESC, Nazwisko ASC; -- asc nie jest konieczne

SELECT DISTINCT TOP 4 Stanowisko innanazwa
FROM tblPracownicy;



/*æwiczenia*/

-- 1. Wyœwietl kody klientów i ich nazwy posortowane malej¹co po kodzie. Nastêpnie ogranicz wyœwietlenie do pierwszych 5 klientów,
--		i nadaj kolumnom aliasy "KOD KLIENTA" i "NAZWA"
-- 2. Wyœwietl nazwy miast w których znajduj¹ siê siedziby klientów (bez duplikatów)
-- 3. Wyœwietl wszystkie dane z tabeli tblOpisSprzedazy posortowane po iloœci oraz cenie sprzeda¿y (oba rozn¹co).


/*WARUNEK WHERE*/

SELECT * FROM tblKlienci
WHERE TelefonKomorkowy IS NULL AND Miasto = 'Warszawa';


SELECT NazwaTowaru, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE 
	Cena_Katalogowa >= 6 AND Cena_Katalogowa <= 10 -- TODO u¿yjmy BETWEEN
	-- OR Kategoria_ID != 6 

SELECT NazwaTowaru, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE 
	Cena_Katalogowa < 6 AND Cena_Katalogowa > 10 -- TODO u¿yjmy NOT BETWEEN



SELECT NazwaTowaru AS Towar, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE Kategoria_ID = 1 OR 
	Kategoria_ID = 3 AND 
	Cena_Katalogowa > 6 -- TODO zmieñmy nawiasowanie
ORDER BY Cena_Katalogowa;

-- TODO zmieñmy na wersjê z operatorem IN (kategorie)
--


SELECT Imie, Nazwisko, Miasto
FROM tblPracownicy
WHERE Nazwisko like 'k%'

SELECT Imie, Nazwisko, Miasto
FROM tblPracownicy
WHERE Nazwisko like '_o%' -- % dowolny ciag, _ dowolny jeden znak

SELECT Imie, Nazwisko, Miasto
FROM tblPracownicy
WHERE Nazwisko like '[a-k]%' OR Nazwisko LIKE '%S%'
ORDER BY Nazwisko


/* æwieczenia */
-- 1.Znajdz w pracownika ktory pracuje na stanowisku Przedstawiciel handlowy
-- 2. wyswietl kod klienta, nazwê firmy, ulice oraz miasto z tabeli klineci. Wybierz tych,
--		ktorzy mieszkaja w miescie na W i kod klienta jest dwuznakowy
--		posortuj wg kodu malejaco
-- 3. Wybierz klientów, których telefon nie ma "2" jako drug¹ cyfrê, oraz nazwa firmy zawiera literê "a"
-- 4. Z tabeli pracowników wybierz wszystkie imiona i nazwiska osób których id mieœci siê miêdzy 5 a 12 
--		lub nazwa ich stanowiska zawiera w sobie s³owo "handlowy" 
-- 5. Wybierz z tabeli pracownicy osoby o inicja³ach M.S. i J.M.





/* FUNKCJE SKALARNE */
SELECT 
LTRIM(NazwaTowaru), ID_Towar + Kategoria_ID
FROM tblTowary
WHERE LTRIM(NazwaTowaru) like 'Czekolada%'
ORDER BY ID_Towar + Kategoria_ID;

SELECT 
ROUND(15.193, 1) AS zaokr¹glenie,  
POWER(3, 2) as potêga,  
FLOOR(15.7) AS pod³oga,  
CEILING(15.7) AS sufit;

SELECT 
LEN('Hello World') AS d³ugoœæ_napisu,
LEFT('Hello World', 5) AS lewa_czêœæ_napisu,
RIGHT('Hello World', 5) AS prawa_czêœæ_napisu,
SUBSTRING('Hello World',1, 3) AS wycinek,
REPLACE('Hello World', 'World', 'DB2') AS napis_z_zast¹pieniem,
UPPER('Hello World') AS wielkie_litery,
LOWER('Hello World') AS ma³e_litery;

SELECT (Imie + ' ' + Nazwisko) AS pe³ne_imiê FROM tblPracownicy; 

SELECT NazwaFirmy,
		Telefon,
		COALESCE(TelefonKomorkowy, 'brak numeru komórkowego') AS TelefonKomorkowy
FROM tblKlienci;

SELECT 
CAST(GETDATE() AS DATE) AS aktualna_data, 
CAST(GETDATE() AS TIME) AS aktualny_czas,
'Data: ' + CAST(GETDATE() AS VARCHAR) AS data_napis,
GETDATE() AS aktualna_data_i_czas,
MONTH(GETDATE()) AS miesi¹c, -- to samo z YEAR, DAY
DATENAME(year, GETDATE()) AS rok,
DATENAME(day, GETDATE()) AS dzien,
DATENAME(weekday, GETDATE()) AS nazwa_dnia,
DATEPART(weekday, GETDATE()) AS numer_dnia_tygodnia,
CAST('2023-03-15' AS DATE) AS zmiana_napisu_na_datê;

SELECT 
ID_Sprzedaz, 
DATEDIFF(day, DataSprzedazy, GETDATE()) AS roznica_dni,
DATEDIFF(month, DataSprzedazy, GETDATE()) AS ró¿nica_miesiêcy  
FROM tblSprzedaz;


-- 1. Wyœwietl inicja³y pracowników (LEFT, + )
-- 2. Wyœwietl nazwê firmy i napis "Numer Telefonu: [Telefon], Komórka [TelefonKomorkowy]". 
-- Jeœli brak danych TelefonKomorkowy wyœwietl zamiast tego "brak". Ogranicz wyniki do firm, których 
--		kod jest 2 znakowy  (+, COALESCE, LEN)
-- 3. Z tabeli z opisem sprzeda¿y wyœwietl wartoœæ sprzeda¿y - (cena * ilosc) "zaokr¹glone w dó³" (FLOOR)
--		do liczb ca³kowitych
-- 4. SprawdŸ ile dni up³ynê³o od '2020-01-01' (DATEDIFF, nie trzeba u¿ywaæ FROM)


