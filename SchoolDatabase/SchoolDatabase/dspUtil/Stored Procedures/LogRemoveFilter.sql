-- @Filter if NULL then all filter will be removed
CREATE PROCEDURE [dspUtil].[LogRemoveFilter]
    @Filter TSTRING = NULL
AS
BEGIN
	SET NOCOUNT ON;
	-- Enable the Log System
    IF ( dspUtil.LogIsEnabled() = 0 )
        EXEC dspUtil.LogEnable;

	-- Remove all filters
    IF ( @Filter IS NULL )
    BEGIN
        DELETE  dspUtil.LogFilterSetting
        WHERE   UserName = SYSTEM_USER;
        PRINT 'LogSystem> All filters have been removed.';
        RETURN;
    END;
	
	-- Remove the existing filter
    IF EXISTS ( SELECT 1 FROM dspUtil.LogFilterSetting AS LFS WHERE LFS.LogFilter = @Filter AND LFS.UserName = SYSTEM_USER )
    BEGIN
        DELETE  LogFilterSetting
        WHERE   LogFilter = @Filter AND UserName = SYSTEM_USER;
        PRINT 'LogSystem> Filter has been removed.';
        RETURN;
    END;
	
	-- Print not-find message
    PRINT 'LogSystem> Could not find the filter.';
END;