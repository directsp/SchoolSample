﻿CREATE PROCEDURE [tCodeQuality].[test dbo should not have WITH EXECUTE AS OWNER]
AS
BEGIN
	-- Declaring pattern
	DECLARE @Pattern_WithExecuteASOwner TSTRING = dspUtil.String_RemoveWhitespaces('WITH EXECUTE AS OWNER');
	DECLARE @Pattern_WithExecASOwner TSTRING = dspUtil.String_RemoveWhitespaces('WITH EXEC AS OWNER');
	DECLARE @msg TSTRING;
	DECLARE @ProcedureName TSTRING;

	-- Getting list all procedures with pagination
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Getting list all procedures with pagination';
	DECLARE @t TABLE (SchemaName TSTRING,
		ProcedureName TSTRING,
		Script TBIGSTRING);
	INSERT INTO @t
	SELECT	PD.SchemaName, PD.ObjectName, PD.Script
	FROM	dspUtil.Metadata_ProceduresDefination() AS PD
	WHERE	PD.SchemaName IN ( 'dbo', 'dspUtil', 'perm' );

	-- Looking for "With Execute AS Owner" phrase
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Looking for "With Execute AS Owner" phrase';
	SELECT	@ProcedureName = SchemaName + '.' + ProcedureName
	FROM	@t
	WHERE	CHARINDEX(@Pattern_WithExecuteASOwner, Script) > 0 OR	CHARINDEX(@Pattern_WithExecASOwner, Script) > 0;

	IF (@ProcedureName IS NOT NULL)
	BEGIN
		SET @msg = '"With Execute AS Owner" phrase was found in procedure: ' + @ProcedureName;
		EXEC tSQLt.Fail @Message0 = @msg;
	END;
END;