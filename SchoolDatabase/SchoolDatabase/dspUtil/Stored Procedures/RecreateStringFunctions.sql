-- Create Procedure RecreateStringFunctions


CREATE PROC [dspUtil].[RecreateStringFunctions]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Text_en TSTRING;
	DECLARE @StringName TSTRING;
	DECLARE @DdlText TSTRING = '';

	--Drop String Functions
	EXEC dspUtil.DropSchemaObjects @SchemaName = N'str', @DropFunctions = 1;

	-- Recreate Srtring Functions
	DECLARE LocalCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR SELECT	ST.StringTableName AS Name, ST.Text_en FROM dbo.StringTable AS ST;
	OPEN LocalCursor;
	FETCH NEXT FROM LocalCursor
	INTO @StringName, @Text_en;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @DdlText = '
CREATE FUNCTION str.{StringName}() 
RETURNS TSTRING
AS 
BEGIN
	RETURN dspUtil.StringTable_Text(''{StringName}'');
END';
		SET @DdlText = REPLACE(@DdlText, '{StringName}', @StringName);
		EXEC sys.sp_executesql @DdlText;
		FETCH NEXT FROM LocalCursor
		INTO @StringName, @Text_en;
	END;
	CLOSE LocalCursor;
	DEALLOCATE LocalCursor;
END;