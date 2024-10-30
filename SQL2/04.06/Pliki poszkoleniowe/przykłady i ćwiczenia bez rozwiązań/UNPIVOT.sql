CREATE TABLE products_pivot (
Napoje float, Alkohole float, Piwo float, S³odycze float, 
		Owoce float, [Mleczne przetwory] float, [Zbo¿owe przetwory] float , Pieczywo float
)

INSERT INTO products_pivot
SELECT Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo 
FROM(
-- 2. kwerenda zwracaj¹ca kolumnê z tymi wartoœciami, oraz wartoœci¹ do agregacji
	SELECT NazwaKategorii, Cena_Katalogowa, t.NazwaTowaru
	FROM tblTowary t 	
	JOIN tblKategorie k  ON k.ID_Kategoria = t.Kategoria_ID) AS qr
-- 3. Okreœlenie agregacji dla ... tu znowu lista "nowych" kolumn
PIVOT 
	(SUM(Cena_Katalogowa) FOR NazwaKategorii IN 
		(Napoje, Alkohole, Piwo, S³odycze, 
		Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)) AS pv


SELECT * FROM products_pivot

SELECT 
    ProductCategory,
    Value
FROM 
    products_pivot
UNPIVOT 
(
    Value FOR ProductCategory IN (Napoje, Alkohole, Piwo, S³odycze, Owoce, [Mleczne przetwory], [Zbo¿owe przetwory], Pieczywo)
) AS unpvt;