

-- 1. Nietypowe grupowanie danych (dla bazy BS)
-- Zgrupuj klient�w wed�ug pierwszej litery nazwy firmy i zsumuj ich ��czne transakcje sprzeda� 
-- - Ilo�� tranzakcji i Suma ich cen
USE BS

-- 2. PIVOT (dla bazy BS)
-- Zadanie: Utw�rz raport sprzeda�y produkt�w, gdzie kolumny to kwarta�y, a wiersze to kategorie produkt�w.
USE BS

-- 3. UNIA (Union) Baza BS
-- Zadanie: Po��cz list� klient�w i list� pracownik�w z ich adresami. Dla klient�w wy�wietl nazw� firmy, dla pracownik�w 
-- Pierwsz� liter� imienia i nazwisko: np. J.Kowalski
USE BS

-- 4. Tworzenie procedury sk�adowanej dla bazy danych HM
-- Zadanie: Procedura, kt�ra zwraca sum� sprzeda�y dla danego klienta.
USE HM


-- 5: Stw�rz widok z agregatami dla BS, zawieraj�cy pracownik�w i 
-- sumaryczn� warto�� sprzeda�y, kt�r� obs�u�yli. Uwzgl�dnij tylko tych, kt�rzy 
-- obs�u�yli sprzeda� o warto�ci z pierwszego kwartyla wszystkich tranzakcji
USE BS

-- 6. Uszereguj towary u�ywaj�c RANK z bs po r�nicy ich ceny katalogowaj (tbTowary) i �redniej ceny sprzeda�y (tbSprzedaz)
-- wyniki zaokr�glij do 2 miejsc po przecinku
USE BS



























-- Odpowiedzi

-- 1 
USE BS
SELECT 
    LEFT(NazwaFirmy, 1) AS FirstLetter,
    COUNT(*) AS NumberOfTransactions,
    SUM(o.CenaSprzedazy * o.Ilosc) AS TotalSales
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
GROUP BY LEFT(NazwaFirmy, 1);


-- 2. PIVOT (dla bazy BS)
-- Zadanie: Utw�rz raport sprzeda�y produkt�w, gdzie kolumny to kwarta�y, a wiersze to kategorie produkt�w.
USE BS
SELECT *
FROM
(
    SELECT 
        k.NazwaKategorii,
        'Q' + CONVERT(varchar, DATEPART(QUARTER, s.DataSprzedazy)) AS Quarter,
        o.CenaSprzedazy * o.Ilosc AS Sales
    FROM tblSprzedaz s
    JOIN tblOpisSprzedazy o ON s.ID_Sprzedaz = o.Sprzedaz_ID
    JOIN tblTowary t ON o.Towar_ID = t.ID_Towar
    JOIN tblKategorie k ON t.Kategoria_ID = k.ID_Kategoria
) src
PIVOT
(
    SUM(Sales)
    FOR Quarter IN ([Q1], [Q2], [Q3], [Q4])
) pvt;



-- 3. UNIA (Union) Baza BS
-- Zadanie: Po��cz list� klient�w i list� pracownik�w z ich adresami. Dla klient�w wy�wietl nazw� firmy, dla pracownik�w 
-- Pierwsz� liter� imienia i nazwisko: np. J.Kowalski
SELECT NazwaFirmy AS Name, Ulica AS Address FROM tblKlienci
UNION
SELECT LEFT(Imie,1)+ '. ' + Nazwisko AS Name, Adres FROM tblPracownicy;

-- 5. Tworzenie procedury sk�adowanej dla bazy danych HM
-- Zadanie: Procedura, kt�ra zwraca sum� sprzeda�y dla danego klienta.
USE HM
CREATE PROCEDURE dbo.GetTotalSalesByCustomer 
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON; -- Zapobiega zwracaniu dodatkowych informacji o liczbie wierszy

    SELECT SUM(pf.CenaSprz * pf.Ilosc) AS TotalSales
    FROM tbFaktury f
    JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
    WHERE f.KlientID = @CustomerID;
END;
GO

-- 6
USE BS
SELECT  t.NazwaTowaru, ROUND(t.Cena_Katalogowa - AVG(os.CenaSprzedazy),2) as diff,
	RANK() OVER (ORDER BY t.Cena_Katalogowa - AVG(os.CenaSprzedazy)) AS lp
FROM tblOpisSprzedazy os
JOIN tblTowary t ON t.ID_Towar = os.Towar_ID
GROUP BY t.NazwaTowaru, t.Cena_Katalogowa
ORDER BY diff
