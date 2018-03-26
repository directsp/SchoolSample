

CREATE FUNCTION [dspUtil].[Context_AuthUserId] (@Context TCONTEXT)
RETURNS INT
AS
BEGIN
	RETURN JSON_VALUE(@Context, '$.User.AuthUserId');
END;