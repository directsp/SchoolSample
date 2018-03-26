CREATE PROC [tCodeQuality].[test API must have Context TCONTEXT OUT]
AS
BEGIN

	-- Declaring pattern
	DECLARE @Pattern_Context TCONTEXT = dspUtil.String_RemoveWhitespaces('@Context TCONTEXT OUT');
	DECLARE @Pattern_AppUserContext TCONTEXT = dspUtil.String_RemoveWhitespaces('@AppUserContext TCONTEXT OUT');

	DECLARE @msg TSTRING;
	DECLARE @ProcedureName TSTRING;

	-- Getting list all procedures with pagination
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Getting list all procedures with api schema';
	DECLARE @t TABLE (SchemaName TSTRING,
		ProcedureName TSTRING,
		Script TBIGSTRING);
	INSERT INTO @t
	SELECT	PD.SchemaName, PD.ObjectName, PD.Script
	FROM	dspUtil.Metadata_ProceduresDefination() AS PD
	WHERE	PD.SchemaName = 'api';

	-- Looking for "@Context TCONTEXT OUT" phrase
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Looking for "@Context TCONTEXT OUT" phrase';
	SELECT	@ProcedureName = SchemaName + '.' + ProcedureName
	FROM	@t
	WHERE	CHARINDEX(@Pattern_Context, Script) < 1 AND CHARINDEX(@Pattern_AppUserContext, Script) < 1;

	IF (@ProcedureName IS NOT NULL)
	BEGIN
		SET @msg = '"@Context TCONTEXT OUT" phrase was not found in procedure: ' + @ProcedureName;
		EXEC tSQLt.Fail @Message0 = @msg;
	END;
END;