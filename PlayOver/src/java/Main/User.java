/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

/**
  * @author Kamurai
 */
public class User 
{
    private int UserIndex;
    public int getUserIndex()
    {
        return UserIndex;
    }
    private String Username;
    public String getUsername()
    {
        return Username;
    }
    public void setUsername(String input)
    {
        Username = input;
    }
    private String Email;
    public String getEmail()
    {
        return Email;
    }
    public void setEmail(String input)
    {
        Email = input;
    }
    private int AdminLevel;
    public int getAdminLevel()
    {
        return AdminLevel;
    }
    public void setAdminLevel(int input)
    {
        AdminLevel = input;
    }
    
    //Genres
    private boolean TwoDP;
    public boolean getTwoDP()
    {
        return TwoDP;
    }
    public void setTwoDP(boolean input)
    {
        TwoDP = input;
    }
    private boolean ThreeDP;
    public boolean getThreeDP()
    {
        return ThreeDP;
    }
    public void setThreeDP(boolean input)
    {
        ThreeDP = input;
    }
    private boolean FPS;
    public boolean getFPS()
    {
        return FPS;
    }
    public void setFPS(boolean input)
    {
        FPS = input;
    }
    private boolean FPP;
    public boolean getFPP()
    {
        return FPP;
    }
    public void setFPP(boolean input)
    {
        FPP = input;
    }
    private boolean VPuzzle;
    public boolean getVPuzzle()
    {
        return VPuzzle;
    }
    public void setVPuzzle(boolean input)
    {
        VPuzzle = input;
    }
    private boolean Bulletstorm;
    public boolean getBulletstorm()
    {
        return Bulletstorm;
    }
    public void setBulletstorm(boolean input)
    {
        Bulletstorm = input;
    }
    private boolean Fighting;
    public boolean getFighting()
    {
        return Fighting;
    }
    public void setFighting(boolean input)
    {
        Fighting = input;
    }
    private boolean Stealth;
    public boolean getStealth()
    {
        return Stealth;
    }
    public void setStealth(boolean input)
    {
        Stealth = input;
    }
    private boolean Survival;
    public boolean getSurvival()
    {
        return Survival;
    }
    public void setSurvival(boolean input)
    {
        Survival = input;
    }
    private boolean VN;
    public boolean getVN()
    {
        return VN;
    }
    public void setVN(boolean input)
    {
        VN = input;
    }
    private boolean IM;
    public boolean getIM()
    {
        return IM;
    }
    public void setIM(boolean input)
    {
        IM = input;
    }
    private boolean RPG;
    public boolean getRPG()
    {
        return RPG;
    }
    public void setRPG(boolean input)
    {
        RPG = input;
    }
    private boolean TRPG;
    public boolean getTRPG()
    {
        return TRPG;
    }
    public void setTRPG(boolean input)
    {
        TRPG = input;
    }
    private boolean ARPG;
    public boolean getARPG()
    {
        return ARPG;
    }
    public void setARPG(boolean input)
    {
        ARPG = input;
    }
    private boolean Sports;
    public boolean getSports()
    {
        return Sports;
    }
    public void setSports(boolean input)
    {
        Sports = input;
    }
    private boolean Racing;
    public boolean getRacing()
    {
        return Racing;
    }
    public void setRacing(boolean input)
    {
        Racing = input;
    }
    private boolean RTS;
    public boolean getRTS()
    {
        return RTS;
    }
    public void setRTS(boolean input)
    {
        RTS = input;
    }
    private boolean TBS;
    public boolean getTBS()
    {
        return TBS;
    }
    public void setTBS(boolean input)
    {
        TBS = input;
    }
    private boolean VE;
    public boolean getVE()
    {
        return VE;
    }
    public void setVE(boolean input)
    {
        VE = input;
    }
    private boolean MMO;
    public boolean getMMO()
    {
        return MMO;
    }
    public void setMMO(boolean input)
    {
        MMO = input;
    }
    private boolean MOBA;
    public boolean getMOBA()
    {
        return MOBA;
    }
    public void setMOBA(boolean input)
    {
        MOBA = input;
    }
    //Platforms
    private boolean PC;
    public boolean getPC()
    {
        return PC;
    }
    public void setPC(boolean input)
    {
        PC = input;
    }
    private boolean Atari;
    public boolean getAtari()
    {
        return Atari;
    }
    public void setAtari(boolean input)
    {
        Atari = input;
    }
    private boolean Commodore64;
    public boolean getCommodore64()
    {
        return Commodore64;
    }
    public void setCommodore64(boolean input)
    {
        Commodore64 = input;
    }
    private boolean FAMICOM;
    public boolean getFAMICOM()
    {
        return FAMICOM;
    }
    public void setFAMICOM(boolean input)
    {
        FAMICOM = input;
    }
    private boolean NES;
    public boolean getNES()
    {
        return NES;
    }
    public void setNES(boolean input)
    {
        NES = input;
    }
    private boolean SNES;
    public boolean getSNES()
    {
        return SNES;
    }
    public void setSNES(boolean input)
    {
        SNES = input;
    }
    private boolean N64;
    public boolean getN64()
    {
        return N64;
    }
    public void setN64(boolean input)
    {
        N64 = input;
    }
    private boolean Gamecube;
    public boolean getGamecube()
    {
        return Gamecube;
    }
    public void setGamecube(boolean input)
    {
        Gamecube = input;
    }
    private boolean Wii;
    public boolean getWii()
    {
        return Wii;
    }
    public void setWii(boolean input)
    {
        Wii = input;
    }
    private boolean WiiU;
    public boolean getWiiU()
    {
        return WiiU;
    }
    public void setWiiU(boolean input)
    {
        WiiU = input;
    }
    private boolean NintendoSwitch;
    public boolean getNintendoSwitch()
    {
        return NintendoSwitch;
    }
    public void setNintendoSwitch(boolean input)
    {
        NintendoSwitch = input;
    }
    private boolean Gameboy;
    public boolean getGameboy()
    {
        return Gameboy;
    }
    public void setGameboy(boolean input)
    {
        Gameboy = input;
    }
    private boolean VirtualBoy;
    public boolean getVirtualBoy()
    {
        return VirtualBoy;
    }
    public void setVirtualBoy(boolean input)
    {
        VirtualBoy = input;
    }
    private boolean GBA;
    public boolean getGBA()
    {
        return GBA;
    }
    public void setGBA(boolean input)
    {
        GBA = input;
    }
    private boolean DS;
    public boolean getDS()
    {
        return DS;
    }
    public void setDS(boolean input)
    {
        DS = input;
    }
    private boolean ThreeDS;
    public boolean getThreeDS()
    {
        return ThreeDS;
    }
    public void setThreeDS(boolean input)
    {
        ThreeDS = input;
    }
    private boolean SegaGenesis;
    public boolean getSegaGenesis()
    {
        return SegaGenesis;
    }
    public void setSegaGenesis(boolean input)
    {
        SegaGenesis = input;
    }
    private boolean SegaCD;
    public boolean getSegaCD()
    {
        return SegaCD;
    }
    public void setSegaCD(boolean input)
    {
        SegaCD = input;
    }
    private boolean SegaDreamcast;
    public boolean getSegaDreamcast()
    {
        return SegaDreamcast;
    }
    public void setSegaDreamcast(boolean input)
    {
        SegaDreamcast = input;
    }
    private boolean PS1;
    public boolean getPS1()
    {
        return PS1;
    }
    public void setPS1(boolean input)
    {
        PS1 = input;
    }
    private boolean PS2;
    public boolean getPS2()
    {
        return PS2;
    }
    public void setPS2(boolean input)
    {
        PS2 = input;
    }
    private boolean PS3;
    public boolean getPS3()
    {
        return PS3;
    }
    public void setPS3(boolean input)
    {
        PS3 = input;
    }
    private boolean PS4;
    public boolean getPS4()
    {
        return PS4;
    }
    public void setPS4(boolean input)
    {
        PS4 = input;
    }
    private boolean PSP;
    public boolean getPSP()
    {
        return PSP;
    }
    public void setPSP(boolean input)
    {
        PSP = input;
    }
    private boolean PSVita;
    public boolean getPSVita()
    {
        return PSVita;
    }
    public void setPSVita(boolean input)
    {
        PSVita = input;
    }
    private boolean Xbox;
    public boolean getXbox()
    {
        return Xbox;
    }
    public void setXbox(boolean input)
    {
        Xbox = input;
    }
    private boolean Xbox360;
    public boolean getXbox360()
    {
        return Xbox360;
    }
    public void setXbox360(boolean input)
    {
        Xbox360 = input;
    }
    private boolean XboxOne;
    public boolean getXboxOne()
    {
        return XboxOne;
    }
    public void setXboxOne(boolean input)
    {
        XboxOne = input;
    }
    private boolean Ouya;
    public boolean getOuya()
    {
        return Ouya;
    }
    public void setOuya(boolean input)
    {
        Ouya = input;
    }
    private boolean OculusRift;
    public boolean getOculusRift()
    {
        return OculusRift;
    }
    public void setOculusRift(boolean input)
    {
        OculusRift = input;
    }
    private boolean Vive;
    public boolean getVive()
    {
        return Vive;
    }
    public void setVive(boolean input)
    {
        Vive = input;
    }
    private boolean PSVR;
    public boolean getPSVR()
    {
        return PSVR;
    }
    public void setPSVR(boolean input)
    {
        PSVR = input;
    }
    
