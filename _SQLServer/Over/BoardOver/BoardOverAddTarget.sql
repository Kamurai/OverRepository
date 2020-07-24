--drop PROCEDURE BoardOverAddTarget;

create PROCEDURE BoardOverAddTarget(
    @strBoardGameName varChar(50),
	@strBoardGameRelease varChar(50),
	@strBoardGameGenre varChar(50),
	@strBoardGamePicture varChar(50),
	@intUserIndex int   
)
AS
BEGIN
	INSERT INTO BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strBoardGameName, @strBoardGameRelease, @strBoardGameGenre, @strBoardGamePicture, @intUserIndex );

	DELETE FROM BoardGameRequests where Name = @strBoardGameName;
END