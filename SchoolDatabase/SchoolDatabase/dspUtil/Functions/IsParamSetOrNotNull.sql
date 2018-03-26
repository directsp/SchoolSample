CREATE FUNCTION [dspUtil].[IsParamSetOrNotNull] (
	@value SQL_VARIANT
)
RETURNS BIT
AS
BEGIN
	RETURN IIF(@value IS NULL OR dspUtil.IsParamSet(@value) = 0, 0, 1);
END;