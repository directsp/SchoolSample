﻿CREATE PROCEDURE [dspUtil].[Metadata_StoreProcedures]
	@Json TJSON OUT
AS
BEGIN
	DECLARE @Params TABLE (ParamName NVARCHAR(MAX),
		IsOutput BIT,
		SystemTypeName NVARCHAR(MAX),
		UserTypeName NVARCHAR(MAX),
		Length INT,
		object_id INT);
	INSERT INTO @Params (ParamName, IsOutput, SystemTypeName, UserTypeName, Length, object_id)
	SELECT	Params.name AS ParamName, Params.is_output, TYPE_NAME(Type.system_type_id) AS SystemTypeName, TYPE_NAME(Type.user_type_id) AS UserTypeName,
		Params.max_length AS Length, Params.object_id
	FROM	sys.parameters AS Params
			INNER JOIN sys.types AS Type ON Type.user_type_id = Params.user_type_id;

	SET @Json =
		CAST((	SELECT	[Procedure].SchemaName, [Procedure].name AS ProcedureName, Params.ParamName, Params.IsOutput, Params.SystemTypeName,
					Params.UserTypeName, Params.Length AS Length, [Procedure].ExtendedProps AS ExtendedProps
				FROM	(	SELECT	[Procedure].object_id, [Schema].name AS SchemaName, [Procedure].name,
								JSON_QUERY(dspUtil.Metadata_StoreProcedureAnnotation([Schema].name + '.' + [Procedure].name), '$') AS ExtendedProps
							FROM	sys.procedures AS [Procedure]
									INNER JOIN sys.schemas AS [Schema] ON [Schema].schema_id = [Procedure].schema_id) AS [Procedure]
						INNER JOIN @Params AS Params ON Params.object_id = [Procedure].object_id
				WHERE --dspUtil.Metadata_ExtendedPropertyValueOfSchema([Procedure].SchemaName, @ExtendedPropertyName) = 1 OR	
					[Procedure].SchemaName = 'api'
				ORDER BY [Procedure].name
				FOR JSON AUTO) AS NVARCHAR(MAX));
END;