--drop PROCEDURE BangOverClearMemories;

create PROCEDURE BangOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM BangOverMemories where UserIndex = @intUserIndex;
END