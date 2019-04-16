--drop PROCEDURE BangOverAddTarget;

create PROCEDURE BangOverAddTarget
(
    @strCelebrityName varChar(50),
	@strCelebritySex varChar(1),
	@strCelebrityPicture varChar(50),
	@intUserIndex int
)
AS
BEGIN
	INSERT INTO Celebrities (Name, Sex, Picture, UploadUserIndex) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture, @intUserIndex );

	DELETE FROM CelebrityRequests where Name = @strCelebrityName;
END