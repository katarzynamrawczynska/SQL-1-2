
USE BS
GO
/* SELECT - PODSTAWY */

-- nie nadu�ywaj gwazdki, bo poczekasz d�u�ej
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



/*�wiczenia*/
-- 1. Kody klient�w i ich nazwy, posortowane malej�co po kodzie, ograniczone do pierwszych 5
SELECT TOP 5 KodKlienta AS [KOD KLIENTA], NazwaFirmy AS [NAZWA]
FROM tblKlienci
ORDER BY KodKlienta DESC;

-- 2. Nazwy miast z siedzibami klient�w (bez duplikat�w)
SELECT DISTINCT Miasto
FROM tblKlienci;

-- 3. Wszystkie dane z tblOpisSprzedazy, posortowane po ilo�ci oraz cenie sprzeda�y rosn�co
SELECT *
FROM tblOpisSprzedazy
ORDER BY Ilosc ASC, CenaSprzedazy ASC;


/*WARUNEK WHERE*/

SELECT * FROM tblKlienci
WHERE TelefonKomorkowy IS NULL AND Miasto = 'Warszawa';


SELECT NazwaTowaru, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE 
	Cena_Katalogowa >= 6 AND Cena_Katalogowa <= 10 -- TODO u�yjmy BETWEEN
	-- OR Kategoria_ID != 6 

SELECT NazwaTowaru, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE 
	Cena_Katalogowa < 6 AND Cena_Katalogowa > 10 -- TODO u�yjmy NOT BETWEEN



SELECT NazwaTowaru AS Towar, Kategoria_ID , Cena_Katalogowa
FROM tblTowary
WHERE Kategoria_ID = 1 OR 
	Kategoria_ID = 3 AND 
	Cena_Katalogowa > 6 -- TODO zmie�my nawiasowanie
ORDER BY Cena_Katalogowa;

-- TODO zmie�my na wersj� z operatorem IN (kategorie)
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


/* �wieczenia */
-- 1.Znajdz w pracownika ktory pracuje na stanowisku Przedstawiciel handlowy
-- 2. wyswietl kod klienta, nazw� firmy, ulice oraz miasto z tabeli klineci. Wybierz tych,
--		ktorzy mieszkaja w miescie na W i kod klienta jest dwuznakowy
--		posortuj wg kodu malejaco
-- 3. Wybierz klient�w, kt�rych telefon nie ma "2" jako drug� cyfr�, oraz nazwa firmy zawiera liter� "a"
-- 4. Z tabeli pracownik�w wybierz wszystkie imiona i nazwiska os�b kt�rych id mie�ci si� mi�dzy 5 a 12 
--		lub nazwa ich stanowiska zawiera w sobie s�owo "handlowy" 
-- 5. Wybierz z tabeli pracownicy osoby o inicja�ach M.S. i J.M.





/* FUNKCJE SKALARNE */
SELECT 
LTRIM(NazwaTowaru), ID_Towar + Kategoria_ID
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

/*�wiczenia*/
-- 1. Znajd� pracownika na stanowisku Przedstawiciel handlowy
SELECT *
FROM tblPracownicy
WHERE Stanowisko = 'Przedstawiciel handlowy';

-- 2. Wy�wietl kod klienta, nazw� firmy, ulic� oraz miasto klient�w mieszkaj�cych w mie�cie na 'W' i maj�cych dwuznakowy kod klienta
SELECT KodKlienta, NazwaFirmy, Ulica, Miasto
FROM tblKlienci
WHERE Miasto LIKE 'W%' AND KodKlienta LIKE '__'
ORDER BY KodKlienta DESC;

-- 3. Wybierz klient�w, kt�rych telefon nie ma "2" jako drug� cyfr�, oraz nazwa firmy zawiera liter� "a"
SELECT *
FROM tblKlienci
WHERE Telefon NOT LIKE '_2%' AND NazwaFirmy LIKE '%a%';

-- 4. Wybierz imiona i nazwiska pracownik�w o ID mi�dzy 5 a 12 lub ze stanowiskiem zawieraj�cym "handlowy"
SELECT Imie, Nazwisko
FROM tblPracownicy
WHERE IDPracownika BETWEEN 5 AND 12 OR Stanowisko LIKE '%handlowy%';

