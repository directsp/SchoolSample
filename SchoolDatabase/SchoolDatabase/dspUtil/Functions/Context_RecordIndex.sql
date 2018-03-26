CREATE FUNCTION [dspUtil].[Context_RecordIndex] (@Context TCONTEXT)
RETURNS INT 
AS
BEGIN
	RETURN JSON_VALUE(@Context, '$.InvokeOptions.RecordIndex');
END