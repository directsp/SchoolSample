CREATE PROCEDURE [dspUtil].[LogEnable]
    @RemoveAllFilters AS BIT = 0
AS
BEGIN
	SET @RemoveAllFilters = ISNULL(@RemoveAllFilters, 0);

	-- install log system if it is not installed
	IF (dspUtil.LogIsInstalled()=0)
		EXEC dspUtil.LogInstall;

	-- Set enable flag
	IF NOT EXISTS(SELECT 1 FROM dspUtil.LogUser AS LU WHERE LU.UserName = SYSTEM_USER)
		INSERT dspUtil.LogUser ( UserName, IsEnabled )	VALUES  ( SYSTEM_USER, 1);
	ELSE 
		UPDATE dspUtil.LogUser SET	IsEnabled = 1 WHERE UserName = SYSTEM_USER;
	PRINT 'LogSystem> LogSystem has been enabled.';

	-- Remove All old filters
	IF (@RemoveAllFilters = 1)
	BEGIN
		EXEC dspUtil.LogRemoveFilter @Filter = NULL;
	END

END