-- Create Procedure InitExceptions


CREATE PROC [dspUtil].[InitCommonExceptions]
AS
BEGIN
	SET NOCOUNT ON;

	-- Create common exception
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55001, N'GeneralException');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55002, N'AccessDeniedOrObjectNotExists');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55004, N'ObjectAlreadyExists');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55005, N'ObjectIsInUse');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55009, N'PageSizeTooLarge');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55011, N'InvalidArgument');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55012, N'FatalError');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55013, N'LockFailed');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55015, N'ValidationError');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55016, N'InvalidOperation');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55017, N'NotSupported');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55018, N'NotImplemeted');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55019, N'UserIsDisabled');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55020, N'AmbiguousException');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55021, N'NoOperation');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55022, N'InvalidCaptcha');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55023, N'BatchIsNotAllowed');
	INSERT dbo.Exception (ExceptionId, ExceptionName) VALUES (55024, N'TooManyRequest');

END