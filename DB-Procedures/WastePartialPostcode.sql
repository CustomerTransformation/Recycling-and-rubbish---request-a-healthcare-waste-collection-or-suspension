USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WastePartialPostcode]    Script Date: 08/07/2019 13:39:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 15/12/2017
-- Description:	displays the first three characters from the postcode
-- =============================================Partial
CREATE PROCEDURE [dbo].[WastePartialPostcode]
	-- Add the parameters for the stored procedure here
	@WhoAreYou varchar (20),
	@PostcodeP varchar (20),
	@PostcodeC varchar (20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	
	DECLARE @Postcode varchar(10)
	IF @WhoAreYou = 'for myself'
	BEGIN
	SET @Postcode = @PostcodeP
	SELECT LEFT (@Postcode, 5) AS PartialPostcode
	END
	IF @WhoAreYou = 'for somebody else'
	BEGIN
	SET @Postcode = @PostcodeC
	SELECT LEFT (@Postcode, 5) AS PartialPostcode
	END
	
	

	
END

GO

