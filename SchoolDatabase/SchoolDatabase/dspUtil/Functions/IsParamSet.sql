CREATE FUNCTION [dspUtil].[IsParamSet] (
	@Value SQL_VARIANT
)
RETURNS BIT
AS
BEGIN
	RETURN dspUtil.IsParamSetBase(@Value, 0);
END;