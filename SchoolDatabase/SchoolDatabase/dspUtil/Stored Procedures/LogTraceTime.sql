CREATE PROCEDURE [dspUtil].[LogTraceTime]
	@Time AS DATETIME OUT, @Tag TSTRING
AS
BEGIN
	SET @Time = ISNULL(@Time, GETDATE());
	DECLARE @TimeDiff INT = DATEDIFF(MILLISECOND, @Time, GETDATE());

	DECLARE @msg TSTRING;
	EXEC @msg = dspUtil.LogFormatMessage2 @ProcId = @@PROCID, @Message = '{0}: {1}', @Param0 = @Tag, @Param1 = @TimeDiff, @Elipsis = 0;
	PRINT @msg;

	SET @Time = GETDATE();
END;