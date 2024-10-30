USE HM

SELECT MAX(cena) FROM tbTowary; 
-- Do powy�szego nie da si� doda� niezgrupowanych p�l
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary);

USE BS

SELECT Miasto FROM tblPracownicy
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN 
	(SELECT DISTINCT Miasto FROM tblPracownicy)

SELECT os.Sprzedaz_ID, 
	t.NazwaTowaru,
	os.Ilosc,
	CenaSprzedazy - (SELECT AVG(CenaSprzedazy) FROM tblOpisSprzedazy) AS odchylenie
FROM tblOpisSprzedazy os
JOIN tblTowary t ON os.Towar_ID = t.ID_Towar 
order by odchylenie DESC

-- u�ycie w JOIN z prefiltrowaniem - zb�dne dane s� odfiltrowane zanim nast�pi po��czenie - mo�e przy�pieszy� 
-- czas wykonania, ale komplikuje sk�adnie
USE HM
SELECT 
    f.IDFaktury,
    f.KlientID,
    pf.TotalCena
FROM 
    tbFaktury f
JOIN 
    (SELECT 
         FakturaID, 
         SUM(CenaSprz) AS TotalCena 
		 FROM tbPozycjeFaktur 
		 WHERE Ilosc > 5  -- Pre-filtrowanie danych; u�yte by przy�pieszy� wykonanie zapytania (mniej danych musi si� po��czy� z drug� tabel�)
		 GROUP BY  FakturaID
	) pf 
ON f.IDFaktury = pf.FakturaID;


/*�wiczenia*/
-- 1.  Wy�wietl wszystkie naj�wie�szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
SELECT * FROM tbFaktury
WHERE DataSprzed = (SELECT MAX(DataSprzed) FROM tbFaktury)
	OR DataSprzed = (SELECT MIN(DataSprzed) FROM tbFaktury)

-- 2. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD
SELECT pf.FakturaID, SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
 WHERE TowarID IN (SELECT IDTowaru FROM tbTowary WHERE nosnik = 'CD')
GROUP BY pf.FakturaID
-- 3. Napisz zapytanie, kt�re wyci�ga dane faktur z 2005 roku. Gotowe zapytanie po��cz jako subselect z tabel� 
-- pozycje faktur, oraz towary. Z podanych wy�wietl dat� faktury (z podzapytania z fakturami), nazw� wykonawcy 
-- i albumu(towary), oraz cen� sprzeda�y (pozycje faktur)
SELECT * FROM tbFaktury
WHERE YEAR(DataSprzed) = 2006 


SELECT t.tytul, t.wykonawca, faktury2005.DataSprzed, pf.CenaSprz
FROM (SELECT DataSprzed, IDFaktury 
	FROM tbFaktury
	WHERE YEAR(DataSprzed) = 2005 ) faktury2005
JOIN tbPozycjeFaktur pf ON faktury2005.IDFaktury = pf.FakturaID
JOIN tbTowary t ON pf.TowarID = t.IDTowaru



/*CTE*/
-- wersja z subselect
USE HM
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary)

-- wersja z CTE
;WITH NajdrozszyTowar AS (      -- �rednik przed WITH nie jest konieczny, ale bez niego nie odpalimy poprzedniego zapytania razem z tym
    SELECT MAX(cena) AS MaxCena
    FROM tbTowary
)
SELECT cena, wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MaxCena FROM NajdrozszyTowar)

USE BS
-- wersja z subselect
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN 
	(SELECT Miasto FROM tblPracownicy)
-- wersja z CTE
;WITH miasta_pracownicy AS(
SELECT miasto from tblPracownicy)
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN (SELECT * FROM miasta_pracownicy)


USE HM
-- U�ycie CTE dla prefiltrowania przed JOIN
;WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID

-- U�ycie CTE dla dodatkowej kolumny
;WITH SumaCen AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
LEFT JOIN SumaCen p ON f.IDFaktury = p.FakturaID



-- u�ywamy tych samych subselect / cte w select i w where 
-- SUBSELECT: zapytanie czterokrotnie przechodzi przez wszystkie rekordy tabeli tbFaktury - ka�dy subselect dzia�a osobno
-- CTE: dane do CTE wyci�gane s� raz - program pami�ta je do ko�ca pracy zapytania
SELECT 
    k.IDKlienta, 
    k.Nazwa, 
    (
		SELECT SUM(pf.CenaSprz) 
		FROM tbPozycjeFaktur pf
		JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
		WHERE f.KlientID = k.IDKlienta) 
	AS SumaZakupow, 
    (
		SELECT COUNT(DISTINCT pf.FakturaID) 
		FROM tbPozycjeFaktur pf
		JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
		WHERE f.KlientID = k.IDKlienta) 
	AS LiczbaTransakcji
