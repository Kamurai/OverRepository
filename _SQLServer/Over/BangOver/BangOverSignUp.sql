--drop procedure BangOverSignUp;

create PROCEDURE BangOverSignUp(
    @strUsername	varchar(max),
	@strEmail		varchar(max),
	@strPasscode	varchar(max),
	/*Genders*/
    @bitWomen		bit,
	@bitMen			bit,
	@bitTransWomen	bit,
	@bitTransMen	bit
)
AS
BEGIN
	IF( (select count(*) from [HTKB].dbo.Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO [HTKB].dbo.Users (
		AdminLevel, Online, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update U SET 
		/*Genders*/
		U.Women 		= @bitWomen, 
		U.Men 			= @bitMen, 
		U.TransWomen 	= @bitTransWomen, 
		U.TransMen 		= @bitTransMen

		FROM [Over].dbo.BangOverUsers U
		JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
		WHERE H.Username = @strUsername;
	END
END