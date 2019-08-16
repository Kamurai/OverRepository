 --drop PROCEDURE BubbleUpAddBox;

create PROCEDURE BubbleUpAddBox(
	@intUserIndex			int,
	@intTargetBoxIndex		int,
	@intLocationOrderRank	int
)
AS
BEGIN
	PRINT('BubbleUpAddBox');
	PRINT(CONCAT('@intUserIndex: ',				@intUserIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',		@intTargetBoxIndex));
	PRINT(CONCAT('@intLocationOrderRank: ',		@intLocationOrderRank));
	
	DECLARE @newOrderRank	int;

	--IF @intLocationOrderRank == -2
	IF(@intLocationOrderRank = -2)
	BEGIN
		SET @newOrderRank = (SELECT MAX(OrderRank) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
		PRINT(CONCAT('@newOrderRank: ',		@newOrderRank));
	
		IF(@newOrderRank IS NULL)
		BEGIN
			SET @newOrderRank = 0;
		END
		PRINT(CONCAT('@newOrderRank: ',		@newOrderRank));
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END

	--Push targets forward in the list
	EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @intTargetBoxIndex, @newOrderRank, 1;

	INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) 
	VALUES (@intUserIndex, '', 'Horizontal', @intTargetBoxIndex, @newOrderRank);
END