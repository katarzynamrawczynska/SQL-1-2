SELECT MAX(cena) FROM tbTowary; 
-- Do powy¿szego nie da siê dodaæ niezgrupowanych pól
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

-- u¿ycie w JOIN z prefiltrowaniem - zbêdne dane s¹ odfiltrowane zanim nast¹pi po³¹czenie - mo¿e przyœpieszyæ 
-- czas wykonania, ale komplikuje sk³adnie

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
		 WHERE Ilosc > 5  -- Pre-filtrowanie danych; u¿yte by przyœpieszyæ wykonanie zapytania (mniej danych musi siê po³¹czyæ z drug¹ tabel¹)
		 GROUP BY  FakturaID
	) pf 
ON f.IDFaktury = pf.FakturaID;


/*æwiczenia*/
-- 1.  Wyœwietl wszystkie najœwie¿szej i najstarszej faktury w bazie (MAX i MIN(DataSprzed))
-- 2. W poni¿szym zapytaniu dodaj WHERE, który wybierze tylko te pozycje faktur, w których towar jest na noœniku CD
SELECT SUM(pf.CenaSprz)
FROM tbFaktury f
JOIN tbPozycjeFaktur pf ON f.IDFaktury = pf.FakturaID
-- WHERE .... IN (subselect)
GROUP BY pf.FakturaID
-- 3. Napisz zapytanie, które wyci¹ga dane faktur z 2005 roku. Gotowe zapytanie po³¹cz jako subselect z tabel¹ 
-- pozycje faktur, oraz towary. Z podanych wyœwietl datê faktury (z podzapytania z fakturami), nazwê wykonawcy 
-- i albumu(towary), oraz cenê sprzeda¿y (pozycje faktur)


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


