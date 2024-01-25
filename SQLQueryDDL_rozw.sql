USE BS
--CREATE [OR ALTER] VIEW name AS (...)
--CREATE [OR ALTER] PROCEDURE name @param AS (...)

CREATE TABLE Dzialy (
    ID_Dzial INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g��wny, automatycznie ustawiane NOT NULL 
    NazwaDzialu VARCHAR(100) NOT NULL UNIQUE -- tylko unikalne warto�ci
);
CREATE TABLE Pracownicy (
    ID_Pracownik INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g��wny
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

-- Zmiana typu istniej�cej kolumny w tabeli Pracownicy
ALTER TABLE Pracownicy
ALTER COLUMN Stanowisko NVARCHAR(100);

-- Usuni�cie klucza obcego z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP CONSTRAINT FK_Pracownicy_Dzialy;

-- Dodanie klucza obcego do tabeli Pracownicy
ALTER TABLE Pracownicy
ADD CONSTRAINT FK_Pracownicy_Dzialy FOREIGN KEY (ID_Dzial) REFERENCES Dzialy(ID_Dzial);

-- Dodanie ograniczenia UNIQUE do kolumny Email w tabeli Pracownicy
ALTER TABLE Pracownicy
ADD CONSTRAINT UNQ_Pracownicy_Email UNIQUE (EmailAdress);


-- Usuni�cie kolumny z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP COLUMN Nazwisko;

-- Usuni�cie klucza obcego z tabeli Pracownicy
ALTER TABLE Pracownicy
DROP CONSTRAINT FK_Pracownicy_Dzialy;

-- Usuni�cie tabeli Pracownicy (zak�adaj�c, �e nie istniej� �adne zale�no�ci)
DROP TABLE Pracownicy;

-- Usuni�cie tabeli Dzialy (zak�adaj�c, �e nie istniej� �adne zale�no�ci)
DROP TABLE Dzialy;

/*�wiczenia*/

USE HM
-- 1. W bazie danych HM stw�rz tabel� tbKategorieTowarow z kolumnami:
--	a. IDKategoria jako klucz g��wny - int z autouzupe�nianiem (identity)
--	b. KodKategoria typu nvarchar(4) o warto�ciach unikalnych z not null
--  c. Nazwa typu nvarchar(50) z not null

-- 2. To tabeli tbTowary dodaj kolumn� KategoriaID typu int. W kolejnej komendzie dodaj obostrzenie - klucz obcy o nazwie FK_Towary_Kategorie
--	na kolumnie KategoriaID referuj�cy do tabeli tbKategorieTowarow(IDKategoria)

-- 3. Usu� kolumn� KategoriaID z tbTowary - najpierw musisz usun�� CONSTRAINT FK_Towary_Kategorie, potem dopiero kolumn�
-- 4. Usu� tabel� tbKategorieTowarow

CREATE TABLE tbKategorieTowarow (
    IDKategoria INT IDENTITY(1,1) PRIMARY KEY, -- Klucz g��wny z autouzupe�nianiem
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