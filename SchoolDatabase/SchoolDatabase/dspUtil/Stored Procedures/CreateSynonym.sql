CREATE PROC [dspUtil].[CreateSynonym]
	@SchemaName TSTRING, @SynonymName TSTRING, @ObjectName TSTRING
AS
BEGIN
	DECLARE @sql TSTRING;

	-- drop if already exists
	SET @sql = 'DROP SYNONYM IF EXISTS ' + @SchemaName + '.' + @SynonymName;
	EXEC (@sql);

	-- create synonym
	SET @sql = 'CREATE SYNONYM ' + @SchemaName + '.' + @SynonymName + ' FOR ' + @ObjectName;
	EXEC (@sql);
END;