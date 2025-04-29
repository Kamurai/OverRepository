--drop PROCEDURE WatchOverClearMemories;

CREATE OR ALTER PROCEDURE WatchOverClearMemories(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM WatchOverMemories where UserIndex = @intUserIndex;
END