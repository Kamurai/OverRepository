 --drop PROCEDURE BubbleUpAddTarget;

create PROCEDURE BubbleUpAddTarget(
	@intUserIndex			int,
	@intTargetBoxIndex		int,
	@intLocationRank		int
)
AS
BEGIN
	DECLARE @newRank	int;

	--IF @intLocationRank == -2
	IF(@intLocationRank = -2)
	BEGIN
		SET @newRank = (SELECT MAX(Rank) FROM TARGETS WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
		
		IF(@newRank IS NULL)
		BEGIN
			SET @newRank = 0;
		END
	END
	--ELSE
	ELSE
	BEGIN
		SET @newRank = @intLocationRank;
	END

	--Push targets forward in the list
	EXEC BubbleUpUpdateRankTargets @intUserIndex, @intTargetBoxIndex, @newRank, 1;

	INSERT INTO TARGETS (UserIndex, Label, ParentBoxIndex, Rank) 
	VALUES (@intUserIndex, '', @intTargetBoxIndex, @newRank);
END