CREATE TABLE [dspUtil].[LogUser] (
    [UserName]  NVARCHAR (100) COLLATE Persian_100_CS_AI NOT NULL,
    [IsEnabled] BIT            CONSTRAINT [DF_LogUser_IsEnabled] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__LogUser__C9F28457BC3C1B77] PRIMARY KEY CLUSTERED ([UserName] ASC)
);

