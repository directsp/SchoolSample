CREATE FUNCTION [dspUtil].[Context_RecordCount] (@Context TCONTEXT)
RETURNS INT 
AS
BEGIN
	RETURN JSON_VALUE(@Context, '$.InvokeOptions.RecordCount');
END