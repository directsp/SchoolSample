CREATE TABLE [dbo].[Exception] (
    [ExceptionId]   INT            NOT NULL,
    [ExceptionName] NVARCHAR (100) COLLATE Persian_100_CS_AI NOT NULL,
    [Description]   NVARCHAR (MAX) COLLATE Persian_100_CS_AI NULL,
    CONSTRAINT [PK_Exception] PRIMARY KEY CLUSTERED ([ExceptionId] ASC),
    CONSTRAINT [IX_ExceptionNationalNumber] UNIQUE NONCLUSTERED ([ExceptionName] ASC)
);

