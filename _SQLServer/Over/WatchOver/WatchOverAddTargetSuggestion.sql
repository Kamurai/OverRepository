--drop PROCEDURE WatchOverAddTargetSuggestion;

create PROCEDURE WatchOverAddTargetSuggestion(
    @strMovieName varChar(50),
	@strMovieRelease varChar(50),
	@strMovieGenre varChar(50),
	@strMoviePicture varChar(50),
	@intUserIndex int    
)
AS
BEGIN
	INSERT INTO MovieRequests (Name, Release, Genre, Picture, UploadUserIndex) VALUES ( @strMovieName, @strMovieRelease, @strMovieGenre, @strMoviePicture, @intUserIndex );
END