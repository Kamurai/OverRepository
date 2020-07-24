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
            stmt = getConnect().prepareCall("{call PlayOverPullUserList()}");
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
                        rs.getBoolean("TwoDP"), 
                        rs.getBoolean("ThreeDP"), 
                        rs.getBoolean("FPS"), 
                        rs.getBoolean("FPP"), 
                        rs.getBoolean("VPuzzle"), 
                        rs.getBoolean("Bulletstorm"), 
                        rs.getBoolean("Fighting"), 
                        rs.getBoolean("Stealth"), 
                        rs.getBoolean("Survival"), 
                        rs.getBoolean("VN"), 
                        rs.getBoolean("IM"), 
                        rs.getBoolean("RPG"), 
                        rs.getBoolean("TRPG"), 
                        rs.getBoolean("ARPG"), 
                        rs.getBoolean("Sports"), 
                        rs.getBoolean("Racing"), 
                        rs.getBoolean("RTS"), 
                        rs.getBoolean("TBS"), 
                        rs.getBoolean("VE"), 
                        rs.getBoolean("MMO"), 
                        rs.getBoolean("MOBA"), 
                        //Platforms
                        rs.getBoolean("PC"), 
                        rs.getBoolean("Atari"), 
                        rs.getBoolean("Commodore64"), 
                        rs.getBoolean("FAMICOM"), 
                        rs.getBoolean("NES"), 
                        rs.getBoolean("SNES"), 
                        rs.getBoolean("N64"), 
                        rs.getBoolean("Gamecube"), 
                        rs.getBoolean("Wii"), 
                        rs.getBoolean("WiiU"), 
                        rs.getBoolean("NintendoSwitch"), 
                        rs.getBoolean("Gameboy"), 
                        rs.getBoolean("VirtualBoy"), 
                        rs.getBoolean("GBA"), 
                        rs.getBoolean("DS"), 
                        rs.getBoolean("ThreeDS"), 
                        rs.getBoolean("SegaGenesis"), 
                        rs.getBoolean("SegaCD"), 
                        rs.getBoolean("SegaDreamcast"), 
                        rs.getBoolean("PS1"), 
                        rs.getBoolean("PS2"), 
                        rs.getBoolean("PS3"), 
                        rs.getBoolean("PS4"), 
                        rs.getBoolean("PSP"), 
                        rs.getBoolean("PSVita"), 
                        rs.getBoolean("Xbox"), 
                        rs.getBoolean("Xbox360"), 
                        rs.getBoolean("XboxOne"), 
                        rs.getBoolean("Ouya"), 
                        rs.getBoolean("OculusRift"), 
                        rs.getBoolean("Vive"), 
                        rs.getBoolean("PSVR")
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
            stmt = getConnect().prepareCall("{call PlayOverPullUserList()}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add(rs.getString("Username"));
                sub.add(rs.getString("Email"));
                sub.add(Integer.toString(rs.getInt("AdminLevel")));
                sub.add(Integer.toString(rs.getInt("Memory")));
                sub.add(Integer.toString(rs.getInt("Women")));
                sub.add(Integer.toString(rs.getInt("Men")));
                sub.add(Integer.toString(rs.getInt("TransWomen")));
                sub.add(Integer.toString(rs.getInt("TransMen")));
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
            stmt = getConnect().prepareCall("{call PlayOverPullUserCounts()}");
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
