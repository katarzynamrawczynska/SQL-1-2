

USE BS
GO
/*INSERT - UPDATE - DELETE*/


BEGIN TRANSACTION
INSERT INTO tblTowary VALUES (5, 'Banana', 566)

-- COMMIT
ROLLBACK


INSERT INTO tblTowary (ID_Towar, Kategoria_ID, NazwaTowaru, Cena_Katalogowa) VALUES (36, 5, 'Papaja', 5.5)
INSERT INTO tblTowary VALUES (37, 5, 'Kiwi', 5.5) -- b³¹d
INSERT INTO tblTowary VALUES (5, 'Banana', 5.5)


INSERT INTO HM.dbo.tbKlienci 
SELECT NazwaFirmy, Miasto, Kod, Ulica, 'N/A'
FROM BS.dbo.tblKlienci   -- wyst¹pi b³¹d, co mo¿emy zrobiæ w tej sytuacji? left, case?


UPDATE tblTowary
SET NazwaTowaru = 'Zaktualizowana nazwa produktu'
WHERE NazwaTowaru = 'Stara nazwa produktu';

UPDATE tblOpisSprzedazy
SET Ilosc = Ilosc + 3
WHERE Towar_ID = 103 

UPDATE tblOpisSprzedazy
SET Ilosc = Ilosc * 1.1
WHERE Towar_ID = 103 

UPDATE tblOpisSprzedazy
SET Ilosc = (SELECT MAX(Ilosc) FROM tblOpisSprzedazy)
WHERE Towar_ID = 103 AND Sprzedaz_ID = 
(SELECT ID_Sprzedaz FROM tblSprzedaz WHERE Klient_ID = 4);


-- PK rekordu nie jest FK w innej tabeli
DELETE FROM tblTowary
WHERE ID_Towar = 36

-- PK rekordu jest FK w innej tabeli, przy próbie usuniêcia pojawi siê b³¹d

DELETE FROM tblTowary
WHERE ID_Towar = 15

-- Spróbujmy rozwi¹zaæ problem: 


/*æwiczenia*/
 -- 1. BS: W tabeli z towarami mamy wci¹¿ nazwy, które zawieraj¹ na poczêtku bia³e znaki. Dla wszystkich rekordów
 -- zamieñ nazwê, na wynik funkcji LTRIM na tej nazwie 
 -- 2. BS: Dodaj now¹ kategorie produktu, poczym przypisz do tej kategorii towary o id 5, 6, 7, 8
 -- 3. HM:  Poni¿szy skrypt stworzy now¹ pust¹ tabelê. Przenieœ do niej dane wszystkich uregulowanych ju¿ faktur (uregulowana = 1) poleceniem INSERT INTO ... SELECT.
 -- 
GO

CREATE TABLE [dbo].[tbFaktury_Zaplacone](
	[IDFaktury] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[KlientID] [int] NULL,
	[NrFaktury] [int] NOT NULL,
	[DataSprzed] [datetime2](7) NULL,
	[TerminPlat] [datetime2](7) NULL,
	[Uregulowana] [bit] NULL,
	[Uwagi] [nvarchar](100) NULL
	FOREIGN KEY (KlientID) REFERENCES tbKlienci(IDKlienta)
	);

