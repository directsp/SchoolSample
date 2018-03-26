CREATE TABLE [dspUtil].[LogFilterSetting] (
    [LogFilterSettingId] INT             IDENTITY (1, 1) NOT NULL,
    [UserName]           NVARCHAR (100)  NOT NULL,
    [IsExludedFilter]    BIT             CONSTRAINT [DF_LogFilter_IsExludedFilter] DEFAULT ((0)) NOT NULL,
    [LogFilter]          NVARCHAR (2000) NULL,
    CONSTRAINT [PK__LogFilte__7B08B2A3839E413F] PRIMARY KEY CLUSTERED ([LogFilterSettingId] ASC),
    CONSTRAINT [FK__LogFilter__UserN__11BEFB29] FOREIGN KEY ([UserName]) REFERENCES [dspUtil].[LogUser] ([UserName])
);

