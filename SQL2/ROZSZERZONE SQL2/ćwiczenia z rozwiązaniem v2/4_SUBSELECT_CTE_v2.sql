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


SELECT * FROM (
	SELECT NazwaFirmy, Miasto 
	FROM tblKlienci

		UNION

	SELECT Nazwisko, Miasto
	FROM tblPracownicy
	) as dane
ORDER BY Miasto



-- Zapytania skorelowane
-- albumy z cen� wy�sz� ni�  �rednia cen dla dystrybutora
USE HM
SELECT t.Tytul, t.Dystrybutor, t.Cena,
	(SELECT AVG(Cena)      ------ je�li chcemy r�wnie� wy�wietli� t� cen�, to musimy wykona� subzapytanie dwukrotnie
     FROM tbTowary t2 
     WHERE t2.Dystrybutor = t.Dystrybutor)
FROM tbTowary t
WHERE t.Cena > (SELECT AVG(Cena) 
                FROM tbTowary t2 
                WHERE t2.Dystrybutor = t.Dystrybutor)  -- wymaga po��czenia z dystrybutorem
ORDER BY t.Dystrybutor;

-- zam�wienia, kt�re maj� wi�ksz� warto�� ni� �rednia warto�� wszystkich zam�wie� danego klienta
USE  BS
SELECT s.ID_Sprzedaz, s.Klient_ID, s.DataSprzedazy, 
       (SELECT AVG(CenaSprzedazy * Ilosc) 
        FROM tblOpisSprzedazy os 
        WHERE os.Sprzedaz_ID = s.ID_Sprzedaz) AS SredniaWartoscZamowienia
FROM tblSprzedaz s
WHERE (SELECT SUM(CenaSprzedazy * Ilosc) 
       FROM tblOpisSprzedazy os 
       WHERE os.Sprzedaz_ID = s.ID_Sprzedaz) 
       > (SELECT AVG(CenaSprzedazy * Ilosc) 
          FROM tblOpisSprzedazy os 
          WHERE os.Sprzedaz_ID = s.ID_Sprzedaz)
ORDER BY s.ID_Sprzedaz;

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

USE BS
--Z�o�one agregacje z dodatkowymi filtrami

SELECT Klient_ID, MAX(SumaZamowienia) AS NajwyzszaWartosc
FROM (
    SELECT Klient_ID, SUM(CenaSprzedazy * Ilosc) AS SumaZamowienia
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    GROUP BY Klient_ID, ID_Sprzedaz
) AS Podzapytanie
GROUP BY Klient_ID;



/*�wiczenia*/

-- 1. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD
USE HM
SELECT pf.FakturaID, SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
-- WHERE ...
WHERE TowarID IN (SELECT IDTowaru FROM tbTowary WHERE nosnik = 'CD')
GROUP BY pf.FakturaID


-- 2.  Wy�wietl wszystkie naj�wie�szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
SELECT * FROM tbFaktury
WHERE DataSprzed = (SELECT MAX(DataSprzed) FROM tbFaktury)
	OR DataSprzed = (SELECT MIN(DataSprzed) FROM tbFaktury)
-- b. Wy�wietl 3 naj�wie�sze faktury w bazie - w pod zapytaniu pobierz dane za pomoc� TOP 3 przy odpowiednim sortowaniu


-- 3. Wy�wietl dane klienta, zagregowan� sum� warto�ci jego sprzedazy, oraz procentowa warto�� jego sprzedazy wzgl�dem sumy ze wszystkich sprzedazy
USE BS;
SELECT k.ID_Klient, k.NazwaFirmy, k.NIP,
       SUM(os.CenaSprzedazy * os.Ilosc) AS SumaFakturKlienta,
       ROUND(SUM(os.CenaSprzedazy * os.Ilosc) * 100.0 / 
             (SELECT SUM(CenaSprzedazy * Ilosc) 
              FROM tblSprzedaz s2
              JOIN tblOpisSprzedazy os2 ON os2.Sprzedaz_ID = s2.ID_Sprzedaz), 2) AS ProcentWartosciFaktur
FROM tblKlienci k
JOIN tblSprzedaz s ON s.Klient_ID = k.ID_Klient
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
GROUP BY k.ID_Klient, k.NazwaFirmy, k.NIP
ORDER BY ProcentWartosciFaktur DESC;


-- 4. HM: Znajd� albumy, kt�re s� ta�sze od najdro�szego albumu tego samego wykonawcy
USE HM
SELECT t.Tytul, t.Wykonawca, t.Cena
FROM tbTowary t
WHERE t.Cena < (SELECT MAX(Cena) 
                FROM tbTowary t2 
                WHERE t2.Wykonawca = t.Wykonawca)
ORDER BY t.Wykonawca;


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


-- Znajd� albumy, kt�re s� dro�sze od �redniej ceny album�w tego samego dystrybutora
USE HM;
SELECT t.Tytul, t.Dystrybutor, t.Cena,
       (SELECT AVG(Cena)
        FROM tbTowary t2
        WHERE t2.Dystrybutor = t.Dystrybutor) AS SredniaCenaDystrybutora
FROM tbTowary t
WHERE t.Cena > (SELECT AVG(Cena)
                FROM tbTowary t2
                WHERE t2.Dystrybutor = t.Dystrybutor)
ORDER BY t.Dystrybutor;

