

CREATE FUNCTION [dspUtil].[Context_UserId] (@Context TCONTEXT)
RETURNS INT 
AS
BEGIN
	RETURN JSON_VALUE(@Context, '$.User.UserId');
END