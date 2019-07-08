USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteCollectionBiffaSuspendedJob]    Script Date: 08/07/2019 13:38:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 12/12/2017
-- Description:	Informs Biffa that the colection is suspended now (Waste collection or suspension form)
-- =============================================
CREATE PROCEDURE [dbo].[WasteCollectionBiffaSuspendedJob] 
	-- Add the parameters for the stored procedure here
	--@SuspensionType varchar(50),
	--@ResumedDate date,
	@UPRNP int,
	@FirstLineAddressP varchar (20),
	@PostcodeP varchar (20),
	@UPRNC int,
	@FirstLineAddressC varchar (20),
	@PostcodeC varchar (20)		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @PrintMessage varchar (max)
    DECLARE @SuspensionType varchar (50)
    SET @SuspensionType = 'before'
    SELECT @SuspensionType = SuspensionType FROM WasteHealthCollection
    WHERE ((UPRN = @UPRNP and UPRN > 1) or (FirstLineAddress = @FirstLineAddressP and Postcode = @PostcodeP)) or
	((UPRN = @UPRNC and UPRN > 1) or (FirstLineAddress = @FirstLineAddressC and Postcode = @PostcodeC))
  
	IF @SuspensionType = 'Temporary'
	SET @PrintMessage = 'This collection has been temporarily suspended. The collection will resume on the date shown above under Collection start date.'
	IF @SuspensionType = 'Permanent'
	SET @PrintMessage = 'This collection has been permanently suspended'
	SELECT @PrintMessage AS PrintMessageBiffa
	
	
END

GO

