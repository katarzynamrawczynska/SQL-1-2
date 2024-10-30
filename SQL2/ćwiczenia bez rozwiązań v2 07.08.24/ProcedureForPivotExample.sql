CREATE PROCEDURE [dbo].[OdswiezFakturyUwagi]
AS
BEGIN
;WITH AggregatedData AS (
    SELECT 
        p.FakturaID,
        STRING_AGG(CAST(t.IDTowaru AS NVARCHAR(MAX)), '; ') AS TowaryIDs
    FROM  tbPozycjeFaktur p
    JOIN  tbTowary t ON t.IDTowaru = p.TowarID
    GROUP BY p.FakturaID
)
UPDATE f
SET  f.Uwagi = ad.TowaryIDs
FROM  tbFaktury f
JOIN  AggregatedData ad ON f.IDFaktury = ad.FakturaID;
END
GO