CREATE FUNCTION [dspUtil].[Context_CaptchaSet] (@Context TCONTEXT,
	@Value BIT)
RETURNS TCONTEXT
AS
BEGIN
	IF (JSON_VALUE(@Context, N'$.InvokeOptions') IS NULL)
		SET @Context = JSON_MODIFY(@Context, N'$.InvokeOptions', JSON_QUERY(@Context,'$'));
	RETURN JSON_MODIFY(@Context, '$.InvokeOptions.IsCaptcha', @Value);
END;