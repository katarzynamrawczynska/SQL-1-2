
SELECT * FROM BS.dbo.tblKlienci



USE HM
SELECT 
-- TOP 1 -- WITH TIES
-- *, k.*, pf.*
-- FakturaID -- TYLKO jeœli w tabelach ta nazwa jest jednoznaczna, lepiej odnieœæ siê przez nazwê/alias tabeli, jak ni¿ej
pf.FakturaID, SUM(CenaSprz) AS wartoœæ, k.Nazwa AS "Nazwa Klienta"
FROM tbPozycjeFaktur pf
JOIN tbFaktury f 
	ON f.IDFaktury = pf.FakturaID
JOIN tbKlienci k 
	ON f.KlientID = k.IDKlienta 
WHERE pf.FakturaID NOT IN (1,4,8)
	AND k.Nazwa LIKE '%' 
	AND k.miasto IS NOT NULL
GROUP BY k.Nazwa, pf.FakturaID -- czy zadzia³a tak samo, jeœli zamieniæ na pole f.IDFaktury (pole posiada te same wartoœci)?
HAVING SUM(pf.CenaSprz)  > 33 -- czy mo¿na zamieniæ SUM(pf.CenaSprz)  na alias wartoœæ ?
ORDER BY k.Nazwa  -- czy mo¿na zamieniæ SUM(pf.CenaSprz)  na alias "Nazwa Klienta" ?


USE BS
/* FUNKCJE SKALARNE */
SELECT 
LTRIM(NazwaTowaru), NazwaTowaru, ID_Towar + Kategoria_ID
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
-- datename zawsze zwraca napisy, datepart numery
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
-- 5. Wyœwietl Wszystkie dane towarów, ale zamiast numeru z id kategorii wyœwietl id_kat: 3 pierwsze litery nazwy kategorii

/* dodatkowe */
-- 6. wyœwietl id i daty sprzeda¿y posortowane po dniu tygodnia tej sprzeda¿y (weekday)
--		jeœli bêd¹ takie same dni posortuj po dniu miesi¹ca (day)
-- 7. Wyœwietl pracowników którzy bêd¹ obchodziæ rocznicê zatrudnienia w ci¹gu najbli¿szych 30 dni 
--(musisz zmieniæ rok w dacie zatrudnienia, by porównaæ z aktualn¹ dat¹)



SELECT *, DATEDIFF(DAY, GETDATE(), '2024-'+DATENAME(month,DataZatrudnienia)+'-'+DATENAME(day,DataZatrudnienia))
FROM tblPracownicy
WHERE DATEDIFF(DAY, GETDATE(), '2024-'+DATENAME(month,DataZatrudnienia)+'-'+DATENAME(day,DataZatrudnienia))  BETWEEN 0 AND 30



USE HM
-- u¿ycie OVER - PARTITION BY - ORDER BY 
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

SELECT DISTINCT -- dane nie s¹ zagregowane, distict usuwa duplikaty
    FakturaID, --*,   -- dziêki OVER, zamiast grupowania mamy dostêp do wszystkich pól zapytania, a nie tylko tych zagregowanych i zgrupowanych
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS CenaFaktury
FROM dbo.tbPozycjeFaktur;



/* OVER, FUNKCJE RANKINGOWE  baza danych HM */
-- GRUPOWANIE
SELECT 
    FakturaID,
    SUM(CenaSprz * Ilosc) AS TotalAmount
FROM tbPozycjeFaktur
GROUP BY FakturaID;
-- Alternatywa z u¿yciem OVER
SELECT DISTINCT
    FakturaID, -- *, -- dane siê nie agreguj¹, mo¿emy wyœwietliæ wszystkie kolumny
    SUM(CenaSprz * Ilosc) OVER(PARTITION BY FakturaID) AS TotalAmount
FROM dbo.tbPozycjeFaktur;



