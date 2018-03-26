
CREATE PROC [dspUtil].[SetUp]
AS
BEGIN
	-- try to create err schema
	IF SCHEMA_ID('err') IS NULL
		EXEC sys.sp_executesql N'CREATE SCHEMA [err]';

	-- try to create str schema
	IF SCHEMA_ID('str') IS NULL
		EXEC sys.sp_executesql N'CREATE SCHEMA [str]';

	-- try to create const schema
	IF SCHEMA_ID('const') IS NULL
		EXEC sys.sp_executesql N'CREATE SCHEMA [const]';

	--Create string table if not exists
	IF (dspUtil.IsTableExists('dbo', 'StringTable') = 0)
	BEGIN
		CREATE TABLE dbo.StringTable (StringTableName TSTRING NOT NULL,
			Text_en NTEXT NOT NULL,
			Text_fa NTEXT NULL,
			Description TBIGSTRING NULL --
				CONSTRAINT PK_StringTable_Name PRIMARY KEY CLUSTERED (StringTableName ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
												IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
		EXEC sys.sp_addextendedproperty @name = N'MS_Description', @value = N'To store string values which apear in CRUD statements', @level0type = N'SCHEMA',
			@level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StringTable';
	END;

	--Create Exception table if not exists
	IF (dspUtil.IsTableExists('dbo', 'Exception') = 0)
	BEGIN
		CREATE TABLE dbo.Exception (ExceptionId INT NOT NULL,
			ExceptionName TSTRING NOT NULL,
			Description TBIGSTRING NULL,
			CONSTRAINT PK_Exception PRIMARY KEY CLUSTERED (ExceptionId ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
										ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
			CONSTRAINT IX_ExceptionNationalNumber UNIQUE NONCLUSTERED (ExceptionName ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
													IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
	END;

END;

-- init common exception
DELETE	dbo.Exception;
EXEC dspUtil.InitCommonExceptions;