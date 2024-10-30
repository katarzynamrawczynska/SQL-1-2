-- Zadanie 1: Wybierz nazwê firmy i telefon klientów, których kod pocztowy zaczyna siê na '00' i s¹ aktywni.

-- Zadanie 2: Wyœwietl unikalne nazwy towarów, których cena jest ni¿sza b¹dŸ równa od 20, a kategoria to nie 4

-- Zadanie 3: Wybierz 3 pracowników z najd³u¿szymi nazwiskami (sortowanie po d³ugoœci nazwiska LEN).

-- Zadanie 4: Wybierz id sprzeda¿y, datê i id firm dla faktur wystawionych miêdzy poniedzia³kiem a œrod¹ ( DATEPART(dw, DataSprzedazy) , gdzie 1 - Niedziela, 7 - Sobota)

-- Zadanie 5: Wybierz wszystkie towary, których nazwa zawiera 'y' lub 'b' i cena jest miêdzy 2 a 10 z³.

-- Zadanie 6: Wybierz ID klienta i nazwê firmy tych, którzy maj¹ zarówno telefon stacjonarny, jak i komórkowy.

-- Zadanie 7: Wybierz pracowników, którzy mieszkaj¹ w Warszawie, ale ich adres nie zawiera s³owa 'ulica'.

-- Zadanie 8: Wybierz nazwiska i miasta pracowników, których nazwisko koñczy siê na 'ski' lub 'ska'.

-- Zadanie 9: Wybierz 5 najnowszych sprzeda¿y (wed³ug daty).

-- Zadanie 10: Wybierz nazwiska pracowników, których imiê zaczyna siê na 'J' i pracuj¹ w mieœcie zaczynaj¹cym siê na 'W'.

-- Zadanie 11: Wybierz towary z cen¹ katalogow¹ wy¿sz¹ ni¿ 10 z³ i nazw¹ zawieraj¹c¹ co najmniej trzy 'a'.

-- Zadanie 12: Wybierz klientów, którzy nie maj¹ podanego telefonu komórkowego, ale ich NIP zaczyna siê od '1'.

-- Zadanie 13: Wybierz 3 najtañsze towary, które nie nale¿¹ do kategorii 1 i 2. Cenê zaokr¹glij do jednego miejsca po przecinku (ROUND)

-- Zadanie 14: Wybierz nazwy firm klientów dla klient ID miêdzy 5 a 22 lub: 3,25,1


-- ODPOWIEDZI PONI¯EJ:
























































-- Zadanie 1: Wybierz nazwê firmy i telefon klientów, których kod pocztowy zaczyna siê na '00' i s¹ aktywni.
SELECT NazwaFirmy, Telefon FROM tblKlienci WHERE Kod LIKE '00%' AND Aktywny = 1;

-- Zadanie 2: Wyœwietl unikalne nazwy towarów, których cena jest ni¿sza b¹dŸ równa od 20, a kategoria to nie 4
SELECT DISTINCT NazwaTowaru FROM tblTowary WHERE Cena_Katalogowa <= 20 AND Kategoria_ID != 4;

-- Zadanie 3: Wybierz 3 pracowników z najd³u¿szymi nazwiskami (sortowanie po d³ugoœci nazwiska LEN()).
SELECT TOP 3 Imie, Nazwisko FROM tblPracownicy ORDER BY LEN(Nazwisko) DESC;

-- Zadanie 4: Wybierz id sprzeda¿y, datê i id firm dla faktur wystawionych miêdzy poniedzia³kiem a œrod¹ ( DATEPART(dw, DataSprzedazy) , gdzie 1 - Niedziela, 7 - Sobota)
SELECT Klient_ID, ID_Sprzedaz FROM tblSprzedaz WHERE DATEPART(dw, DataSprzedazy) BETWEEN 2 AND 4;

-- Zadanie 5: Wybierz wszystkie towary, których nazwa zawiera 'y' lub 'b' i cena jest miêdzy 2 a 10 z³.
SELECT NazwaTowaru FROM tblTowary WHERE (NazwaTowaru LIKE '%y%' OR NazwaTowaru LIKE '%b%') AND Cena_Katalogowa BETWEEN 2 AND 10;

-- Zadanie 6: Wybierz ID klienta i nazwê firmy tych, którzy maj¹ zarówno telefon stacjonarny, jak i komórkowy.
SELECT ID_Klient, NazwaFirmy FROM tblKlienci WHERE Telefon IS NOT NULL AND TelefonKomorkowy IS NOT NULL;

-- Zadanie 7: Wybierz pracowników, którzy mieszkaj¹ w Warszawie, ale ich adres nie zawiera s³owa 'ulica'.
SELECT Imie, Nazwisko FROM tblPracownicy WHERE Miasto = 'Warszawa' AND Adres NOT LIKE '%ulica%';

-- Zadanie 8: Wybierz nazwiska i miasta pracowników, których nazwisko koñczy siê na 'ski' lub 'ska'.
SELECT Nazwisko, Miasto FROM tblPracownicy WHERE Nazwisko LIKE '%ski' OR Nazwisko LIKE '%ska';

-- Zadanie 9: Wybierz 5 najnowszych sprzeda¿y (wed³ug daty).
SELECT TOP 5 ID_Sprzedaz FROM tblSprzedaz  ORDER BY DataSprzedazy DESC;

-- Zadanie 10: Wybierz nazwiska pracowników, których imiê zaczyna siê na 'J' i pracuj¹ w mieœcie zaczynaj¹cym siê na 'W'.
SELECT Nazwisko FROM tblPracownicy WHERE Imie LIKE 'J%' AND Miasto LIKE 'W%';

-- Zadanie 11: Wybierz towary z cen¹ katalogow¹ wy¿sz¹ ni¿ 10 z³ i nazw¹ zawieraj¹c¹ co najmniej trzy 'a'.
SELECT NazwaTowaru FROM tblTowary WHERE Cena_Katalogowa > 10 AND NazwaTowaru LIKE '%a%a%a%';

-- Zadanie 12: Wybierz klientów, którzy nie maj¹ podanego telefonu komórkowego, ale ich NIP zaczyna siê od '1'.
SELECT NazwaFirmy FROM tblKlienci WHERE TelefonKomorkowy IS NULL AND NIP LIKE '1%';

-- Zadanie 13: Wybierz 3 najtañsze towary, które nie nale¿¹ do kategorii 1 i 2. Cenê zaokr¹glij do jednego miejsca po przecinku (ROUND)
SELECT TOP 3 NazwaTowaru, Cena_Katalogowa FROM tblTowary WHERE Kategoria_ID NOT IN (1, 2) ORDER BY Cena_Katalogowa ASC;

-- Zadanie 14: Wybierz nazwy firm klientów dla klient ID miêdzy 5 a 22 lub: 3,25,1
SELECT NazwaFirmy FROM tblKlienci WHERE ID_Klient BETWEEN 5 and 22 OR ID_Klient IN (3,25,1);
