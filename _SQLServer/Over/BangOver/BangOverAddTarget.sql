--drop PROCEDURE BangOverAddTarget;

create PROCEDURE BangOverAddTarget(
    @strCelebrityName varChar(50),
	@strCelebrityGender varChar(1),
	@strCelebrityPicture varChar(50),
	@intUserIndex int
)
AS
BEGIN
	INSERT INTO Celebrities (Name, Gender, Picture, UploadUserIndex) VALUES ( @strCelebrityName, @strCelebrityGender, @strCelebrityPicture, @intUserIndex );

	DELETE FROM CelebrityRequests where Name = @strCelebrityName;
END