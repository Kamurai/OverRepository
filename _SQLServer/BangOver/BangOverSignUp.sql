--drop procedure BangOverSignUp;

create PROCEDURE BangOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),
    @bitWomen bit,
	@bitMen bit,
	@bitTransWomen bit,
	@bitTransMen bit

)
AS
BEGIN
	-- COLLATE SQL_Latin1_General_CP1_CS_AS

	if( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO Users (Username, Email, Passcode, AdminLevel)
		VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
	END

	if( (select count(*) from Users JOIN BangOverUsers ON Users.UserIndex = MasterUserIndex where Username = @strUsername) = 0)
	BEGIN
		DECLARE @TargetUserIndex int = (select UserIndex from Users where Username = @strUsername);

	INSERT INTO BangOverUsers (MasterUserIndex, LoggedOn, Women, Men, TransWomen, TransMen)
	VALUES ( @TargetUserIndex, 0, @bitWomen, @bitMen, @bitTransWomen, @bitTransMen );
	END
END