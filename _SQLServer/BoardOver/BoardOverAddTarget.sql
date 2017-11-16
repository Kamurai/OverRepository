--drop PROCEDURE BoardOverAddTarget;

create PROCEDURE BoardOverAddTarget
(
    @strBoardGameName varChar(50),
	@strBoardGameRelease varChar(50),
	@strBoardGameGenre varChar(50),
	@strBoardGamePicture varChar(50)
    
)
AS
BEGIN
	INSERT INTO BoardGames (Name, Release, Genre, Picture ) VALUES ( @strBoardGameName, @strBoardGameRelease, @strBoardGameGenre, @strBoardGamePicture );

	DELETE FROM BoardGameRequests where Name = @strBoardGameName;
END