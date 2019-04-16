--drop PROCEDURE PlayOverPullGlobalCounts;

create PROCEDURE PlayOverPullGlobalCounts
AS
BEGIN
	select count(TargetIndex) as retNum from VideoGames
    UNION all
	--Genres
    select count(Genre) from VideoGames where VideoGames.Genre = 'TwoDP'
    UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'ThreeDP'
    UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'FPS'
    UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'FPP'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'VPuzzle'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'Bulletstorm'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'Fighting'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'Stealth'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'Survival'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'VN'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'IM'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'RPG'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'TRPG'
	UNION all
    select count(Genre) from VideoGames where VideoGames.Genre = 'ARPG'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'Sports'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'Racing'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'RTS'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'TBS'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'VE'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'MMO'
	UNION all
	select count(Genre) from VideoGames where VideoGames.Genre = 'MOBA'
	--Platforms
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PC'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Atari'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Commodore64'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'FAMICOM'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'NES'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'SNES'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'N64'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Gamecube'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Wii'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'WiiU'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'NintendoSwitch'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Gameboy'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'VirtualBoy'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'GBA'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'DS'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'ThreeDS'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'SegaGenesis'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'SegaCD'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'SegaDreamcast'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PS1'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PS2'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PS3'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PS4'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PSP'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PSVita'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Xbox'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Xbox360'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'XboxOne'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Ouya'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'OculusRift'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'Vive'
	UNION all
	select count(Genre) from VideoGames where VideoGames.GamePlatform = 'PSVR'
;
END