USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteHealthBookedDates]    Script Date: 08/07/2019 13:40:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 02/01/2017
-- Description:	Updates table WastehealthColDates with days booked
-- =============================================
CREATE PROCEDURE [dbo].[WasteHealthBookedDates]
	-- Add the parameters for the stored procedure here
	@DatePicked varchar (40),
	@overRide varchar (10) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @DateChosen	varchar (30)
	       ,@password as varchar(10)

	SET @password = 'waste123'
	SET @DateChosen = CONVERT(date, RIGHT(@DatePicked, 10), 103)
	DECLARE @AvailableForDate int
	SELECT @AvailableForDate = Available FROM WasteHealthColDates

	UPDATE WasteHealthColDates
	SET Booked = Booked + 1,
		Available = Available - 1
	WHERE (Booked < 70  OR @overRide = @password )AND @DateChosen= Col_Date


END

GO

