USE [HM]
GO

/****** Object:  StoredProcedure [dbo].[OdswiezFakturyUwagi]    Script Date: 04.06.2024 08:09:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OdswiezFakturyUwagi]
AS
BEGIN
;WITH AggregatedData AS (
    SELECT 
        p.FakturaID,
        STRING_AGG(CAST(t.IDTowaru AS NVARCHAR(MAX)), '; ') AS TowaryIDs
    FROM 
        tbPozycjeFaktur p
    JOIN 
        tbTowary t ON t.IDTowaru = p.TowarID
    GROUP BY 
        p.FakturaID
)
UPDATE f
SET 
    f.Uwagi = ad.TowaryIDs
FROM 
    tbFaktury f
JOIN 
    AggregatedData ad ON f.IDFaktury = ad.FakturaID;
END
GO


