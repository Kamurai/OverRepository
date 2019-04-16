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
        
            stmt = connect.prepareCall("{call BangOverGetValidUser(?,?)}");
            stmt.setString(1, strUsername);
            stmt.setString(2, strPassword);
            rs = stmt.executeQuery();
            
            rs.next();
            
            returnUser = new User(
                rs.getInt("BangOverUserIndex"), 
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getInt("BangOverAdminLevel"),
                    
                rs.getBoolean("Women"), 
                rs.getBoolean("Men"), 
                rs.getBoolean("TransWomen"), 
                rs.getBoolean("TransMen"), 
                    
                rs.getBoolean("BangOverOnline") 
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
        
            stmt = getConnect().prepareCall("{call BangOverSetOnlineStatus(?,?)}");
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
        
            stmt = getConnect().prepareCall("{call BangOverSetOnlineStatus(?,?)}");
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
        if( !targetUser.getWomen() && 
            !targetUser.getMen() && 
            !targetUser.getTransWomen() && 
            !targetUser.getTransMen())
        {
            //then set default to true
            targetUser.setWomen(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
        
            stmt = getConnect().prepareCall("{call BangOverUpdateOptions(?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            stmt.setBoolean(2, targetUser.getWomen());
            stmt.setBoolean(3, targetUser.getMen());
            stmt.setBoolean(4, targetUser.getTransWomen());
            stmt.setBoolean(5, targetUser.getTransMen());
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
        boolean boolWomen,
        boolean boolMen,
        boolean boolTransWomen,
        boolean boolTransMen
    )
    {
        CallableStatement stmt = null;
        boolean result = false;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            //open connection
            openConnection();
            
            stmt = getConnect().prepareCall("{call BangOverUpdateOptions(?,?,?,?,?,?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setBoolean(4, boolWomen);
            stmt.setBoolean(5, boolMen);
            stmt.setBoolean(6, boolTransWomen);
            stmt.setBoolean(7, boolTransMen);
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
