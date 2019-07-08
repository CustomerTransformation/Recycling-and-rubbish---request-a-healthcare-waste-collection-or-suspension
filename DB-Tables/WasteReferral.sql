USE [ProdRubbishRecycling]
GO

/****** Object:  Table [dbo].[WasteReferral]    Script Date: 08/07/2019 12:28:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WasteReferral](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[FormReference] [varchar](20) NOT NULL,
	[Contact_FullName] [varchar](30) NULL,
	[Contact_ContactDetails] [varchar](50) NULL,
	[Contact_Address] [varchar](100) NULL,
	[Customer_FullName] [varchar](30) NULL,
	[Customer_ContactDetails] [varchar](50) NULL,
	[Customer_Address] [varchar](100) NULL,
	[UPRN] [int] NULL,
	[UCRN] [int] NULL,
	[Referral_FullName] [varchar](30) NOT NULL,
	[Referral_ContactDetails] [varchar](50) NULL,
	[Referral_Address] [varchar](300) NULL,
	[WasteType] [varchar](20) NULL,
	[HowOften] [varchar](20) NOT NULL,
	[Location] [varchar](50) NULL,
	[Neighbour] [varchar](max) NULL,
	[SecurePlace] [varchar](max) NULL,
	[Approved] [varchar](10) NULL,
	[ApprovedDate] [date] NULL,
	[DesiredStartDate] [date] NULL,
	[FirstLineAddress] [varchar](50) NULL,
	[Postcode] [varchar](7) NULL,
	[DateCancellation] [date] NULL,
	[Frequency] [varchar](60) NULL,
	[ActualColDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

