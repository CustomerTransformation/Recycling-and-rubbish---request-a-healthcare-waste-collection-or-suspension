USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteHealthcareCalendarNew3]    Script Date: 08/07/2019 13:39:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniela Dutu
-- Create date: 07/09/2018
-- Description:	Checks available dates and maximum slots
-- =============================================
CREATE PROCEDURE [dbo].[WasteHealthcareCalendarNew3]
	-- Add the parameters for the stored procedure here
	@DatePicked varchar (40),--,--this is the date picked by the customer from the list
	@HowOften varchar (10),
	@overRide varchar (10) = NULL
--@DatePicked date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @BookedDate1 int
declare @BookedDate2 int
DECLARE @CurrentDate date
        ,@password as varchar(10)

SET @password = 'waste123'
SET @CurrentDate = GETDATE()

DECLARE @DayName AS int
SET @DayName = 0
DECLARE @DayID int
SET @DayID = 4--this is Wednesday's ID

DECLARE @CountAvailable1 date
SET @CountAvailable1 = (SELECT DATEADD(DAY, (DATEDIFF(DAY, ((@DayID + 5) % 8), GETDATE()) / 7) * 7 + 7, ((@DayID - 2))))--this is next Wednesday's date, but can be booked up to Monday

DECLARE @CountAvailable11 date
SET @CountAvailable11 = (SELECT DATEADD(DAY, (DATEDIFF(DAY, ((@DayID + 5) % 7), GETDATE()) / 7) * 7 + 7, ((@DayID - 2))))--this is next Wednesday's date, but can be booked on Tuesday as well
DECLARE @CountAvailable2 date
SET @CountAvailable2 = DATEADD (day, 1, @CountAvailable11)--this is next Thursday's date




DECLARE @ColDay varchar(30)
SET @ColDay= DATENAME(weekday, @CountAvailable1)--this will show as Wednesday
DECLARE @ColDay2 varchar(30)
SET @ColDay2= DATENAME(weekday, @CountAvailable2)--this will show as Thursday

DECLARE @Description as varchar(255)
DECLARE @ColDate1 date
SET @ColDate1 = @CountAvailable1
DECLARE @ColDate2 date
SET @ColDate2 = @CountAvailable2



DECLARE @Available int
DECLARE @AvailableForDate1 int
DECLARE @AvailableForDate2 int
declare @ActualDate varchar (20)
set @ActualDate = RIGHT(@DatePicked, 10)
DECLARE @ActualColDate date
select @ActualColDate = CONVERT (date, @ActualDate,103 )

SELECT @Available = Available FROM WasteHealthColDates
DECLARE @Booked int
SELECT @Booked = Booked FROM WasteHealthColDates

WHILE @DayName < 4 --display 4 Wednesdays or 4 Thursdays
	BEGIN
		
		--these are the booked dates for Wednesday and Thursday (@BookedDate1 and 'CountAvailable1 are Wednesdays, nb 2 are Thursdays)
		IF  @HowOften = 'Regular'--if the collection is regular, the customer will see Wednesday dates as available
		BEGIN
			
			select @BookedDate1= count(HowOften) from WasteHealthCollection where ActualColDate= @CountAvailable1--nb of slots already booked
			SELECT @AvailableForDate1 = Available FROM WasteHealthColDates
			WHERE Col_Date = @CountAvailable1 

				--if the dates don't exist, insert them (new)	
				IF @AvailableForDate1 IS NULL
				BEGIN
					INSERT INTO WasteHealthColDates (Col_Date, Col_Day, Available, Booked)
					VALUES (@CountAvailable1, @ColDay, 70 -  @BookedDate1, 0 + @BookedDate1)--insert Wednesdays
					set @AvailableForDate1 = 70;
				END
			--if the dates already exist in the calendar, update the number of bookings and available slots against the date picked
				else		
				BEGIN
					update WasteHealthColDates
					set Available = 70 - @BookedDate1 , --update the Wednesdays which already exist in the calendar
						Booked = 0 +  @BookedDate1
					where Col_Date = @CountAvailable1 
					set @AvailableForDate1 = 70 - @BookedDate1
				END

			IF @AvailableForDate1 >= 1	
				SET @DayName = @DayName + 1;

			SET @CountAvailable1 = dateadd(day,7,@CountAvailable1);
		
	
			SET @AvailableForDate1 = NULL--reset the date
		END

		ELSE -- if the collection is one off or infrequent, the customer will see Thursday dates as available
		BEGIN
			
			select @BookedDate2= count(HowOften) from WasteHealthCollection where ActualColDate= @CountAvailable2
			SELECT @AvailableForDate2 = Available FROM WasteHealthColDates
			WHERE Col_Date = @CountAvailable2
		
		    IF @AvailableForDate2 IS NULL 
			BEGIN
				INSERT INTO WasteHealthColDates (Col_Date, Col_Day, Available, Booked)
				VALUES (@CountAvailable2, @ColDay2, 70 -  @BookedDate2, 0 + @BookedDate2)--insert Thursdays
				set @AvailableForDate2 = 70;
			END
			--if the dates already exist in the calendar, update the number of bookings and available slots against the date picked
			else
			BEGIN
				update WasteHealthColDates
				set Available = 70- @BookedDate2 , --update the Thursdays which already exist in the calendar
				Booked = 0 +  @BookedDate2
				where Col_Date = @CountAvailable2
				set @AvailableForDate2 = 70 - @BookedDate2
			END
			
			
			IF @AvailableForDate2 >= 1	
				SET @DayName = @DayName + 1;

			SET @CountAvailable2 = dateadd(day,7,@CountAvailable2);
	
			SET @AvailableForDate2= NULL--reset the date
		END
	END


	

		
	




		--this is what the customer will see in the form
	
		IF  @HowOften = 'Regular'--if the collection is regular, the customer will see Wednesday dates as available
		SELECT distinct Col_Day + ' ' + CONVERT( VARCHAR(20), Col_Date, 103) as display, Col_Date as name from WasteHealthColDates
		WHERE (Available >= 1 OR @overRide = @password) AND Col_Date >= @ColDate1 AND Col_Day = 'Wednesday'
		ORDER BY  name ASC

		ELSE -- if the collection is one off or infrequent, the customer will see Thursday dates as available
		SELECT distinct Col_Day + ' ' + CONVERT( VARCHAR(20), Col_Date, 103) as display, Col_Date as name from WasteHealthColDates
		WHERE (Available >= 1 OR @overRide = @password) AND  Col_Date >= @ColDate2 AND Col_Day = 'Thursday'
		ORDER BY name ASC


END



GO