-- Wersja z CTE
WITH SrednieCenyDystrybutorow AS (
    SELECT Dystrybutor, AVG(Cena) AS SredniaCena
    FROM tbTowary
    GROUP BY Dystrybutor
)
SELECT t.Tytul, t.Dystrybutor, t.Cena, scd.SredniaCena AS SredniaCenaDystrybutora
FROM tbTowary t
JOIN SrednieCenyDystrybutorow scd ON scd.Dystrybutor = t.Dystrybutor
WHERE t.Cena > scd.SredniaCena
ORDER BY t.Dystrybutor;


USE BS
-- Zapytanie 3: Znajd� najwy�sz� warto�� zam�wienia dla ka�dego klienta
SELECT Klient_ID, MAX(SumaZamowienia) AS NajwyzszaWartosc
FROM (
    SELECT Klient_ID, SUM(CenaSprzedazy * Ilosc) AS SumaZamowienia
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    GROUP BY Klient_ID, ID_Sprzedaz
) AS Podzapytanie
GROUP BY Klient_ID;

-- Wersja z CTE
WITH WartoscZamowien AS (
    SELECT Klient_ID, SUM(CenaSprzedazy * Ilosc) AS SumaZamowienia
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
    GROUP BY Klient_ID, ID_Sprzedaz
)
SELECT Klient_ID, MAX(SumaZamowienia) AS NajwyzszaWartosc
FROM WartoscZamowien
GROUP BY Klient_ID;



-- u�ywamy tych samych subselect / cte w select i w where 
-- SUBSELECT: zapytanie czterokrotnie przechodzi przez wszystkie rekordy tabeli tbFaktury - ka�dy subselect dzia�a osobno
-- CTE: dane do CTE wyci�gane s� raz - program pami�ta je do ko�ca pracy zapytania
USE HM
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



/*REKURENCYJNE CTE*/
WITH HierarchiaPracownikow AS (
    -- CTE pocz�tkowe (Anchor)
    SELECT 
        p.IDPracownika, 
        p.Imie, 
        p.Nazwisko, 
        p.Stanowisko, 
        p.Przelozony_ID, 
        p.Dzial_ID, 
        0 AS PoziomHierarchii,
		-- CAST, by uniknac b��du przy automatycznym rzutowaniu typu:
			-- Msg 240: types don't match between the anchor and the recursive part in column "PrzelozonyImie" 
			-- of recursive query "HierarchiaPracownikow".
        CAST(NULL AS nvarchar(10)) AS PrzelozonyImie,
        CAST(NULL AS nvarchar(20)) AS PrzelozonyNazwisko,
        CAST(NULL AS nvarchar(40)) AS PrzelozonyStanowisko
    FROM BS.dbo.tblPracownicy p
    WHERE p.Przelozony_ID IS NULL  -- Znajd� pracownik�w na najwy�szym poziomie (bez prze�o�onego)

    UNION ALL

    -- Rekurencyjna cz�� CTE
    SELECT 
        p.IDPracownika, 
        p.Imie, 
        p.Nazwisko, 
        p.Stanowisko, 
        p.Przelozony_ID, 
        p.Dzial_ID, 
        hp.PoziomHierarchii + 1 AS PoziomHierarchii,
        hp.Imie AS PrzelozonyImie,
        hp.Nazwisko AS PrzelozonyNazwisko,
        hp.Stanowisko AS PrzelozonyStanowisko
    FROM BS.dbo.tblPracownicy p
    JOIN HierarchiaPracownikow hp ON p.Przelozony_ID = hp.IDPracownika
)

SELECT  *
FROM HierarchiaPracownikow
ORDER BY PoziomHierarchii, Dzial_ID;


-- Poprzednie �wiczenia wykonaj z u�yciem CTE:
/*�wiczenia*/

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


-- 4. Wy�wietl dane klienta, zagregowan� sum� warto�ci jego sprzedazy, oraz procentowa warto�� jego sprzedazy wzgl�dem sumy ze wszystkich sprzedazy
USE BS;
SELECT k.ID_Klient, k.NazwaFirmy, k.NIP,
       SUM(os.CenaSprzedazy * os.Ilosc) AS SumaFakturKlienta,
       ROUND(SUM(os.CenaSprzedazy * os.Ilosc) * 100.0 / 
             (SELECT SUM(CenaSprzedazy * Ilosc) 
              FROM tblSprzedaz s2
              JOIN tblOpisSprzedazy os2 ON os2.Sprzedaz_ID = s2.ID_Sprzedaz), 2) AS ProcentWartosciFaktur
FROM tblKlienci k
JOIN tblSprzedaz s ON s.Klient_ID = k.ID_Klient
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
GROUP BY k.ID_Klient, k.NazwaFirmy, k.NIP
ORDER BY ProcentWartosciFaktur DESC;

;WITH SumaCenFaktur AS 
 (SELECT SUM(CenaSprzedazy * Ilosc) SumaCenFaktur
              FROM tblSprzedaz s2
              JOIN tblOpisSprzedazy os2 ON os2.Sprzedaz_ID = s2.ID_Sprzedaz)
SELECT k.ID_Klient, k.NazwaFirmy, k.NIP,
       SUM(os.CenaSprzedazy * os.Ilosc) AS SumaFakturKlienta,
       ROUND(SUM(os.CenaSprzedazy * os.Ilosc) * 100.0 / 
            (SELECT SumaCenFaktur FROM SumaCenFaktur), 2) AS ProcentWartosciFaktur
FROM tblKlienci k
JOIN tblSprzedaz s ON s.Klient_ID = k.ID_Klient
JOIN tblOpisSprzedazy os ON os.Sprzedaz_ID = s.ID_Sprzedaz
GROUP BY k.ID_Klient, k.NazwaFirmy, k.NIP
ORDER BY ProcentWartosciFaktur DESC;
