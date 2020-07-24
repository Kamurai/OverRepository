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
            stmt = getConnect().prepareCall("{call BubbleUpPullUserList()}");
            rs = stmt.executeQuery();
            
            boolean boolLoggedOn = false;
            
            while(rs.next()){
                if(rs.getInt("Online") == 1){
                    boolLoggedOn = true;
                }else{
                    boolLoggedOn = false;
                }
                
                tempUser = new User(
                        rs.getInt("UserIndex"), 
                        rs.getString("Username"), 
                        rs.getString("Email"), 
                        rs.getInt("AdminLevel"), 
                        boolLoggedOn
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
    public ArrayList<ArrayList<String>> callablePullUserList(){
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> sub = new ArrayList<String>();
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call BubbleUpPullUserList()}");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                sub.add(rs.getString("Username"));
                sub.add(rs.getString("Email"));
                sub.add(Integer.toString(rs.getInt("AdminLevel")));
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
            stmt = getConnect().prepareCall("{call BubbleUpPullUserCounts()}");
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
