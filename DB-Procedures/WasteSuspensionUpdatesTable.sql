USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteSuspensionUpdatesTable]    Script Date: 08/07/2019 13:37:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 12/12/2017
-- Description:	Updates WasteHealthCollection table with the suspension type and reason
-- =============================================
CREATE PROCEDURE [dbo].[WasteSuspensionUpdatesTable]
	-- Add the parameters for the stored procedure here
	@SuspensionType varchar (50),
	@UPRNP int,
    @UPRNC int,
	@FirstLineAddressP varchar (50),
    @FirstLineAddressC varchar (50),
	@PostcodeP varchar (10),
    @PostcodeC varchar (10),
    @DateCancellation date
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	IF @SuspensionType = 'Permanent'
	BEGIN
	UPDATE  WasteHealthCollection
	SET SuspensionType = @SuspensionType , Approved = 'Cncl' , DateCancellation = @DateCancellation
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	UPDATE  WasteReferral
	SET Approved = 'Cncl' , DateCancellation = @DateCancellation
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	END
	ELSE
	BEGIN
	UPDATE  WasteHealthCollection
	SET SuspensionType = @SuspensionType, DateCancellation = @DateCancellation
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	UPDATE  WasteReferral
	SET  DateCancellation = @DateCancellation
	WHERE (UPRN = @UPRNP or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	(UPRN = @UPRNC or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
	END
END

GO

