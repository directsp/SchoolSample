CREATE TABLE [dbo].[StringTable] (
    [StringTableName] NVARCHAR (100) COLLATE Persian_100_CI_AI NOT NULL,
    [Text_en]         NVARCHAR (MAX) COLLATE Persian_100_CI_AI NOT NULL,
    [Text_fa]         NVARCHAR (MAX) COLLATE Persian_100_CI_AI NULL,
    [Description]     NVARCHAR (MAX) COLLATE Persian_100_CI_AI NULL,
    CONSTRAINT [PK_StringTable_Name] PRIMARY KEY CLUSTERED ([StringTableName] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'To store string values which apear in CRUD statements', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StringTable';

