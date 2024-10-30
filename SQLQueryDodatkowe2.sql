
-- Zadanie 1: ZnajdŸ najdro¿szy towar w ka¿dej kategorii 

-- Zadanie 2: Wybierz towary, których cena katalogowa przekracza 20, a nazwa zaczyna siê od litery 'W'

-- Zadanie 3: Poka¿ liczbê towarów w ka¿dej kategorii

-- Zadanie 4: ZnajdŸ klientów, którzy dokonali zakupu wiêcej ni¿ raz w danym miesi¹cu (np. styczeñ)

-- Zadanie 5: Wyœwietl nazwy firm i sumê ich zakupów, posortuj od najwiêkszej sumy

-- Zadanie 6: ZnajdŸ pracowników, którzy obs³u¿yli wiêcej ni¿ 10 transakcji

-- Zadanie 7: Wyœwietl nazwy towarów, które nie zosta³y jeszcze sprzedane (u¿yj LEFT JOIN)

-- Zadanie 8: Dla ka¿dej kategorii wyœwietl œredni¹ cenê towarów

-- Zadanie 9: Wybierz klientów, którzy kupili towary o ³¹cznej wartoœci wiêkszej ni¿ œrednia wartoœæ 
-- zakupów (u¿yj subzapytañ)



-- Rozwi¹zania na dole pliku:
































-- Zadanie 1: ZnajdŸ najdro¿szy towar w ka¿dej kategorii 
SELECT k.NazwaKategorii, MAX(t.Cena_Katalogowa) AS NajwyzszaCena
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 2: Wybierz towary, których cena katalogowa przekracza 20,
-- a nazwa zaczyna siê od litery 'W'
SELECT NazwaTowaru, Cena_Katalogowa
FROM tblTowary
WHERE Cena_Katalogowa > 20 AND NazwaTowaru LIKE 'W%';

-- Zadanie 3: Poka¿ liczbê towarów w ka¿dej kategorii
SELECT k.NazwaKategorii, COUNT(t.ID_Towar) AS LiczbaTowarow
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 4: ZnajdŸ klientów, którzy dokonali zakupu wiêcej ni¿ raz w danym miesi¹cu (np. styczeñ)
SELECT k.NazwaFirmy, COUNT(s.ID_Sprzedaz) AS LiczbaZakupow
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
WHERE MONTH(s.DataSprzedazy) = 1 -- Styczeñ
GROUP BY k.NazwaFirmy
HAVING COUNT(s.ID_Sprzedaz) > 1;


-- Zadanie 5: Wyœwietl nazwy firm i sumê ich zakupów, posortuj od najwiêkszej sumy
SELECT k.NazwaFirmy, SUM(os.CenaSprzedazy * os.Ilosc) AS SumaZakupow
FROM tblKlienci k
JOIN tblSprzedaz s ON k.ID_Klient = s.Klient_ID
JOIN tblOpisSprzedazy os ON s.ID_Sprzedaz = os.Sprzedaz_ID
GROUP BY k.NazwaFirmy
ORDER BY SumaZakupow DESC;

-- Zadanie 6: ZnajdŸ pracowników, którzy obs³u¿yli wiêcej ni¿ 10 transakcji
SELECT p.Imie, p.Nazwisko, COUNT(s.ID_Sprzedaz) AS LiczbaTransakcji
FROM tblPracownicy p
JOIN tblSprzedaz s ON p.IDPracownika = s.Pracownik_ID
GROUP BY p.Imie, p.Nazwisko
HAVING COUNT(s.ID_Sprzedaz) > 10;

-- Zadanie 7: Wyœwietl nazwy towarów, które nie zosta³y jeszcze sprzedane (u¿yj LEFT JOIN)
SELECT t.NazwaTowaru
FROM tblTowary t
LEFT JOIN tblOpisSprzedazy os ON t.ID_Towar = os.Towar_ID
WHERE os.Towar_ID IS NULL;

-- Zadanie 8: Dla ka¿dej kategorii wyœwietl œredni¹ cenê towarów
SELECT k.NazwaKategorii, AVG(t.Cena_Katalogowa) AS SredniaCena
FROM tblKategorie k
JOIN tblTowary t ON k.ID_Kategoria = t.Kategoria_ID
GROUP BY k.NazwaKategorii;

-- Zadanie 9: Wybierz klientów, którzy kupili towary o ³¹cznej wartoœci wiêkszej ni¿ œrednia wartoœæ zakupów (u¿yj subzapytania)
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
