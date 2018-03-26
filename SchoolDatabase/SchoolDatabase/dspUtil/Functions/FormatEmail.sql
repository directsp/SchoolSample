CREATE FUNCTION [dspUtil].[FormatEmail] (
	@Email TSTRING)
RETURNS TSTRING
AS
BEGIN
	SET @Email = dspUtil.FormatString(@Email);
	RETURN IIF(dspUtil.IsValidEmailFormat(@Email) = 1, @Email, NULL);
END;