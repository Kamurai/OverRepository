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
        
            stmt = connect.prepareCall("{call ShowOverGetValidUser(?,?)}");
            stmt.setString(1, strUsername);
            stmt.setString(2, strPassword);
            rs = stmt.executeQuery();
            
            rs.next();
            
            returnUser = new User(
                rs.getInt("UserIndex"), 
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getInt("AdminLevel"),
                //Genres
                rs.getBoolean("ComedyS"), 
                rs.getBoolean("DramaS"), 
                rs.getBoolean("ActionS"), 
                rs.getBoolean("HorrorS"), 
                rs.getBoolean("ThrillerS"), 
                rs.getBoolean("MysteryS"), 
                rs.getBoolean("DocumentaryS"), 
                //Settings
                rs.getBoolean("ScienceFictionS"), 
                rs.getBoolean("FantasyS"), 
                rs.getBoolean("WesternS"), 
                rs.getBoolean("MartialArtsS"), 
                rs.getBoolean("ModernS"), 
                rs.getBoolean("HistoricS"), 
                rs.getBoolean("PrehistoricS"), 
                rs.getBoolean("ComicsS"), 
                rs.getBoolean("PeriodS"), 
                
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
        
            stmt = getConnect().prepareCall("{call ShowOverSetOnlineStatus(?,?)}");
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
        
            stmt = getConnect().prepareCall("{call ShowOverSetOnlineStatus(?,?)}");
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
        if( !targetUser.getComedyS() && 
            !targetUser.getDramaS() && 
            !targetUser.getActionS() && 
            !targetUser.getHorrorS() && 
            !targetUser.getThrillerS() && 
            !targetUser.getMysteryS() && 
            !targetUser.getDocumentaryS()
        ){
            //then set default to true
            targetUser.setComedyS(true);
        }
        
        //if all Platforms are false
        if( !targetUser.getScienceFictionS() && 
            !targetUser.getFantasyS() && 
            !targetUser.getWesternS() && 
            !targetUser.getMartialArtsS() && 
            !targetUser.getModernS() && 
            !targetUser.getHistoricS() && 
            !targetUser.getPrehistoricS() && 
            !targetUser.getComicsS() && 
            !targetUser.getPeriodS()
        ){
            //then set default to true
            targetUser.setScienceFictionS(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
        
            stmt = getConnect().prepareCall("{call ShowOverUpdateOptions(?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            //Genres
            stmt.setBoolean(2, targetUser.getComedyS());
            stmt.setBoolean(3, targetUser.getDramaS());
            stmt.setBoolean(4, targetUser.getActionS());
            stmt.setBoolean(5, targetUser.getHorrorS());
            stmt.setBoolean(5, targetUser.getThrillerS());
            stmt.setBoolean(5, targetUser.getMysteryS());
            stmt.setBoolean(5, targetUser.getDocumentaryS());
            //Settings
            stmt.setBoolean(5, targetUser.getScienceFictionS());
            stmt.setBoolean(5, targetUser.getFantasyS());
            stmt.setBoolean(5, targetUser.getWesternS());
            stmt.setBoolean(5, targetUser.getMartialArtsS());
            stmt.setBoolean(5, targetUser.getModernS());
            stmt.setBoolean(5, targetUser.getHistoricS());
            stmt.setBoolean(5, targetUser.getPrehistoricS());
            stmt.setBoolean(5, targetUser.getComicsS());
            stmt.setBoolean(5, targetUser.getPeriodS());
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
        boolean boolComedyS,
        boolean boolDramaS,
        boolean boolActionS,
        boolean boolHorrorS,
        boolean boolThrillerS,
        boolean boolMysteryS,
        boolean boolDocumentaryS,
        //Settings
        boolean boolScienceFictionS,
        boolean boolFantasyS,
        boolean boolWesternS,
        boolean boolMartialArtsS,
        boolean boolModernS,
        boolean boolHistoricS,
        boolean boolPrehistoricS,
        boolean boolComicsS,
        boolean boolPeriodS
    ){
        CallableStatement stmt = null;
        boolean result = false;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            //open connection
            openConnection();
            
            stmt = getConnect().prepareCall("{call ShowOverUpdateOptions(?,?,?,?,?,?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            //Genres
            stmt.setBoolean(4, boolComedyS);
            stmt.setBoolean(5, boolDramaS);
            stmt.setBoolean(6, boolActionS);
            stmt.setBoolean(7, boolHorrorS);
            stmt.setBoolean(8, boolThrillerS);
            stmt.setBoolean(9, boolMysteryS);
            stmt.setBoolean(10, boolDocumentaryS);
            //Settings
            stmt.setBoolean(11, boolScienceFictionS);
            stmt.setBoolean(12, boolFantasyS);
            stmt.setBoolean(13, boolWesternS);
            stmt.setBoolean(14, boolMartialArtsS);
            stmt.setBoolean(15, boolModernS);
            stmt.setBoolean(16, boolHistoricS);
            stmt.setBoolean(17, boolPrehistoricS);
            stmt.setBoolean(18, boolComicsS);
            stmt.setBoolean(19, boolPeriodS);
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
