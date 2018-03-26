CREATE FUNCTION [dspUtil].[RedactCardNumber] (@CardNumber TSTRING)
RETURNS TSTRING
AS
BEGIN
	SET @CardNumber = dspUtil.FormatString(@CardNumber);
	RETURN RIGHT(@CardNumber, 4) + REPLICATE('*', LEN(@CardNumber) - 4);
END;