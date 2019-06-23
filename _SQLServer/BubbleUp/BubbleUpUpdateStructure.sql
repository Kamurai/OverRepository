--drop PROCEDURE BubbleUpUpdateStructure;

create PROCEDURE BubbleUpUpdateStructure
(
	@intUserIndex		int,
	@boxIdList			varchar(max),
	@boxLabelList		varchar(max),
	@targetIdList		varchar(max),
	@targetLabelList	varchar(max)
)
AS
BEGIN
	DECLARE @checkBoxes		BIT = 1;
	DECLARE @trackerIds		int = 0;
	DECLARE @startIds		int = 0;
	DECLARE @strId			varchar(max) = '';

	DECLARE @trackerLabels	int = 0;
	DECLARE @startLabels	int = 0;
	DECLARE @strLabel		varchar(max) = '';

	DECLARE @checkTargets	BIT = 1;
	
	WHILE (@checkBoxes = 1)
	BEGIN
		--while we are searching for the next id
		WHILE ((SUBSTRING(@boxIdList,@trackerIds,1) != ',') AND (@trackerIds < LEN(@boxIdList)))
		BEGIN
			SET @trackerIds = @trackerIds + 1;
		END
		IF((@trackerIds > LEN(@boxIdList)))
		BEGIN
			SET @checkBoxes = 0;
			BREAK;
		END
		SET @strId		= SUBSTRING(@boxIdList,@startIds,@trackerIds-@startIds+1);
		SET @trackerIds = @trackerIds + 1;
		SET @startIds	= @trackerIds;
				
		--while we are searching for the next label
		WHILE ((SUBSTRING(@boxLabelList,@trackerLabels,1) != ',') AND (@trackerLabels < LEN(@boxLabelList)))
		BEGIN
			SET @trackerLabels = @trackerLabels + 1;
		END
		IF((@trackerLabels > LEN(@boxLabelList)))
		BEGIN
			SET @checkBoxes = 0;
			BREAK;
		END
		SET @strLabel		= SUBSTRING(@boxLabelList,@startLabels,@trackerLabels-@startLabels+1);
		SET @trackerLabels	= @trackerLabels + 1;
		SET @startLabels	= @trackerLabels;

		IF(
		(LEN(@strLabel) > 0) AND
		(LEN(@strId) > 0)
		)
		BEGIN
			UPDATE Boxes SET Label = @strLabel WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @strId;
		END
	END

	SET @trackerIds		= 0;
	SET @startIds		= 0;
	SET @strId			= '';

	SET @trackerLabels	= 0;
	SET @startLabels	= 0;
	SET @strLabel		= '';

	WHILE (@checkTargets = 1)
	BEGIN
		--while we are searching for the next id
		WHILE ((SUBSTRING(@targetIdList,@trackerIds,1) != ',') AND (@trackerIds < LEN(@targetIdList)))
		BEGIN
			SET @trackerIds = @trackerIds + 1;
		END
		IF((@trackerIds >= LEN(@targetIdList)))
		BEGIN
			SET @checkTargets = 0;
			BREAK;
		END
		SET @strId		= SUBSTRING(@targetIdList,@startIds,@trackerIds-@startIds+1);
		SET @trackerIds = @trackerIds + 1;
		SET @startIds	= @trackerIds;

		UPDATE Boxes SET Label = @strLabel WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @strId;
				
		--while we are searching for the next label
		WHILE ((SUBSTRING(@targetLabelList,@trackerLabels,1) != ',') AND (@trackerLabels < LEN(@targetLabelList)))
		BEGIN
			SET @trackerLabels = @trackerLabels + 1;
		END
		IF((@trackerLabels >= LEN(@targetLabelList)))
		BEGIN
			SET @checkTargets = 0;
			BREAK;
		END
		SET @strLabel		= SUBSTRING(@targetLabelList,@startLabels,@trackerLabels-@startLabels+1);
		SET @trackerLabels	= @trackerLabels + 1;
		SET @startLabels	= @trackerLabels;

		IF(
		(LEN(@strLabel) > 0) AND
		(LEN(@strId) > 0)
		)
		BEGIN
			UPDATE Targets SET Label = @strLabel WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @strId;
		END
	END
	
END