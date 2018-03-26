﻿CREATE PROCEDURE [dspUtil].[LogWarn]
    @ProcId AS INT,
    @Message AS TSTRING,
    @Param0 AS TSTRING = '<notset>',
    @Param1 AS TSTRING = '<notset>',
    @Param2 AS TSTRING = '<notset>'
AS
BEGIN
    SET @Message = 'Warning: ' + @Message;
    EXEC dspUtil.LogTrace @ProcId = @ProcId, @Message = @Message, @Param0 = @Param0, @Param1 = @Param1, @Param2 = @Param2, @Elipse = 0;
END;