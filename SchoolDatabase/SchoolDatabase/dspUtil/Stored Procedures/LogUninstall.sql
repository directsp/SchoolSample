CREATE PROCEDURE [dspUtil].[LogUninstall]
as
BEGIN
	DROP TABLE IF EXISTS dspUtil.LogFilterSetting;
	DROP TABLE IF EXISTS dspUtil.LogUser;
	PRINT 'Log System has been unistalled.';
END