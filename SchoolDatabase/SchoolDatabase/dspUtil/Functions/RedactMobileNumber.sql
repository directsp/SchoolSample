CREATE FUNCTION [dspUtil].[RedactMobileNumber] (@MobileNumber TSTRING)
RETURNS TSTRING
BEGIN
	SET @MobileNumber = dspUtil.FormatMobileNumber(@MobileNumber);
	IF (@MobileNumber IS NOT NULL)
		RETURN '*********' + SUBSTRING(@MobileNumber, LEN(@MobileNumber) - 1, 2);

	RETURN NULL;
END;