--drop PROCEDURE PlayOverPullUserCounts;

create PROCEDURE PlayOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from Users where AdminLevel = 0
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 1
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 2
    UNION all
	--Genres
	select count(TwoDP) from PlayOverUsers where TwoDP = 1
    UNION all
    select count(ThreeDP) from PlayOverUsers where ThreeDP = 1
    UNION all
    select count(FPS) from PlayOverUsers where FPS = 1
    UNION all
    select count(FPP) from PlayOverUsers where FPP = 1
	UNION all
    select count(VPuzzle) from PlayOverUsers where VPuzzle = 1
	UNION all
	select count(Bulletstorm) from PlayOverUsers where Bulletstorm = 1
	UNION all
	select count(Fighting) from PlayOverUsers where Fighting = 1
	UNION all
	select count(Stealth) from PlayOverUsers where Stealth = 1
	UNION all
	select count(Survival) from PlayOverUsers where Survival = 1
	UNION all
	select count(VN) from PlayOverUsers where VN = 1
	UNION all
	select count(IM) from PlayOverUsers where IM = 1
	UNION all
	select count(RPG) from PlayOverUsers where RPG = 1
	UNION all
    select count(TRPG) from PlayOverUsers where TRPG = 1
	UNION all
    select count(ARPG) from PlayOverUsers where ARPG = 1
	UNION all
    select count(Sports) from PlayOverUsers where Sports = 1
    UNION all
	select count(Racing) from PlayOverUsers where Racing = 1
    UNION all
	select count(RTS) from PlayOverUsers where RTS = 1
    UNION all
	select count(TBS) from PlayOverUsers where TBS = 1
    UNION all
	select count(VE) from PlayOverUsers where VE = 1
    UNION all
	select count(MMO) from PlayOverUsers where MMO = 1
    UNION all
	select count(MOBA) from PlayOverUsers where MOBA = 1
    UNION all
	--Platforms
	select count(PC) from PlayOverUsers where PC = 1
    UNION all
	select count(Atari) from PlayOverUsers where Atari = 1
    UNION all
	select count(Commodore64) from PlayOverUsers where Commodore64 = 1
    UNION all
	select count(FAMICOM) from PlayOverUsers where FAMICOM = 1
    UNION all
	select count(NES) from PlayOverUsers where NES = 1
    UNION all
	select count(SNES) from PlayOverUsers where SNES = 1
    UNION all
	select count(N64) from PlayOverUsers where N64 = 1
    UNION all
	select count(Gamecube) from PlayOverUsers where Gamecube = 1
    UNION all
	select count(Wii) from PlayOverUsers where Wii = 1
    UNION all
	select count(WiiU) from PlayOverUsers where WiiU = 1
    UNION all
	select count(NintendoSwitch) from PlayOverUsers where NintendoSwitch = 1
    UNION all
	select count(Gameboy) from PlayOverUsers where Gameboy = 1
    UNION all
	select count(VirtualBoy) from PlayOverUsers where VirtualBoy = 1
    UNION all
	select count(GBA) from PlayOverUsers where GBA = 1
    UNION all
	select count(DS) from PlayOverUsers where DS = 1
    UNION all
	select count(ThreeDS) from PlayOverUsers where ThreeDS = 1
    UNION all
	select count(SegaGenesis) from PlayOverUsers where SegaGenesis = 1
    UNION all
	select count(SegaCD) from PlayOverUsers where SegaCD = 1
    UNION all
	select count(SegaDreamcast) from PlayOverUsers where SegaDreamcast = 1
    UNION all
	select count(PS1) from PlayOverUsers where PS1 = 1
    UNION all
	select count(PS2) from PlayOverUsers where PS2 = 1
    UNION all
	select count(PS3) from PlayOverUsers where PS3 = 1
    UNION all
	select count(PS4) from PlayOverUsers where PS4 = 1
    UNION all
	select count(PSP) from PlayOverUsers where PSP = 1
    UNION all
	select count(PSVita) from PlayOverUsers where PSVita = 1
    UNION all
	select count(Xbox) from PlayOverUsers where Xbox = 1
    UNION all
	select count(Xbox360) from PlayOverUsers where Xbox360 = 1
    UNION all
	select count(XboxOne) from PlayOverUsers where XboxOne = 1
    UNION all
	select count(Ouya) from PlayOverUsers where Ouya = 1
    UNION all
	select count(OculusRift) from PlayOverUsers where OculusRift = 1
    UNION all
	select count(Vive) from PlayOverUsers where Vive = 1
    UNION all
	select count(PSVR) from PlayOverUsers where PSVR = 1
    UNION all
	select count(LoggedOn) from PlayOverUsers where LoggedOn = 1;
END