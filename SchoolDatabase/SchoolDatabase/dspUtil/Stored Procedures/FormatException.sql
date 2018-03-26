﻿CREATE PROCEDURE [dspUtil].[FormatException]
	@ProcId INT = NULL, @ExceptionId INT, @Message TSTRING = NULL, @Param0 TSTRING = '<notset>', @Param1 TSTRING = '<notset>', @Param2 TSTRING = '<notset>',
	@Param3 TSTRING = '<notset>', @Exception TJSON = NULL OUT
AS
BEGIN
	SET NOCOUNT ON;

	-- get exception name and detail
	DECLARE @Text_en TSTRING;
	DECLARE @Name TSTRING;
	SELECT	@Text_en = Description, @Name = ExceptionName
	FROM	dbo.Exception
	WHERE	ExceptionId = @ExceptionId;

	-- validate exception Id
	IF (@Name IS NULL)
	BEGIN
		SET @Message = 'Inavlid AppExceptionId; ExceptionId: {0}';
		SET @Param0 = @ExceptionId;
		SET @ExceptionId = 55001;
	END;

	-- Replace Message
	EXEC @Message = dspUtil.FormatMessage @Message = @Message, @Param0 = @Param0, @Param1 = @Param1, @Param2 = @Param2, @Param3 = @Param3;

	-- generate exception
	SET @Exception = '{}';
	SET @Exception = JSON_MODIFY(@Exception, '$.errorId', @ExceptionId);
	SET @Exception = JSON_MODIFY(@Exception, '$.errorName', @Name);
	IF (@Text_en IS NOT NULL)
		SET @Exception = JSON_MODIFY(@Exception, '$.errorDescription', @Text_en);
	IF (@Text_en IS NOT NULL)
		SET @Exception = JSON_MODIFY(@Exception, '$.errorDescription', @Text_en);
	IF (@Message IS NOT NULL)
		SET @Exception = JSON_MODIFY(@Exception, '$.errorMessage', @Message);

	-- Set Schema and ProcName
	IF (@ProcId IS NOT NULL)
	BEGIN
		DECLARE @ProcName TSTRING = ISNULL(OBJECT_NAME(@ProcId), '(NoSP)');
		DECLARE @SchemaName TSTRING = OBJECT_SCHEMA_NAME(@ProcId);
		IF (@SchemaName IS NOT NULL)
			SET @ProcName = @SchemaName + '.' + @ProcName;
		SET @Exception = JSON_MODIFY(@Exception, '$.errorProcName', @ProcName);
	END;

END;