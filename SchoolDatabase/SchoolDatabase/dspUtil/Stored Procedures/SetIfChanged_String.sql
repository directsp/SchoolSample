CREATE PROCEDURE [dspUtil].[SetIfChanged_String]
	@IsUpdated BIT OUT, @OldValue TSTRING OUT, @NewValue TSTRING, @ExceptionId INT = NULL, @ExceptionMessage TSTRING = NULL,
	@NullAsNotSet BIT = 0
AS
BEGIN
	IF (dspUtil.IsParamChanged(dspUtil.ToSqlvariant(@OldValue), dspUtil.ToSqlvariant(@NewValue), @NullAsNotSet) = 0)
		RETURN;

	IF (@ExceptionId IS NOT NULL) --
		EXEC dspUtil.ThrowAppException @ExceptionId = @ExceptionId, @Message = @ExceptionMessage;

	SET @IsUpdated = 1;
	SET @OldValue = @NewValue;
END;