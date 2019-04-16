--drop PROCEDURE PlayOverAddTargetSuggestion;

create PROCEDURE PlayOverAddTargetSuggestion
(
    @strVideoGameName varChar(50),
	@strVideoGameRelease varChar(50),
	@strVideoGamePlatform varChar(50),
	@strVideoGameGenre varChar(50),
	@strVideoGamePicture varChar(50),
	@intUserIndex int    
)
AS
BEGIN
	INSERT INTO VideoGameRequests (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ( @strVideoGameName, @strVideoGameRelease, @strVideoGamePlatform, @strVideoGameGenre, @strVideoGamePicture, @intUserIndex );
END