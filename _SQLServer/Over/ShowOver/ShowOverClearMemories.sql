--drop PROCEDURE ShowOverClearMemories;

CREATE OR ALTER PROCEDURE ShowOverClearMemories(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM ShowOverMemories where UserIndex = @intUserIndex;
END