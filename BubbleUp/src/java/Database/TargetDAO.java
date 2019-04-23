/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import Bean.LoginBean;
import Main.User;
import Main.Box;
import Main.Target;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;

public class TargetDAO extends DAO{
    
    public TargetDAO(){
        super();
    }

    //Pull Personal List
    public Box callablePullStructure(int intUserIndex){
        CallableStatement stmt = null;
        Box resultBox = new Box();
        ResultSet rs;
        List<Box> tempBoxes = new ArrayList<Box>();
        List<Target> tempTargets = new ArrayList<Target>();
        
        try{
            openConnection();
            stmt = getConnect().prepareCall("{call BubbleUpPullStructure(?)}");
            stmt.setInt(1, intUserIndex);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                //if a box
                if(rs.getString("Direction") != null){
                    tempBoxes.add(
                        new Box(
                            rs.getInt("BoxIndex"), 
                            rs.getString("Direction"),
                            rs.getString("Label"),
                            rs.getInt("ParentBoxIndex"),
                            rs.getInt("OrderRank")
                        )
                    );
                }
                //else is a target
                else{
                    tempTargets.add(
                        new Target(
                            rs.getInt("BoxIndex"), 
                            rs.getString("Label"),
                            rs.getInt("ParentBoxIndex"),
                            rs.getInt("OrderRank")
                        )
                    );
                }
            }            
        }catch(Exception e){
            e.printStackTrace();
            resultBox = null;
        }finally{
            closeConnection();
        }
        
        for( int x = 0; x < tempBoxes.size(); x++){
            if(tempBoxes.get(x).getParentIndex() == -1){
                resultBox = tempBoxes.get(x);
                tempBoxes.remove(x);
                break;
            }
        }
        
        resultBox.addBoxesAndTargets(tempBoxes, tempTargets);
                
        return resultBox;
    }
    
    //Pull Random Advert Pair
    public ArrayList<ArrayList<String>> callablePullAdvertPair(){
        CallableStatement stmt = null;
        ArrayList<String> sub = new ArrayList<String>();
        ArrayList<ArrayList<String>> pairList = new ArrayList<ArrayList<String>>();
        ResultSet rs;
        
        try{
            openConnection();
            
            System.out.print(connect);
            
            stmt = connect.prepareCall("{call BubbleUpPullAdvertPair}");
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
