CREATE FUNCTION [dspUtil].[Context_IsBatch] (@Context TCONTEXT)
RETURNS BIT
AS
BEGIN
	RETURN ISNULL(JSON_VALUE(@Context, '$.InvokeOptions.IsBatch'), 0);
END;