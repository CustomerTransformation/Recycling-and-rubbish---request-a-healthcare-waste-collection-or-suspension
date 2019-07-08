USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteHealthAddressChanged]    Script Date: 08/07/2019 13:35:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 07/12/2017
-- Description:	replaces the old address with the new one
-- =============================================
CREATE PROCEDURE [dbo].[WasteHealthAddressChanged]
	-- Add the parameters for the stored procedure here
	@UPRNP int,
	@UPRNC int,
	@FirstLineAddressP varchar (50),
	@FirstLineAddressC varchar(50),
	@PostcodeP varchar(10),
	@PostcodeC varchar(10),
	@UPRNnew int,
	@FirstLineAddressNew varchar (50),
	@PostcodeNew varchar (10),
	@CustomerNewAddress varchar(100),
	@Location varchar (50),
	@Neighbour varchar(max),
	@SecurePlace varchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--DECLARE @DayID int
--SET @DayID = 4
--DECLARE @DateCollection date
--SET @DateCollection = (SELECT DATEADD(DAY, (DATEDIFF(DAY, ((@DayID + 5) % 7), @DateMoving) / 7) * 7 + 7, ((@DayID - 2))))
UPDATE WasteHealthCollection
SET UPRN = @UPRNnew,
	FirstLineAddress = @FirstLineAddressNew,
	Postcode = @PostcodeNew,
	Customer_Address = @CustomerNewAddress,
	Location = @Location,
	Neighbour = @Neighbour,
	SecurePlace = @SecurePlace
WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	
UPDATE  WasteReferral
	SET UPRN = @UPRNnew,
		FirstLineAddress = @FirstLineAddressNew,
		Postcode = @PostcodeNew,
		Customer_Address = @CustomerNewAddress,
		Location = @Location,
		Neighbour = @Neighbour,
		SecurePlace = @SecurePlace
WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	
END

GO

