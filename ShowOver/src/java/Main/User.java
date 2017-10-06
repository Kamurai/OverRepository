/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

/**
 *
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
    private boolean ComedyS;
    public boolean getComedyS()
    {
        return ComedyS;
    }
    public void setComedyS(boolean input)
    {
        ComedyS = input;
    }
    private boolean DramaS;
    public boolean getDramaS()
    {
        return DramaS;
    }
    public void setDramaS(boolean input)
    {
        DramaS = input;
    }
    private boolean ActionS;
    public boolean getActionS()
    {
        return ActionS;
    }
    public void setActionS(boolean input)
    {
        ActionS = input;
    }
    private boolean HorrorS;    
    public boolean getHorrorS()
    {
        return HorrorS;
    }
    public void setHorrorS(boolean input)
    {
        HorrorS = input;
    }
    private boolean ThrillerS;
    public boolean getThrillerS()
    {
        return ThrillerS;
    }
    public void setThrillerS(boolean input)
    {
        ThrillerS = input;
    }
    private boolean MysteryS;
    public boolean getMysteryS()
    {
        return MysteryS;
    }
    public void setMysteryS(boolean input)
    {
        MysteryS = input;
    }
    private boolean DocumentaryS;
    public boolean getDocumentaryS()
    {
        return DocumentaryS;
    }
    public void setDocumentaryS(boolean input)
    {
        DocumentaryS = input;
    }
    //Settings
    private boolean ScienceFictionS;
    public boolean getScienceFictionS()
    {
        return ScienceFictionS;
    }
    public void setScienceFictionS(boolean input)
    {
        ScienceFictionS = input;
    }
    private boolean FantasyS;
    public boolean getFantasyS()
    {
        return FantasyS;
    }
    public void setFantasyS(boolean input)
    {
        FantasyS = input;
    }
    private boolean WesternS;
    public boolean getWesternS()
    {
        return WesternS;
    }
    public void setWesternS(boolean input)
    {
        WesternS = input;
    }
    private boolean MartialArtsS;
    public boolean getMartialArtsS()
    {
        return MartialArtsS;
    }
    public void setMartialArtsS(boolean input)
    {
        MartialArtsS = input;
    }
    private boolean ModernS;  
    public boolean getModernS()
    {
        return ModernS;
    }
    public void setModernS(boolean input)
    {
        ModernS = input;
    }
    private boolean HistoricS;  
    public boolean getHistoricS()
    {
        return HistoricS;
    }
    public void setHistoricS(boolean input)
    {
        HistoricS = input;
    }
    private boolean PrehistoricS;  
    public boolean getPrehistoricS()
    {
        return PrehistoricS;
    }
    public void setPrehistoricS(boolean input)
    {
        PrehistoricS = input;
    }
    private boolean ComicsS;  
    public boolean getComicsS()
    {
        return ComicsS;
    }
    public void setComicsS(boolean input)
    {
        ComicsS = input;
    }
    private boolean PeriodS;  
    public boolean getPeriodS()
    {
        return PeriodS;
    }
    public void setPeriodS(boolean input)
    {
        PeriodS = input;
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
            boolean boolComedyS, 
            boolean boolDramaS, 
            boolean boolActionS, 
            boolean boolHorrorS, 
            boolean boolThrillerS, 
            boolean boolMysteryS, 
            boolean boolDocumentaryS, 
            boolean boolScienceFictionS, 
            boolean boolFantasyS, 
            boolean boolWesternS, 
            boolean boolMartialArtsS, 
            boolean boolModernS, 
            boolean boolHistoricS, 
            boolean boolPreHistoricS, 
            boolean boolComicsS, 
            boolean boolPeriodS, 
            boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        
        //Genres
        ComedyS = boolComedyS;
        DramaS = boolDramaS;
        ActionS = boolActionS;
        HorrorS = boolHorrorS;
        ThrillerS = boolThrillerS;
        MysteryS = boolMysteryS;
        DocumentaryS = boolDocumentaryS;
        //Settings
        ScienceFictionS = boolScienceFictionS;
        FantasyS = boolFantasyS;
        WesternS = boolWesternS;
        MartialArtsS = boolMartialArtsS;
        ModernS = boolModernS;
        HistoricS = boolHistoricS;
        PrehistoricS = boolPreHistoricS;
        ComicsS = boolComicsS;
        PeriodS = boolPeriodS;
        
        LoggedOn = boolLoggedOn;

    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        
        //Genres
        ComedyS = newUser.ComedyS;
        DramaS = newUser.DramaS;
        ActionS = newUser.ActionS;
        HorrorS = newUser.HorrorS;
        ThrillerS = newUser.ThrillerS;
        MysteryS = newUser.MysteryS;
        DocumentaryS = newUser.DocumentaryS;
        //Settings
        ScienceFictionS = newUser.ScienceFictionS;
        FantasyS = newUser.FantasyS;
        WesternS = newUser.WesternS;
        MartialArtsS = newUser.MartialArtsS;
        ModernS = newUser.ModernS;
        HistoricS = newUser.HistoricS;
        PrehistoricS = newUser.PrehistoricS;
        ComicsS = newUser.ComicsS;
        PeriodS = newUser.PeriodS;
        
        LoggedOn = newUser.LoggedOn;

    }
    
}
