--drop PROCEDURE WatchOverAddTarget;

create PROCEDURE WatchOverAddTarget(
    @strMovieName varChar(50),
	@strMovieRelease varChar(50),
	@strMovieGenre varChar(50),
	@strMoviePicture varChar(50)  ,
	@intUserIndex int  
)
AS
BEGIN
	INSERT INTO Movies (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strMovieName, @strMovieRelease, @strMovieGenre, @strMoviePicture, @intUserIndex );

	DELETE FROM MovieRequests where Name = @strMovieName;
END