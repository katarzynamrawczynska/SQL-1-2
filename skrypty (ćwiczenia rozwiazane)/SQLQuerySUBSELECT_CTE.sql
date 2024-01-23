/*VIEW, SUBSELECT, CTE*/
USE HM
GO

/*SUBSELECT*/


SELECT MAX(cena) --, wykonawca + ' - ' + tytul
FROM tbTowary
-- u�ycie w warunku, przy agregacji - zwalnia czas wykonania, ale jest potrzebne
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary)

-- u�ycie w warunku z operatorem ANY, ale szybciej zadzia�a, gdy przerobimy na INNER JOIN
SELECT nazwa 
FROM hm.dbo.tbKlienci
WHERE nazwa = ANY(SELECT NazwaFirmy FROM BS.dbo.tblKlienci)

-- u�ycie w JOIN z prefiltrowaniem - zb�dne dane s� odfiltrowane zanim nast�pi po��czenie - mo�e przy�pieszy� 
-- czas wykonania, ale komplikuje sk�adnie
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
		 WHERE Ilosc > 5  -- Pre-filtrowanie danych
		 GROUP BY  FakturaID
	) pf 
ON f.IDFaktury = pf.FakturaID;

-- u�ycie subzapytania do wyci�gni�cia dodatkowej kolumny
SELECT 
    f.IDFaktury,
    f.KlientID,
    (
		SELECT SUM(CenaSprz) 
		FROM tbPozycjeFaktur 
		WHERE FakturaID = f.IDFaktury
	 ) AS TotalCena
FROM 
    tbFaktury f;

/* �wiczenia */
-- 1.  Wy�wietl wszystkie dane faktur wraz z opisem naj�wie�szej i najstarszej faktury w bazie (MAX i MIN data)
-- 2. Napisz zapytanie kt�re ��czy wszystkie tabele inner join wed�ug relacji. Nast�pnie w warunku WHERE odfiltrowuje 
-- tylko te dane, gdzie faktura nie zosta�a uregulowana
-- 3(cd. punktu 2). ogranicz kolumny do nazwy klienta, towaru, daty faktury, ilo�ci i ceny sprzeda�y.
-- zmie� warunek WHERE na taki, gdzie interesuj� nas tylko te wyniki, gdzie suma cenysprzeda�y dla ca�ej faktury jest wi�ksza od �redniej ceny sprzeda�y na fakturze w bazie

-- 1. Wy�wietl wszystkie dane faktur z datami naj�wie�szej i najstarszej faktury
SELECT *
FROM tbFaktury
WHERE dataSprzed = (SELECT MAX(dataSprzed) FROM tbFaktury) 
OR dataSprzed = (SELECT MIN(dataSprzed) FROM tbFaktury) 


/* CTE */
-- Zast�powanie subzapytania przez CTE - jak wida�, przy tak prostym CTE kwerenda jest d�u�sza ni� z subselect
-- Na zwi�z�o�ci zyskamy, gdy u�ywamy tego samego wyra�enia w kilku miejscach

WITH NajdrozszyTowar AS (
    SELECT MAX(cena) AS MaxCena
    FROM tbTowary
)
SELECT cena, wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MaxCena FROM NajdrozszyTowar)


-- U�ycie CTE zamiast ANY
WITH NazwyFirm AS (
    SELECT NazwaFirmy FROM BS.dbo.tblKlienci
)
SELECT nazwa 
FROM hm.dbo.tbKlienci
WHERE nazwa IN (SELECT NazwaFirmy FROM NazwyFirm)


-- U�ycie CTE dla prefiltrowania przed JOIN
WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID


-- U�ycie CTE dla dodatkowej kolumny
WITH SumaCen AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
LEFT JOIN SumaCen p ON f.IDFaktury = p.FakturaID


-- subselect vs CTE u�ywane wielokrotnie



