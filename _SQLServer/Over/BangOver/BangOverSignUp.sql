--drop procedure BangOverSignUp;

create PROCEDURE BangOverSignUp
(
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
		HTKBAdminLevel, HTKBOnline, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update B SET 
		/*Genders*/
		Women = @bitWomen, 
		Men = @bitMen, 
		TransWomen = @bitTransWomen, 
		TransMen = @bitTransMen

		FROM [Over].dbo.BangOverUsers B
		JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
		WHERE H.Username = @strUsername;
	END
END