-- Create Procedure ThrowAppException

CREATE PROCEDURE [dspUtil].[ThrowAppException]
	@ProcId INT = NULL, @ExceptionId INT, @Message TSTRING = NULL, @Param0 TSTRING = '<notset>', @Param1 TSTRING = '<notset>', @Param2 TSTRING = '<notset>',
	@Param3 TSTRING = '<notset>'
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Exception TJSON;
	EXEC dspUtil.FormatException @ProcId = @ProcId, @ExceptionId = @ExceptionId, @Message = @Message, @Param0 = @Param0, @Param1 = @Param1, @Param2 = @Param2,
		@Param3 = @Param3, @Exception = @Exception OUTPUT;
	EXEC dspUtil.ThrowException @Exception = @Exception;

END;