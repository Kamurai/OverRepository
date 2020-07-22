--drop PROCEDURE WatchOverClearMemories;

create PROCEDURE WatchOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM WatchOverMemories where WatchOverUserIndex = @intUserIndex;
END