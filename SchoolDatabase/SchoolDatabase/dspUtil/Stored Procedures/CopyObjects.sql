CREATE PROC [dspUtil].[CopyObjects]
	@SourceDB TSTRING, @DestinationDB TSTRING, @SchemaName TSTRING
AS
BEGIN
	--Delete schema objects; left schema and its security info
	EXEC dspUtil.DropSchema @SchemaName = @SchemaName, @DbName = @DestinationDB, @IsDropObjectOnly = 1;

	-- Copy objects to destination
	DECLARE @ObjectName TSTRING;
	SET @ObjectName = @SourceDB + '.sys.objects';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'CopyObjects_objects', @ObjectName = @ObjectName;
	SET @ObjectName = @SourceDB + '.sys.schemas';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'CopyObjects_schemas', @ObjectName = @ObjectName;
	SET @ObjectName = @DestinationDB + '.sys.sp_executesql';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'CopyObjects_sp_executesql', @ObjectName = @ObjectName;

	-- Create shema on DestinationDB if does not exists
	BEGIN TRY
		DECLARE @Sql TSTRING = N'CREATE SCHEMA ' + @SchemaName;
		EXEC dspUtil.CopyObjects_sp_executesql @Sql;
	END TRY
	BEGIN CATCH
	END CATCH;

	-- first cursor for 'FN', 'P'
	DECLARE @definition TBIGSTRING;
	DECLARE CreateObjectsCursor CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT	OBJECT_DEFINITION(O.object_id)
	FROM	dspUtil.CopyObjects_objects AS O
			INNER JOIN dspUtil.CopyObjects_schemas AS S ON S.schema_id = O.schema_id
	WHERE	O.type IN ( 'FN', 'P' ) AND S.name = @SchemaName;

	OPEN CreateObjectsCursor;
	FETCH NEXT FROM CreateObjectsCursor
	INTO @definition;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXEC dspUtil.CopyObjects_sp_executesql @definition;
		FETCH NEXT FROM CreateObjectsCursor
		INTO @definition;
	END;
	CLOSE CreateObjectsCursor;
	DEALLOCATE CreateObjectsCursor;


	-- Second cursor for 'TF', 'IF' 
	SET @definition = NULL;
	DECLARE SecondCreateObjectsCursor CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT	OBJECT_DEFINITION(O.object_id)
	FROM	dspUtil.CopyObjects_objects AS O
			INNER JOIN dspUtil.CopyObjects_schemas AS S ON S.schema_id = O.schema_id
	WHERE	O.type IN ( 'TF', 'IF' ) AND S.name = @SchemaName;

	OPEN SecondCreateObjectsCursor;
	FETCH NEXT FROM SecondCreateObjectsCursor
	INTO @definition;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXEC dspUtil.CopyObjects_sp_executesql @definition;
		FETCH NEXT FROM SecondCreateObjectsCursor
		INTO @definition;
	END;
	CLOSE SecondCreateObjectsCursor;
	DEALLOCATE SecondCreateObjectsCursor;

	--Cleanup synonyms
	DROP SYNONYM dspUtil.CopyObjects_objects;
	DROP SYNONYM dspUtil.CopyObjects_schemas;
	DROP SYNONYM dspUtil.CopyObjects_sp_executesql;
END;