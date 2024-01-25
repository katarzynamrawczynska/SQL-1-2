-- Zadanie 1: Wybierz nazw� firmy i telefon klient�w, kt�rych kod pocztowy zaczyna si� na '00' i s� aktywni.

-- Zadanie 2: Wy�wietl unikalne nazwy towar�w, kt�rych cena jest ni�sza b�d� r�wna od 20, a kategoria to nie 4

-- Zadanie 3: Wybierz 3 pracownik�w z najd�u�szymi nazwiskami (sortowanie po d�ugo�ci nazwiska LEN).

-- Zadanie 4: Wybierz id sprzeda�y, dat� i id firm dla faktur wystawionych mi�dzy poniedzia�kiem a �rod� ( DATEPART(dw, DataSprzedazy) , gdzie 1 - Niedziela, 7 - Sobota)

-- Zadanie 5: Wybierz wszystkie towary, kt�rych nazwa zawiera 'y' lub 'b' i cena jest mi�dzy 2 a 10 z�.

-- Zadanie 6: Wybierz ID klienta i nazw� firmy tych, kt�rzy maj� zar�wno telefon stacjonarny, jak i kom�rkowy.

-- Zadanie 7: Wybierz pracownik�w, kt�rzy mieszkaj� w Warszawie, ale ich adres nie zawiera s�owa 'ulica'.

-- Zadanie 8: Wybierz nazwiska i miasta pracownik�w, kt�rych nazwisko ko�czy si� na 'ski' lub 'ska'.

-- Zadanie 9: Wybierz 5 najnowszych sprzeda�y (wed�ug daty).

-- Zadanie 10: Wybierz nazwiska pracownik�w, kt�rych imi� zaczyna si� na 'J' i pracuj� w mie�cie zaczynaj�cym si� na 'W'.

-- Zadanie 11: Wybierz towary z cen� katalogow� wy�sz� ni� 10 z� i nazw� zawieraj�c� co najmniej trzy 'a'.

-- Zadanie 12: Wybierz klient�w, kt�rzy nie maj� podanego telefonu kom�rkowego, ale ich NIP zaczyna si� od '1'.

-- Zadanie 13: Wybierz 3 najta�sze towary, kt�re nie nale�� do kategorii 1 i 2. Cen� zaokr�glij do jednego miejsca po przecinku (ROUND)

-- Zadanie 14: Wybierz nazwy firm klient�w dla klient ID mi�dzy 5 a 22 lub: 3,25,1


-- ODPOWIEDZI PONI�EJ:
























































-- Zadanie 1: Wybierz nazw� firmy i telefon klient�w, kt�rych kod pocztowy zaczyna si� na '00' i s� aktywni.
SELECT NazwaFirmy, Telefon FROM tblKlienci WHERE Kod LIKE '00%' AND Aktywny = 1;

-- Zadanie 2: Wy�wietl unikalne nazwy towar�w, kt�rych cena jest ni�sza b�d� r�wna od 20, a kategoria to nie 4
SELECT DISTINCT NazwaTowaru FROM tblTowary WHERE Cena_Katalogowa <= 20 AND Kategoria_ID != 4;

-- Zadanie 3: Wybierz 3 pracownik�w z najd�u�szymi nazwiskami (sortowanie po d�ugo�ci nazwiska LEN()).
SELECT TOP 3 Imie, Nazwisko FROM tblPracownicy ORDER BY LEN(Nazwisko) DESC;

-- Zadanie 4: Wybierz id sprzeda�y, dat� i id firm dla faktur wystawionych mi�dzy poniedzia�kiem a �rod� ( DATEPART(dw, DataSprzedazy) , gdzie 1 - Niedziela, 7 - Sobota)
SELECT Klient_ID, ID_Sprzedaz FROM tblSprzedaz WHERE DATEPART(dw, DataSprzedazy) BETWEEN 2 AND 4;

-- Zadanie 5: Wybierz wszystkie towary, kt�rych nazwa zawiera 'y' lub 'b' i cena jest mi�dzy 2 a 10 z�.
SELECT NazwaTowaru FROM tblTowary WHERE (NazwaTowaru LIKE '%y%' OR NazwaTowaru LIKE '%b%') AND Cena_Katalogowa BETWEEN 2 AND 10;

-- Zadanie 6: Wybierz ID klienta i nazw� firmy tych, kt�rzy maj� zar�wno telefon stacjonarny, jak i kom�rkowy.
SELECT ID_Klient, NazwaFirmy FROM tblKlienci WHERE Telefon IS NOT NULL AND TelefonKomorkowy IS NOT NULL;

-- Zadanie 7: Wybierz pracownik�w, kt�rzy mieszkaj� w Warszawie, ale ich adres nie zawiera s�owa 'ulica'.
SELECT Imie, Nazwisko FROM tblPracownicy WHERE Miasto = 'Warszawa' AND Adres NOT LIKE '%ulica%';

-- Zadanie 8: Wybierz nazwiska i miasta pracownik�w, kt�rych nazwisko ko�czy si� na 'ski' lub 'ska'.
SELECT Nazwisko, Miasto FROM tblPracownicy WHERE Nazwisko LIKE '%ski' OR Nazwisko LIKE '%ska';

-- Zadanie 9: Wybierz 5 najnowszych sprzeda�y (wed�ug daty).
SELECT TOP 5 ID_Sprzedaz FROM tblSprzedaz  ORDER BY DataSprzedazy DESC;

-- Zadanie 10: Wybierz nazwiska pracownik�w, kt�rych imi� zaczyna si� na 'J' i pracuj� w mie�cie zaczynaj�cym si� na 'W'.
SELECT Nazwisko FROM tblPracownicy WHERE Imie LIKE 'J%' AND Miasto LIKE 'W%';

-- Zadanie 11: Wybierz towary z cen� katalogow� wy�sz� ni� 10 z� i nazw� zawieraj�c� co najmniej trzy 'a'.
SELECT NazwaTowaru FROM tblTowary WHERE Cena_Katalogowa > 10 AND NazwaTowaru LIKE '%a%a%a%';

-- Zadanie 12: Wybierz klient�w, kt�rzy nie maj� podanego telefonu kom�rkowego, ale ich NIP zaczyna si� od '1'.
SELECT NazwaFirmy FROM tblKlienci WHERE TelefonKomorkowy IS NULL AND NIP LIKE '1%';

-- Zadanie 13: Wybierz 3 najta�sze towary, kt�re nie nale�� do kategorii 1 i 2. Cen� zaokr�glij do jednego miejsca po przecinku (ROUND)
SELECT TOP 3 NazwaTowaru, Cena_Katalogowa FROM tblTowary WHERE Kategoria_ID NOT IN (1, 2) ORDER BY Cena_Katalogowa ASC;

-- Zadanie 14: Wybierz nazwy firm klient�w dla klient ID mi�dzy 5 a 22 lub: 3,25,1
SELECT NazwaFirmy FROM tblKlienci WHERE ID_Klient BETWEEN 5 and 22 OR ID_Klient IN (3,25,1);
