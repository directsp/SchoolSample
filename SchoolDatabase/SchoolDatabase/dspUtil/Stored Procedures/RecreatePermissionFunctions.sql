-- Create Procedure RecreatePermissionFunctions

CREATE PROC [dspUtil].[RecreatePermissionFunctions]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PermissionId INT;
	DECLARE @ObjectName TSTRING;
	DECLARE @DdlText TSTRING = '';

	-- Drop const Functions
	EXEC dspUtil.DropSchemaObjects @SchemaName = N'prms', @DropFunctions = 1;

	-- Recreate Permissions Functions
	DECLARE LocalCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR SELECT	P.PermissionName AS Name, P.PermissionId FROM dbo.Permission AS P;
	OPEN LocalCursor;
	FETCH NEXT FROM LocalCursor
	INTO @ObjectName, @PermissionId;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @DdlText = '
CREATE FUNCTION prms.{ObjectName}()
RETURNS INT WITH SCHEMABINDING
AS
BEGIN
	RETURN {PermissionId};  
END
'	;
		SET @DdlText = REPLACE(@DdlText, '{ObjectName}', @ObjectName);
		SET @DdlText = REPLACE(@DdlText, '{PermissionId}', @PermissionId);

		EXEC sys.sp_executesql @DdlText;
		FETCH NEXT FROM LocalCursor
		INTO @ObjectName, @PermissionId;
	END;
	CLOSE LocalCursor;
	DEALLOCATE LocalCursor;
END;