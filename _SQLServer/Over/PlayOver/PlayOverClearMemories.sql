--drop PROCEDURE PlayOverClearMemories;

create PROCEDURE PlayOverClearMemories(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM PlayOverMemories where UserIndex = @intUserIndex;
END