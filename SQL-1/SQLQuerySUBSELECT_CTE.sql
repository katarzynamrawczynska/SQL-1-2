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



/* �wiczenia */
-- Opieraj�c si� na �wiczeniach z subselect (1,2,3) wykonaj kwerendy kt�re pobieraj� te same dane ale z u�yciem CTE



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
