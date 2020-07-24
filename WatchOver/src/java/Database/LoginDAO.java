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
        
            stmt = connect.prepareCall("{call WatchOverGetValidUser(?,?)}");
            stmt.setString(1, strUsername);
            stmt.setString(2, strPassword);
            rs = stmt.executeQuery();
            
            rs.next();
            
            returnUser = new User(
                rs.getInt("UserIndex"), 
                rs.getInt("AdminLevel"),
                rs.getBoolean("Online"), 
                
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getBoolean("Memory"), 
                //Genres
                rs.getBoolean("Comedy"), 
                rs.getBoolean("Drama"), 
                rs.getBoolean("Action"), 
                rs.getBoolean("Horror"), 
                rs.getBoolean("Thriller"), 
                rs.getBoolean("Mystery"), 
                rs.getBoolean("Documentary"), 
                //Settings
                rs.getBoolean("ScienceFiction"), 
                rs.getBoolean("Fantasy"), 
                rs.getBoolean("Western"), 
                rs.getBoolean("MartialArts"), 
                rs.getBoolean("Modern"), 
                rs.getBoolean("Historic"), 
                rs.getBoolean("Prehistoric"), 
                rs.getBoolean("Comics"), 
                rs.getBoolean("Period")
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
        
            stmt = getConnect().prepareCall("{call WatchOverSetOnlineStatus(?,?)}");
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
        
            stmt = getConnect().prepareCall("{call WatchOverSetOnlineStatus(?,?)}");
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
        
        //if all Genres are false
        if( !targetUser.getComedy() && 
            !targetUser.getDrama() && 
            !targetUser.getAction() && 
            !targetUser.getHorror() && 
            !targetUser.getThriller() && 
            !targetUser.getMystery() && 
            !targetUser.getDocumentary()
        ){
            //then set default to true
            targetUser.setComedy(true);
        }
        
        //if all Platforms are false
        if( !targetUser.getScienceFiction() && 
            !targetUser.getFantasy() && 
            !targetUser.getWestern() && 
            !targetUser.getMartialArts() && 
            !targetUser.getModern() && 
            !targetUser.getHistoric() && 
            !targetUser.getPrehistoric() && 
            !targetUser.getComics() && 
            !targetUser.getPeriod()
        ){
            //then set default to true
            targetUser.setScienceFiction(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
        
            stmt = getConnect().prepareCall("{call WatchOverUpdateOptions(?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            //Genres
            stmt.setBoolean(2, targetUser.getComedy());
            stmt.setBoolean(3, targetUser.getDrama());
            stmt.setBoolean(4, targetUser.getAction());
            stmt.setBoolean(5, targetUser.getHorror());
            stmt.setBoolean(5, targetUser.getThriller());
            stmt.setBoolean(5, targetUser.getMystery());
            stmt.setBoolean(5, targetUser.getDocumentary());
            //Settings
            stmt.setBoolean(5, targetUser.getScienceFiction());
            stmt.setBoolean(5, targetUser.getFantasy());
            stmt.setBoolean(5, targetUser.getWestern());
            stmt.setBoolean(5, targetUser.getMartialArts());
            stmt.setBoolean(5, targetUser.getModern());
            stmt.setBoolean(5, targetUser.getHistoric());
            stmt.setBoolean(5, targetUser.getPrehistoric());
            stmt.setBoolean(5, targetUser.getComics());
            stmt.setBoolean(5, targetUser.getPeriod());
            rs = stmt.executeQuery();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableClearMemories(User targetUser){
        CallableStatement stmt = null;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call WatchOverClearMemories(?)}");
            stmt.setInt(1, targetUser.getUserIndex());
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
        boolean boolPrehistoric,
        boolean boolComics,
        boolean boolPeriod
    )
    {
        CallableStatement stmt = null;
        boolean result = false;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            //open connection
            openConnection();
            
            stmt = getConnect().prepareCall("{call WatchOverSignUp(?,?,?,?,?,?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            //Genres
            stmt.setBoolean(4, boolComedy);
            stmt.setBoolean(5, boolDrama);
            stmt.setBoolean(6, boolAction);
            stmt.setBoolean(7, boolHorror);
            stmt.setBoolean(8, boolThriller);
            stmt.setBoolean(9, boolMystery);
            stmt.setBoolean(10, boolDocumentary);
            //Settings
            stmt.setBoolean(11, boolScienceFiction);
            stmt.setBoolean(12, boolFantasy);
            stmt.setBoolean(13, boolWestern);
            stmt.setBoolean(14, boolMartialArts);
            stmt.setBoolean(15, boolModern);
            stmt.setBoolean(16, boolHistoric);
            stmt.setBoolean(17, boolPrehistoric);
            stmt.setBoolean(18, boolComics);
            stmt.setBoolean(19, boolPeriod);
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
