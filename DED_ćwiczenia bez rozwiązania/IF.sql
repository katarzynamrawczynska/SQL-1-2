DECLARE @MIN INT=1; 
DECLARE @MAX INT=4; 

DECLARE @Value int = (SELECT @MIN+FLOOR((@MAX-@MIN+1)*RAND(CONVERT(VARBINARY,NEWID()))))
SELECT @Value


IF @Value = 1 --Argument 1
BEGIN --Block 1
 PRINT 'first option'
END
ELSE IF @Value = 2  --Argument 2
BEGIN --Block 2
 PRINT 'second option'
END
ELSE  -- In all other cases
BEGIN --Block 3
 PRINT 'Other Value: ' +  @Value
END --Final End
