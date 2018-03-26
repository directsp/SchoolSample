
CREATE PROC [dspUtil].[Validate_CheckNotNull]
	@ProcId INT, @ArgumentName TSTRING, @ArgumentValue TSTRING
AS
BEGIN
	IF (@ArgumentValue IS NULL) --
		EXEC dspUtil.ThrowInvalidArgument @ProcId = @ProcId, @ArgumentName = @ArgumentName, @ArgumentValue = @ArgumentValue;
END;