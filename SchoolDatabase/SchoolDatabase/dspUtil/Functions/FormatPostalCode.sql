CREATE FUNCTION [dspUtil].[FormatPostalCode] (@PostalCode TSTRING)
RETURNS TSTRING
AS
BEGIN
	SET @PostalCode = dspUtil.FormatString(@PostalCode);
	RETURN IIF(ISNUMERIC(@PostalCode) = 1 AND LEN(@PostalCode) = 10, @PostalCode, NULL);
END;