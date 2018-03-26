
-- returns 1, should the message be printed
CREATE FUNCTION [dspUtil].[LogCheckFilters] ( @Message TSTRING )
RETURNS BIT
AS
BEGIN
	-- return 0 if @message likes exclude filters
	IF EXISTS( SELECT 1 FROM dspUtil.LogFilterSetting AS LFS 
		WHERE LFS.UserName = SYSTEM_USER AND LFS.IsExludedFilter = 1 AND @Message LIKE '%'+ LFS.LogFilter + '%' )
		RETURN 0;

	-- return 1 if include filters are empty
	IF NOT EXISTS( SELECT 1 FROM dspUtil.LogFilterSetting AS LFS WHERE LFS.UserName = SYSTEM_USER AND LFS.IsExludedFilter = 0)
		RETURN 1;
	
	--  return 1 if @message likes include filters  
	IF EXISTS( SELECT 1 FROM dspUtil.LogFilterSetting AS LFS 
		WHERE LFS.UserName = SYSTEM_USER AND LFS.IsExludedFilter = 0 AND @Message LIKE '%'+ LFS.LogFilter + '%' )
		RETURN 1;

	RETURN 0;
END;