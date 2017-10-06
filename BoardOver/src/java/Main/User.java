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
    
    private boolean DeckBuilding;
    public boolean getDeckBuilding()
    {
        return DeckBuilding;
    }
    public void setDeckBuilding(boolean input)
    {
        DeckBuilding = input;
    }
    private boolean FixedDeck;
    public boolean getFixedDeck()
    {
        return FixedDeck;
    }
    public void setFixedDeck(boolean input)
    {
        FixedDeck = input;
    }
    private boolean ConstructedDeck;
    public boolean getConstructedDeck()
    {
        return ConstructedDeck;
    }
    public void setConstructedDeck(boolean input)
    {
        ConstructedDeck = input;
    }
    private boolean Strategy;
    public boolean getStrategy()
    {
        return Strategy;
    }
    public void setStrategy(boolean input)
    {
        Strategy = input;
    }
    private boolean War;
    public boolean getWar()
    {
        return War;
    }
    public void setWar(boolean input)
    {
        War = input;
    }
    private boolean Economy;
    public boolean getEconomy()
    {
        return Economy;
    }
    public void setEconomy(boolean input)
    {
        Economy = input;
    }
    private boolean TableauBuilding;
    public boolean getTableauBuilding()
    {
        return TableauBuilding;
    }
    public void setTableauBuilding(boolean input)
    {
        TableauBuilding = input;
    }
    private boolean Coop;
    public boolean getCoop()
    {
        return Coop;
    }
    public void setCoop(boolean input)
    {
        Coop = input;
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
    private boolean SemiCoop;
    public boolean getSemiCoop()
    {
        return SemiCoop;
    }
    public void setSemiCoop(boolean input)
    {
        SemiCoop = input;
    }
    private boolean PPRPG;
    public boolean getPPRPG()
    {
        return PPRPG;
    }
    public void setPPRPG(boolean input)
    {
        PPRPG = input;
    }
    private boolean Bluffing;
    public boolean getBluffing()
    {
        return Bluffing;
    }
    public void setBluffing(boolean input)
    {
        Bluffing = input;
    }
    private boolean Puzzle;
    public boolean getPuzzle()
    {
        return Puzzle;
    }
    public void setPuzzle(boolean input)
    {
        Puzzle = input;
    }
    private boolean Dexterity;
    public boolean getDexterity()
    {
        return Dexterity;
    }
    public void setDexterity(boolean input)
    {
        Dexterity = input;
    }
    private boolean Party;
    public boolean getParty()
    {
        return Party;
    }
    public void setParty(boolean input)
    {
        Party = input;
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
            boolean boolDeckBuilding, 
            boolean boolFixedDeck, 
            boolean boolConstructedDeck, 
            boolean boolStrategy,
            boolean boolWar,
            boolean boolEconomy,
            boolean boolTableauBuilding,
            boolean boolCoop,
            boolean boolMystery,
            boolean boolSemiCoop,
            boolean boolPPRPG,
            boolean boolBluffing,
            boolean boolPuzzle,
            boolean boolDexterity,
            boolean boolParty,
            
            boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        
        DeckBuilding = boolDeckBuilding;
        FixedDeck = boolFixedDeck;
        ConstructedDeck = boolConstructedDeck;
        Strategy = boolStrategy;
        War = boolWar;
        Economy = boolEconomy;
        TableauBuilding = boolTableauBuilding;
        Coop = boolCoop;
        Mystery = boolMystery;
        SemiCoop = boolSemiCoop;
        PPRPG = boolPPRPG;
        Bluffing = boolBluffing;
        Puzzle = boolPuzzle;
        Dexterity = boolDexterity;
        Party = boolParty;
        
        LoggedOn = boolLoggedOn;

    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        
        DeckBuilding = newUser.DeckBuilding;
        FixedDeck = newUser.FixedDeck;
        ConstructedDeck = newUser.ConstructedDeck;
        Strategy = newUser.Strategy;
        War = newUser.War;
        Economy = newUser.Economy;
        TableauBuilding = newUser.TableauBuilding;
        Coop = newUser.Coop;
        Mystery = newUser.Mystery;
        SemiCoop = newUser.SemiCoop;
        PPRPG = newUser.PPRPG;
        Bluffing = newUser.Bluffing;
        Puzzle = newUser.Puzzle;
        Dexterity = newUser.Dexterity;
        Party = newUser.Party;
        
        LoggedOn = newUser.LoggedOn;

    }
    
    
}
