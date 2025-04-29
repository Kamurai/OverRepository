--drop PROCEDURE PlayOverClearMemories;

CREATE OR ALTER PROCEDURE PlayOverClearMemories(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM PlayOverMemories where UserIndex = @intUserIndex;
END