--drop PROCEDURE ShowOverAddTargetSuggestion;

create PROCEDURE ShowOverAddTargetSuggestion
(
    @strShowName varChar(50),
	@strShowRelease varChar(50),
	@strShowGenre varChar(50),
	@strShowPicture varChar(50),
	@intUserIndex int    
)
AS
BEGIN
	INSERT INTO ShowRequests (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strShowName, @strShowRelease, @strShowGenre, @strShowPicture, @intUserIndex );
END