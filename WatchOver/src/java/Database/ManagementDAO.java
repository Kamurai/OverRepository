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
    public List<User> callablePullUserDataModel()
    {
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
                sub.add(Integer.toString(rs.getInt("WatchOverAdminLevel")));
                sub.add(Integer.toString(rs.getInt("Women")));
                sub.add(Integer.toString(rs.getInt("Men")));
                sub.add(Integer.toString(rs.getInt("TransWomen")));
                sub.add(Integer.toString(rs.getInt("TransMen")));
                sub.add(Integer.toString(rs.getInt("WatchOverOnline")));
                
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
