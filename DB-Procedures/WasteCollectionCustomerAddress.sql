USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteCollectionCustomerAddress]    Script Date: 08/07/2019 13:36:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 08/12/2017
-- Description:	Updates Biffa with the new address and collection date
-- =============================================
CREATE PROCEDURE [dbo].[WasteCollectionCustomerAddress]
	-- Add the parameters for the stored procedure here

	@UPRN int,
	@FirstLineAddress varchar (20),
	@Postcode varchar (20),
	@FormReference varchar (20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    --DECLARE @DateChosen	varchar (30)
	--SET @DateChosen = CONVERT(date, RIGHT(@DatePicked, 10), 103)
	
	DECLARE @CurrentDate date
	SET @CurrentDate = GETDATE()
    DECLARE @Frequency varchar(60)
    SELECT @Frequency = Frequency FROM WasteHealthCollection
    DECLARE @ActualColDate date
    SELECT @ActualColDate = ActualColDate FROM WasteHealthCollection
    DECLARE @Weekly date
    SET @Weekly = DATEADD (week, 1, @ActualColDate)
    DECLARE @Fortnightly date
    SET @Fortnightly = DATEADD (week, 2, @ActualColDate)
    DECLARE @Monthly date
    SET @Monthly = DATEADD (month, 1, @ActualColDate)
    

	
	SELECT Customer_Address AS CustomerAddress, ActualColDate AS NewDesiredStartDate FROM WasteHealthCollection
	WHERE (UPRN = @UPRN AND UPRN > 1) OR (FirstLineAddress =@FirstLineAddress AND Postcode = @Postcode) OR FormReference = @FormReference
	
	
	--SELECT Customer_Address AS CustomerAddress, ActualColDate AS NewDesiredStartDate FROM WasteHealthCollection
	--WHERE UPRN = @UPRN  OR (FirstLineAddress =@FirstLineAddress AND Postcode = @Postcode) OR FormReference = @FormReference
	
	
	
END

GO

