--drop PROCEDURE BoardOverAddTargetSuggestion;

create PROCEDURE BoardOverAddTargetSuggestion
(
    @strBoardGameName varChar(50),
	@strBoardGameRelease varChar(50),
	@strBoardGameGenre varChar(50),
	@strBoardGamePicture varChar(50),
	@intUserIndex int
)
AS
BEGIN
	INSERT INTO BoardGameRequests (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strBoardGameName, @strBoardGameRelease, @strBoardGameGenre, @strBoardGamePicture, @intUserIndex );
END