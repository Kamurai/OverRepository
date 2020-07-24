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

public class TargetDAO extends DAO{
    
    public TargetDAO(){
        super();
    }
    
    //Swap Positions
    public void callableSwapTargets(int intUserIndex, String strTarget1, String strTarget2){
        CallableStatement stmt = null;
        
        try{
            openConnection();
            
            //Call statement
            stmt = getConnect().prepareCall("{call BangOverSwapTargets(?,?,?)}");
            //Parameters
            stmt.setInt(1, intUserIndex);
            stmt.setString(2, strTarget1);
            stmt.setString(3, strTarget2);
            stmt.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }

    //Add Target
    public void callableAddTarget(String strTargetToAdd, String strValueToAdd, String strURLToAdd, int intUserIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();
            //Call statement
            stmt = getConnect().prepareCall("{call BangOverAddTarget(?,?,?,?)}");
            //Parameters
            stmt.setString(1,   strTargetToAdd);    //Target Name
            stmt.setString(2,   strValueToAdd);     //Target Category
            stmt.setString(3,   strURLToAdd);       //Target URL
            stmt.setInt(4,      intUserIndex);      //Requesting User index
            stmt.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    //Add Target Suggestion
    public void callableAddTargetSuggestion(String strTargetToAdd, String strValueToAdd, String strURLToAdd, int intUserIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            //Call statement
            stmt = getConnect().prepareCall("{call BangOverAddTargetSuggestion(?,?,?,?)}");
            //Parameters
            stmt.setString(1,   strTargetToAdd);    //Target Name
            stmt.setString(2,   strValueToAdd);     //Target Category
            stmt.setString(3,   strURLToAdd);       //Target URL
            stmt.setInt(4,      intUserIndex);      //Requesting User index
            stmt.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    //Pull Global List
    public ArrayList<ArrayList<String>> callablePullGlobalList(){
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        //TODO: Add Target object
        ArrayList<String> Sub = new ArrayList<String>();
        String tempValue = "";
        ResultSet rs;
               
        try{
            openConnection();
            
            stmt = getConnect().prepareCall("{call BangOverPullGlobalListAll}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                Sub.add(rs.getString("NAME"));
                Sub.add(rs.getString("Picture"));
                tempValue = rs.getString("Gender");
                
                if( tempValue.compareTo("F") == 0 )
                {
                    Sub.add("Woman");
                }
                else if( tempValue.compareTo("M") == 0 )
                {
                    Sub.add("Man");
                }
                else if( tempValue.compareTo("W") == 0 )
                {
                    Sub.add("Trans Woman");
                }
                else if( tempValue.compareTo("T") == 0 )
                {
                    Sub.add("Trans Man");
                }
                
                Sub.add(rs.getString("Ranking"));
                
                resultList.add(new ArrayList<String>(Sub));
                Sub.clear();
            }
        }catch(Exception e){
            e.printStackTrace();
            resultList = null;
        }finally{
            closeConnection();
        }
        
        return resultList;
    }

    //Pull Personal List
    public ArrayList<ArrayList<String>> callablePullPersonalList(int intUserIndex){
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> Sub = new ArrayList<String>();
        String tempValue = "";
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call BangOverPullPersonalList(?)}");
            stmt.setInt(1, intUserIndex);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                Sub.add(rs.getString("NAME"));
                Sub.add(rs.getString("Picture"));
                tempValue = rs.getString("Gender");
                
                if( tempValue.compareTo("F") == 0 )
                {
                    Sub.add("Woman");
                }
                else if( tempValue.compareTo("M") == 0 )
                {
                    Sub.add("Man");
                }
                else if( tempValue.compareTo("W") == 0 )
                {
                    Sub.add("Trans Woman");
                }
                else if( tempValue.compareTo("T") == 0 )
                {
                    Sub.add("Trans Man");
                }
                Sub.add(rs.getString("Rank"));
                
                resultList.add(new ArrayList<String>(Sub));
                Sub.clear();
            }            
        }catch(Exception e){
            e.printStackTrace();
            resultList = null;
        }finally{
            closeConnection();
        }
        
        return resultList;
    }

    //Pull Global Counts
    public ArrayList<ArrayList<String>> callablePullGlobalCounts()
    {
        CallableStatement stmt = null;
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> sub = new ArrayList<String>();
        ResultSet rs;
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call BangOverPullGlobalCounts()}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add(Integer.toString(rs.getInt("Retnum")));
                
                resultList.add(new ArrayList<String>(sub));
                sub.clear();
            }            
        }
        catch(Exception e){
            e.printStackTrace();
            resultList = null;
        }finally{
            closeConnection();
        }
        
        return resultList;
    }
        
    //Pull Random Target Pair: Pull 1 from Personal, plus adjacent (non-lock) or global if at ends
    public ArrayList<ArrayList<String>> callablePullTargetPair(String strUserIndex)
    {
        CallableStatement stmt = null;
        ArrayList<String> resultList = new ArrayList<String>();
        ArrayList<String> sub = new ArrayList<String>();
        ArrayList<ArrayList<String>> pairList = new ArrayList<ArrayList<String>>();
        ResultSet rs;
        
        try
        {
            //open dbi.getConnect()ion
            openConnection();
            stmt = getConnect().prepareCall("{call BangOverPullTargetPair(?)}");
            stmt.setString(1, strUserIndex);
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add(rs.getString("Name"));
                sub.add(rs.getString("Picture"));
                pairList.add(new ArrayList<String>(sub) );
                sub.clear();                
            }            
        }catch(Exception e){
            e.printStackTrace();
            resultList = null;
        }finally{
            closeConnection();
        }
        
        while(pairList.size() > 2)
        {
            pairList.remove(2);           
        }
        
        return pairList;
    }
    
    //Pull Random Advert Pair
    public ArrayList<ArrayList<String>> callablePullAdvertPair(){
        CallableStatement stmt = null;
        ArrayList<String> sub = new ArrayList<String>();
        ArrayList<ArrayList<String>> pairList = new ArrayList<ArrayList<String>>();
        ResultSet rs;
        
        try{
            openConnection();
            
            stmt = connect.prepareCall("{call BangOverPullAdvertPair}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add( rs.getString("Picture") );
                sub.add( rs.getString("Link") );
                pairList.add(new ArrayList<String>(sub) );
                sub.clear();
            }            
        }
        catch(Exception e){
            e.printStackTrace();
            pairList = null;
        }finally{
            closeConnection();
        }
        
        while(pairList != null && pairList.size() > 2)
        {
            pairList.remove(2);           
        }
      
        return pairList;
    }
}
