--drop PROCEDURE PlayOverPullUserCounts;

create PROCEDURE PlayOverPullUserCounts
AS
BEGIN
	select count(PlayOverAdminLevel) as retNum from [Over].dbo.PlayOveUsers where PlayOverAdminLevel = 0
    UNION all
    select count(PlayOverAdminLevel) from [Over].dbo.PlayOveUsers where PlayOverAdminLevel = 1
    UNION all
    select count(PlayOverAdminLevel) from [Over].dbo.PlayOveUsers where PlayOverAdminLevel = 2
    UNION all
    select count(PlayOverAdminLevel) from [Over].dbo.PlayOveUsers where PlayOverAdminLevel = 3
    UNION all
	--Genres
	select count(TwoDP) from [Over].dbo.PlayOveUsers where TwoDP = 1
    UNION all
    select count(ThreeDP) from [Over].dbo.PlayOveUsers where ThreeDP = 1
    UNION all
    select count(FPS) from [Over].dbo.PlayOveUsers where FPS = 1
    UNION all
    select count(FPP) from [Over].dbo.PlayOveUsers where FPP = 1
	UNION all
    select count(VPuzzle) from [Over].dbo.PlayOveUsers where VPuzzle = 1
	UNION all
	select count(Bulletstorm) from [Over].dbo.PlayOveUsers where Bulletstorm = 1
	UNION all
	select count(Fighting) from [Over].dbo.PlayOveUsers where Fighting = 1
	UNION all
	select count(Stealth) from [Over].dbo.PlayOveUsers where Stealth = 1
	UNION all
	select count(Survival) from [Over].dbo.PlayOveUsers where Survival = 1
	UNION all
	select count(VN) from [Over].dbo.PlayOveUsers where VN = 1
	UNION all
	select count(IM) from [Over].dbo.PlayOveUsers where IM = 1
	UNION all
	select count(RPG) from [Over].dbo.PlayOveUsers where RPG = 1
	UNION all
    select count(TRPG) from [Over].dbo.PlayOveUsers where TRPG = 1
	UNION all
    select count(ARPG) from [Over].dbo.PlayOveUsers where ARPG = 1
	UNION all
    select count(Sports) from [Over].dbo.PlayOveUsers where Sports = 1
    UNION all
	select count(Racing) from [Over].dbo.PlayOveUsers where Racing = 1
    UNION all
	select count(RTS) from [Over].dbo.PlayOveUsers where RTS = 1
    UNION all
	select count(TBS) from [Over].dbo.PlayOveUsers where TBS = 1
    UNION all
	select count(VE) from [Over].dbo.PlayOveUsers where VE = 1
    UNION all
	select count(MMO) from [Over].dbo.PlayOveUsers where MMO = 1
    UNION all
	select count(MOBA) from [Over].dbo.PlayOveUsers where MOBA = 1
    UNION all
	--Platforms
	select count(PC) from [Over].dbo.PlayOveUsers where PC = 1
    UNION all
	select count(Atari) from [Over].dbo.PlayOveUsers where Atari = 1
    UNION all
	select count(Commodore64) from [Over].dbo.PlayOveUsers where Commodore64 = 1
    UNION all
	select count(FAMICOM) from [Over].dbo.PlayOveUsers where FAMICOM = 1
    UNION all
	select count(NES) from [Over].dbo.PlayOveUsers where NES = 1
    UNION all
	select count(SNES) from [Over].dbo.PlayOveUsers where SNES = 1
    UNION all
	select count(N64) from [Over].dbo.PlayOveUsers where N64 = 1
    UNION all
	select count(Gamecube) from [Over].dbo.PlayOveUsers where Gamecube = 1
    UNION all
	select count(Wii) from [Over].dbo.PlayOveUsers where Wii = 1
    UNION all
	select count(WiiU) from [Over].dbo.PlayOveUsers where WiiU = 1
    UNION all
	select count(NintendoSwitch) from [Over].dbo.PlayOveUsers where NintendoSwitch = 1
    UNION all
	select count(Gameboy) from [Over].dbo.PlayOveUsers where Gameboy = 1
    UNION all
	select count(VirtualBoy) from [Over].dbo.PlayOveUsers where VirtualBoy = 1
    UNION all
	select count(GBA) from [Over].dbo.PlayOveUsers where GBA = 1
    UNION all
	select count(DS) from [Over].dbo.PlayOveUsers where DS = 1
    UNION all
	select count(ThreeDS) from [Over].dbo.PlayOveUsers where ThreeDS = 1
    UNION all
	select count(SegaGenesis) from [Over].dbo.PlayOveUsers where SegaGenesis = 1
    UNION all
	select count(SegaCD) from [Over].dbo.PlayOveUsers where SegaCD = 1
    UNION all
	select count(SegaDreamcast) from [Over].dbo.PlayOveUsers where SegaDreamcast = 1
    UNION all
	select count(PS1) from [Over].dbo.PlayOveUsers where PS1 = 1
    UNION all
	select count(PS2) from [Over].dbo.PlayOveUsers where PS2 = 1
    UNION all
	select count(PS3) from [Over].dbo.PlayOveUsers where PS3 = 1
    UNION all
	select count(PS4) from [Over].dbo.PlayOveUsers where PS4 = 1
    UNION all
	select count(PSP) from [Over].dbo.PlayOveUsers where PSP = 1
    UNION all
	select count(PSVita) from [Over].dbo.PlayOveUsers where PSVita = 1
    UNION all
	select count(Xbox) from [Over].dbo.PlayOveUsers where Xbox = 1
    UNION all
	select count(Xbox360) from [Over].dbo.PlayOveUsers where Xbox360 = 1
    UNION all
	select count(XboxOne) from [Over].dbo.PlayOveUsers where XboxOne = 1
    UNION all
	select count(Ouya) from [Over].dbo.PlayOveUsers where Ouya = 1
    UNION all
	select count(OculusRift) from [Over].dbo.PlayOveUsers where OculusRift = 1
    UNION all
	select count(Vive) from [Over].dbo.PlayOveUsers where Vive = 1
    UNION all
	select count(PSVR) from [Over].dbo.PlayOveUsers where PSVR = 1
    UNION all
	select count(PlayOverOnline) from [Over].dbo.PlayOveUsers where PlayOverOnline = 1;
END