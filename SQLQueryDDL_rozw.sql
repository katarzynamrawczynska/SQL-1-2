USE BS
--CREATE [OR ALTER] VIEW name AS (...)
--CREATE [OR ALTER] PROCEDURE name @param AS (...)

CREATE TABLE Dzialy (
    ID_Dzial INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g³ówny, automatycznie ustawiane NOT NULL 
    NazwaDzialu VARCHAR(100) NOT NULL UNIQUE -- tylko unikalne wartoœci
);
CREATE TABLE Pracownicy (
    ID_Pracownik INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g³ówny
    ID_Dzial INT,
	EmailAdress NVARCHAR(50),
    DataZatrudnienia DATE NOT NULL CHECK (DataZatrudnienia > '2000-01-01'), 
    Stanowisko NVARCHAR(50) NOT NULL DEFAULT 'Pracownik' -- DEFAULT
    CONSTRAINT FK_Pracownicy_Dzialy FOREIGN KEY (ID_Dzial) REFERENCES Dzialy (ID_Dzial)  -- Klucz obcy
    ON UPDATE CASCADE 
    ON DELETE SET NULL 
);

-- Dodanie nowej kolumny do tabeli Pracownicy
ALTER TABLE Pracownicy
ADD Nazwisko NVARCHAR(100);

-- Zmiana typu istniej¹cej kolumny w tabeli Pracownicy
ALTER TABLE Pracownicy
ALTER COLUMN Stanowisko NVARCHAR(100);

-- Usuniêcie klucza obcego z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP CONSTRAINT FK_Pracownicy_Dzialy;

-- Dodanie klucza obcego do tabeli Pracownicy
ALTER TABLE Pracownicy
ADD CONSTRAINT FK_Pracownicy_Dzialy FOREIGN KEY (ID_Dzial) REFERENCES Dzialy(ID_Dzial);

-- Dodanie ograniczenia UNIQUE do kolumny Email w tabeli Pracownicy
ALTER TABLE Pracownicy
ADD CONSTRAINT UNQ_Pracownicy_Email UNIQUE (EmailAdress);


-- Usuniêcie kolumny z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP COLUMN Nazwisko;

-- Usuniêcie klucza obcego z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP CONSTRAINT FK_Pracownicy_Dzialy;

-- Usuniêcie tabeli Pracownicy (zak³adaj¹c, ¿e nie istniej¹ ¿adne zale¿noœci)
DROP TABLE Pracownicy;

-- Usuniêcie tabeli Dzialy (zak³adaj¹c, ¿e nie istniej¹ ¿adne zale¿noœci)
DROP TABLE Dzialy;

/*æwiczenia*/

USE HM
-- 1. W bazie danych HM stwórz tabelê tbKategorieTowarow z kolumnami:
--	a. IDKategoria jako klucz g³ówny - int z autouzupe³nianiem (identity)
--	b. KodKategoria typu nvarchar(4) o wartoœciach unikalnych z not null
--  c. Nazwa typu nvarchar(50) z not null

-- 2. To tabeli tbTowary dodaj kolumnê KategoriaID typu int. W kolejnej komendzie dodaj obostrzenie - klucz obcy o nazwie FK_Towary_Kategorie
--	na kolumnie KategoriaID referuj¹cy do tabeli tbKategorieTowarow(IDKategoria)

-- 3. Usuñ kolumnê KategoriaID z tbTowary - najpierw musisz usun¹æ CONSTRAINT FK_Towary_Kategorie, potem dopiero kolumnê
-- 4. Usuñ tabelê tbKategorieTowarow

CREATE TABLE tbKategorieTowarow (
    IDKategoria INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g³ówny z autouzupe³nianiem
    KodKategoria NVARCHAR(4) NOT NULL UNIQUE, -- Unikalny kod kategorii
    Nazwa NVARCHAR(50) NOT NULL -- Nazwa kategorii
);

ALTER TABLE tbTowary
	ADD KategoriaID INT

ALTER TABLE tbTowary
	ADD CONSTRAINT FK_Towary_Kategorie FOREIGN KEY (KategoriaID)
	REFERENCES tbKategorieTowarow(IDKategoria)

ALTER TABLE tbTowary
	DROP CONSTRAINT FK_Towary_Kategorie
ALTER TABLE tbTowary
	DROP COLUMN KategoriaID

DROP TABLE tbKategorieTowarow