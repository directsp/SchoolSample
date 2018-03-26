﻿CREATE FUNCTION [dspUtil].[Path_RemoveExtension] (
	@Path TSTRING)
RETURNS TSTRING
BEGIN
	RETURN LEFT(@Path, LEN(@Path) - CHARINDEX('.', REVERSE(@Path)));
END;