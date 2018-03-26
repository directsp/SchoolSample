CREATE PROCEDURE [dspUtil].[LogFilter]
	@Filter TSTRING = NULL
AS
BEGIN
	SET @Filter = NULLIF(@Filter, '');

	-- remove all old filters
	EXEC dspUtil.LogRemoveFilter @Filter = NULL;
	IF (@Filter IS NULL)
		RETURN;

	-- set new filter
	EXEC dspUtil.LogAddFilter @Filter = @Filter, @IsExclude = 0;
END;