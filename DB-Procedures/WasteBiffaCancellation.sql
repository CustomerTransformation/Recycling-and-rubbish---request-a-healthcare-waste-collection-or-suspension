USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteBiffaCancellation]    Script Date: 08/07/2019 13:40:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 08/01/2018
-- Description:	If Biffa answers 'no' to the collection and sends the form to waste, this should cancel the collection
-- =============================================
CREATE PROCEDURE [dbo].[WasteBiffaCancellation]
	-- Add the parameters for the stored procedure here
@BiffaCancellation varchar (5),
@FormReference varchar (20),
@DateCancellation date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
IF @BiffaCancellation = 'no'
BEGIN
UPDATE WasteHealthCollection
SET SuspensionType = 'Cancelled by Biffa',
	DateCancellation = @DateCancellation,
	WasteCollected = 'no'
WHERE FormReference = @FormReference AND isnull(SuspensionType, '') != 'Permanent'
END
IF @BiffaCancellation = 'yes'
BEGIN
UPDATE WasteHealthCollection
SET SuspensionType = NULL,
	DateCancellation = NULL,
	WasteCollected = 'yes'
WHERE FormReference = @FormReference AND isnull(SuspensionType, '') != 'Permanent'
END
END

GO

