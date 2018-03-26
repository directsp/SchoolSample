
CREATE PROCEDURE [dspUtil].[LogInstall]
as
BEGIN
	DROP TABLE IF EXISTS dspUtil.LogFilterSetting;
	DROP TABLE IF EXISTS dspUtil.LogUser;
	CREATE TABLE dspUtil.LogUser
	(
		[UserName] NVARCHAR(/*ignore coe quality*/ 100) NOT NULL PRIMARY KEY,
		IsEnabled BIT NOT NULL CONSTRAINT DF_LogUser_IsEnabled DEFAULT(0) 
	);

	CREATE TABLE dspUtil.LogFilterSetting
	(
		LogFilterSettingId INT NOT NULL PRIMARY KEY IDENTITY,
		[UserName] NVARCHAR(/*ignore coe quality*/100) NOT NULL REFERENCES dspUtil.LogUser(UserName),
		IsExludedFilter BIT NOT NULL CONSTRAINT DF_LogFilter_IsExludedFilter DEFAULT(0),
		LogFilter NVARCHAR(/*ignore coe quality*/2000) NULL 
	)  ;

	PRINT 'Log System has been installed.';
END