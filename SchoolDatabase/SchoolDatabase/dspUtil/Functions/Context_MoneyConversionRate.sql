CREATE FUNCTION [dspUtil].[Context_MoneyConversionRate] (@Context TCONTEXT)
RETURNS FLOAT
AS
BEGIN
	RETURN ISNULL(JSON_VALUE(@Context, '$.InvokeOptions.MoneyConversionRate'), 1);
END;