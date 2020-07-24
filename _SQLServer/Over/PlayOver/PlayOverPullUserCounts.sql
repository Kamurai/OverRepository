--drop PROCEDURE PlayOverPullUserCounts;

create PROCEDURE PlayOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum 	from [Over].dbo.PlayOverUsers where AdminLevel = 0
    UNION all
    select count(AdminLevel) 			from [Over].dbo.PlayOverUsers where AdminLevel = 1
    UNION all
    select count(AdminLevel) 			from [Over].dbo.PlayOverUsers where AdminLevel = 2
    UNION all
    select count(AdminLevel) 			from [Over].dbo.PlayOverUsers where AdminLevel = 3
    UNION all
	--Genres
	select count(TwoDP) 				from [Over].dbo.PlayOverUsers where TwoDP = 1
    UNION all
    select count(ThreeDP) 				from [Over].dbo.PlayOverUsers where ThreeDP = 1
    UNION all
    select count(FPS) 					from [Over].dbo.PlayOverUsers where FPS = 1
    UNION all
    select count(FPP) 					from [Over].dbo.PlayOverUsers where FPP = 1
	UNION all
    select count(VPuzzle) 				from [Over].dbo.PlayOverUsers where VPuzzle = 1
	UNION all
	select count(Bulletstorm) 			from [Over].dbo.PlayOverUsers where Bulletstorm = 1
	UNION all
	select count(Fighting) 				from [Over].dbo.PlayOverUsers where Fighting = 1
	UNION all
	select count(Stealth) 				from [Over].dbo.PlayOverUsers where Stealth = 1
	UNION all
	select count(Survival) 				from [Over].dbo.PlayOverUsers where Survival = 1
	UNION all
	select count(VN) 					from [Over].dbo.PlayOverUsers where VN = 1
	UNION all
	select count(IM) 					from [Over].dbo.PlayOverUsers where IM = 1
	UNION all
	select count(RPG) 					from [Over].dbo.PlayOverUsers where RPG = 1
	UNION all
    select count(TRPG) 					from [Over].dbo.PlayOverUsers where TRPG = 1
	UNION all
    select count(ARPG) 					from [Over].dbo.PlayOverUsers where ARPG = 1
	UNION all
    select count(Sports)				from [Over].dbo.PlayOverUsers where Sports = 1
    UNION all
	select count(Racing) 				from [Over].dbo.PlayOverUsers where Racing = 1
    UNION all
	select count(RTS) 					from [Over].dbo.PlayOverUsers where RTS = 1
    UNION all
	select count(TBS) 					from [Over].dbo.PlayOverUsers where TBS = 1
    UNION all
	select count(VE) 					from [Over].dbo.PlayOverUsers where VE = 1
    UNION all
	select count(MMO) 					from [Over].dbo.PlayOverUsers where MMO = 1
    UNION all
	select count(MOBA) 					from [Over].dbo.PlayOverUsers where MOBA = 1
    UNION all
	--Platforms
	select count(PC) 					from [Over].dbo.PlayOverUsers where PC = 1
    UNION all
	select count(Atari) 				from [Over].dbo.PlayOverUsers where Atari = 1
    UNION all
	select count(Commodore64) 			from [Over].dbo.PlayOverUsers where Commodore64 = 1
    UNION all
	select count(FAMICOM) 				from [Over].dbo.PlayOverUsers where FAMICOM = 1
    UNION all
	select count(NES) 					from [Over].dbo.PlayOverUsers where NES = 1
    UNION all
	select count(SNES) 					from [Over].dbo.PlayOverUsers where SNES = 1
    UNION all
	select count(N64) 					from [Over].dbo.PlayOverUsers where N64 = 1
    UNION all
	select count(Gamecube) 				from [Over].dbo.PlayOverUsers where Gamecube = 1
    UNION all
	select count(Wii) 					from [Over].dbo.PlayOverUsers where Wii = 1
    UNION all
	select count(WiiU) 					from [Over].dbo.PlayOverUsers where WiiU = 1
    UNION all
	select count(NintendoSwitch) 		from [Over].dbo.PlayOverUsers where NintendoSwitch = 1
    UNION all
	select count(Gameboy) 				from [Over].dbo.PlayOverUsers where Gameboy = 1
    UNION all
	select count(VirtualBoy) 			from [Over].dbo.PlayOverUsers where VirtualBoy = 1
    UNION all
	select count(GBA) 					from [Over].dbo.PlayOverUsers where GBA = 1
    UNION all
	select count(DS) 					from [Over].dbo.PlayOverUsers where DS = 1
    UNION all
	select count(ThreeDS) 				from [Over].dbo.PlayOverUsers where ThreeDS = 1
    UNION all
	select count(SegaGenesis)			from [Over].dbo.PlayOverUsers where SegaGenesis = 1
    UNION all
	select count(SegaCD) 				from [Over].dbo.PlayOverUsers where SegaCD = 1
    UNION all
	select count(SegaDreamcast) 		from [Over].dbo.PlayOverUsers where SegaDreamcast = 1
    UNION all
	select count(PS1)					from [Over].dbo.PlayOverUsers where PS1 = 1
    UNION all
	select count(PS2) 					from [Over].dbo.PlayOverUsers where PS2 = 1
    UNION all
	select count(PS3) 					from [Over].dbo.PlayOverUsers where PS3 = 1
    UNION all
	select count(PS4) 					from [Over].dbo.PlayOverUsers where PS4 = 1
    UNION all
	select count(PSP) 					from [Over].dbo.PlayOverUsers where PSP = 1
    UNION all
	select count(PSVita) 				from [Over].dbo.PlayOverUsers where PSVita = 1
    UNION all
	select count(Xbox) 					from [Over].dbo.PlayOverUsers where Xbox = 1
    UNION all
	select count(Xbox360) 				from [Over].dbo.PlayOverUsers where Xbox360 = 1
    UNION all
	select count(XboxOne) 				from [Over].dbo.PlayOverUsers where XboxOne = 1
    UNION all
	select count(Ouya) 					from [Over].dbo.PlayOverUsers where Ouya = 1
    UNION all
	select count(OculusRift) 			from [Over].dbo.PlayOverUsers where OculusRift = 1
    UNION all
	select count(Vive) 					from [Over].dbo.PlayOverUsers where Vive = 1
    UNION all
	select count(PSVR) 					from [Over].dbo.PlayOverUsers where PSVR = 1
    UNION all
	select count(Online) 				from [Over].dbo.PlayOverUsers where Online = 1;
END