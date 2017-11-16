--drop PROCEDURE PlayOverAddTargetSuggestion;

create PROCEDURE PlayOverAddTargetSuggestion
(
    @strVideoGameName varChar(50),
	@strVideoGameRelease varChar(50),
	@strVideoGamePlatform varChar(50),
	@strVideoGameGenre varChar(50),
	@strVideoGamePicture varChar(50)
    
)
AS
BEGIN
	INSERT INTO VideoGameRequests (Name, Release, GamePlatform, Genre, Picture ) VALUES ( @strVideoGameName, @strVideoGameRelease, @strVideoGamePlatform, @strVideoGameGenre, @strVideoGamePicture );
END