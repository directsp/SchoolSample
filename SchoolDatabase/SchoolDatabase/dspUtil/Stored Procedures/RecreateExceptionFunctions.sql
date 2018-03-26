-- Create Procedure RecreateExceptionProcedures


CREATE PROC [dspUtil].[RecreateExceptionFunctions]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ExceptionId INT;
	DECLARE @ExceptionName TSTRING;
	DECLARE @DdlText TSTRING = '';

	-- Drop const Functions
	EXEC dspUtil.DropSchemaObjects @SchemaName = N'err', @DropFunctions = 1, @DropProcedures = 1;

	-- Recreate const Functions
	DECLARE LocalCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR SELECT	E.ExceptionId, E.ExceptionName AS Name FROM dbo.Exception AS E;
	OPEN LocalCursor;
	FETCH NEXT FROM LocalCursor
	INTO @ExceptionId, @ExceptionName;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @DdlText = '
CREATE FUNCTION err.{ExceptionName}Id()
	RETURNS INT WITH SCHEMABINDING 
AS
BEGIN
	RETURN {ExceptionId};
END 
'	;
		SET @DdlText = REPLACE(@DdlText, '{ExceptionName}', @ExceptionName);
		SET @DdlText = REPLACE(@DdlText, '{ExceptionId}', @ExceptionId);
		EXEC sys.sp_executesql @DdlText;

		-- Create Procedures
		SET @DdlText =
			'
CREATE PROC err.Throw{ExceptionName} @ProcId INT, @Message TSTRING = NULL, @Param0 TSTRING = ''<notset>'', @Param1 TSTRING = ''<notset>'', @Param2 TSTRING = ''<notset>'', @Param3 TSTRING = ''<notset>''
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ExceptionId INT = err.{ExceptionName}Id();
	EXEC dspUtil.ThrowAppException @ProcId = @ProcId, @ExceptionId = @ExceptionId, @Message = @Message, @Param0 = @Param0, @Param1 = @Param1, @Param2 = @Param2, @Param3 = @Param3;
END
'		;
		SET @DdlText = REPLACE(@DdlText, '{ExceptionName}', @ExceptionName);
		SET @DdlText = REPLACE(@DdlText, '{ExceptionId}', @ExceptionId);
		EXEC sys.sp_executesql @DdlText;

		FETCH NEXT FROM LocalCursor
		INTO @ExceptionId, @ExceptionName;
	END;
	CLOSE LocalCursor;
	DEALLOCATE LocalCursor;

END;