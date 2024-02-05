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
WITH AvgSales AS (
    SELECT AVG(SumaZakupow) AS AvgSum
    FROM BS.dbo.tbSprzedaz
),
ClientStats AS (
    SELECT 
        Klient_ID, 
        SUM(CenaSprzedazy) AS SumaZakupow, 
        COUNT(*) AS LiczbaTransakcji
    FROM BS.dbo.tbSprzedaz
    GROUP BY Klient_ID
    HAVING COUNT(*) > 5
)
SELECT 
    k.ID_Klient, 
    k.NazwaFirmy, 
    cs.SumaZakupow, 
    cs.LiczbaTransakcji
FROM 
    BS.dbo.tblKlienci k
JOIN 
    ClientStats cs ON k.ID_Klient = cs.Klient_ID
WHERE 
    cs.SumaZakupow > (SELECT AvgSum FROM AvgSales);

-- Zadanie 2: Dla HM, wyświetl pracowników i liczbę obsłużonych transakcji,
-- sortując wyniki według nazwiska i imienia pracownika
WITH EmployeeSales AS (
    SELECT 
        Pracownik_ID, 
        COUNT(*) AS LiczbaTransakcji
    FROM HM.dbo.tblSprzedaz
    GROUP BY Pracownik_ID
)
SELECT 
    p.Imie, 
    p.Nazwisko, 
    es.LiczbaTransakcji
FROM 
    HM.dbo.tblPracownicy p
JOIN 
    EmployeeSales es ON p.IDPracownika = es.Pracownik_ID
ORDER BY 
    p.Nazwisko, p.Imie;

-- Zadanie 3: Połącz informacje o produktach z BS i HM, wyświetlając ich nazwy
-- i cenę, jeżeli istnieją w obu bazach
SELECT 
    BSProd.NazwaTowaru AS NazwaProduktuBS,
    HMProd.NazwaTowaru AS NazwaProduktuHM,
    BSProd.Cena_Katalogowa AS CenaBS,
    HMProd.Cena AS CenaHM
FROM 
    BS.dbo.tblTowary AS BSProd
INNER JOIN 
    HM.dbo.tblTowary AS HMProd ON BSProd.ID_Towar = HMProd.ID_Towar
WHERE 
    BSProd.NazwaTowaru = HMProd.NazwaTowaru
    AND BSProd.Cena_Katalogowa = HMProd.Cena;

-- Zadanie 4: Stwórz widok z agregatami dla HM, zawierający pracowników i 
-- sumaryczną wartość sprzedaży, którą obsłużyli, tylko dla tych którzy 
-- obsłużyli sprzedaż o wartości większej niż 10 000
EXECUTE ('CREATE VIEW HM.dbo.EmployeeSalesSummary AS
          SELECT 
              p.IDPracownika, 
              p.Nazwisko, 
              SUM(s.Wartosc) AS TotalSalesValue
          FROM 
              HM.dbo.tblPracownicy p
          JOIN 
              HM.dbo.tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID
          GROUP BY 
              p.IDPracownika, p.Nazwisko
          HAVING 
              SUM(s.Wartosc) > 10000');

-- Zadanie 5: Wyświetl sumę wartości sprzedaży dla każdego pracownika w BS
WITH EmployeeTotalSales AS (
    SELECT 
        Pracownik_ID, 
        SUM(CenaSprzedazy * Ilosc) AS TotalValue
    FROM BS.dbo.tblOpisSprzedazy os
    JOIN BS.dbo.tblSprzedaz s ON os.Sprzedaz_ID = s.ID_Sprzedaz
    GROUP BY Pracownik_ID
)
SELECT 
    p.Imie, 
    p.Nazwisko, 
    ets.TotalValue
FROM BS.dbo.tblPracownicy p
JOIN EmployeeTotalSales ets ON p.IDPracownika = ets.Pracownik_ID
ORDER BY TotalValue DESC;

-- Zadanie 6: Utwórz listę klientów w HM, którzy dokonali zakupu w każdym miesiącu ostatniego roku
SELECT 
    k.ID_Klient, 
    k.NazwaFirmy
FROM HM.dbo.tblKlienci k
WHERE NOT EXISTS (
    SELECT 1
    FROM HM.dbo.tblSprzedaz s
    WHERE s.Klient_ID = k.ID_Klient
    AND YEAR(s.DataSprzedazy) = YEAR(GETDATE()) - 1
    GROUP BY MONTH(s.DataSprzedazy)
    HAVING COUNT(DISTINCT MONTH(s.DataSprzedazy)) < 12
);

-- Zadanie 7: Wybierz wszystkie towary z BS, które nie zostały jeszcze sprzedane
SELECT 
    t.ID_Towar, 
    t.NazwaTowaru
FROM BS.dbo.tblTowary t
LEFT JOIN BS.dbo.tblOpisSprzedazy os ON t.ID_Towar = os.Towar_ID
WHERE os.Towar_ID IS NULL;

-- Zadanie 8: Znajdź klientów w HM, którzy kupili więcej niż jeden towar w pojedynczej transakcji
SELECT DISTINCT 
    k.ID_Klient, 
    k.NazwaFirmy
FROM HM.dbo.tblKlienci k
JOIN HM.dbo.tblSprzedaz s ON k.ID_Klient = s.Klient_ID
JOIN HM.dbo.tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
GROUP BY k.ID_Klient, k.NazwaFirmy
HAVING COUNT(DISTINCT os.Towar_ID) > 1;

-- Zadanie 9: Dla każdego działu w BS wyświetl ilość pracowników i średnią wartość sprzedaży na pracownika
SELECT 
    d.NazwaDzialu, 
    COUNT(p.IDPracownika) AS LiczbaPracownikow,
    AVG(s.Wartosc) AS SredniaSprzedazNaPracownika
FROM BS.dbo.tblDzialy d
JOIN BS.dbo.tblPracownicy p ON d.ID_Dzial = p.ID_Dzial
JOIN BS.dbo.tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID
GROUP BY d.NazwaDzialu;

-- Zadanie 10: Znajdź towary z HM, których cena jest wyższa niż średnia cena wszystkich towarów
SELECT 
    t.ID_Towar, 
    t.NazwaTowaru, 
    t.Cena
FROM HM.dbo.tblTowary t
CROSS JOIN (SELECT AVG(Cena) AS SredniaCena FROM HM.dbo.tblTowary) avgPrice
WHERE t.Cena > avgPrice.SredniaCena;

-- Zadanie 11: Wyświetl historię sprzedaży towarów w BS, pokazując zmiany cenowe
WITH PriceChanges AS (
    SELECT 
        Towar_ID, 
        CenaSprzedazy, 
        LAG(CenaSprzedazy) OVER (PARTITION BY Towar_ID ORDER BY DataSprzedazy) AS PreviousPrice
    FROM BS.dbo.tblOpisSprzedazy
)
SELECT 
    t.ID_Towar, 
    t
