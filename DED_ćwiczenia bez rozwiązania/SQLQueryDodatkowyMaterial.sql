/*Procedura z dynamicznym SQL*/

CREATE OR ALTER PROCEDURE PobierzStatystykiKlientow @NazwaKolumny NVARCHAR(128), 
    @KierunekSortowania NVARCHAR(4)
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
	ORDER BY @NazwaKolumny --- to samo z desc/asc
END;
GO

EXECUTE PobierzStatystykiKlienta 'nazwa', 'ASC'
GO



/*Cały na biało, dynamiczny SQL*/

CREATE OR ALTER PROCEDURE StatystykiKlientaSort @NazwaKolumny NVARCHAR(128), 
    @KierunekSortowania NVARCHAR(4)
AS
BEGIN
DECLARE @SQLQuery AS NVARCHAR(MAX); -- zmienna w której skleimy zaptanie
SET @SQLQuery =  N'WITH StatystykiKlienta AS (
        SELECT  f.KlientID,  SUM(pf.CenaSprz) AS SumaZakupow,  
		COUNT(DISTINCT pf.FakturaID) AS LiczbaTransakcji
        FROM tbPozycjeFaktur pf
        JOIN tbFaktury f ON pf.FakturaID = f.IDFaktury
        GROUP BY f.KlientID
    )
    SELECT *
    FROM tbKlienci k
    JOIN StatystykiKlienta sk ON k.IDKlienta = sk.KlientID
ORDER BY ' + QUOTENAME(@NazwaKolumny) + ' ' + @KierunekSortowania;
PRINT @SQLQuery -- Dodatkowo wyświetlamy całość zapytania
EXEC sp_executesql @SQLQuery -- wywoła n ie całości zapytania przygotowanego w zmiennej
END;
GO


EXECUTE StatystykiKlientaSort
    @NazwaKolumny = 'nazwa', 
    @KierunekSortowania = 'ASC';

-- Zadanie 1: Znajdź klientów z BS z sumą zakupów większą niż średnia
-- i przynajmniej 5 transakcjami


-- Zadanie 2: Dla BS, wyświetl pracowników i liczbę obsłużonych transakcji,
-- sortując wyniki według nazwiska i imienia pracownika


-- Zadanie 3: Połącz informacje o produktach z BS i HM, wyświetlając ich nazwy (dla HM tytuł)
-- i cenę


-- Zadanie 4: Stwórz widok z agregatami dla BS, zawierający pracowników i 
-- sumaryczną wartość sprzedaży, którą obsłużyli, tylko dla tych którzy 
-- obsłużyli sprzedaż o wartości z pierwszego kwartyla wszystkich tranzakcji


-- Zadanie 5: Wybierz wszystkie towary z BS, które nie zostały jeszcze sprzedane


-- Zadanie 6: Znajdź klientów w BS, którzy kupili więcej niż jeden towar w pojedynczej transakcji


-- Zadanie 7: Znajdź towary z HM, których cena jest wyższa niż średnia cena wszystkich towarów
 


