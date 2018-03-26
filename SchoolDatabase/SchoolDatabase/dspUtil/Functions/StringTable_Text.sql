-- Create Function String
CREATE FUNCTION [dspUtil].[StringTable_Text] (@Name TSTRING)
RETURNS TSTRING
AS
BEGIN
	DECLARE @Text_En TSTRING;

	SELECT	@Text_En = ST.Text_en
	FROM dbo.StringTable AS ST
	WHERE	ST.StringTableName = @Name;

	RETURN dspUtil.String_ReplaceEnter(@Text_En);
END;