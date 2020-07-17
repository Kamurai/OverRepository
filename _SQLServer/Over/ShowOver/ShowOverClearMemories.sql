--drop PROCEDURE ShowOverClearMemories;

create PROCEDURE ShowOverClearMemories
(
    @intUserIndex int        
)
AS
BEGIN
	DELETE FROM ShowOverMemories where UserIndex = @intUserIndex;
END