    private boolean LoggedOn;
    public boolean getLoggedOn()
    {
        return LoggedOn;
    }
    public void setLoggedOn(boolean input)
    {
        LoggedOn = input;
    }
    
    
    
    public User(int intUserIndex, String strUsername, String strEmail, int intAdminLevel, 
            //Genres
            boolean boolTwoDP, 
            boolean boolThreeDP, 
            boolean boolFPS, 
            boolean boolFPP,             
            boolean boolVPuzzle, 
            boolean boolBulletstorm, 
            boolean boolFighting, 
            boolean boolStealth, 
            boolean boolSurvival, 
            boolean boolVN, 
            boolean boolIM, 
            boolean boolRPG, 
            boolean boolTRPG, 
            boolean boolARPG, 
            boolean boolSports, 
            boolean boolRacing, 
            boolean boolRTS, 
            boolean boolTBS, 
            boolean boolVE, 
            boolean boolMMO,             
            boolean boolMOBA, 
            //Platforms
            boolean boolPC, 
            boolean boolAtari, 
            boolean boolCommodore64, 
            boolean boolFAMICOM, 
            boolean boolNES, 
            boolean boolSNES, 
            boolean boolN64, 
            boolean boolGamecube, 
            boolean boolWii, 
            boolean boolWiiU, 
            boolean boolNintendoSwitch, 
            boolean boolGameboy, 
            boolean boolVirtualBoy, 
            boolean boolGBA, 
            boolean boolDS, 
            boolean boolThreeDS, 
            boolean boolSegaGenesis, 
            boolean boolSegaCD, 
            boolean boolSegaDreamcast, 
            boolean boolPS1, 
            boolean boolPS2, 
            boolean boolPS3, 
            boolean boolPS4, 
            boolean boolPSP, 
            boolean boolPSVita, 
            boolean boolXbox, 
            boolean boolXbox360, 
            boolean boolXboxOne, 
            boolean boolOuya, 
            boolean boolOculusRift, 
            boolean boolVive, 
            boolean boolPSVR, 
            boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        TwoDP = boolTwoDP;
        ThreeDP = boolThreeDP;
        FPS = boolFPS;
        FPP = boolFPP;        
        VPuzzle = boolVPuzzle;
        Bulletstorm = boolBulletstorm;
        Fighting = boolFighting;
        Stealth = boolStealth;
        Survival = boolSurvival;
        VN = boolVN;
        IM = boolIM;
        RPG = boolRPG;
        TRPG = boolTRPG;
        ARPG = boolARPG;
        Sports = boolSports;
        Racing = boolRacing;
        RTS = boolRTS;
        TBS = boolTBS;
        VE = boolVE;
        MMO = boolMMO;
        MOBA = boolMOBA;
        //Platforms
        PC = boolPC;
        Atari = boolAtari; 
        Commodore64 = boolCommodore64; 
        FAMICOM = boolFAMICOM; 
        NES = boolNES; 
        SNES = boolSNES; 
        N64 = boolN64; 
        Gamecube = boolGamecube; 
        Wii = boolWii; 
        WiiU = boolWiiU; 
        NintendoSwitch = boolNintendoSwitch; 
        Gameboy = boolGameboy; 
        VirtualBoy = boolVirtualBoy; 
        GBA = boolGBA; 
        DS = boolDS; 
        ThreeDS = boolThreeDS; 
        SegaGenesis = boolSegaGenesis; 
        SegaCD = boolSegaCD; 
        SegaDreamcast = boolSegaDreamcast; 
        PS1 = boolPS1; 
        PS2 = boolPS2; 
        PS3 = boolPS3; 
        PS4 = boolPS4; 
        PSP = boolPSP; 
        PSVita = boolPSVita; 
        Xbox = boolXbox; 
        Xbox360 = boolXbox360; 
        XboxOne = boolXboxOne; 
        Ouya = boolOuya; 
        OculusRift = boolOculusRift; 
        Vive = boolVive; 
        PSVR = boolPSVR; 
        LoggedOn = boolLoggedOn;

    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        //Genres
        TwoDP = newUser.TwoDP;
        ThreeDP = newUser.ThreeDP;
        FPS = newUser.FPS;
        FPP = newUser.FPP;
        VPuzzle = newUser.VPuzzle;
        Bulletstorm = newUser.Bulletstorm;
        Fighting = newUser.Fighting;
        Stealth = newUser.Stealth;
        Survival = newUser.Survival;
        VN = newUser.VN;
        IM = newUser.IM;
        RPG = newUser.RPG;
        TRPG = newUser.TRPG;
        ARPG = newUser.ARPG;
        Sports = newUser.Sports;
        Racing = newUser.Racing;
        RTS = newUser.RTS;
        TBS = newUser.TBS;
        VE = newUser.VE;
        MMO = newUser.MMO;
        MOBA = newUser.MOBA;
        //Platforms
        PC = newUser.PC;
        Atari = newUser.Atari; 
        Commodore64 = newUser.Commodore64; 
        FAMICOM = newUser.FAMICOM; 
        NES = newUser.NES; 
        SNES = newUser.SNES; 
        N64 = newUser.N64; 
        Gamecube = newUser.Gamecube; 
        Wii = newUser.Wii; 
        WiiU = newUser.WiiU; 
        NintendoSwitch = newUser.NintendoSwitch; 
        Gameboy = newUser.Gameboy; 
        VirtualBoy = newUser.VirtualBoy; 
        GBA = newUser.GBA; 
        DS = newUser.DS; 
        ThreeDS = newUser.ThreeDS; 
        SegaGenesis = newUser.SegaGenesis; 
        SegaCD = newUser.SegaCD; 
        SegaDreamcast = newUser.SegaDreamcast; 
        PS1 = newUser.PS1; 
        PS2 = newUser.PS2; 
        PS3 = newUser.PS3; 
        PS4 = newUser.PS4; 
        PSP = newUser.PSP; 
        PSVita = newUser.PSVita; 
        Xbox = newUser.Xbox; 
        Xbox360 = newUser.Xbox360; 
        XboxOne = newUser.XboxOne; 
        Ouya = newUser.Ouya; 
        OculusRift = newUser.OculusRift; 
        Vive = newUser.Vive; 
        PSVR = newUser.PSVR; 
        LoggedOn = newUser.LoggedOn;
    }    
    
}