SELECT 
    f.IDFaktury,
    p.CenaSprz,
    ROW_NUMBER() OVER(ORDER BY p.CenaSprz) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK()       OVER(ORDER BY p.CenaSprz) AS 'RangaCeny',
    DENSE_RANK() OVER(ORDER BY p.CenaSprz) AS 'GêstaRangaCeny',
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
    DENSE_RANK() OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'GêstaRangaCeny',
    NTILE(4) OVER(PARTITION BY f.IDFaktury ORDER BY p.CenaSprz DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
ORDER BY 
    f.IDFaktury, p.CenaSprz DESC;



/* æwiczenia */
-- 1. U¿yj OVER, aby policzyæ klientów z podzia³em na miasta. *** - Zwróæ uwagê, ¿e w tabeli z klientami mamy dwa sposoby zapisu: "Kraków" i Kraków. 
-- Spróbuj wymyœliæ jak znormalizowaæ te zapisy, aby oba sposoby dla tego samego miasta grupowa³y siê razem (mo¿na to zrobiæ jedn¹ funkcj¹ skalarn¹)

SELECT REPLACE(miasto,'"','' ) , COUNT(IDKlienta) OVER (PARTITION BY REPLACE(miasto,'"','' ))
FROM tbKlienci


SELECT miasto , COUNT(IDKlienta) OVER (PARTITION BY miasto)
FROM tbKlienci
-- 2. a. zmieñ partycjonowanie poprzedniego zapytania na ID klienta - dodaj do wyników nazwê klienta - nale¿y do³¹czyæ  INNER JOIN tabelê tbKlienci
-- b. nastêpnie zmieñ sortowanie po cenie, na sortowanie po iloœci. Zmieñ sortowania tak, aby mieæ rosn¹ce pozycje rankingów w danej grupie
SELECT 
    f.IDFaktury,
    p.CenaSprz,
	k.nazwa,
	p.ilosc,
    ROW_NUMBER() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'NumerPozycji', -- TODO Co gdy pominiemy PARTICION
    RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'RangaCeny',
    DENSE_RANK() OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'GêstaRangaCeny',
    NTILE(4) OVER(PARTITION BY f.KlientID ORDER BY p.ilosc DESC) AS 'KwartylCeny'
FROM tbFaktury f
JOIN tbPozycjeFaktur p ON f.IDFaktury = p.FakturaID
JOIN tbKlienci k ON k.IDKlienta = f.KlientID  
ORDER BY 
    f.KlientID, p.Ilosc DESC;


-- 3. Do zapytania poni¿ej dodaj funkcje rankingowe:
	-- a. Dodaj danse rank i rank z sortowaniem rankingu i wyniku zapytania po cenie, bez u¿ycia partition by 
	-- b. Dodaj partycjonowanie po nazwie zespo³u

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
OFFSET 5 ROWS        -- Pomiñ pierwsze 5 wierszy
FETCH NEXT 10 ROWS ONLY; -- Nastêpnie pobierz 10 wierszy


/*CASE - wyœwietl wed³ug warunków*/

SELECT  ID_OpisSprzedazy, 
	Towar_ID, 
	CASE
		WHEN Ilosc <= 5 THEN 'Pojedyncza'
		WHEN Ilosc <= 15 THEN 'Detaliczna'
		ELSE 'Hurtowa'
	END AS typSprzedazy
FROM tblOpisSprzedazy


/*æwiczenia*/

-- 1. Wybierz z tabeli tblSprzedaz id klienta, rok sprzeda¿y, miesi¹c sprzeda¿y, oraz dodatkowe pole które zawiera:
 -- Jeœli rok sprzedarzy to 2017 wypisz 'Faktura tegoroczna',
 -- Jeœli rok sprzeda¿y to 2016, to 'Faktura zesz³oroczna',
 -- W innym przypadku 'Starsza'
-- 2. Wyniki posortuj po latach i miesi¹cach, nastêpnie wyœwietl  od wiersza 33 do 44

SELECT 
    Klient_ID,
    YEAR(DataSprzedazy) AS RokSprzedazy,
    MONTH(DataSprzedazy) AS MiesiacSprzedazy,
    CASE 
        WHEN YEAR(DataSprzedazy) = 2017 THEN 'Faktura tegoroczna'
        WHEN YEAR(DataSprzedazy) = 2016 THEN 'Faktura zesz³oroczna'
        ELSE 'Starsza'
    END AS StatusFaktury
FROM tblSprzedaz
ORDER BY RokSprzedazy, MiesiacSprzedazy
OFFSET 32 ROWS        -- Pomiñ pierwsze 5 wierszy
FETCH NEXT 12 ROWS ONLY; 

 /*æwiczenia dodatkowe */
-- 1. wyœwietl pierwsze 3 litery nazwy i ceny towarów posortowane po cenie malej¹co. W wyniku pomiñ pierwsze 3 wiersze i poka¿ kolejne 7 (trzeba u¿yæ JOIN)
-- 2. Z tabeli pracowników wybierz wszystkie imiona i nazwiska. Jeœli nazwa stanowiska zawiera w sobie s³owo "handlowy" 
-- przy nazwisku wyœwietl napis 'Handlowiec', w innym przypadku wyœwietl napis 'Inne stanowisko'