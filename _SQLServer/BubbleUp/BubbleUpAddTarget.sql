 --drop PROCEDURE BubbleUpAddTarget;

create PROCEDURE BubbleUpAddTarget(
	@intUserIndex			int,
	@intTargetBoxIndex		int,
	@intLocationOrderRank	int
)
AS
BEGIN
	DECLARE @newOrderRank	int;

	--IF @intLocationOrderRank == -2
	IF(@intLocationOrderRank = -2)
	BEGIN
		SET @newOrderRank = (SELECT MAX(OrderRank) FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
		
		IF(@newOrderRank IS NULL)
		BEGIN
			SET @newOrderRank = 0;
		END
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END

	--Push targets forward in the list
	EXEC BubbleUpUpdateOrderRankTargets @intUserIndex, @intTargetBoxIndex, @newOrderRank, 1;

	INSERT INTO TARGETS (BubbleUpUserIndex, Label, ParentBoxIndex, OrderRank) 
	VALUES (@intUserIndex, '', @intTargetBoxIndex, @newOrderRank);
END