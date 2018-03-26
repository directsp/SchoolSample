

CREATE PROC [tCodeQuality].[test Declare BIGINT]
AS
BEGIN
	--EXEC tSQLt.Fail 

	-- Getting procedures which have bigint columns with int declaration
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Getting procedures which have bigint columns with int declaration';
	DECLARE @ProcInfo TABLE (
		SchemaName TSTRING,
		ProcedureName TSTRING,
		DEFINITION TBIGSTRING,
		ColumnName TSTRING);
	INSERT @ProcInfo (SchemaName, ProcedureName, DEFINITION, ColumnName)
	EXEC dspUtil.CodeQuality_ColumnsWithBigintTypes;

	-- Checking if there is any wrong type for Bigint Columns
	EXEC dspUtil.LogTrace @ProcId = @@PROCID, @Message = N'Checking if there is any wrong type for Bigint Columns';
	DECLARE @ProcName TSTRING = '';
	DECLARE @ParamName TSTRING = '';
	IF EXISTS (SELECT	1 FROM @ProcInfo AS PI)
	BEGIN
		SELECT	@ProcName = PI.SchemaName + '.' + PI.ProcedureName, @ParamName = PI.ColumnName
		FROM	@ProcInfo AS PI;
		DECLARE @Message TSTRING = N'in the procedure "' + @ProcName + '", parameter "' + @ParamName + '" has wrong parameter data type!';
		EXEC tSQLt.Fail @Message0 = @Message;
	END;
END;