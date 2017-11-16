DECLARE @strUsername varchar(max) = 'TestBob';
DECLARE @strEmail varchar(max) = 'TestBob@htkb.com';
DECLARE @strPasscode varchar(max) = 'green20';

DECLARE @bitWomen bit = 1;
DECLARE @bitMen bit = 0;
DECLARE @bitTransWomen bit = 0;
DECLARE @bitTransMen bit = 0;


if( (select count(*) from Users where Username = @strUsername) = 0)
BEGIN
	INSERT INTO Users (Username, Email, Passcode, AdminLevel)
	VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
END

if( (select count(*) from Users, BangOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
BEGIN
	DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

	INSERT INTO BangOverUsers (UserIndex, LoggedOn, Women, Men, TransWomen, TransMen)
	VALUES ( @TargetUserIndex, 0, @bitWomen, @bitMen, @bitTransWomen, @bitTransMen );
END


select * from Users;

delete from Users where Indext = 6;












