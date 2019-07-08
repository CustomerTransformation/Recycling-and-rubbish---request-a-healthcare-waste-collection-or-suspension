USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteClosingCall]    Script Date: 08/07/2019 13:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WasteClosingCall]
	-- Add the parameters for the stored procedure here
@Action varchar(20), 
@NewDate date,
@FormReference varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @Action = 'Close'
	BEGIN
	UPDATE WasteHealthCollection
	SET CallAction = @Action	
	WHERE FormReference = @FormReference
	END
	
	
	IF @Action = 'Biffa'
	BEGIN
	UPDATE WasteHealthCollection
	SET 
	CallAction = @Action,
	ActualColDate = @NewDate
	WHERE FormReference = @FormReference
	END
END

GO

