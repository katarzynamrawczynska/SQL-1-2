
SELECT * FROM BS.dbo.tblKlienci

USE HM
SELECT 
 TOP 10
 --*, k.*, pf.*,
 -- FakturaID, -- TYLKO jeœli w tabelach ta nazwa jest jednoznaczna, lepiej odnieœæ siê przez nazwê/alias tabeli, jak ni¿ej
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
LTRIM(NazwaTowaru) , NazwaTowaru, ID_Towar + Kategoria_ID
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

SELECT (Imie + ' ' + CAST(IDPracownika AS nvarchar)) AS pe³ne_imiê FROM tblPracownicy; 

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
DATEPART(year, GETDATE()) AS rok,
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

SELECT LEFT(Imie, 1) + '.' + LEFT(Nazwisko, 1)+ '.' AS inicjaly
FROM tblPracownicy

-- 2. Wyœwietl nazwê firmy i napis "Numer Telefonu: [Telefon], Komórka [TelefonKomorkowy]". 
-- Jeœli brak danych TelefonKomorkowy wyœwietl zamiast tego "brak". Ogranicz wyniki do firm, których 
--		kod jest 2 znakowy  (+, COALESCE, LEN)

SELECT NazwaFirmy, KodKlienta, 'Numer Telefonu: ['+Telefon+'], Komórka ['+COALESCE(TelefonKomorkowy,'brak')+']'
FROM tblKlienci
WHERE LEN(KodKlienta) = 2

-- 3. Z tabeli z opisem sprzeda¿y wyœwietl wartoœæ sprzeda¿y - (cena * ilosc) "zaokr¹glone w dó³" (FLOOR)
--		do liczb ca³kowitych
SELECT FLOOR(CenaSprzedazy*Ilosc)
FROM tblOpisSprzedazy

-- 4. SprawdŸ ile dni up³ynê³o od '2020-01-01' (DATEDIFF, nie trzeba u¿ywaæ FROM)
SELECT DATEDIFF(DAY,  '01-01-2020', GETDATE())
/* dodatkowe */
-- 5. wyœwietl id i daty sprzeda¿y posortowane po dniu tygodnia tej sprzeda¿y (weekday)
--		jeœli bêd¹ takie same dni posortuj po dniu miesi¹ca (day)
SELECT ID_Sprzedaz, DataSprzedazy , DATEPART(WEEKDAY,DataSprzedazy), DATENAME(WEEKDAY,DataSprzedazy), DATEPART(DAY, DataSprzedazy)
FROM tblSprzedaz 
ORDER BY DATEPART(WEEKDAY,DataSprzedazy), DATEPART(DAY, DataSprzedazy)



