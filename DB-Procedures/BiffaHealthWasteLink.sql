USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[BiffaHealthWasteLink]    Script Date: 08/07/2019 13:42:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 25/06/2018
-- Description:	Enter Link for Biffa stage to table
-- =============================================
CREATE PROCEDURE [dbo].[BiffaHealthWasteLink]
	@CaseRef varchar(50),
	@BiffaLink varchar(255)



AS
BEGIN
	SET NOCOUNT ON;

    UPDATE WasteHealthCollection
    SET LinkJob = @BiffaLink
	WHERE FormReference = @CaseRef;
	
END

GO

