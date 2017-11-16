--drop PROCEDURE PlayOverGetValidUser;

create PROCEDURE PlayOverGetValidUser
(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does not exists
	IF( (select count(*) from Users where Username = @strUsername) = 1 )
	BEGIN
		
		--if user does not exist in Video Over table
		IF( (select count(*) from Users, PlayOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
		BEGIN
			--get UserIndex
			DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

			--create default user in Video Over table
			INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR)
		VALUES ( @TargetUserIndex, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, /*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
		END
	END
	
	select * from Users, PlayOverUsers where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS
    and UserIndex = Users.Indext;
END