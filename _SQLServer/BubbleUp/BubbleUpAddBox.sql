 --drop PROCEDURE BubbleUpAddBox;

create PROCEDURE BubbleUpAddBox(
	@intUserIndex			int,
	@intTargetBoxIndex		int,
	@intLocationRank		int
)
AS
BEGIN
	PRINT('BubbleUpAddBox');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',	@intTargetBoxIndex));
	PRINT(CONCAT('@intLocationRank: ',		@intLocationRank));
	
	DECLARE @newRank	int;

	--IF @intLocationRank == -2
	IF(@intLocationRank = -2)
	BEGIN
		SET @newRank = (SELECT MAX(Rank) FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
		PRINT(CONCAT('@newRank: ',		@newRank));
	
		IF(@newRank IS NULL)
		BEGIN
			SET @newRank = 0;
		END
		PRINT(CONCAT('@newRank: ',		@newRank));
	END
	--ELSE
	ELSE
	BEGIN
		SET @newRank = @intLocationRank;
	END

	--Push targets forward in the list
	EXEC BubbleUpUpdateRankBoxes @intUserIndex, @intTargetBoxIndex, @newRank, 1;

	INSERT INTO BOXES (UserIndex, Label, Direction, ParentBoxIndex, Rank) 
	VALUES (@intUserIndex, '', 'Horizontal', @intTargetBoxIndex, @newRank);
END