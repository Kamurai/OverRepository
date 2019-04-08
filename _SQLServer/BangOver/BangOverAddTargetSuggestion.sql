--drop PROCEDURE BangOverAddTargetSuggestion;

create PROCEDURE BangOverAddTargetSuggestion
(
    @strCelebrityName varChar(50),
	@strCelebritySex varChar(1),
	@strCelebrityPicture varChar(50),
	@intUserIndex int
)
AS
BEGIN
	INSERT INTO CelebrityRequests (Name, Sex, Picture, UploadUserIndex) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture, @intUserIndex );
END