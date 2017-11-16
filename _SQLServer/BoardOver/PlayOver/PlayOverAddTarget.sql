--drop PROCEDURE PlayOverAddTarget;

create PROCEDURE PlayOverAddTarget
(
    @strVideoGameName varChar(50),
	@strVideoGameRelease varChar(50),
	@strVideoGamePlatform varChar(50),
	@strVideoGameGenre varChar(50),
	@strVideoGamePicture varChar(50)
    
)
AS
BEGIN
	INSERT INTO VideoGames (Name, Release, GamePlatform, Genre, Picture ) VALUES ( @strVideoGameName, @strVideoGameRelease, @strVideoGamePlatform, @strVideoGameGenre, @strVideoGamePicture );

	DELETE FROM VideoGameRequests where Name = @strVideoGameName;
END