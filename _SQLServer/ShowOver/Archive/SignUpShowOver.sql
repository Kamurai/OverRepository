DECLARE @strUsername varchar(max) = 'TestBob';
DECLARE @strEmail varchar(max) = 'TestBob@htkb.com';
DECLARE @strPasscode varchar(max) = 'green20';

DECLARE @bitComedyS bit = 1;
DECLARE @bitDramaS bit = 0;
DECLARE @bitActionS bit = 0;
DECLARE @bitHorrorS bit = 0;
DECLARE @bitThrillerS bit = 0;
DECLARE @bitScienceFictionS bit = 0;
DECLARE @bitFantasyS bit = 0;
DECLARE @bitWesternS bit = 0;
DECLARE @bitMartialArtsS bit = 0;
DECLARE @bitDocumentaryS bit = 0;
DECLARE @bitMockumentaryS bit = 0;



if( (select count(*) from Users where Username = @strUsername) = 0)
BEGIN
	INSERT INTO Users (Username, Email, Passcode, AdminLevel)
	VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
END

if( (select count(*) from Users, ShowOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
BEGIN
	DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

	INSERT INTO ShowOverUsers (UserIndex, LoggedOn, ComedyS, DramaS, ActionS, HorrorS, ThrillerS, ScienceFictionS, FantasyS, WesternS, MartialArtsS, DocumentaryS, MockumentaryS) 
	VALUES ( @TargetUserIndex, 0, @bitComedyS, @bitDramaS, @bitActionS, @bitHorrorS, @bitThrillerS, @bitScienceFictionS, @bitFantasyS, @bitWesternS, @bitMartialArtsS, @bitDocumentaryS, @bitMockumentaryS );
END


select * from Users;

delete from Users where Indext = 6;












