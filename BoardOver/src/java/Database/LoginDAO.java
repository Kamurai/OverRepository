/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import Bean.LoginBean;
import Main.User;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class LoginDAO extends DAO{
    
    public LoginDAO(){
        super();
    }
    
    public User callableLogIn(String strUsername, String strPassword){
        CallableStatement stmt = null;
        User returnUser;
        ResultSet rs;
        
        try{
            openConnection();
        
            stmt = connect.prepareCall("{call BoardOverGetValidUser(?,?)}");
            stmt.setString(1, strUsername);
            stmt.setString(2, strPassword);
            rs = stmt.executeQuery();
            
            rs.next();
            
            returnUser = new User(
                rs.getInt("UserIndex"), 
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getInt("AdminLevel"),
                rs.getBoolean("DeckBuilding"), 
                rs.getBoolean("FixedDeck"), 
                rs.getBoolean("ConstructedDeck"), 
                rs.getBoolean("Strategy"), 
                rs.getBoolean("War"), 
                rs.getBoolean("Economy"), 
                rs.getBoolean("TableauBuilding"), 
                rs.getBoolean("Coop"), 
                rs.getBoolean("Mystery"), 
                rs.getBoolean("SemiCoop"), 
                rs.getBoolean("PPRPG"), 
                rs.getBoolean("Bluffing"), 
                rs.getBoolean("Puzzle"), 
                rs.getBoolean("Dexterity"), 
                rs.getBoolean("Party"), 
                rs.getBoolean("LoggedOn") 
            );
            
        }
        catch(Exception e){
            e.printStackTrace();
            returnUser = null;
        }finally{
            closeConnection();
        }
        
        return returnUser;
    }
    
    public boolean callableSetOnline(String user)
    {
        CallableStatement stmt = null;
        boolean result = false;
        
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call BoardOverSetOnlineStatus(?,?)}");
            stmt.setInt(1, 1);
            stmt.setString(2, user);
            stmt.executeUpdate();
            result = true;
        }catch(Exception e){
            e.printStackTrace();
            result = false;
        }finally{
            //close connection
            closeConnection();
        }
        
        return result;
    }
    
    public boolean callableSetOffline(String user)
    {
        CallableStatement stmt = null;
        boolean result = false;
        
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call BoardOverSetOnlineStatus(?,?)}");
            stmt.setInt(1, 0);
            stmt.setString(2, user);
            stmt.executeUpdate();
            result = false;
        }catch(Exception e){
            e.printStackTrace();
            result = true;
        }finally{
            //close connection
            closeConnection();
        }
        
        return result;
    }
    
    public void callableUpdateOptions(User targetUser)
    {
        CallableStatement stmt = null;
        ResultSet rs;
        
        //if all are false
        if( !targetUser.getDeckBuilding() && 
            !targetUser.getFixedDeck() && 
            !targetUser.getConstructedDeck() && 
            !targetUser.getStrategy() && 
            !targetUser.getWar() && 
            !targetUser.getEconomy() && 
            !targetUser.getTableauBuilding() && 
            !targetUser.getCoop() && 
            !targetUser.getMystery() && 
            !targetUser.getSemiCoop() && 
            !targetUser.getPPRPG() && 
            !targetUser.getBluffing() && 
            !targetUser.getPuzzle() && 
            !targetUser.getDexterity() && 
            !targetUser.getParty()
        ){
            //then set default to true
            targetUser.setDeckBuilding(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
        
            stmt = getConnect().prepareCall("{call BoardOverUpdateOptions(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            stmt.setBoolean(2, targetUser.getDeckBuilding());
            stmt.setBoolean(3, targetUser.getFixedDeck());
            stmt.setBoolean(4, targetUser.getConstructedDeck());
            stmt.setBoolean(5, targetUser.getStrategy());
            stmt.setBoolean(6, targetUser.getWar());
            stmt.setBoolean(7, targetUser.getEconomy());
            stmt.setBoolean(8, targetUser.getTableauBuilding());
            stmt.setBoolean(9, targetUser.getCoop());
            stmt.setBoolean(10, targetUser.getMystery());
            stmt.setBoolean(11, targetUser.getSemiCoop());
            stmt.setBoolean(12, targetUser.getPPRPG());
            stmt.setBoolean(13, targetUser.getBluffing());
            stmt.setBoolean(14, targetUser.getPuzzle());
            stmt.setBoolean(15, targetUser.getDexterity());
            stmt.setBoolean(16, targetUser.getParty());
            rs = stmt.executeQuery();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public boolean callableSignUp(String username, 
        String email,
        String password, 
        //Genres
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
        boolean boolParty
    ){
        CallableStatement stmt = null;
        boolean result = false;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            //open connection
            openConnection();
            
            stmt = getConnect().prepareCall("{call BoardOverUpdateOptions(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setBoolean(4, boolDeckBuilding);
            stmt.setBoolean(5, boolFixedDeck);
            stmt.setBoolean(6, boolConstructedDeck);
            stmt.setBoolean(7, boolStrategy);
            stmt.setBoolean(8, boolWar);
            stmt.setBoolean(9, boolEconomy);
            stmt.setBoolean(10, boolTableauBuilding);
            stmt.setBoolean(11, boolCoop);
            stmt.setBoolean(12, boolMystery);
            stmt.setBoolean(13, boolSemiCoop);
            stmt.setBoolean(14, boolPPRPG);
            stmt.setBoolean(15, boolBluffing);
            stmt.setBoolean(16, boolPuzzle);
            stmt.setBoolean(17, boolDexterity);
            stmt.setBoolean(18, boolParty);
            rs = stmt.executeQuery();
            
            result = true;
        }catch(Exception e){
            e.printStackTrace();
            result = false;
        }finally{
            closeConnection();
        }
        
        return result;
    }
}
