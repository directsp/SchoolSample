CREATE FUNCTION [dspUtil].[FormatRemoveLikeInjection] (
	@Value TSTRING)
RETURNS TSTRING
AS
BEGIN
	SET @Value = dspUtil.FormatString(@Value);
	SET @Value = REPLACE(@Value, '%', '');
	SET @Value = REPLACE(@Value, '[', '');
	SET @Value = REPLACE(@Value, '_', '[_]');

	RETURN @Value;
END;