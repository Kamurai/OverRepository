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
    private boolean Memory;
    public boolean getMemory(){
        return Memory;
    }
    public void setMemory(boolean input){
        Memory = input;
    }
    
    //Genres
    private boolean Comedy;
    public boolean getComedy()
    {
        return Comedy;
    }
    public void setComedy(boolean input)
    {
        Comedy = input;
    }
    private boolean Drama;
    public boolean getDrama()
    {
        return Drama;
    }
    public void setDrama(boolean input)
    {
        Drama = input;
    }
    private boolean Action;
    public boolean getAction()
    {
        return Action;
    }
    public void setAction(boolean input)
    {
        Action = input;
    }
    private boolean Horror;    
    public boolean getHorror()
    {
        return Horror;
    }
    public void setHorror(boolean input)
    {
        Horror = input;
    }
    private boolean Thriller;
    public boolean getThriller()
    {
        return Thriller;
    }
    public void setThriller(boolean input)
    {
        Thriller = input;
    }
    private boolean Mystery;
    public boolean getMystery()
    {
        return Mystery;
    }
    public void setMystery(boolean input)
    {
        Mystery = input;
    }
    private boolean Documentary;
    public boolean getDocumentary()
    {
        return Documentary;
    }
    public void setDocumentary(boolean input)
    {
        Documentary = input;
    }
    //Settings
    private boolean ScienceFiction;
    public boolean getScienceFiction()
    {
        return ScienceFiction;
    }
    public void setScienceFiction(boolean input)
    {
        ScienceFiction = input;
    }
    private boolean Fantasy;
    public boolean getFantasy()
    {
        return Fantasy;
    }
    public void setFantasy(boolean input)
    {
        Fantasy = input;
    }
    private boolean Western;
    public boolean getWestern()
    {
        return Western;
    }
    public void setWestern(boolean input)
    {
        Western = input;
    }
    private boolean MartialArts;
    public boolean getMartialArts()
    {
        return MartialArts;
    }
    public void setMartialArts(boolean input)
    {
        MartialArts = input;
    }
    private boolean Modern;  
    public boolean getModern()
    {
        return Modern;
    }
    public void setModern(boolean input)
    {
        Modern = input;
    }
    private boolean Historic;  
    public boolean getHistoric()
    {
        return Historic;
    }
    public void setHistoric(boolean input)
    {
        Historic = input;
    }
    private boolean Prehistoric;  
    public boolean getPrehistoric()
    {
        return Prehistoric;
    }
    public void setPrehistoric(boolean input)
    {
        Prehistoric = input;
    }
    private boolean Comics;  
    public boolean getComics()
    {
        return Comics;
    }
    public void setComics(boolean input)
    {
        Comics = input;
    }
    private boolean Period;  
    public boolean getPeriod()
    {
        return Period;
    }
    public void setPeriod(boolean input)
    {
        Period = input;
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
    
    
    public User(
            int intUserIndex, 
            int intAdminLevel,
            boolean boolLoggedOn, 
            
            String strUsername, 
            String strEmail,             
            boolean boolMemory, 
            //Genres
            boolean boolComedy, 
            boolean boolDrama, 
            boolean boolAction, 
            boolean boolHorror, 
            boolean boolThriller, 
            boolean boolMystery, 
            boolean boolDocumentary, 
            //Settings
            boolean boolScienceFiction, 
            boolean boolFantasy, 
            boolean boolWestern, 
            boolean boolMartialArts, 
            boolean boolModern, 
            boolean boolHistoric, 
            boolean boolPreHistoric, 
            boolean boolComics, 
            boolean boolPeriod
    ){
        UserIndex = intUserIndex;
        AdminLevel = intAdminLevel;
        LoggedOn = boolLoggedOn;
        
        Username = strUsername;
        Email = strEmail;
        Memory = boolMemory;
        
        //Genres
        Comedy = boolComedy;
        Drama = boolDrama;
        Action = boolAction;
        Horror = boolHorror;
        Thriller = boolThriller;
        Mystery = boolMystery;
        Documentary = boolDocumentary;
        //Settings
        ScienceFiction = boolScienceFiction;
        Fantasy = boolFantasy;
        Western = boolWestern;
        MartialArts = boolMartialArts;
        Modern = boolModern;
        Historic = boolHistoric;
        Prehistoric = boolPreHistoric;
        Comics = boolComics;
        Period = boolPeriod;
    }
    
    public User(User newUser){
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        Memory = newUser.Memory;
        
        //Genres
        Comedy = newUser.Comedy;
        Drama = newUser.Drama;
        Action = newUser.Action;
        Horror = newUser.Horror;
        Thriller = newUser.Thriller;
        Mystery = newUser.Mystery;
        Documentary = newUser.Documentary;
        //Settings
        ScienceFiction = newUser.ScienceFiction;
        Fantasy = newUser.Fantasy;
        Western = newUser.Western;
        MartialArts = newUser.MartialArts;
        Modern = newUser.Modern;
        Historic = newUser.Historic;
        Prehistoric = newUser.Prehistoric;
        Comics = newUser.Comics;
        Period = newUser.Period;
        
        LoggedOn = newUser.LoggedOn;

    }
    
}
