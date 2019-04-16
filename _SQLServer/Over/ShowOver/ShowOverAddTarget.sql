--drop PROCEDURE ShowOverAddTarget;

create PROCEDURE ShowOverAddTarget
(
    @strShowName varChar(50),
	@strShowRelease varChar(50),
	@strShowGenre varChar(50),
	@strShowPicture varChar(50),
	@intUserIndex int
    
)
AS
BEGIN
	INSERT INTO Shows (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strShowName, @strShowRelease, @strShowGenre, @strShowPicture, @intUserIndex );

	DELETE FROM ShowRequests where Name = @strShowName;
END