-- u�ywamy tych samych subselect / cte w select i w where
-- zapytanie czterokrotnie przechodzi przez wszystkie rekordy tabeli tbFaktury - ka�dy subselect dzia�a osobno
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
WITH StatystykiKlienta AS (
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




/* �wiczenia */
-- Opieraj�c si� na �wiczeniach z subselect (1,2,3) wykonaj kwerendy kt�re pobieraj� te same dane ale z u�yciem CTE

-- CTE dla naj�wie�szej i najstarszej daty faktury
WITH FakturyDaty AS (
    SELECT MAX(DataSprzed) AS NajswiezszaFaktura, MIN(DataSprzed) AS NajstarszaFaktura
    FROM tbFaktury
)
SELECT *
FROM tbFaktury f
WHERE f.DataSprzed = (SELECT NajswiezszaFaktura FROM FakturyDaty)
OR f.DataSprzed = (SELECT NajstarszaFaktura FROM FakturyDaty)


-- CTE dla ��cz�cego zapytania z tabelami
WITH LaczoneDane AS (
    SELECT f.IDFaktury, k.NazwaFirmy, t.NazwaTowaru, f.DataFaktury, os.Ilosc, os.CenaSprzedazy
    FROM tblFaktury f
    INNER JOIN tblKlienci k ON f.KlientID = k.IDKlienta
    INNER JOIN tblOpisSprzedazy os ON f.IDFaktury = os.FakturaID
    INNER JOIN tblTowary t ON os.TowarID = t.IDTowaru
)

-- 2. Wybierz nieuregulowane faktury z po��czonych danych
SELECT *
FROM LaczoneDane
WHERE IDFaktury IN (SELECT IDFaktury FROM tblFaktury WHERE Uregulowana = 0);

-- 3. Wybierz dane z ograniczeniem sumy ceny sprzeda�y wi�kszej ni� �rednia
SELECT *
FROM LaczoneDane
WHERE (SELECT SUM(CenaSprzedazy) FROM tblOpisSprzedazy WHERE FakturaID = IDFaktury) > (SELECT AVG(CenaSprzedazy) FROM tblOpisSprzedazy);


/*VIEWS*/
-- Tworzenie widoku powinno by� osobn� komend�, ale gdy zaznaczymy tylko t� instrukcje / u�ywamy po niej GO
-- Widok si� utworzy
-- UWAGA! w widoku wszystkie kolumny musz� mie� nazwy

CREATE OR ALTER VIEW avg_sprzedaz AS (SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur ); --UNION 3);
GO;
SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur WHERE CenaSprz > (SELECT TOP 1 srednia_sp FROM avg_sprzedaz) -- dlaczego top 1? Czy u�y�?

DROP VIEW avg_sprzedaz  -- usuni�cie widoku

-- CTE tworzone wcze�niej
WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID

-- zmiana na u�ywanie widoku

CREATE OR ALTER VIEW prefiltrowanie_pozycji AS 
(	
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
);
GO 
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN prefiltrowanie_pozycji p ON f.IDFaktury = p.FakturaID

/*�wiczenia*/
-- 1. ko�ystaj�c z zapyta� 1 z subselect i 1 z CTE utw�rz na ich podstawie dwa widoki
-- 2. Utw�rz widok z numerami faktur, dat� sprzeda�y oraz nazw� klienta z fakturami z bie��ce
-- 3. Poni�ej mamy dwa zapytania zwracaj�ce takie same wyniki. Zapisz SELECT b�d�cy subselectem jednocze�nie CTE 
-- w drugim zapytaniu, i przer�b zapytania, by u�ywa�y widoku



SELECT f.IDFaktury, f.KlientID, pf.TotalCena
FROM tbFaktury f
JOIN (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
) pf ON f.IDFaktury = pf.FakturaID

WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID


/* Procedura z parametrami */
CREATE PROCEDURE PobierzStatystykiKlienta  @MinSumaZakupow MONEY, @MinLiczbaTransakcji INT
AS
BEGIN
    WITH StatystykiKlienta AS (
        SELECT  f.KlientID,  SUM(pf.CenaSprz) AS SumaZakupow,  
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
    FROM tbKlienci k
    JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
    WHERE sk.SumaZakupow > @MinSumaZakupow AND sk.LiczbaTransakcji > @MinLiczbaTransakcji;
END;
GO


EXECUTE PobierzStatystykiKlienta 10, 1
GO
