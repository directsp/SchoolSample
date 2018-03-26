CREATE PROCEDURE [dspUtil].[LogTrace]
	@ProcId AS INT, @Message AS TSTRING, @Param0 AS TSTRING = '<notset>', @Param1 AS TSTRING = '<notset>', @Param2 AS TSTRING = '<notset>',
	@Param3 AS TSTRING = '<notset>', @Param4 AS TSTRING = '<notset>', @Param5 AS TSTRING = '<notset>', @Elipse BIT = 1, @IsHeader BIT = 0
AS
BEGIN
	IF (dspUtil.LogIsEnabled() = 0)
		RETURN;

	-- Format Message
	DECLARE @Msg TSTRING = dspUtil.LogFormatMessage2(@ProcId, @Message, @Elipse, @Param0, @Param1, @Param2, @Param3, @Param4, @Param5);

	-- Manage header
	IF (@IsHeader = 1)
		SET @Msg = dspUtil.String_ReplaceEnter(N'\n-----------------------\n-- ' + @Msg + N'\n-----------------------');

	-- Check Filter
	IF (dspUtil.LogCheckFilters(@Msg) = 0)
		RETURN;

	-- Print with Black Color
	-- PRINT @Msg;
	RAISERROR(@Msg, 0, 1) WITH NOWAIT; -- force to flush the buffer
END;