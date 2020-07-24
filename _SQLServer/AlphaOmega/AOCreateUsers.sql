--Kamurai
--HTKB
INSERT INTO [HTKB].dbo.Users (AdminLevel, Online, Username, Passcode, Email) 
VALUES (3, 0, 'Kamurai', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Kamurai';
--BoardOver
Update D SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers D
JOIN [Over].dbo.Users O ON D.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Kamurai';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Kamurai';
--ShowOver
Update S SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1,  
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Kamurai';
--WatchOver
Update W SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1, 
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Kamurai';

--Aethenis
--HTKB
INSERT INTO [HTKB].dbo.Users (AdminLevel, Online, Username, Passcode, Email) 
VALUES (2, 1, 'Aethenis', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Aethenis';
--BoardOver
Update D SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers D
JOIN [Over].dbo.Users O ON D.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Aethenis';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Aethenis';
--ShowOver
Update S SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1,  
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Aethenis';
--WatchOver
Update W SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1, 
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Aethenis';

--Setzer
--HTKB
INSERT INTO [HTKB].dbo.Users (AdminLevel, Online, Username, Passcode, Email) 
VALUES (1, 0, 'Setzer', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Setzer';
--BoardOver
Update D SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers D
JOIN [Over].dbo.Users O ON D.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Setzer';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Setzer';
--ShowOver
Update S SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1,  
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Setzer';
--WatchOver
Update W SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1, 
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Setzer';

--Shaed
--HTKB
INSERT INTO [HTKB].dbo.Users (AdminLevel, Online, Username, Passcode, Email) 
VALUES (0, 0, 'Shaed', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Shaed';
--BoardOver
Update D SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers D
JOIN [Over].dbo.Users O ON D.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Shaed';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Shaed';
--ShowOver
Update S SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1,  
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Shaed';
--WatchOver
Update W SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1, 
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Shaed';

--Blackhand
--HTKB
INSERT INTO [HTKB].dbo.Users (AdminLevel, Online, Username, Passcode, Email) 
VALUES (0, 0, 'Blackhand', 'green20', 'KamuraiBlue25@gmail.com');
--BangOver
Update B SET 
/*Genders*/ Women = 1, Men = 0, TransWomen = 1, TransMen = 0
FROM [Over].dbo.BangOverUsers B
JOIN [Over].dbo.Users O ON B.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Blackhand';
--BoardOver
Update D SET 
/*Genres*/ DeckBuilding = 1, FixedDeck = 1, ConstructedDeck = 1, Strategy = 1, War = 1, Economy = 1, TableauBuilding = 1, Coop = 1, Mystery = 1, SemiCoop = 1, PPRPG = 1, Bluffing = 1, Puzzle = 1, Dexterity = 1, Party = 1
FROM [Over].dbo.BoardOverUsers D
JOIN [Over].dbo.Users O ON D.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Blackhand';
--PlayOver
Update P SET 
/*Genres*/ TwoDP = 1, ThreeDP = 1, FPS = 1, FPP = 1, VPuzzle = 1, Bulletstorm = 1, Fighting = 1, Stealth = 1, Survival = 1, VN = 1, IM = 1, RPG = 1, TRPG = 1, ARPG = 1, Sports = 1, Racing = 1, RTS = 1, TBS = 1, VE = 1, MMO = 1, MOBA = 1, 
/*Platforms*/ PC = 1, Atari = 1, Commodore64 = 1, FAMICOM = 1, NES = 1, SNES = 1, N64 = 1, Gamecube = 1, Wii = 1, WiiU = 1, NintendoSwitch = 1, Gameboy = 1, VirtualBoy = 1, GBA = 1, DS = 1, ThreeDS = 1, SegaGenesis = 1, SegaCD = 1, SegaDreamcast = 1, PS1 = 1, PS2 = 1, PS3 = 1, PS4 = 1, PSP = 1, PSVita = 1, Xbox = 1, Xbox360 = 1, XboxOne = 1, Ouya = 1, OculusRift = 1, Vive = 1, PSVR = 1
FROM [Over].dbo.PlayOverUsers P
JOIN [Over].dbo.Users O ON P.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Blackhand';
--ShowOver
Update S SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1,  
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.ShowOverUsers S
JOIN [Over].dbo.Users O ON S.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Blackhand';
--WatchOver
Update W SET 
/*Genres*/ Comedy = 1, Drama = 1, Action = 1, Horror = 1, Thriller = 1, Mystery = 1, Documentary = 1, 
/*Settings*/ ScienceFiction = 1, Fantasy = 1, Western = 1, MartialArts = 1, Modern = 1, Historic = 1, Prehistoric = 1, Comics = 1, Period = 1
FROM [Over].dbo.WatchOverUsers W
JOIN [Over].dbo.Users O ON W.OverUserIndex = O.UserIndex
JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
WHERE H.Username = 'Blackhand';
