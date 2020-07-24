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
import java.util.List;
import javax.faces.event.ValueChangeEvent;

public class ManagementDAO extends DAO{
    
    public ManagementDAO(){
        super();
    }
    
    public void callableUpdateUser(String username, int adminLevel)
    {
        CallableStatement stmt = null;
        
        //Update preferences to match check boxes (local variables)
        try
        {
            openConnection();
            
            //Call statement
            stmt = getConnect().prepareCall("{call AllOverUpdateUser(?,?)}");
            //Parameters
            stmt.setString(1, username);
            stmt.setInt(2, adminLevel);
            stmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    //Pull User Data Model
    public List<User> callablePullUserDataModel(){
        CallableStatement stmt = null;
        List<User> ResultList = new ArrayList<User>();
        User tempUser;
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call WatchOverPullUserList()}");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                tempUser = new User(
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
                
                ResultList.add(new User(tempUser));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
        
        return ResultList;
    }
    
    //Pull User List
    public ArrayList<ArrayList<String>> callablePullUserList()
    {
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> sub = new ArrayList<String>();
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call WatchOverPullUserList()}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add(rs.getString("Username"));
                sub.add(rs.getString("Email"));
                sub.add(Integer.toString(rs.getInt("AdminLevel")));
                sub.add(Integer.toString(rs.getInt("Memory")));
                
                //Genres
                sub.add(Integer.toString(rs.getInt("Comedy")));
                sub.add(Integer.toString(rs.getInt("Drama")));
                sub.add(Integer.toString(rs.getInt("Action")));
                sub.add(Integer.toString(rs.getInt("Horror")));
                sub.add(Integer.toString(rs.getInt("Thriller")));
                sub.add(Integer.toString(rs.getInt("Mystery")));
                sub.add(Integer.toString(rs.getInt("Documentary")));
                //Settings
                sub.add(Integer.toString(rs.getInt("ScienceFiction")));
                sub.add(Integer.toString(rs.getInt("Fantasy")));
                sub.add(Integer.toString(rs.getInt("Western")));
                sub.add(Integer.toString(rs.getInt("MartialArts")));
                sub.add(Integer.toString(rs.getInt("Modern")));
                sub.add(Integer.toString(rs.getInt("Historic")));
                sub.add(Integer.toString(rs.getInt("Prehistoric")));
                sub.add(Integer.toString(rs.getInt("Comics")));
                sub.add(Integer.toString(rs.getInt("Period")));
                
                sub.add(Integer.toString(rs.getInt("Online")));
                
                resultList.add(new ArrayList<String>(sub));
                sub.clear();
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
        
        return resultList;
    }
    
    //Pull User Counts
    public ArrayList<ArrayList<String>> callablePullUserCounts()
    {
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> sub = new ArrayList<String>();
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call WatchOverPullUserCounts()}");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                sub.add(Integer.toString(rs.getInt("Retnum")));
                
                resultList.add(new ArrayList<String>(sub));
                sub.clear();
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
        
        return resultList;
    }
}
