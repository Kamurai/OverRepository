--drop PROCEDURE BangOverClearMemories;

create PROCEDURE BangOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM BangOverMemories where BangOverUserIndex = @intUserIndex;
END