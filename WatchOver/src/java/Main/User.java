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
    private boolean ComedyM;
    public boolean getComedyM()
    {
        return ComedyM;
    }
    public void setComedyM(boolean input)
    {
        ComedyM = input;
    }
    private boolean DramaM;
    public boolean getDramaM()
    {
        return DramaM;
    }
    public void setDramaM(boolean input)
    {
        DramaM = input;
    }
    private boolean ActionM;
    public boolean getActionM()
    {
        return ActionM;
    }
    public void setActionM(boolean input)
    {
        ActionM = input;
    }
    private boolean HorrorM;    
    public boolean getHorrorM()
    {
        return HorrorM;
    }
    public void setHorrorM(boolean input)
    {
        HorrorM = input;
    }
    private boolean ThrillerM;
    public boolean getThrillerM()
    {
        return ThrillerM;
    }
    public void setThrillerM(boolean input)
    {
        ThrillerM = input;
    }
    private boolean MysteryM;
    public boolean getMysteryM()
    {
        return MysteryM;
    }
    public void setMysteryM(boolean input)
    {
        MysteryM = input;
    }
    private boolean DocumentaryM;
    public boolean getDocumentaryM()
    {
        return DocumentaryM;
    }
    public void setDocumentaryM(boolean input)
    {
        DocumentaryM = input;
    }
    //Settings
    private boolean ScienceFictionM;
    public boolean getScienceFictionM()
    {
        return ScienceFictionM;
    }
    public void setScienceFictionM(boolean input)
    {
        ScienceFictionM = input;
    }
    private boolean FantasyM;
    public boolean getFantasyM()
    {
        return FantasyM;
    }
    public void setFantasyM(boolean input)
    {
        FantasyM = input;
    }
    private boolean WesternM;
    public boolean getWesternM()
    {
        return WesternM;
    }
    public void setWesternM(boolean input)
    {
        WesternM = input;
    }
    private boolean MartialArtsM;
    public boolean getMartialArtsM()
    {
        return MartialArtsM;
    }
    public void setMartialArtsM(boolean input)
    {
        MartialArtsM = input;
    }
    private boolean ModernM;  
    public boolean getModernM()
    {
        return ModernM;
    }
    public void setModernM(boolean input)
    {
        ModernM = input;
    }
    private boolean HistoricM;  
    public boolean getHistoricM()
    {
        return HistoricM;
    }
    public void setHistoricM(boolean input)
    {
        HistoricM = input;
    }
    private boolean PrehistoricM;  
    public boolean getPrehistoricM()
    {
        return PrehistoricM;
    }
    public void setPrehistoricM(boolean input)
    {
        PrehistoricM = input;
    }
    private boolean ComicsM;  
    public boolean getComicsM()
    {
        return ComicsM;
    }
    public void setComicsM(boolean input)
    {
        ComicsM = input;
    }
    private boolean PeriodM;  
    public boolean getPeriodM()
    {
        return PeriodM;
    }
    public void setPeriodM(boolean input)
    {
        PeriodM = input;
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
            boolean boolComedyM, 
            boolean boolDramaM, 
            boolean boolActionM, 
            boolean boolHorrorM, 
            boolean boolThrillerM, 
            boolean boolMysteryM, 
            boolean boolDocumentaryM, 
            boolean boolScienceFictionM, 
            boolean boolFantasyM, 
            boolean boolWesternM, 
            boolean boolMartialArtsM, 
            boolean boolModernM, 
            boolean boolHistoricM, 
            boolean boolPreHistoricM, 
            boolean boolComicsM, 
            boolean boolPeriodM,
            boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        
        //Genres
        ComedyM = boolComedyM;
        DramaM = boolDramaM;
        ActionM = boolActionM;
        HorrorM = boolHorrorM;
        ThrillerM = boolThrillerM;
        MysteryM = boolMysteryM;
        DocumentaryM = boolDocumentaryM;
        //Settings
        ScienceFictionM = boolScienceFictionM;
        FantasyM = boolFantasyM;
        WesternM = boolWesternM;
        MartialArtsM = boolMartialArtsM;
        ModernM = boolModernM;
        HistoricM = boolHistoricM;
        PrehistoricM = boolPreHistoricM;
        ComicsM = boolComicsM;
        PeriodM = boolPeriodM;
        
        LoggedOn = boolLoggedOn;

    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        
        //Genres
        ComedyM = newUser.ComedyM;
        DramaM = newUser.DramaM;
        ActionM = newUser.ActionM;
        HorrorM = newUser.HorrorM;
        ThrillerM = newUser.ThrillerM;
        MysteryM = newUser.MysteryM;
        DocumentaryM = newUser.DocumentaryM;
        //Settings
        ScienceFictionM = newUser.ScienceFictionM;
        FantasyM = newUser.FantasyM;
        WesternM = newUser.WesternM;
        MartialArtsM = newUser.MartialArtsM;
        ModernM = newUser.ModernM;
        HistoricM = newUser.HistoricM;
        PrehistoricM = newUser.PrehistoricM;
        ComicsM = newUser.ComicsM;
        PeriodM = newUser.PeriodM;
        
        LoggedOn = newUser.LoggedOn;

    }
    
}
