

USE BS
GO
/*INSERT - UPDATE - DELETE*/


BEGIN TRANSACTION
INSERT INTO tblTowary VALUES (5, 'Banana', 566)

-- COMMIT
ROLLBACK


INSERT INTO tblTowary (ID_Towar, Kategoria_ID, NazwaTowaru, Cena_Katalogowa) VALUES (36, 5, 'Papaja', 5.5)
INSERT INTO tblTowary VALUES (37, 5, 'Kiwi', 5.5) -- b��d
INSERT INTO tblTowary VALUES (5, 'Banana', 5.5)


INSERT INTO HM.dbo.tbKlienci 
SELECT NazwaFirmy, Miasto, Kod, Ulica, 'N/A'
FROM BS.dbo.tblKlienci   -- wyst�pi b��d, co mo�emy zrobi� w tej sytuacji? left, case?


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

-- PK rekordu jest FK w innej tabeli, przy pr�bie usuni�cia pojawi si� b��d

DELETE FROM tblTowary
WHERE ID_Towar = 15

-- Spr�bujmy rozwi�za� problem: 


/*�wiczenia*/
 -- 1. BS: W tabeli z towarami mamy wci�� nazwy, kt�re zawieraj� na pocz�tku bia�e znaki. Dla wszystkich rekord�w
 -- zamie� nazw�, na wynik funkcji LTRIM na tej nazwie 
 -- 2. BS: Dodaj now� kategorie produktu, poczym przypisz do tej kategorii towary o id 5, 6, 7, 8
 -- 3. HM:  Poni�szy skrypt stworzy now� pust� tabel�. Przenie� do niej dane wszystkich uregulowanych ju� faktur (uregulowana = 1) poleceniem INSERT INTO ... SELECT.
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

