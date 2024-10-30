
-- PIVOT

USE BS

-- 0. wynik zapytania, na którym chcemy zamieniæ osie
SELECT NazwaKategorii, SUM(Cena_Katalogowa)
FROM tblTowary t
RIGHT JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
GROUP BY NazwaKategorii


-- 1. wartoœci które maj¹ siê staæ nazwami kolumn
SELECT Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj¹ca kolumnê z tymi wartoœciami, oraz wartoœci¹ do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okreœlenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)) AS pv


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


-- 1. Wyœwietl jako kolumny nazwy noœników muzyki, i iloœci odpowiadaj¹cych im p³yt:
-- a. Napisz zapytanie, które wyœwietla wynik bez pivotowania
-- b. Sprowad¿ do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, które stan¹ siê kolumnami)
-- c. wstaw w poni¿sze ramy select
USE HM
SELECT * FROM
(
	-- Wybieramy kolumnê z noœnikami
) AS qr
PIVOT ( 
-- agregacja COUNT DLA (nazwy wartoœci - nowych kolumn
) AS pv


-- 2.  Korzystaj¹c z bazy HM wyœwietl tabele, w której kolumny to lata z
-- których pochodz¹ faktury, a w wierszu znajduje siê œrednia wartoœæ faktury w danym roku


-- 1. Wyœwietl jako kolumny nazwy noœników muzyki, i iloœci odpowiadaj¹cych im p³yt:
SELECT nosnik, COUNT(1) FROM tbTowary GROUP BY nosnik
-- a. Napisz zapytanie, które wyœwietla wynik bez pivotowania
-- b. Sprowad¿ do wersji bez grupowania i bez agregacji - COUNT(1) z naszej zagregowanej komendy usuwamy i wstawiamy go do PIVOT 
-- dodajemy FOR nosnik in (wartosci, które stan¹ siê kolumnami)
-- c. wstaw w poni¿sze ramy select
USE HM
SELECT * FROM
(
SELECT nosnik FROM tbTowary
) AS qr
PIVOT ( 
 COUNT(nosnik) FOR nosnik IN ( Analog, CD,DVD,MC,VHS)
) AS pv



/* UNPIVOT - przyk³ad */


USE BS
CREATE TABLE products_pivot (
Napoje float, Alkohole float, Piwo float, S³odycze float, 
		Owoce float, [Mleczne przetwory] float, [Zbo¿owe przetwory] float , Pieczywo float
)

INSERT INTO products_pivot
SELECT Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj¹ca kolumnê z tymi wartoœciami, oraz wartoœci¹ do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa, t.NazwaTowaru
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okreœlenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)) AS pv


SELECT * FROM products_pivot

SELECT 
    ProductCategory,
    Value
FROM 
    products_pivot
UNPIVOT 
(
    Value FOR ProductCategory IN (Napoje, Alkohole, Piwo, S³odycze, Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)
) AS unpvt;