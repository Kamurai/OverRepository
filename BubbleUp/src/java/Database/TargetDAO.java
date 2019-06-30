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
    
    //Update Personal List
    public void callableUpdateStructure(int intUserIndex, Box structure, Box originalStructure){
        CallableStatement stmt = null;
        
        List<String> bigList    = new ArrayList<String>();
        String boxIdList        = "";
        String boxLabelList     = "";
        String targetIdList     = "";
        String targetLabelList  = "";
        
        bigList         = createStringLists(structure, originalStructure);
        boxIdList       = bigList.get(0);
        boxLabelList    = bigList.get(1);
        targetIdList    = bigList.get(2);
        targetLabelList = bigList.get(3);
        
//        System.out.println("BoxIdList: " + boxIdList);
//        System.out.println("BoxLabelList: " + boxLabelList);
//        System.out.println("TargetIdList: " + targetIdList);
//        System.out.println("TargetLabelList: " + targetLabelList);
        
        if(
            boxIdList.length() > 0 ||
            boxLabelList.length() > 0 ||
            targetIdList.length() > 0 ||
            targetLabelList.length() > 0
        ){
            try{
                openConnection();

                stmt = connect.prepareCall("{call BubbleUpUpdateStructure(?,?,?,?,?)}");
                stmt.setInt(1, intUserIndex);
                stmt.setString(2, boxIdList);
                stmt.setString(3, boxLabelList);
                stmt.setString(4, targetIdList);
                stmt.setString(5, targetLabelList);
                stmt.executeUpdate();
            }
            catch(Exception e){
                e.printStackTrace();
            }finally{
                closeConnection();
            }
        }
        
    }
    
    private List<String> createStringLists(Box structure, Box originalStructure){
        List<String> bigList    = new ArrayList<String>();
        List<String> tempList   = new ArrayList<String>();
        bigList.add("");
        bigList.add("");
        bigList.add("");
        bigList.add("");
        
//        System.out.println(originalStructure.getLabel() + " vs " + structure.getLabel());
        
        
        if(!structure.getLabel().equals(originalStructure.getLabel())){
            if(bigList.get(0).length() > 0){
                bigList.set(0, bigList.get(0) + ",");
            }
            bigList.set(0, bigList.get(0) + structure.getBoxIndex());
//            System.out.println(structure.getBoxIndex());
        
            if(bigList.get(1).length() > 0){
                bigList.set(1, bigList.get(1) + ",");
            }
            bigList.set(1, bigList.get(1) + structure.getLabel());
//            System.out.println(structure.getLabel());
        
        }
        
        for(int x = 0; x < structure.boxList.size(); x++){
            tempList = createStringLists(structure.boxList.get(x), originalStructure.boxList.get(x));
            
            if(bigList.get(0).length() > 0 && tempList.get(0).length() > 0){
                bigList.set(0, bigList.get(0) + ",");
            }
            bigList.set(0, bigList.get(0) + tempList.get(0));
            if(bigList.get(1).length() > 0 && tempList.get(1).length() > 0){
                bigList.set(1, bigList.get(1) + ",");
            }
            bigList.set(1, bigList.get(1) + tempList.get(1));
            if(bigList.get(2).length() > 0 && tempList.get(2).length() > 0){
                bigList.set(2, bigList.get(2) + ",");
            }
            bigList.set(2, bigList.get(2) + tempList.get(2));
            if(bigList.get(3).length() > 0 && tempList.get(3).length() > 0){
                bigList.set(3, bigList.get(3) + ",");
            }
            bigList.set(3, bigList.get(3) + tempList.get(3));
            
        }
        
        for(int y = 0; y < structure.targetList.size(); y++){
            if(!structure.targetList.get(y).getLabel().equals(originalStructure.targetList.get(y).getLabel())){
                if(bigList.get(2).length() > 0){
                    bigList.set(2, bigList.get(2) + ",");
                }
                bigList.set(2, bigList.get(2) + structure.targetList.get(y).getTargetIndex());
                if(bigList.get(3).length() > 0){
                    bigList.set(3, bigList.get(3) + ",");
                }
                bigList.set(3, bigList.get(3) + structure.targetList.get(y).getLabel());
            }
        }
        
        return bigList;
    }
    
    public void callableDeleteTarget(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpDeleteTarget(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intTargetIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableAddTargetToBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpAddTargetToBox(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intBoxIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableChangeDirectionOfBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpChangeDirectionOfBox(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intBoxIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableMoveBoxAfter(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveBoxAfter(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intBoxIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableMoveBoxBefore(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveBoxBefore(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intBoxIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableMoveTargetAfter(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveTargetAfter(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intTargetIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableMoveTargetBefore(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveTargetBefore(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intTargetIndex);
            stmt.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    //Pull Random Advert Pair
    public ArrayList<ArrayList<String>> callablePullAdvertPair(){
        CallableStatement stmt = null;
        ArrayList<String> sub = new ArrayList<String>();
        ArrayList<ArrayList<String>> pairList = new ArrayList<ArrayList<String>>();
        ResultSet rs;
        
        try{
            openConnection();
            
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
