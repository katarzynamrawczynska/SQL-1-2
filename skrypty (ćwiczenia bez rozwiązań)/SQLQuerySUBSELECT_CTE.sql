/*VIEW, SUBSELECT, CTE*/
USE HM
GO

/*SUBSELECT*/


SELECT MAX(cena) --, wykonawca + ' - ' + tytul
FROM tbTowary
-- u¿ycie w warunku, przy agregacji - zwalnia czas wykonania, ale jest potrzebne
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary)

-- u¿ycie w warunku z operatorem ANY, ale szybciej zadzia³a, gdy przerobimy na INNER JOIN
SELECT nazwa 
FROM hm.dbo.tbKlienci
WHERE nazwa = ANY(SELECT NazwaFirmy FROM BS.dbo.tblKlienci)

-- u¿ycie w JOIN z prefiltrowaniem - zbêdne dane s¹ odfiltrowane zanim nast¹pi po³¹czenie - mo¿e przyœpieszyæ 
-- czas wykonania, ale komplikuje sk³adnie
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

-- u¿ycie subzapytania do wyci¹gniêcia dodatkowej kolumny
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

/* æwiczenia */
-- 1.  Wyœwietl wszystkie dane faktur wraz z opisem najœwie¿szej i najstarszej faktury w bazie (MAX i MIN data)
-- 2. Napisz zapytanie które ³¹czy wszystkie tabele inner join wed³ug relacji. Nastêpnie w warunku WHERE odfiltrowuje 
-- tylko te dane, gdzie faktura nie zosta³a uregulowana
-- 3(cd. punktu 2). ogranicz kolumny do nazwy klienta, towaru, daty faktury, iloœci i ceny sprzeda¿y.
-- zmieñ warunek WHERE na taki, gdzie interesuj¹ nas tylko te wyniki, gdzie suma cenysprzeda¿y dla ca³ej faktury jest wiêksza od œredniej ceny sprzeda¿y na fakturze w bazie



/* CTE */
-- Zastêpowanie subzapytania przez CTE - jak widaæ, przy tak prostym CTE kwerenda jest d³u¿sza ni¿ z subselect
-- Na zwiêz³oœci zyskamy, gdy u¿ywamy tego samego wyra¿enia w kilku miejscach

WITH NajdrozszyTowar AS (
    SELECT MAX(cena) AS MaxCena
    FROM tbTowary
)
SELECT cena, wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MaxCena FROM NajdrozszyTowar)


-- U¿ycie CTE zamiast ANY
WITH NazwyFirm AS (
    SELECT NazwaFirmy FROM BS.dbo.tblKlienci
)
SELECT nazwa 
FROM hm.dbo.tbKlienci
WHERE nazwa IN (SELECT NazwaFirmy FROM NazwyFirm)


-- U¿ycie CTE dla prefiltrowania przed JOIN
WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID


-- U¿ycie CTE dla dodatkowej kolumny
WITH SumaCen AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
LEFT JOIN SumaCen p ON f.IDFaktury = p.FakturaID


-- subselect vs CTE u¿ywane wielokrotnie



-- u¿ywamy tych samych subselect / cte w select i w where
-- zapytanie czterokrotnie przechodzi przez wszystkie rekordy tabeli tbFaktury - ka¿dy subselect dzia³a osobno
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


-- Raz wykonane CTE zostaje w pamiêci do koñca wykonania zapytania, nie musi wykonywaæ siê ponownie
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




/* æwiczenia */
-- Opieraj¹c siê na æwiczeniach z subselect (1,2,3) wykonaj kwerendy które pobieraj¹ te same dane ale z u¿yciem CTE



/*VIEWS*/
-- Tworzenie widoku powinno byæ osobn¹ komend¹, ale gdy zaznaczymy tylko t¹ instrukcje / u¿ywamy po niej GO
-- Widok siê utworzy
-- UWAGA! w widoku wszystkie kolumny musz¹ mieæ nazwy

CREATE OR ALTER VIEW avg_sprzedaz AS (SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur ); --UNION 3);
GO;
SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur WHERE CenaSprz > (SELECT TOP 1 srednia_sp FROM avg_sprzedaz) -- dlaczego top 1? Czy u¿yæ?

DROP VIEW avg_sprzedaz  -- usuniêcie widoku

-- CTE tworzone wczeœniej
WITH PrefiltrowanePozycje AS (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
)
SELECT f.IDFaktury, f.KlientID, p.TotalCena
FROM tbFaktury f
JOIN PrefiltrowanePozycje p ON f.IDFaktury = p.FakturaID

-- zmiana na u¿ywanie widoku

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

/*æwiczenia*/
-- 1. ko¿ystaj¹c z zapytañ 1 z subselect i 1 z CTE utwórz na ich podstawie dwa widoki
-- 2. Utwórz widok z numerami faktur, dat¹ sprzeda¿y oraz nazw¹ klienta z fakturami z bie¿¹ce
-- 3. Poni¿ej mamy dwa zapytania zwracaj¹ce takie same wyniki. Zapisz SELECT bêd¹cy subselectem jednoczeœnie CTE 
-- w drugim zapytaniu, i przerób zapytania, by u¿ywa³y widoku



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
