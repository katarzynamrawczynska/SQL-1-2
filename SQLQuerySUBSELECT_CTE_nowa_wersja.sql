SELECT MAX(cena) FROM tbTowary; 
-- Do powy�szego nie da si� doda� niezgrupowanych p�l
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary);

SELECT Miasto FROM tblPracownicy
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN 
	(SELECT Miasto FROM tblPracownicy)

SELECT os.Sprzedaz_ID, 
	t.NazwaTowaru,
	os.Ilosc,
	CenaSprzedazy - (SELECT AVG(CenaSprzedazy) FROM tblOpisSprzedazy) AS odchylenie
FROM tblOpisSprzedazy os
JOIN tblTowary t ON os.Towar_ID = t.ID_Towar 
order by odchylenie DESC

-- u�ycie w JOIN z prefiltrowaniem - zb�dne dane s� odfiltrowane zanim nast�pi po��czenie - mo�e przy�pieszy� 
-- czas wykonania, ale komplikuje sk�adnie

SELECT 
    f.IDFaktury,
    f.KlientID,
    pf.TotalCena
FROM 
    tbFaktury f
JOIN 
    (SELECT 
         FakturaID, 
         SUM(CenaSprz) AS TotalCena 
		 FROM tbPozycjeFaktur 
		 WHERE Ilosc > 5  -- Pre-filtrowanie danych; u�yte by przy�pieszy� wykonanie zapytania (mniej danych musi si� po��czy� z drug� tabel�)
		 GROUP BY  FakturaID
	) pf 
ON f.IDFaktury = pf.FakturaID;


/*�wiczenia*/
-- 1.  Wy�wietl wszystkie naj�wie�szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
-- 2. W poni�szym zapytaniu dodaj WHERE, kt�ry wybierze tylko te pozycje faktur, w kt�rych towar jest na no�niku CD
SELECT SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
-- WHERE .... IN (subselect)
GROUP BY pf.FakturaID
-- 3. Napisz zapytanie, kt�re wyci�ga dane faktur z 2005 roku. Gotowe zapytanie po��cz jako subselect z tabel� 
-- pozycje faktur, oraz towary. Z podanych wy�wietl dat� faktury (z podzapytania z fakturami), nazw� wykonawcy 
-- i albumu(towary), oraz cen� sprzeda�y (pozycje faktur)


/*CTE*/
-- wersja z subselect
SELECT cena , wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MAX(cena) FROM tbTowary);

-- wersja z CTE
WITH NajdrozszyTowar AS (
    SELECT MAX(cena) AS MaxCena
    FROM tbTowary
)
SELECT cena, wykonawca + ' - ' + tytul
FROM tbTowary
WHERE cena = (SELECT MaxCena FROM NajdrozszyTowar)

-- wersja z subselect
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN 
	(SELECT Miasto FROM tblPracownicy)
-- wersja z CTE
;WITH miasta_pracownicy AS(
SELECT miasto from tblPracownicy)
SELECT KodKlienta, Miasto FROM tblKlienci
WHERE Miasto IN (SELECT * FROM miasta_pracownicy)


