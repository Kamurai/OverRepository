--Kamurai
--HTKB
INSERT INTO [HTKB].dbo.Users (HTKBAdminLevel, HTKBOnline, Username, Passcode, Email) 
VALUES (3, 0, 'Kamurai', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Kamurai';
--BoardOver
Update B SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Kamurai';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Kamurai';
--ShowOver
Update S SET 
/*Genres*/ ComedyS = 1, DramaS = 1, ActionS = 1, HorrorS = 1, ThrillerS = 1, MysteryS = 1, DocumentaryS = 1,  
/*Settings*/ ScienceFictionS = 1, FantasyS = 1, WesternS = 1, MartialArtsS = 1, ModernS = 1, HistoricS = 1, PrehistoricS = 1, ComicsS = 1, PeriodS = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Kamurai';
--WatchOver
Update W SET 
/*Genres*/ ComedyM = 1, DramaM = 1, ActionM = 1, HorrorM = 1, ThrillerM = 1, MysteryM = 1, DocumentaryM = 1, 
/*Settings*/ ScienceFictionM = 1, FantasyM = 1, WesternM = 1, MartialArtsM = 1, ModernM = 1, HistoricM = 1, PrehistoricM = 1, ComicsM = 1, PeriodM = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Kamurai';

--Aethenis
--HTKB
INSERT INTO [HTKB].dbo.Users (HTKBAdminLevel, HTKBOnline, Username, Passcode, Email) 
VALUES (2, 1, 'Aethenis', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Aethenis';
--BoardOver
Update B SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Aethenis';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Aethenis';
--ShowOver
Update S SET 
/*Genres*/ ComedyS = 1, DramaS = 1, ActionS = 1, HorrorS = 1, ThrillerS = 1, MysteryS = 1, DocumentaryS = 1,  
/*Settings*/ ScienceFictionS = 1, FantasyS = 1, WesternS = 1, MartialArtsS = 1, ModernS = 1, HistoricS = 1, PrehistoricS = 1, ComicsS = 1, PeriodS = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Aethenis';
--WatchOver
Update W SET 
/*Genres*/ ComedyM = 1, DramaM = 1, ActionM = 1, HorrorM = 1, ThrillerM = 1, MysteryM = 1, DocumentaryM = 1, 
/*Settings*/ ScienceFictionM = 1, FantasyM = 1, WesternM = 1, MartialArtsM = 1, ModernM = 1, HistoricM = 1, PrehistoricM = 1, ComicsM = 1, PeriodM = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Aethenis';

--Setzer
--HTKB
INSERT INTO [HTKB].dbo.Users (HTKBAdminLevel, HTKBOnline, Username, Passcode, Email) 
VALUES (1, 0, 'Setzer', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Setzer';
--BoardOver
Update B SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Setzer';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Setzer';
--ShowOver
Update S SET 
/*Genres*/ ComedyS = 1, DramaS = 1, ActionS = 1, HorrorS = 1, ThrillerS = 1, MysteryS = 1, DocumentaryS = 1,  
/*Settings*/ ScienceFictionS = 1, FantasyS = 1, WesternS = 1, MartialArtsS = 1, ModernS = 1, HistoricS = 1, PrehistoricS = 1, ComicsS = 1, PeriodS = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Setzer';
--WatchOver
Update W SET 
/*Genres*/ ComedyM = 1, DramaM = 1, ActionM = 1, HorrorM = 1, ThrillerM = 1, MysteryM = 1, DocumentaryM = 1, 
/*Settings*/ ScienceFictionM = 1, FantasyM = 1, WesternM = 1, MartialArtsM = 1, ModernM = 1, HistoricM = 1, PrehistoricM = 1, ComicsM = 1, PeriodM = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Setzer';

--Shaed
--HTKB
INSERT INTO [HTKB].dbo.Users (HTKBAdminLevel, HTKBOnline, Username, Passcode, Email) 
VALUES (0, 0, 'Shaed', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Shaed';
--BoardOver
Update B SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Shaed';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Shaed';
--ShowOver
Update S SET 
/*Genres*/ ComedyS = 1, DramaS = 1, ActionS = 1, HorrorS = 1, ThrillerS = 1, MysteryS = 1, DocumentaryS = 1,  
/*Settings*/ ScienceFictionS = 1, FantasyS = 1, WesternS = 1, MartialArtsS = 1, ModernS = 1, HistoricS = 1, PrehistoricS = 1, ComicsS = 1, PeriodS = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Shaed';
--WatchOver
Update W SET 
/*Genres*/ ComedyM = 1, DramaM = 1, ActionM = 1, HorrorM = 1, ThrillerM = 1, MysteryM = 1, DocumentaryM = 1, 
/*Settings*/ ScienceFictionM = 1, FantasyM = 1, WesternM = 1, MartialArtsM = 1, ModernM = 1, HistoricM = 1, PrehistoricM = 1, ComicsM = 1, PeriodM = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Shaed';

--Blackhand
--HTKB
INSERT INTO [HTKB].dbo.Users (HTKBAdminLevel, HTKBOnline, Username, Passcode, Email) 
VALUES (0, 0, 'Blackhand', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Blackhand';
--BoardOver
Update B SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Blackhand';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Blackhand';
--ShowOver
Update S SET 
/*Genres*/ ComedyS = 1, DramaS = 1, ActionS = 1, HorrorS = 1, ThrillerS = 1, MysteryS = 1, DocumentaryS = 1,  
/*Settings*/ ScienceFictionS = 1, FantasyS = 1, WesternS = 1, MartialArtsS = 1, ModernS = 1, HistoricS = 1, PrehistoricS = 1, ComicsS = 1, PeriodS = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Blackhand';
--WatchOver
Update W SET 
/*Genres*/ ComedyM = 1, DramaM = 1, ActionM = 1, HorrorM = 1, ThrillerM = 1, MysteryM = 1, DocumentaryM = 1, 
/*Settings*/ ScienceFictionM = 1, FantasyM = 1, WesternM = 1, MartialArtsM = 1, ModernM = 1, HistoricM = 1, PrehistoricM = 1, ComicsM = 1, PeriodM = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
WHERE H.Username = 'Blackhand';
