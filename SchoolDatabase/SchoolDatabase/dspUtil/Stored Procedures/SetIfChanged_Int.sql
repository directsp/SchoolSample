﻿CREATE PROCEDURE [dspUtil].[SetIfChanged_Int]
	@IsUpdated BIT OUT, @OldValue BIGINT OUT, @NewValue BIGINT, @ExceptionId INT = NULL, @ExceptionMessage TSTRING = NULL, @NullAsNotSet BIT = 0
AS
BEGIN
	IF (dspUtil.IsParamChanged(@OldValue, @NewValue, @NullAsNotSet) = 0)
		RETURN;

	IF (@ExceptionId IS NOT NULL) --
		EXEC dspUtil.ThrowAppException @ExceptionId = @ExceptionId, @Message = @ExceptionMessage;

	SET @IsUpdated = 1;
	SET @OldValue = @NewValue;
END;