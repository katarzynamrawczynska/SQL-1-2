-- Skalarne funkcje u¿ytkownika (scalar functions)

USE BS;
GO
-- Oblicz podatek VAT na podstawie kwoty sprzeda¿y
CREATE FUNCTION ObliczVAT (@WartoscSprzedazy DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @WartoscSprzedazy * 0.23;
END;
GO

-- Skalarne funkcje
SELECT s.ID_Sprzedaz, os.CenaSprzedazy * os.Ilosc AS WartoscSprzedazy, 
       dbo.ObliczVAT(os.CenaSprzedazy * os.Ilosc) AS PodatekVAT
FROM BS.dbo.tblSprzedaz s
JOIN BS.dbo.tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID;

USE HM;
GO
-- Skróæ nazwê albumu do pierwszych n znaków
CREATE FUNCTION SkrocTytul (@Tytul NVARCHAR(50), @IloscZnakow INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN LEFT(@Tytul, @IloscZnakow);
END;
GO

SELECT Tytul, dbo.SkrocTytul(Tytul, 10) AS SkroconyTytul
FROM tbTowary;

-- Tablicowe funkcje u¿ytkownika (table-valued functions)

USE BS;
GO
-- Wyœwietl historiê sprzeda¿y dla konkretnego klienta
CREATE OR ALTER FUNCTION HistoriaSprzedazyKlienta (@ID_Klient INT)
RETURNS TABLE
AS
RETURN (
    SELECT s.ID_Sprzedaz, os.ID_OpisSprzedazy, s.DataSprzedazy, os.Towar_ID, os.Ilosc, os.CenaSprzedazy, os.Ilosc * os.CenaSprzedazy AS Wartosc
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
    WHERE s.Klient_ID = @ID_Klient
	
);
GO
SELECT * FROM BS.dbo.HistoriaSprzedazyKlienta(1) ORDER BY ID_Sprzedaz, Towar_ID;
USE HM;
GO
-- Wyœwietl albumy wydane przed danym rokiem
CREATE OR ALTER FUNCTION AlbumyPrzedRokiem (@Rok INT)
RETURNS TABLE
AS
RETURN (
    SELECT Tytul, Wykonawca, rok_wydania, Cena
    FROM tbTowary
    WHERE rok_wydania < @Rok
);
GO


SELECT * FROM HM.dbo.AlbumyPrzedRokiem(1990);
