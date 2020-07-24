--drop PROCEDURE BangOverAddTargetSuggestion;

create PROCEDURE BangOverAddTargetSuggestion(
    @strCelebrityName varChar(50),
	@strCelebrityGender varChar(1),
	@strCelebrityPicture varChar(50),
	@intUserIndex int
)
AS
BEGIN
	INSERT INTO CelebrityRequests (Name, Gender, Picture, UploadUserIndex) VALUES ( @strCelebrityName, @strCelebrityGender, @strCelebrityPicture, @intUserIndex );
END