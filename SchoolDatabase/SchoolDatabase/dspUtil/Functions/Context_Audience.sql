CREATE FUNCTION [dspUtil].[Context_Audience] (@Context TCONTEXT)
RETURNS TSTRING
AS
BEGIN
    RETURN JSON_VALUE(@Context, '$.Audience');
END;