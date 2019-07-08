USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteHealthCollectionGetData]    Script Date: 08/07/2019 13:34:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 27/11/2017
-- Description:	Gets data from Waste Healthcare Collection or Suspension and puts it in the table WasteHealthCollection
-- =============================================
CREATE PROCEDURE [dbo].[WasteHealthCollectionGetData]
	-- Add the parameters for the stored procedure here
	@Date date,
	@FormReference varchar(20),
	@RequestType varchar(20),
	@ForSelf varchar(20),
	@Contact_FullName varchar(30),
	@Contact_ContactDetails varchar(50),
	@Contact_Address varchar(100),
	@Customer_FullName varchar(30),
	@Customer_ContactDetails varchar(50),
	@Customer_Address varchar(100),
	@UPRNP int,
    @UPRNC int,
    @UCRN varchar(20),
	@FirstLineAddressP varchar (50),
    @FirstLineAddressC varchar (50),
	@PostcodeP varchar (10),
    @PostcodeC varchar (10),
	@WasteType varchar(20),
	@DatePicked varchar(60),
	@Location varchar (50)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateChosen	varchar (30)
	SET @DateChosen = CONVERT(date, RIGHT(@DatePicked, 10), 103)
    IF @ForSelf = 'for myself'
    BEGIN
	INSERT INTO WasteHealthCollection (
	[Date],
	[FormReference],
	[RequestType],
	[Contact_FullName],
	[Contact_ContactDetails],
	[Contact_Address],
	[Customer_FullName],
	[Customer_ContactDetails],
	[Customer_Address],
	[UPRN],
	[UCRN],
	[FirstLineAddress],
	[Postcode],
	[HowOften],
	[WasteType],
	[DesiredStartDate],
	[Location],
	[Approved],
	[ActualColDate]
	
	
	)
	
	VALUES (
	
	@Date,
	@FormReference,
	@RequestType,
	@Contact_FullName,
	@Contact_ContactDetails,
	@Contact_Address,
	@Contact_FullName,
	@Contact_ContactDetails,
	@Contact_Address,
	@UPRNP,
	@UCRN,
	@FirstLineAddressP,
	@PostcodeP,
	'Infrequent',
	@WasteType,
	@DateChosen,
	@Location,
	'yes',
	@DateChosen
	

)
END
	
	IF @ForSelf = 'for somebody else'
	BEGIN
	INSERT INTO WasteHealthCollection (
	[Date],
	[FormReference],
	[RequestType],
	[Contact_FullName],
	[Contact_ContactDetails],
	[Contact_Address],
	[Customer_FullName],
	[Customer_ContactDetails],
	[Customer_Address],
	[UPRN],
	[UCRN],
	[FirstLineAddress],
	[Postcode],
	[HowOften],
	[WasteType],
	[DesiredStartDate],
	[Location],
	[Approved],
	[ActualColDate]
	
	
	

	
)
	
	VALUES (
	
	@Date,
	@FormReference,
	@RequestType,
	@Contact_FullName,
	@Contact_ContactDetails,
	@Contact_Address,
	@Customer_FullName,
	@Customer_ContactDetails,
	@Customer_Address,
	@UPRNC,
	@UCRN,
	@FirstLineAddressC,
	@PostcodeC,
	'Infrequent',
	@WasteType,
	@DateChosen,
	@Location,
	'yes',
	@DateChosen
	
	)
	END
END

GO