FROM 
    tbKlienci k
WHERE 
	(
		SELECT SUM(pf.CenaSprz) 
		FROM tbPozycjeFaktur pf
		JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
		WHERE f.KlientID = k.IDKlienta
	)   > 1000 
	AND 
	(
		SELECT COUNT(DISTINCT pf.FakturaID) 
		FROM tbPozycjeFaktur pf
		JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
		WHERE f.KlientID = k.IDKlienta
	) > 5;


-- Raz wykonane CTE zostaje w pami�ci do ko�ca wykonania zapytania, nie musi wykonywa� si� ponownie
;WITH StatystykiKlienta AS (
    SELECT 
    f.KlientID, 
    SUM(pf.CenaSprz) AS SumaZakupow, 
    COUNT(DISTINCT pf.FakturaID) AS LiczbaTransakcji
    FROM tbPozycjeFaktur pf
    JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
    GROUP BY f.KlientID
)
SELECT 
    k.IDKlienta, 
    k.Nazwa, 
    sk.SumaZakupow, 
    sk.LiczbaTransakcji
FROM 
    tbKlienci k
JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
WHERE sk.SumaZakupow > 1000 AND sk.LiczbaTransakcji > 5;




-- Poprzednie �wiczenia wykonaj z u�yciem CTE:
/*�wiczenia*/
-- 1.  Wy�wietl wszystkie naj�wie�szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
-- 2. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD

SELECT SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
-- WHERE .... IN (subselect)
GROUP BY pf.FakturaID

-- 3. Napisz zapytanie, kt�re wyci�ga dane faktur z 2005 roku. Gotowe zapytanie po��cz jako subselect z tabel� 
-- pozycje faktur, oraz towary. Z podanych wy�wietl dat� faktury (z podzapytania z fakturami), nazw� wykonawcy 
-- i albumu(towary), oraz cen� sprzeda�y (pozycje faktur)




/*�wiczenia - subselect vs CTE */
-- 1.  Wy�wietl wszystkie naj�wie�szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
SELECT * FROM tbFaktury
WHERE DataSprzed = (SELECT MAX(DataSprzed) FROM tbFaktury)
	OR DataSprzed = (SELECT MIN(DataSprzed) FROM tbFaktury)

;WITH max_min AS (
	SELECT MAX(DataSprzed) AS max_D, MIN(DataSprzed) AS min_D FROM tbFaktury
)
SELECT * FROM tbFaktury 
WHERE DataSprzed = (SELECT max_D FROM max_min)
OR  DataSprzed = (SELECT min_D FROM max_min)


-- 2. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD
SELECT pf.FakturaID, SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
 WHERE TowarID IN (SELECT IDTowaru FROM tbTowary WHERE nosnik = 'CD')
GROUP BY pf.FakturaID

;WITH cds AS (
SELECT IDTowaru
	FROM tbTowary
	WHERE nosnik = 'CD'
)
SELECT pf.FakturaID,SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
 WHERE pf.TowarID IN (SELECT * FROM cds)
GROUP BY pf.FakturaID


-- 3. Napisz zapytanie, kt�re wyci�ga dane faktur z 2005 roku. Gotowe zapytanie po��cz jako subselect z tabel� 
-- pozycje faktur, oraz towary. Z podanych wy�wietl dat� faktury (z podzapytania z fakturami), nazw� wykonawcy 
-- i albumu(towary), oraz cen� sprzeda�y (pozycje faktur)
SELECT * FROM tbFaktury
WHERE YEAR(DataSprzed) = 2006 

SELECT t.tytul, t.wykonawca, faktury2005.DataSprzed, pf.CenaSprz
FROM (SELECT DataSprzed, IDFaktury 
	FROM tbFaktury
	WHERE YEAR(DataSprzed) = 2005 ) faktury2005
JOIN tbPozycjeFaktur pf ON faktury2005.IDFaktury = pf.FakturaID
JOIN tbTowary t ON pf.TowarID = t.IDTowaru

;WITH faktury2005 AS (
SELECT * FROM tbFaktury WHERE YEAR(DataSprzed) = 2005
)
SELECT 
faktury2005.DataSprzed, t.wykonawca, t.tytul, pf.CenaSprz
FROM faktury2005
JOIN tbPozycjeFaktur pf ON pf.FakturaID = faktury2005.IDFaktury
JOIN tbTowary t ON t.IDTowaru = pf.TowarID