CREATE FUNCTION [dspUtil].[FormatNationalNumber] (
	@NationalNumber TSTRING)
RETURNS TSTRING
AS
BEGIN
	SET @NationalNumber = REPLACE(dspUtil.FormatString(@NationalNumber), '-', '');
	RETURN IIF(ISNUMERIC(@NationalNumber) = 1 AND LEN(@NationalNumber) = 10, @NationalNumber, NULL);
END;