﻿CREATE FUNCTION [dspUtil].[String_RemoveWhitespacesBig] ( @String TBIGSTRING )
RETURNS TBIGSTRING
AS
BEGIN
    RETURN REPLACE(REPLACE(REPLACE(REPLACE(@String, ' ', ''), CHAR(13), ''), CHAR(10), ''), CHAR(9), '');
END;