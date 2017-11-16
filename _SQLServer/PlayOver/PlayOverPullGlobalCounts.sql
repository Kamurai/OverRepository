--drop PROCEDURE PlayOverPullGlobalCounts;

create PROCEDURE PlayOverPullGlobalCounts
AS
BEGIN
	select count(Indext) as retNum from VideoGames
    UNION all
	--Genres
    select count(Genre) from VideoGames where Genre = 'TwoDP'
    UNION all
    select count(Genre) from VideoGames where Genre = 'ThreeDP'
    UNION all
    select count(Genre) from VideoGames where Genre = 'FPS'
    UNION all
    select count(Genre) from VideoGames where Genre = 'FPP'
	UNION all
    select count(Genre) from VideoGames where Genre = 'VPuzzle'
	UNION all
    select count(Genre) from VideoGames where Genre = 'Bulletstorm'
	UNION all
    select count(Genre) from VideoGames where Genre = 'Fighting'
	UNION all
    select count(Genre) from VideoGames where Genre = 'Stealth'
	UNION all
    select count(Genre) from VideoGames where Genre = 'Survival'
	UNION all
    select count(Genre) from VideoGames where Genre = 'VN'
	UNION all
    select count(Genre) from VideoGames where Genre = 'IM'
	UNION all
    select count(Genre) from VideoGames where Genre = 'RPG'
	UNION all
    select count(Genre) from VideoGames where Genre = 'TRPG'
	UNION all
    select count(Genre) from VideoGames where Genre = 'ARPG'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Sports'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Racing'
	UNION all
	select count(Genre) from VideoGames where Genre = 'RTS'
	UNION all
	select count(Genre) from VideoGames where Genre = 'TBS'
	UNION all
	select count(Genre) from VideoGames where Genre = 'VE'
	UNION all
	select count(Genre) from VideoGames where Genre = 'MMO'
	UNION all
	select count(Genre) from VideoGames where Genre = 'MOBA'
	--Settings
	UNION all
	select count(Genre) from VideoGames where Genre = 'PC'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Atari'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Commodore64'
	UNION all
	select count(Genre) from VideoGames where Genre = 'FAMICOM'
	UNION all
	select count(Genre) from VideoGames where Genre = 'NES'
	UNION all
	select count(Genre) from VideoGames where Genre = 'SNES'
	UNION all
	select count(Genre) from VideoGames where Genre = 'N64'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Gamecube'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Wii'
	UNION all
	select count(Genre) from VideoGames where Genre = 'WiiU'
	UNION all
	select count(Genre) from VideoGames where Genre = 'NintendoSwitch'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Gameboy'
	UNION all
	select count(Genre) from VideoGames where Genre = 'VirtualBoy'
	UNION all
	select count(Genre) from VideoGames where Genre = 'GBA'
	UNION all
	select count(Genre) from VideoGames where Genre = 'DS'
	UNION all
	select count(Genre) from VideoGames where Genre = 'ThreeDS'
	UNION all
	select count(Genre) from VideoGames where Genre = 'SegaGenesis'
	UNION all
	select count(Genre) from VideoGames where Genre = 'SegaCD'
	UNION all
	select count(Genre) from VideoGames where Genre = 'SegaDreamcast'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PS1'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PS2'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PS3'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PS4'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PSP'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PSVita'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Xbox'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Xbox360'
	UNION all
	select count(Genre) from VideoGames where Genre = 'XboxOne'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Ouya'
	UNION all
	select count(Genre) from VideoGames where Genre = 'OculusRift'
	UNION all
	select count(Genre) from VideoGames where Genre = 'Vive'
	UNION all
	select count(Genre) from VideoGames where Genre = 'PSVR'
;
END