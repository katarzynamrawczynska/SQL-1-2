-- Procedura zwracaj�ca sprzeda� dla danego klienta
CREATE PROCEDURE GetCustomerSales
    @CustomerID INT
AS
BEGIN
    SELECT sp.*, k.NazwaFirmy
    FROM tblSprzedaz sp
    JOIN tblKlienci k ON sp.Klient_ID = k.ID_Klient
    WHERE sp.Klient_ID = @CustomerID;
END;

-- Wywo�anie procedury GetCustomerSales
EXEC GetCustomerSales @CustomerID = 1;

-- Procedura aktualizuj�ca cen� produktu
CREATE PROCEDURE UpdateProductPrice
    @ProductID INT,
    @NewPrice FLOAT
AS
BEGIN
    UPDATE tblTowary
    SET Cena_Katalogowa = @NewPrice
    WHERE ID_Towar = @ProductID;
END;

-- Wywo�anie procedury UpdateProductPrice
EXEC UpdateProductPrice @ProductID = 2, @NewPrice = 75.0;

-- Procedura u�ywaj�ca dynamicznego SQL do wykonania zapytania
CREATE PROCEDURE GetSalesForProduct
    @ProductID INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'SELECT * FROM tblOpisSprzedazy WHERE Towar_ID = ' + CAST(@ProductID AS NVARCHAR);

    EXEC sp_executesql @SQL;
END;

-- Wywo�anie procedury GetSalesForProduct
EXEC GetSalesForProduct @ProductID = 1001;


-- Procedura sprawdzaj�ca poziom sprzeda�y (przyk�ad u�ycia zmiennej lokalnej)
CREATE PROCEDURE CheckProductSales
    @ProductID INT
AS
BEGIN
    DECLARE @SalesCount INT;

    SELECT @SalesCount = COUNT(*)
    FROM tblOpisSprzedazy
    WHERE Towar_ID = @ProductID;

    IF @SalesCount < 10
    BEGIN
        PRINT 'Sprzeda� jest niska';
    END
    ELSE
    BEGIN
        PRINT 'Sprzeda� jest wysoka';
    END;
END;

-- Wywo�anie procedury CheckProductSales
EXEC CheckProductSales @ProductID = 1001;


-- Procedura u�ywaj�ca p�tli WHILE do wypisania liczb od 1 do 10
CREATE PROCEDURE PrintNumbers
AS
BEGIN
    DECLARE @Counter INT;
    SET @Counter = 1;

    WHILE @Counter <= 10
    BEGIN
        PRINT 'Liczba: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END;
END;

-- Wywo�anie procedury PrintNumbers
EXEC PrintNumbers;

