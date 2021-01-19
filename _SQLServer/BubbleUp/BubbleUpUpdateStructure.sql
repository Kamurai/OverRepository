--drop PROCEDURE BubbleUpUpdateStructure;

create PROCEDURE BubbleUpUpdateStructure(
	@intUserIndex		int,
	@boxIdList			varchar(max),
	@boxLabelList		varchar(max),
	@targetIdList		varchar(max),
	@targetLabelList	varchar(max)
)
AS
BEGIN
	PRINT('BubbleUpUpdateStructure: Start');
	
	DECLARE @checkBoxes		BIT = 1;
	DECLARE @trackerIds		int = 0;
	DECLARE @startIds		int = 0;
	DECLARE @strId			varchar(max) = '';

	DECLARE @trackerLabels	int = 0;
	DECLARE @startLabels	int = 0;
	DECLARE @strLabel		varchar(max) = '';

	DECLARE @checkTargets	BIT = 1;
	
	
	
	PRINT('BubbleUpUpdateStructure: Pre-Boxes');
	
	WHILE (@checkBoxes = 1) 
	BEGIN
	
		PRINT('BubbleUpUpdateStructure: Boxes-Pre-Ids');
	
		--while we are searching for the next id
		WHILE ((SUBSTRING(@boxIdList,@trackerIds,1) != ',') AND (@trackerIds <= LEN(@boxIdList)))
		BEGIN
			SET @trackerIds = @trackerIds + 1;
		END

		PRINT('BubbleUpUpdateStructure: Boxes-Mid-Ids');
	
		IF((@trackerIds > LEN(@boxIdList)))
		BEGIN
			SET @checkBoxes = 0;
			--BREAK;
		END














		PRINT('BubbleUpUpdateStructure: Boxes-Post-Ids');
	
		PRINT('BubbleUpUpdateStructure: Boxes-Pre-Labels');
				
		SET @strId		= SUBSTRING(@boxIdList,@startIds,@trackerIds-@startIds);
		SET @trackerIds = @trackerIds + 1;
		SET @startIds	= @trackerIds;

		--while we are searching for the next label
		WHILE ((SUBSTRING(@boxLabelList,@trackerLabels,1) != ',') AND (@trackerLabels <= LEN(@boxLabelList)))
		BEGIN
			SET @trackerLabels = @trackerLabels + 1;
		END
		IF((@trackerLabels > LEN(@boxLabelList)))
		BEGIN
			SET @checkBoxes = 0;
			--BREAK;
		END
		SET @strLabel		= SUBSTRING(@boxLabelList,@startLabels,@trackerLabels-@startLabels);

		--PRINT(CONCAT('@strLabel: ',		@strLabel));
	
		SET @trackerLabels	= @trackerLabels + 1;
		SET @startLabels	= @trackerLabels;

		PRINT('BubbleUpUpdateStructure: Boxes-Post-Labels');
		
		PRINT('BubbleUpUpdateStructure: Boxes-Pre-Update');

		IF(
		(LEN(@strLabel) > 0) AND
		(LEN(@strId) > 0)
		)
		BEGIN
			PRINT(CONCAT('UserIndex: ',		@intUserIndex));
			PRINT(CONCAT('BoxIndex: ',		@strId));
			PRINT(CONCAT('Label: ',			@strLabel));
			UPDATE Boxes SET Label = @strLabel WHERE UserIndex = @intUserIndex AND BoxIndex = @strId;
		END

		PRINT('BubbleUpUpdateStructure: Boxes-Post-Update');

	END

	PRINT('BubbleUpUpdateStructure: Post-Boxes');
	
	SET @trackerIds		= 0;
	SET @startIds		= 0;
	SET @strId			= '';

	SET @trackerLabels	= 0;
	SET @startLabels	= 0;
	SET @strLabel		= '';

	PRINT('BubbleUpUpdateStructure: Pre-Targets');
	
	WHILE (@checkTargets = 1)
	BEGIN
		
		PRINT('BubbleUpUpdateStructure: Targets-Pre-Ids');
	
		--while we are searching for the next id
		WHILE ((SUBSTRING(@targetIdList,@trackerIds,1) != ',') AND (@trackerIds <= LEN(@targetIdList)))
		BEGIN
			SET @trackerIds = @trackerIds + 1;
		END
		IF((@trackerIds > LEN(@targetIdList)))
		BEGIN
			SET @checkTargets = 0;
		--	BREAK;
		END
		
		PRINT('BubbleUpUpdateStructure: Targets-Post-Ids');
	
		PRINT('BubbleUpUpdateStructure: Targets-Pre-Labels');
				
		--PRINT SUBSTRING(@targetIdList,@startIds,@trackerIds-@startIds);
		SET @strId		= SUBSTRING(@targetIdList,@startIds,@trackerIds-@startIds);
		SET @trackerIds = @trackerIds + 1;
		SET @startIds	= @trackerIds;

		--while we are searching for the next label
		WHILE ((SUBSTRING(@targetLabelList,@trackerLabels,1) != ',') AND (@trackerLabels <= LEN(@targetLabelList)))
		BEGIN
			SET @trackerLabels = @trackerLabels + 1;
		END
		IF((@trackerLabels > LEN(@targetLabelList)))
		BEGIN
			SET @checkTargets = 0;
		--	BREAK;
		END

		--PRINT SUBSTRING(@targetLabelList,@startLabels,@trackerLabels-@startLabels);
		SET @strLabel		= SUBSTRING(@targetLabelList,@startLabels,@trackerLabels-@startLabels);
		SET @trackerLabels	= @trackerLabels + 1;
		SET @startLabels	= @trackerLabels;

		PRINT('BubbleUpUpdateStructure: Targets-Post-Labels');
		
		PRINT('BubbleUpUpdateStructure: Targets-Pre-Update');

		IF(
		(LEN(@strLabel) > 0) AND
		(LEN(@strId) > 0)
		)
		BEGIN
			UPDATE Targets SET Label = @strLabel WHERE UserIndex = @intUserIndex AND TargetIndex = @strId;
			SET @strId			= '';
			SET @strLabel		= '';
		END

		PRINT('BubbleUpUpdateStructure: Targets-Post-Update');

	END

	PRINT('BubbleUpUpdateStructure: Post-Targets');
	

	PRINT('BubbleUpUpdateStructure: End');
END