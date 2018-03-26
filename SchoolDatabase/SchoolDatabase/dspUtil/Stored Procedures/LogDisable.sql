-- Stop Logging System but keep settings
CREATE PROCEDURE [dspUtil].[LogDisable]
AS
BEGIN
	IF (dspUtil.LogIsInstalled()=0)
	BEGIN
		PRINT 'LogSystem> LogSystem has not been installed. LogSystem is disabled.';
		RETURN;
	END

	-- Set enable flag
	UPDATE dspUtil.LogUser SET	IsEnabled = 0 WHERE UserName = SYSTEM_USER;
	PRINT 'LogSystem> LogSystem has been disbaled.';
END