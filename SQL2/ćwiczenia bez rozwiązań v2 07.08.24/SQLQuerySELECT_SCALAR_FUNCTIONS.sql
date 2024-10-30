
SELECT * FROM BS.dbo.tblKlienci

USE HM
SELECT 
-- TOP 1 
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

/* dodatkowe */
-- 5. wy�wietl id i daty sprzeda�y posortowane po dniu tygodnia tej sprzeda�y (weekday)
--		je�li b�d� takie same dni posortuj po dniu miesi�ca (day)