-- 5. Wybierz z tabeli pracownicy osoby o inicja�ach M.S. i J.M.
SELECT *
FROM tblPracownicy
WHERE (Imie LIKE 'M%' AND Nazwisko LIKE 'S%') OR (Imie LIKE 'J%' AND Nazwisko LIKE 'M%');



/*FETCH OFFSET*/
-- Wybieranie z wyniku wierszy 21-30 
SELECT *
FROM tblPracownicy
ORDER BY Nazwisko
OFFSET 5 ROWS        -- Pomi� pierwsze 5 wierszy
FETCH NEXT 10 ROWS ONLY; -- Nast�pnie pobierz 10 wierszy

/*FETCH, OFFSET, CASE */

-- Wybieranie z wyniku wierszy 21-30 
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
-- 1. Wy�wietl dane z tabeli tblOpisSprzedazy posortowane po ilo�ci oraz cenie sprzeda�y (oba rosn�co). Ogranicz wyniki 
	-- do takich, gdzie cena sprzeda�y jest r�wna 3, g lub 5, lub zawiera si� mi�dzy 10, a 25. 
	-- Nast�pnie z posortowanych danych wybierz 10 wiersy, od 11-20 (OFFSET, FETCH)

-- 2. Wybierz z tabeli tblSprzedaz id klienta, rok sprzeda�y, miesi�c sprzeda�y, oraz dodatkowe pole kt�re zawiera:
 -- Je�li rok sprzedarzy to 2017 wypisz 'Faktura tegoroczna',
 -- Je�li rok sprzeda�y to 2016, to 'Faktura zesz�oroczna',
 -- W innym przypadku 'Starsza'


 /*�wiczenia dodatkowe */
-- 1. wy�wietl nazwy i ceny towar�w posortowane po cenie malej�co. W wyniku pomi� pierwsze 3 wiersze i poka� kolejne 7 (trzeba u�y� JOIN)
-- 2. Z tabeli pracownik�w wybierz wszystkie imiona i nazwiska. Je�li nazwa stanowiska zawiera w sobie s�owo "handlowy" 
-- przy nazwisku wy�wietl napis 'Handlowiec', w innym przypadku wy�wietl napis 'Inne stanowisko'

-- 1. Wy�wietl dane z tblOpisSprzedazy posortowane po ilo�ci oraz cenie sprzeda�y
SELECT *
FROM tblOpisSprzedazy
WHERE CenaSprzedazy IN (3, 5) OR (CenaSprzedazy BETWEEN 10 AND 25)
ORDER BY Ilosc ASC, CenaSprzedazy ASC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 2. Wybierz z tblSprzedaz id klienta, rok sprzeda�y, miesi�c sprzeda�y i status faktury
SELECT 
    Klient_ID,
    YEAR(DataSprzedazy) AS RokSprzedazy,
    MONTH(DataSprzedazy) AS MiesiacSprzedazy,
    CASE 
        WHEN YEAR(DataSprzedazy) = 2017 THEN 'Faktura tegoroczna'
        WHEN YEAR(DataSprzedazy) = 2016 THEN 'Faktura zesz�oroczna'
        ELSE 'Starsza'
    END AS StatusFaktury
FROM tblSprzedaz;

-- �wiczenia dodatkowe 1: Wy�wietl nazwy i ceny towar�w posortowane po cenie malej�co
SELECT NazwaTowaru, Cena_Katalogowa
FROM tblTowary
ORDER BY Cena_Katalogowa DESC
OFFSET 3 ROWS FETCH NEXT 7 ROWS ONLY;

-- �wiczenia dodatkowe 2: Wybierz imiona i nazwiska pracownik�w z okre�leniem typu stanowiska
SELECT 
    Imie, 
    Nazwisko,
    CASE 
        WHEN Stanowisko LIKE '%handlowy%' THEN 'Handlowiec'
        ELSE 'Inne stanowisko'
    END AS TypStanowiska
FROM tblPracownicy;
