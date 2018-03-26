

CREATE FUNCTION [dspUtil].[FormatNumeric] (@NumberStr TSTRING)
RETURNS TSTRING
AS
BEGIN
	RETURN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@NumberStr, '*', ''), '-', ''), '_', ''), '/', ''), ' ', ''), '#', '');
END;