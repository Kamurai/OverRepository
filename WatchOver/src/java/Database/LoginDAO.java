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
                rs.getInt("WatchOverUserIndex"), 
                rs.getInt("WatchOverAdminLevel"),
                rs.getBoolean("WatchOverOnline"), 
                
                rs.getString("Username"), 
                rs.getString("Email"), 
                //Genres
                rs.getBoolean("ComedyM"), 
                rs.getBoolean("DramaM"), 
                rs.getBoolean("ActionM"), 
                rs.getBoolean("HorrorM"), 
                rs.getBoolean("ThrillerM"), 
                rs.getBoolean("MysteryM"), 
                rs.getBoolean("DocumentaryM"), 
                //Settings
                rs.getBoolean("ScienceFictionM"), 
                rs.getBoolean("FantasyM"), 
                rs.getBoolean("WesternM"), 
                rs.getBoolean("MartialArtsM"), 
                rs.getBoolean("ModernM"), 
                rs.getBoolean("HistoricM"), 
                rs.getBoolean("PrehistoricM"), 
                rs.getBoolean("ComicsM"), 
                rs.getBoolean("PeriodM")
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
        if( !targetUser.getComedyM() && 
            !targetUser.getDramaM() && 
            !targetUser.getActionM() && 
            !targetUser.getHorrorM() && 
            !targetUser.getThrillerM() && 
            !targetUser.getMysteryM() && 
            !targetUser.getDocumentaryM()
        ){
            //then set default to true
            targetUser.setComedyM(true);
        }
        
        //if all Platforms are false
        if( !targetUser.getScienceFictionM() && 
            !targetUser.getFantasyM() && 
            !targetUser.getWesternM() && 
            !targetUser.getMartialArtsM() && 
            !targetUser.getModernM() && 
            !targetUser.getHistoricM() && 
            !targetUser.getPrehistoricM() && 
            !targetUser.getComicsM() && 
            !targetUser.getPeriodM()
        ){
            //then set default to true
            targetUser.setScienceFictionM(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
        
            stmt = getConnect().prepareCall("{call WatchOverUpdateOptions(?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            //Genres
            stmt.setBoolean(2, targetUser.getComedyM());
            stmt.setBoolean(3, targetUser.getDramaM());
            stmt.setBoolean(4, targetUser.getActionM());
            stmt.setBoolean(5, targetUser.getHorrorM());
            stmt.setBoolean(5, targetUser.getThrillerM());
            stmt.setBoolean(5, targetUser.getMysteryM());
            stmt.setBoolean(5, targetUser.getDocumentaryM());
            //Settings
            stmt.setBoolean(5, targetUser.getScienceFictionM());
            stmt.setBoolean(5, targetUser.getFantasyM());
            stmt.setBoolean(5, targetUser.getWesternM());
            stmt.setBoolean(5, targetUser.getMartialArtsM());
            stmt.setBoolean(5, targetUser.getModernM());
            stmt.setBoolean(5, targetUser.getHistoricM());
            stmt.setBoolean(5, targetUser.getPrehistoricM());
            stmt.setBoolean(5, targetUser.getComicsM());
            stmt.setBoolean(5, targetUser.getPeriodM());
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
        boolean boolComedyM,
        boolean boolDramaM,
        boolean boolActionM,
        boolean boolHorrorM,
        boolean boolThrillerM,
        boolean boolMysteryM,
        boolean boolDocumentaryM,
        //Settings
        boolean boolScienceFictionM,
        boolean boolFantasyM,
        boolean boolWesternM,
        boolean boolMartialArtsM,
        boolean boolModernM,
        boolean boolHistoricM,
        boolean boolPrehistoricM,
        boolean boolComicsM,
        boolean boolPeriodM
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
            stmt.setBoolean(4, boolComedyM);
            stmt.setBoolean(5, boolDramaM);
            stmt.setBoolean(6, boolActionM);
            stmt.setBoolean(7, boolHorrorM);
            stmt.setBoolean(8, boolThrillerM);
            stmt.setBoolean(9, boolMysteryM);
            stmt.setBoolean(10, boolDocumentaryM);
            //Settings
            stmt.setBoolean(11, boolScienceFictionM);
            stmt.setBoolean(12, boolFantasyM);
            stmt.setBoolean(13, boolWesternM);
            stmt.setBoolean(14, boolMartialArtsM);
            stmt.setBoolean(15, boolModernM);
            stmt.setBoolean(16, boolHistoricM);
            stmt.setBoolean(17, boolPrehistoricM);
            stmt.setBoolean(18, boolComicsM);
            stmt.setBoolean(19, boolPeriodM);
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
