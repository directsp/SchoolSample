
--Check if a parameter has been updated or not
CREATE FUNCTION [dspUtil].[IsParamChanged] (
	@OldValue SQL_VARIANT,
	@NewValue SQL_VARIANT,
	@NullAsNotSet BIT
)
RETURNS BIT
AS
BEGIN
	RETURN IIF(dspUtil.IsParamSetBase(@NewValue, @NullAsNotSet) = 1 AND dspUtil.IsEqual(@OldValue, @NewValue) = 0, 1, 0);
END;