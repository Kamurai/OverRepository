select * from TARGETS WHERE BubbleUpUserIndex = 0;
select * from BOXES WHERE BubbleUpUserIndex = 0;

Update Boxes SET OrderRank = 0 WHERE BoxIndex = 0;
Update Boxes SET OrderRank = 0 WHERE BoxIndex = 28;
Update Boxes SET OrderRank = 1 WHERE BoxIndex = 30;

EXEC BubbleUpMoveBoxAfter	0, 28
EXEC BubbleUpMoveBoxBefore	0, 30

EXEC BubbleUpMoveBoxAfter	0, 30
EXEC BubbleUpMoveBoxBefore	0, 28

EXEC BubbleUpMoveTargetAfter	0, 22
EXEC BubbleUpMoveTargetBefore	0, 30

SELECT TOP 1 ParentBoxIndex	FROM TARGETS	WHERE BubbleUpUserIndex = 0 AND TargetIndex = 23

Update Targets SET OrderRank = 0 WHERE TargetIndex = 10035;
Update Targets SET OrderRank = 1 WHERE TargetIndex = 10036;
Update Targets SET OrderRank = 2 WHERE TargetIndex = 10037;

EXEC BubbleUpAddBoxToBox 0, 1;

DELETE FROM TARGETS;
DELETE FROM BOXES WHERE BoxIndex != 0;