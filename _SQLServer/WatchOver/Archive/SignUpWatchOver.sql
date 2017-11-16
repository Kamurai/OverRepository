DECLARE @strUsername varchar(max) = 'TestBob';
DECLARE @strEmail varchar(max) = 'TestBob@htkb.com';
DECLARE @strPasscode varchar(max) = 'green20';

DECLARE @bitComedyM bit = 1;
DECLARE @bitDramaM bit = 0;
DECLARE @bitActionM bit = 0;
DECLARE @bitHorrorM bit = 0;
DECLARE @bitThrillerM bit = 0;
DECLARE @bitScienceFictionM bit = 0;
DECLARE @bitFantasyM bit = 0;
DECLARE @bitWesternM bit = 0;
DECLARE @bitMartialArtsM bit = 0;
DECLARE @bitDocumentaryM bit = 0;
DECLARE @bitMockumentaryM bit = 0;



if( (select count(*) from Users where Username = @strUsername) = 0)
BEGIN
	INSERT INTO Users (Username, Email, Passcode, AdminLevel)
	VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
END

if( (select count(*) from Users, WatchOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
BEGIN
	DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

	INSERT INTO WatchOverUsers (UserIndex, LoggedOn, ComedyM, DramaM, ActionM, HorrorM, ThrillerM, ScienceFictionM, FantasyM, WesternM, MartialArtsM, DocumentaryM, MockumentaryM) 
	VALUES ( @TargetUserIndex, 0, @bitComedyM, @bitDramaM, @bitActionM, @bitHorrorM, @bitThrillerM, @bitScienceFictionM, @bitFantasyM, @bitWesternM, @bitMartialArtsM, @bitDocumentaryM, @bitMockumentaryM );
END


select * from Users;

delete from Users where Indext = 6;












