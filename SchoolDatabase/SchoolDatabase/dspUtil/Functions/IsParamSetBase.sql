CREATE FUNCTION [dspUtil].[IsParamSetBase] (
	@Value SQL_VARIANT,
	@NullAsNotSet BIT
)
RETURNS BIT
AS
BEGIN
	IF (@Value IS NULL AND	@NullAsNotSet = 1)
		RETURN 0;

	DECLARE @Type TSTRING = dspUtil.ToString(SQL_VARIANT_PROPERTY(@Value, 'BaseType'));

	IF (@Type LIKE '%int%' AND	CAST(@Value AS INT) = -1)
		RETURN 0;

	IF (@Type LIKE '%char%' AND (dspUtil.ToString(@Value) = '<notset>' OR	dspUtil.ToString(@Value) = '<noaccess>'))
		RETURN 0;

	IF (@Type LIKE '%date%' AND CAST(@Value AS DATETIME) = '1753-01-01')
		RETURN 0;

	IF (@Type LIKE '%decimal%' AND	CAST(@Value AS DECIMAL) = -1)
		RETURN 0;

	IF (@Type LIKE '%money%' AND CAST(@Value AS MONEY) = -1)
		RETURN 0;

	IF (@Type LIKE '%float%' AND CAST(@Value AS FLOAT) = -1)
		RETURN 0;

	RETURN 1;
END;