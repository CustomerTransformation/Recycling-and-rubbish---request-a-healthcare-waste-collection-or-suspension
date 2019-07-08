USE [ProdRubbishRecycling]
GO

/****** Object:  Table [dbo].[WasteHealthCollection]    Script Date: 08/07/2019 12:27:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WasteHealthCollection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[FormReference] [varchar](20) NOT NULL,
	[RequestType] [varchar](20) NOT NULL,
	[Contact_FullName] [varchar](30) NULL,
	[Contact_ContactDetails] [varchar](50) NULL,
	[Contact_Address] [varchar](100) NULL,
	[Customer_FullName] [varchar](30) NULL,
	[Customer_ContactDetails] [varchar](50) NULL,
	[Customer_Address] [varchar](100) NULL,
	[UPRN] [int] NULL,
	[UCRN] [int] NULL,
	[FirstLineAddress] [varchar](50) NULL,
	[Postcode] [varchar](10) NULL,
	[WasteType] [varchar](20) NULL,
	[HowOften] [varchar](20) NULL,
	[Frequency] [varchar](60) NULL,
	[Location] [varchar](50) NULL,
	[Neighbour] [varchar](max) NULL,
	[SecurePlace] [varchar](max) NULL,
	[DesiredStartDate] [date] NULL,
	[Approved] [varchar](10) NULL,
	[SuspensionType] [varchar](50) NULL,
	[ActualColDate] [date] NULL,
	[WasteCollected] [varchar](5) NULL,
	[DateCancellation] [date] NULL,
	[LinkJob] [varchar](max) NULL,
	[CaseNumber] [int] NULL,
	[CallAction] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

