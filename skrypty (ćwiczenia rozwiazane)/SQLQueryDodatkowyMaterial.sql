

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
 

 -- Ustawienie kontekstu dla bazy danych BS
USE BS;
GO

-- Zadanie 1: Znajdź klientów z sumą zakupów większą niż średnia i przynajmniej 5 transakcjami
WITH CustomerSales AS (
    SELECT 
        Klient_ID, 
        SUM(CenaSprzedazy) AS TotalSales, 
        COUNT(DISTINCT Sprzedaz_ID) AS Transactions
    FROM tblSprzedaz s
	JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
    GROUP BY Klient_ID
    HAVING COUNT(DISTINCT Sprzedaz_ID) >= 5
),
AverageSales AS (
    SELECT AVG(TotalSales) AS AvgSales
    FROM CustomerSales
)
SELECT cs.*
FROM CustomerSales cs, AverageSales av
WHERE cs.TotalSales > av.AvgSales;

-- Zadanie 2: Dla BS, wyświetl pracowników i liczbę obsłużonych transakcji
WITH EmployeeTransactions AS (
    SELECT 
        Pracownik_ID, 
        COUNT(*) AS TransactionsCount
    FROM tblSprzedaz
    GROUP BY Pracownik_ID
)
SELECT e.Nazwisko, e.Imie, et.TransactionsCount
FROM tblPracownicy e
JOIN EmployeeTransactions et ON e.IDPracownika = et.Pracownik_ID
ORDER BY e.Nazwisko, e.Imie;

-- Zadanie 3: Połącz informacje o produktach z BS i HM
SELECT NazwaTowaru, Cena_Katalogowa
FROM BS.dbo.tblTowary 
UNION
SELECT tytul, cena 
FROM HM.dbo.tbTowary hmt

-- Zadanie 4: Stwórz widok z agregatami dla BS, zawierający pracowników i 
-- sumaryczną wartość sprzedaży, którą obsłużyli, tylko dla tych którzy 
-- obsłużyli sprzedaż o wartości z pierwszego kwartyla wszystkich tranzakcji
CREATE VIEW vwEmployeeSalesSummary AS
WITH SalesData AS (
    SELECT 
        p.IDPracownika,
        p.Imie + ' ' + p.Nazwisko AS Pracownik,
        SUM(os.CenaSprzedazy * os.Ilosc) AS TotalSales,
        NTILE(4) OVER (ORDER BY SUM(os.CenaSprzedazy * os.Ilosc)) AS SalesQuartile
    FROM 
        dbo.tblPracownicy p
    JOIN 
        dbo.tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID
    JOIN 
        dbo.tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
    GROUP BY 
        p.IDPracownika, p.Imie, p.Nazwisko
)
(
SELECT 
    Pracownik,
    TotalSales
FROM 
    SalesData
WHERE 
    SalesQuartile = 1
)

-- Zadanie 5: Wybierz wszystkie towary z BS, które nie zostały jeszcze sprzedane
SELECT t.*
FROM tblTowary t
LEFT JOIN tblOpisSprzedazy os ON t.ID_Towar = os.Towar_ID
WHERE os.Towar_ID IS NULL;

-- Zadanie 6: Znajdź klientów w BS, którzy kupili więcej niż jeden towar w pojedynczej transakcji
WITH MultipleItems AS (
    SELECT 
        Klient_ID, 
        Sprzedaz_ID
    FROM tblOpisSprzedazy os
	JOIN tblSprzedaz s ON s.ID_Sprzedaz = os.Sprzedaz_ID
    GROUP BY Klient_ID, Sprzedaz_ID
    HAVING COUNT(Towar_ID)> 1
)
SELECT DISTINCT k.*
FROM tblKlienci k
JOIN MultipleItems mi ON k.ID_Klient= mi.Klient_ID;

-- Zadanie 7: Znajdź towary z HM, których cena jest wyższa niż średnia cena wszystkich towarów
USE HM
GO
WITH AvgPrice AS (
    SELECT AVG(Cena) AS AveragePrice
    FROM tbTowary
)
SELECT *
FROM tbTowary t 
WHERE t.cena >  (SELECT * FROM AvgPrice)