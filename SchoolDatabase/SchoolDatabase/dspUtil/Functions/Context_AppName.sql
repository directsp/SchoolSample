CREATE FUNCTION [dspUtil].[Context_AppName] (@Context TCONTEXT)
RETURNS BIT
AS
BEGIN
    RETURN JSON_VALUE(@Context, '$.AppName');
END;