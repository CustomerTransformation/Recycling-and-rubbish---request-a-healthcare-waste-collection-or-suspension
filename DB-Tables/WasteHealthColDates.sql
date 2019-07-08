USE [ProdRubbishRecycling]
GO

/****** Object:  Table [dbo].[WasteHealthColDates]    Script Date: 08/07/2019 12:27:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WasteHealthColDates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Col_Date] [date] NULL,
	[Col_Day] [varchar](30) NULL,
	[Available] [int] NOT NULL,
	[Notes] [varchar](255) NULL,
	[Booked] [int] NULL,
 CONSTRAINT [PK_WasteHealthColDates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

