
-- to check if the @value has been set or not
-- String not set value: <notset>
-- Int not set value: -1
-- datetime not set value: '1753-01-01
CREATE FUNCTION [dspUtil].[IsParamSetOrNotNullString] (
	@Value TSTRING
)
RETURNS BIT
AS
BEGIN
	RETURN IIF(@Value IS NULL OR dspUtil.IsParamSetString(@Value) = 0, 0, 1);
END;