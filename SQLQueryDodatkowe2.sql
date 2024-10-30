
-- Zadanie 1: Znajd� najdro�szy towar w ka�dej kategorii 

-- Zadanie 2: Wybierz towary, kt�rych cena katalogowa przekracza 20, a nazwa zaczyna si� od litery 'W'

-- Zadanie 3: Poka� liczb� towar�w w ka�dej kategorii

-- Zadanie 4: Znajd� klient�w, kt�rzy dokonali zakupu wi�cej ni� raz w danym miesi�cu (np. stycze�)

-- Zadanie 5: Wy�wietl nazwy firm i sum� ich zakup�w, posortuj od najwi�kszej sumy

-- Zadanie 6: Znajd� pracownik�w, kt�rzy obs�u�yli wi�cej ni� 10 transakcji

-- Zadanie 7: Wy�wietl nazwy towar�w, kt�re nie zosta�y jeszcze sprzedane (u�yj LEFT JOIN)

-- Zadanie 8: Dla ka�dej kategorii wy�wietl �redni� cen� towar�w

-- Zadanie 9: Wybierz klient�w, kt�rzy kupili towary o ��cznej warto�ci wi�kszej ni� �rednia warto�� 
-- zakup�w (u�yj subzapyta�)



-- Rozwi�zania na dole pliku:
































-- Zadanie 1: Znajd� najdro�szy towar w ka�dej kategorii 
SELECT k.NazwaKategorii, MAX(t.Cena_Katalogowa) AS NajwyzszaCena
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 2: Wybierz towary, kt�rych cena katalogowa przekracza 20,
-- a nazwa zaczyna si� od litery 'W'
SELECT NazwaTowaru, Cena_Katalogowa
FROM tblTowary
WHERE Cena_Katalogowa > 20 AND NazwaTowaru LIKE 'W%';

-- Zadanie 3: Poka� liczb� towar�w w ka�dej kategorii
SELECT k.NazwaKategorii, COUNT(t.ID_Towar) AS LiczbaTowarow
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 4: Znajd� klient�w, kt�rzy dokonali zakupu wi�cej ni� raz w danym miesi�cu (np. stycze�)
SELECT k.NazwaFirmy, COUNT(s.ID_Sprzedaz) AS LiczbaZakupow
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
WHERE MONTH(s.DataSprzedazy) = 1 -- Stycze�
GROUP BY k.NazwaFirmy
HAVING COUNT(s.ID_Sprzedaz) > 1;


-- Zadanie 5: Wy�wietl nazwy firm i sum� ich zakup�w, posortuj od najwi�kszej sumy
SELECT k.NazwaFirmy, SUM(os.CenaSprzedazy * os.Ilosc) AS SumaZakupow
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
GROUP BY k.NazwaFirmy
ORDER BY SumaZakupow DESC;

-- Zadanie 6: Znajd� pracownik�w, kt�rzy obs�u�yli wi�cej ni� 10 transakcji
SELECT p.Imie, p.Nazwisko, COUNT(s.ID_Sprzedaz) AS LiczbaTransakcji
FROM tblPracownicy p
JOIN tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID
GROUP BY p.Imie, p.Nazwisko
HAVING COUNT(s.ID_Sprzedaz) > 10;

-- Zadanie 7: Wy�wietl nazwy towar�w, kt�re nie zosta�y jeszcze sprzedane (u�yj LEFT JOIN)
SELECT t.NazwaTowaru
FROM tblTowary t
LEFT JOIN tblOpisSprzedazy os ON t.ID_Towar = os.Towar_ID
WHERE os.Towar_ID IS NULL;

-- Zadanie 8: Dla ka�dej kategorii wy�wietl �redni� cen� towar�w
SELECT k.NazwaKategorii, AVG(t.Cena_Katalogowa) AS SredniaCena
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 9: Wybierz klient�w, kt�rzy kupili towary o ��cznej warto�ci wi�kszej ni� �rednia warto�� zakup�w (u�yj subzapytania)
SELECT k.NazwaFirmy
FROM tblKlienci k
WHERE (SELECT SUM(os.CenaSprzedazy * os.Ilosc)
       FROM tblSprzedaz s
       JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
       WHERE k.ID_Klient = s.Klient_ID) > 
      (SELECT AVG(SumaZakupow) FROM 
       (SELECT SUM(os.CenaSprzedazy * os.Ilosc) AS SumaZakupow
        FROM tblSprzedaz s
        JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
        GROUP BY s.Klient_ID) AS AvgPurchases);
