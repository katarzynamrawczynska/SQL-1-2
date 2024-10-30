
-- PIVOT

USE BS

-- 0. wynik zapytania, na kt�rym chcemy zamieni� osie
SELECT NazwaKategorii, SUM(Cena_Katalogowa)
FROM tblTowary t
RIGHT JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
GROUP BY NazwaKategorii


-- 1. warto�ci kt�re maj� si� sta� nazwami kolumn
SELECT Napoje, Alkohole, Piwo, S�odycze, 
		Owoce, [Mleczne przetwory], [Zbo�owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj�ca kolumn� z tymi warto�ciami, oraz warto�ci� do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okre�lenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S�odycze, 
		Owoce, [Mleczne przetwory], [Zbo�owe przetwory], Pieczywo)) AS pv


--------------------------------------------
SELECT YEAR(DataSprzedazy) rok, SUM(CenaSprzedazy) 
FROM tblOpisSprzedazy os
JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz
GROUP BY YEAR(DataSprzedazy) 

---
SELECT YEAR(DataSprzedazy) as rok, CenaSprzedazy
FROM tblOpisSprzedazy os
JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz

--
SELECT DISTINCT YEAR(DataSprzedazy) FROM tblSprzedaz

--
SELECT *--2012, 2013, 2014, 2015, 2016, 2017
FROM (
	SELECT YEAR(DataSprzedazy) as rok, CenaSprzedazy
	FROM tblOpisSprzedazy os
	JOIN tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz
	) qr
PIVOT (SUM(CenaSprzedazy) FOR rok IN ([2012], [2013], [2014], [2015], [2016], [2017]) 
) pv


-- 1. Wy�wietl jako kolumny nazwy no�nik�w muzyki, i ilo�ci odpowiadaj�cych im p�yt:
-- a. Napisz zapytanie, kt�re wy�wietla wynik bez pivotowania
-- b. Sprowad� do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, kt�re stan� si� kolumnami)
-- c. wstaw w poni�sze ramy select
USE HM
SELECT * FROM
(
	-- Wybieramy kolumn� z no�nikami
) AS qr
PIVOT ( 
-- agregacja COUNT DLA (nazwy warto�ci - nowych kolumn
) AS pv


-- 2.  Korzystaj�c z bazy HM wy�wietl tabele, w kt�rej kolumny to lata z
-- kt�rych pochodz� faktury, a w wierszu znajduje si� �rednia warto�� faktury w danym roku


-- 1. Wy�wietl jako kolumny nazwy no�nik�w muzyki, i ilo�ci odpowiadaj�cych im p�yt:
SELECT nosnik, COUNT(1) FROM tbTowary GROUP BY nosnik
-- a. Napisz zapytanie, kt�re wy�wietla wynik bez pivotowania
-- b. Sprowad� do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, kt�re stan� si� kolumnami)
-- c. wstaw w poni�sze ramy select
USE HM
SELECT * FROM
(
SELECT nosnik FROM tbTowary
) AS qr
PIVOT ( 
 COUNT(nosnik) FOR nosnik IN ( Analog, CD,DVD,MC,VHS)
) AS pv



/* UNPIVOT - przyk�ad */


USE BS
CREATE TABLE products_pivot (
Napoje float, Alkohole float, Piwo float, S�odycze float, 
		Owoce float, [Mleczne przetwory] float, [Zbo�owe przetwory] float , Pieczywo float
)

INSERT INTO products_pivot
SELECT Napoje, Alkohole, Piwo, S�odycze, 
		Owoce, [Mleczne przetwory], [Zbo�owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj�ca kolumn� z tymi warto�ciami, oraz warto�ci� do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa, t.NazwaTowaru
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okre�lenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S�odycze, 
		Owoce, [Mleczne przetwory], [Zbo�owe przetwory], Pieczywo)) AS pv


SELECT * FROM products_pivot

SELECT 
    ProductCategory,
    Value
FROM 
    products_pivot
UNPIVOT 
(
    Value FOR ProductCategory IN (Napoje, Alkohole, Piwo, S�odycze, Owoce, [Mleczne przetwory], [Zbo�owe przetwory], Pieczywo)
) AS unpvt;