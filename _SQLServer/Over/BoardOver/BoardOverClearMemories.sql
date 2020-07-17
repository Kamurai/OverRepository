--drop PROCEDURE BoardOverClearMemories;

create PROCEDURE BoardOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM BoardOverMemories where UserIndex = @intUserIndex;
END