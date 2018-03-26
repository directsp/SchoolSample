
CREATE FUNCTION [dspUtil].[LogIsEnabled] ()
RETURNS BIT
AS
BEGIN
	IF (dspUtil.LogIsInstalled() = 0)
		RETURN 0;

	DECLARE @IsUserEnabled BIT;
	SELECT	@IsUserEnabled = LU.IsEnabled
	FROM		dspUtil.LogUser AS LU
	WHERE	LU.UserName = SYSTEM_USER;

	RETURN ISNULL(@IsUserEnabled, 0);
END;