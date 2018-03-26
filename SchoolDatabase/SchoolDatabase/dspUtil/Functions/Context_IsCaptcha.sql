CREATE FUNCTION [dspUtil].[Context_IsCaptcha] (@Context TCONTEXT)
RETURNS BIT
AS
BEGIN
	RETURN ISNULL(JSON_VALUE(@Context, '$.InvokeOptions.IsCaptcha'), 0);
END;