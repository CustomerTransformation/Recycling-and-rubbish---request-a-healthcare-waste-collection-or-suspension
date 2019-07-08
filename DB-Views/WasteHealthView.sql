USE [ProdRubbishRecycling]
GO

/****** Object:  View [dbo].[WasteHealthView]    Script Date: 08/07/2019 12:29:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[WasteHealthView]
AS
SELECT 
Replace(CONVERT(VARCHAR(20), Date, 103),'/','-')AS Date,
FormReference,
Customer_FullName,
Customer_ContactDetails,
Customer_Address,
WasteType,
HowOften,
Frequency,
Location,
Approved,
Replace(CONVERT(VARCHAR(20), DesiredStartDate, 103),'/','-')AS DesiredStartDate,
SuspensionType
 FROM WasteHealthCollection






GO

