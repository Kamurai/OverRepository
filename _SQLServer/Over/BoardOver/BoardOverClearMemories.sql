--drop PROCEDURE BoardOverClearMemories;

create PROCEDURE BoardOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM BoardOverMemories where BoardOverUserIndex = @intUserIndex;
END