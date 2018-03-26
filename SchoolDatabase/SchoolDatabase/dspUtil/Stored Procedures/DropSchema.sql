
-- license: t-SQLt.DropClass
CREATE PROCEDURE [dspUtil].[DropSchema]
    @SchemaName TSTRING , @DbName TSTRING = NULL, @IsDropObjectOnly BIT = 0
AS
BEGIN
    DECLARE @Cmd TBIGSTRING;
	SET @DbName = ISNULL(dspUtil.FormatString(@DbName), DB_NAME());
	SET @IsDropObjectOnly = ISNULL(@IsDropObjectOnly, 0);

	DECLARE @ObjectName TSTRING;
	SET @ObjectName = @DbName + '.sys.objects';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'DropSchema_objects', @ObjectName = @ObjectName;
	SET @ObjectName = @DbName + '.sys.types';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'DropSchema_types', @ObjectName = @ObjectName;
	SET @ObjectName = @DbName + '.sys.schemas';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'DropSchema_schemas', @ObjectName = @ObjectName;
	SET @ObjectName = @DbName + '.sys.xml_schema_collections';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'DropSchema_xml_schema_collections', @ObjectName = @ObjectName;
	SET @ObjectName = @DbName + '.sys.sp_executesql';
	EXEC dspUtil.CreateSynonym @SchemaName = 'dspUtil', @SynonymName = 'DropSchema_sp_executesql', @ObjectName = @ObjectName;

    WITH ObjectInfo(name, type) AS
         (
           SELECT QUOTENAME(S.name)+'.'+QUOTENAME(O.name) , O.type
             FROM dspUtil.DropSchema_objects AS O
			 INNER JOIN dspUtil.DropSchema_schemas AS S ON O.schema_id = S.schema_id
            WHERE S.name = @SchemaName
         ),
         TypeInfo(name) AS
         (
           SELECT QUOTENAME(S.name)+'.'+QUOTENAME(T.name)
             FROM dspUtil.DropSchema_types AS T
			 INNER JOIN dspUtil.DropSchema_schemas AS S ON T.schema_id = S.schema_id
            WHERE S.name = @SchemaName
         ),
         XMLSchemaInfo(name) AS
         (
           SELECT QUOTENAME(S.name)+'.'+QUOTENAME(XSC.name)
             FROM dspUtil.DropSchema_xml_schema_collections AS XSC
			 INNER JOIN dspUtil.DropSchema_schemas AS S ON XSC.schema_id = S.schema_id
            WHERE S.name = @SchemaName
         ),
         DropStatements(no,cmd) AS
         (
           SELECT 10,
                  'DROP ' +
                  CASE ObjectInfo.type WHEN 'P' THEN 'PROCEDURE'
                            WHEN 'PC' THEN 'PROCEDURE'
                            WHEN 'U' THEN 'TABLE'
                            WHEN 'IF' THEN 'FUNCTION'
                            WHEN 'TF' THEN 'FUNCTION'
                            WHEN 'FN' THEN 'FUNCTION'
                            WHEN 'V' THEN 'VIEW'
                   END +
                   ' ' + 
                   ObjectInfo.name + 
                   ';'
              FROM ObjectInfo
             UNION ALL
           SELECT 20,
                  'DROP TYPE ' +
                   TypeInfo.name + 
                   ';'
              FROM TypeInfo
             UNION ALL
           SELECT 30,
                  'DROP XML SCHEMA COLLECTION ' +
                   XMLSchemaInfo.name + 
                   ';'
              FROM XMLSchemaInfo
             UNION ALL
            SELECT 10000,'DROP SCHEMA ' + QUOTENAME(name) +';'
              FROM dspUtil.DropSchema_schemas
             WHERE name = @SchemaName AND @IsDropObjectOnly = 0
         ),
         StatementBlob(xml)AS
         (
           SELECT DropStatements.cmd [text()]
             FROM DropStatements
            ORDER BY DropStatements.no
              FOR XML PATH(''), TYPE
         )
    SELECT @Cmd = StatementBlob.xml.value('/', 'TBIGSTRING') 
      FROM StatementBlob;


  	-- added in  t-SQLt command
	EXEC dspUtil.DropSchema_sp_executesql @Cmd

  	-- drop the created synonym
	DROP SYNONYM dspUtil.DropSchema_objects;
	DROP SYNONYM dspUtil.DropSchema_types;
	DROP SYNONYM dspUtil.DropSchema_schemas;
	DROP SYNONYM dspUtil.DropSchema_xml_schema_collections;
	DROP SYNONYM dspUtil.DropSchema_sp_executesql;

END;