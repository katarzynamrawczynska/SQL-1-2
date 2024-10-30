/*VIEW, SUBSELECT*/
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

-- 2. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD

SELECT pf.FakturaID, SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
	--WHERE pf.TowarID IN ...
GROUP BY pf.FakturaID

-- 3. Napisz zapytanie, kt�re wyci�ga dane faktur z 2005 roku. Gotowe zapytanie po��cz jako subselect z tabel� 
-- pozycje faktur, oraz towary. Z podanych wy�wietl dat� faktury (z podzapytania z fakturami), nazw� wykonawcy 
-- i albumu(towary), oraz cen� sprzeda�y (pozycje faktur)



/*VIEWS*/
-- Tworzenie widoku powinno by� osobn� komend�, ale gdy zaznaczymy tylko t� instrukcje / u�ywamy po niej GO
-- Widok si� utworzy
-- UWAGA! w widoku wszystkie kolumny musz� mie� nazwy

CREATE OR ALTER VIEW avg_sprzedaz AS (SELECT avg(CenaSprz) AS srednia_sp FROM tbPozycjeFaktur order );
GO;
SELECT * FROM avg_sprzedaz

SELECT * from tbPozycjeFaktur WHERE CenaSprz > (SELECT TOP 1 srednia_sp FROM avg_sprzedaz) -- dlaczego top 1? Czy u�y�?

DROP VIEW avg_sprzedaz  -- usuni�cie widoku

-- zmie�my poni�sze zapytanie na widok

SELECT f.IDFaktury, f.KlientID, pf.TotalCena
FROM tbFaktury f
JOIN (
    SELECT FakturaID, SUM(CenaSprz) AS TotalCena 
    FROM tbPozycjeFaktur 
    WHERE Ilosc > 5
    GROUP BY FakturaID
) pf ON f.IDFaktury = pf.FakturaID



/*�wiczenia*/
-- 1. Utw�rz widok z numerami faktur, dat� sprzeda�y oraz nazw� klienta z fakturami z bie��ce
-- 2 Wybierz towary kt�re nie nale�� do kategorii 1 i 2. wy�wietl nazwy i ceny zaokr�glone do jednego miejsca po przecinku (ROUND)
-- po przetestowaniu zapisz wynik jako widok i napisz SELECT wybieraj�cy z niego tylko 3 najta�sze produkty.