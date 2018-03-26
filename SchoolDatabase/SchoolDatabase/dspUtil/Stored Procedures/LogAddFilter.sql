CREATE PROCEDURE [dspUtil].[LogAddFilter]
    @Filter TSTRING = NULL,
    @IsExclude BIT = 0
AS
BEGIN
	SET NOCOUNT ON;
	SET @IsExclude = ISNULL(@IsExclude, 0);

	-- Enable the Log System
	IF (dspUtil.LogIsEnabled() = 0)
		EXEC dspUtil.LogEnable;
	
	-- Clear Filters
	IF (@Filter IS NULL AND @IsExclude = 1)
	BEGIN
		DELETE dspUtil.LogFilterSetting WHERE UserName = SYSTEM_USER AND IsExludedFilter = 1;
		PRINT 'LogSystem> All exclude filters have been removed.';
		RETURN;
	END

	IF (@Filter IS NULL AND @IsExclude = 0)
	BEGIN
		DELETE dspUtil.LogFilterSetting WHERE UserName = SYSTEM_USER AND IsExludedFilter = 0;
		PRINT 'LogSystem> All include filters have been removed.';
		RETURN;
	END

	-- Insert or Update Filters
	IF EXISTS( SELECT 1 FROM dspUtil.LogFilterSetting AS LFS WHERE LFS.LogFilter = @Filter)
	BEGIN
		UPDATE dspUtil.LogFilterSetting SET IsExludedFilter = @IsExclude WHERE LogFilter = @Filter AND UserName = SYSTEM_USER;
		PRINT 'LogSystem> Filter has been updated.';
	END
	ELSE 
	BEGIN
		INSERT dspUtil.LogFilterSetting ( UserName, IsExludedFilter, LogFilter )
		VALUES  (SYSTEM_USER, @IsExclude, @Filter);
		PRINT 'LogSystem> Filter has been added.';
	END

END