CREATE FUNCTION [dspUtil].[FormatMessage] (
	@Message TSTRING,
	@Param0 TSTRING = '<notset>',
	@Param1 TSTRING = '<notset>',
	@Param2 TSTRING = '<notset>',
	@Param3 TSTRING = '<notset>')
RETURNS TSTRING
AS
BEGIN

	-- Validate Params
	SET @Param0 = dspUtil.FormatMessageParam(@Param0);
	SET @Param1 = dspUtil.FormatMessageParam(@Param1);
	SET @Param2 = dspUtil.FormatMessageParam(@Param2);
	SET @Param3 = dspUtil.FormatMessageParam(@Param3);

	-- Replace Message
	SET @Message = dspUtil.FormatString(@Message);
	SET @Message = REPLACE(@Message, '{0}', @Param0);
	SET @Message = REPLACE(@Message, '{1}', @Param1);
	SET @Message = REPLACE(@Message, '{2}', @Param2);
	SET @Message = REPLACE(@Message, '{3}', @Param3);

	RETURN @Message;

END;