USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteSuspensionResumedDate]    Script Date: 08/07/2019 13:41:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 11/01/2018
-- Description:	updates the date in the collection and referral table with the new date
-- =============================================
CREATE PROCEDURE [dbo].[WasteSuspensionResumedDate]
	-- Add the parameters for the stored procedure here
	@DatePicked varchar (40),
	@UPRNP int,
    @UPRNC int,
    @FirstLineAddressP varchar (50),
    @FirstLineAddressC varchar (50),
	@PostcodeP varchar (10),
    @PostcodeC varchar (10)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @DateChosen	varchar (30)
	SET @DateChosen = CONVERT(date, RIGHT(@DatePicked, 10), 103)
	DECLARE @ResumedDate date

	UPDATE WasteHealthCollection
	SET DesiredStartDate = @DateChosen,
		ActualColDate = @DateChosen
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	
	UPDATE WasteReferral
	SET DesiredStartDate = @DateChosen,
		ActualColDate = @DateChosen
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	
END

GO

