USE [ProdRubbishRecycling]
GO

/****** Object:  StoredProcedure [dbo].[WasteHealthRefCheck]    Script Date: 08/07/2019 13:33:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniela Dutu
-- Create date: 16/10/2017
-- Description:	Checks if the customer submitted a health referral form
-- =============================================
CREATE PROCEDURE [dbo].[WasteHealthRefCheck] 
	-- Add the parameters for the stored procedure here
	@WhoAreYou varchar(20),
	@UPRNP int,
	@FirstLineAddressP varchar (20),
	@PostcodeP varchar (20),
	@UPRNC int,
	@FirstLineAddressC varchar (20),
	@PostcodeC varchar (20),
	@CurrentDate date		
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @UPRN_found AS int
	DECLARE @No AS int
	DECLARE @Approved AS varchar (10)
	DECLARE @printMessage varchar (max)
	DECLARE @ApplicationDate date
	--SELECT @ApplicationDate = Date FROM dbo.WasteReferral --date of the application
	DECLARE @MaxInterval date
	SET @MaxInterval = DATEADD(Year, 1, GETDATE())	--this is the maximum time the approval lasts for an infrequent collection
	DECLARE @Frequency varchar (20)
	--SELECT @Frequency = HowOften FROM dbo.WasteHealthCollection
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- If exists, return it and display the message below


		-- Insert statements for procedure here
	IF @WhoAreYou = 'for myself'
	BEGIN
		SELECT TOP (1) @No = 1, @UPRN_found = ID, @Approved = Approved, @Frequency = HowOften , @ApplicationDate = [Date] FROM dbo.WasteHealthCollection 
		WHERE (UPRN = @UPRNP OR (FirstLineAddress =@FirstLineAddressP AND Postcode = @PostcodeP))AND Date < @MaxInterval
		order by ID desc
		--SET @MaxInterval = DATEADD(Year, 1, @ApplicationDate)	--this is the maximum time the approval lasts for an infrequent collection
		IF @UPRN_found IS NOT NULL
			BEGIN
			--SELECT @ApplicationDate = Date FROM dbo.WasteReferral --date of the application
			--SET @MaxInterval = DATEADD(Year, 1, @ApplicationDate)	--this is the maximum time the approval lasts for an infrequent collection
				IF @Approved IS NULL
				SET @printMessage = 'We have received your referral form but it has not yet been approved. Please wait for confirmation of this via email before you complete this form.'
				IF @Approved = 'no'
				SET @printMessage = 'We have received your referral form but this has not been approved, and so you cannot proceed with this form. If you would like to discuss this decision please call the us on 023 9284 1105'
				IF  @Approved = 'Cncl' OR @Frequency = 'Once'
				SET @printMessage = 'We have not been able to find a record of a valid referral form. This may be because you have not submitted a referral form, or because the referral has expired or been cancelled. Please complete the referral form to continue with your request.'
			END	
			ELSE 
			BEGIN
				
				SET @printMessage = 'We have not been able to find a record of a valid referral form. This may be because you have not submitted a referral form, or because the referral has expired or been cancelled. Please complete the referral form to continue with your request.'
				
			END
	END

	
	IF @WhoAreYou = 'for somebody else'
	BEGIN
		SELECT TOP (1) @No = 1, @UPRN_found = ID, @Approved = Approved, @Frequency = HowOften FROM dbo.WasteHealthCollection--@ApplicationDate = Date FROM dbo.WasteHealthCollection
		WHERE (UPRN = @UPRNC OR (FirstLineAddress =@FirstLineAddressC AND Postcode = @PostcodeC))AND Date < @MaxInterval
		SET @MaxInterval = DATEADD(Year, 1, @ApplicationDate)	--this is the maximum time the approval lasts for an infrequent collection
		IF @UPRN_found IS NOT NULL
		BEGIN
		--SELECT @ApplicationDate = Date FROM dbo.WasteReferral --date of the application
		--SET @MaxInterval = DATEADD(Year, 1, @ApplicationDate)	--this is the maximum time the approval lasts for an infrequent collection
			IF @Approved IS NULL
			SET @printMessage = 'We have received your referral form but it has not yet been approved. Please wait for confirmation of this via email before you complete this form.'
			IF @Approved = 'no'
			SET @printMessage = 'We have received your referral form but this has not been approved, and so you cannot proceed with this form. If you would like to discuss this decision please call the us on 023 9284 1105'
			IF @Approved = 'Cncl' OR (@CurrentDate >= @MaxInterval AND @Frequency = 'Infrequent') OR @Frequency = 'Once'
			SET @printMessage = 'We have not been able to find a record of a valid referral form. This may be because you have not submitted a referral form, or because the referral has expired or been cancelled. Please complete the referral form to continue with your request.'
		END
		ELSE 
		BEGIN
			SET @printMessage = 'We have not been able to find a record of a valid referral form. This may be because you have not submitted a referral form, or because the referral has expired or been cancelled. Please complete the referral form to continue with your request.'
			
		END	
	END
	

	SELECT @printMessage AS printMessage
	
	
	
END
GO

