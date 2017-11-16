DECLARE @strUsername varchar(max) = 'TestBob';
DECLARE @strEmail varchar(max) = 'TestBob@htkb.com';
DECLARE @strPasscode varchar(max) = 'green20';

DECLARE @bitTwoDP bit = 1;
DECLARE @bitThreeDP bit = 0;
DECLARE @bitFPS bit = 0;
DECLARE @bitFPP bit = 0;
DECLARE @bitVPuzzle bit = 0;
DECLARE @bitBulletstorm bit = 0;
DECLARE @bitFighting bit = 0;
DECLARE @bitStealth bit = 0;
DECLARE @bitSurvival bit = 0;
DECLARE @bitVN bit = 0;
DECLARE @bitIM bit = 0;
DECLARE @bitRPG bit = 0;
DECLARE @bitTRPG bit = 0;
DECLARE @bitARPG bit = 0;
DECLARE @bitSports bit = 0;
DECLARE @bitRacing bit = 0;
DECLARE @bitRTS bit = 0;
DECLARE @bitTBS bit = 0;
DECLARE @bitVE bit = 0;
DECLARE @bitMMO bit = 0;


if( (select count(*) from Users where Username = @strUsername) = 0)
BEGIN
	INSERT INTO Users (Username, Email, Passcode, AdminLevel)
	VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
END

if( (select count(*) from Users, PlayOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
BEGIN
	DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

	insert into PlayOverUsers ( UserIndex, LoggedOn, TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO )
	VALUES ( @TargetUserIndex, 0, @bitTwoDP, @bitThreeDP, @bitFPS, @bitFPP, @bitVPuzzle, @bitBulletstorm, @bitFighting, @bitStealth, @bitSurvival, @bitVN, @bitIM, @bitRPG, @bitTRPG, @bitARPG, @bitSports,	@bitRacing, @bitRTS, @bitTBS, @bitVE, @bitMMO );
END


select * from Users;

delete from Users where Indext = 6;












