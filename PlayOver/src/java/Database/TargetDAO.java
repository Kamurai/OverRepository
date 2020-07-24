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
            stmt = getConnect().prepareCall("{call PlayOverSwapTargets(?,?,?)}");
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
    public void callableAddTarget(String strTargetToAdd, String strReleaseToAdd, String strPlatformToAdd, String strGenreToAdd, String strURLToAdd, int intUserIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();
            //Call statement
            stmt = getConnect().prepareCall("{call PlayOverAddTarget(?,?,?,?,?,?)}");
            //Parameters
            stmt.setString(1,   strTargetToAdd);    //Target Name
            stmt.setString(2,   strReleaseToAdd);   //Target Release
            stmt.setString(3,   strPlatformToAdd ); //Target Platform
            stmt.setString(4,   strGenreToAdd);     //Target Genre
            stmt.setString(5,   strURLToAdd);       //Target URL
            stmt.setInt(6,      intUserIndex);      //Requesting User index
            stmt.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    //Add Target Suggestion
    public void callableAddTargetSuggestion(String strTargetToSuggest, String strReleaseToSuggest, String strPlatformToSuggest, String strGenreToSuggest, String strURLToSuggest, int intUserIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            //Call statement
            stmt = getConnect().prepareCall("{call PlayOverAddTargetSuggestion(?,?,?,?,?,?)}");
            //Parameters
            stmt.setString(1,   strTargetToSuggest);    //Target Name
            stmt.setString(2,   strReleaseToSuggest);   //Target Release
            stmt.setString(3,   strPlatformToSuggest);  //Target Platform
            stmt.setString(4,   strGenreToSuggest);     //Target Genre
            stmt.setString(5,   strURLToSuggest);       //Target URL
            stmt.setInt(6,      intUserIndex);          //Requesting User index
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
            
            stmt = getConnect().prepareCall("{call PlayOverPullGlobalListAll}");
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                Sub.add(rs.getString("NAME"));
                Sub.add(rs.getString("Picture"));
                Sub.add(rs.getString("Release"));
                Sub.add(rs.getString("GamePlatform"));
                Sub.add(rs.getString("Genre"));
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
            stmt = getConnect().prepareCall("{call PlayOverPullPersonalList(?)}");
            stmt.setInt(1, intUserIndex);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                Sub.add(rs.getString("NAME"));
                Sub.add(rs.getString("Picture"));
                Sub.add(rs.getString("Release"));
                Sub.add(rs.getString("GamePlatform"));
                Sub.add(rs.getString("Genre"));
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
            stmt = getConnect().prepareCall("{call PlayOverPullGlobalCounts()}");
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
            stmt = getConnect().prepareCall("{call PlayOverPullTargetPair(?)}");
            stmt.setString(1, strUserIndex);
            rs = stmt.executeQuery();
            
            while(rs.next())
            {
                sub.add(rs.getString("Name"));
                sub.add(rs.getString("Release"));
                sub.add(rs.getString("GamePlatform"));
                sub.add(rs.getString("Genre"));
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
            
            stmt = connect.prepareCall("{call PlayOverPullAdvertPair}");
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
