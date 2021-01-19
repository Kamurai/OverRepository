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
                            rs.getInt("Rank")
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
                            rs.getInt("Rank")
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
//                System.out.println("Removed: " + tempBoxes.get(x).getLabel());
                tempBoxes.remove(x);
                break;
            }
        }
        
//        System.out.println("Temp Boxes");
        for(int x = 0; x < tempBoxes.size(); x++){
//            System.out.println(tempBoxes.get(x).getLabel());
        }
        
        resultBox.addBoxesAndTargets(tempBoxes, tempTargets);
        
//        System.out.println("Result Box");
        for(int x = 0; x < resultBox.getBoxList().size(); x++){
//            System.out.println(resultBox.getBoxList().get(x).getLabel());
        }
                
        return resultBox;
    }
    
    //Update Personal List
    public void callableUpdateStructure(int intUserIndex, Box structure, Box originalStructure){
        System.out.println("callableUpdateStructure: Start");
        
        
        CallableStatement stmt = null;
        
        Statement test = null;
        
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
        
        System.out.println("BoxIdList: " + boxIdList);
        System.out.println("BoxLabelList: " + boxLabelList);
        System.out.println("TargetIdList: " + targetIdList);
        System.out.println("TargetLabelList: " + targetLabelList);
        
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
        }else{
            try{
            test.executeUpdate("update Boxes SET Label = 'Failure Pile' WHERE BoxIndex = 49");
            }catch(Exception e){
                
            }
        }
        
        System.out.println("callableUpdateStructure: End");
    }
    
    private List<String> createStringLists(Box structure, Box originalStructure){
        System.out.println("CreateStringLists: Start");
        
        List<String> bigList    = new ArrayList<String>();
        List<String> tempList   = new ArrayList<String>();
        bigList.add("");
        bigList.add("");
        bigList.add("");
        bigList.add("");
        
        System.out.println(originalStructure.getLabel() + " vs " + structure.getLabel());
        
        
        if(!structure.getLabel().equals(originalStructure.getLabel())){
            if(bigList.get(0).length() > 0){
                bigList.set(0, bigList.get(0) + ",");
            }
            bigList.set(0, bigList.get(0) + structure.getBoxIndex());
            System.out.println(structure.getBoxIndex());
        
            if(bigList.get(1).length() > 0){
                bigList.set(1, bigList.get(1) + ",");
            }
            bigList.set(1, bigList.get(1) + structure.getLabel());
            System.out.println(structure.getLabel());
        
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
            
            System.out.println(originalStructure.targetList.get(y).getLabel() + " vs " + structure.targetList.get(y).getLabel());
            
            if(!structure.targetList.get(y).getLabel().equals(originalStructure.targetList.get(y).getLabel())){
                System.out.println("Safety 1");
                
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
        
        System.out.println("Indexes: " + bigList.get(2));
        System.out.println("Labels: " + bigList.get(3));
                
        
        System.out.println("CreateStringLists: End");
        
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
    
    public void callableDeleteBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpDeleteBox(?,?)}");
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
    
    public void callableAddBoxToBox(int intUserIndex, int intParentIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpAddBoxToBox(?,?)}");
            stmt.setInt(1, intUserIndex);
            stmt.setInt(2, intParentIndex);
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
    
    
    
    
    
    
    
    public void callableMoveOutLeftBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutLeftBox(?,?)}");
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
    
    public void callableMoveOutRightBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutRightBox(?,?)}");
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
    
    public void callableMoveOutBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutBox(?,?)}");
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
    
    public void callableMoveInBox(int intUserIndex, int intBoxIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveInBox(?,?)}");
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
    
    public void callableMoveOutLeftTarget(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutLeftTarget(?,?)}");
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
    
    public void callableMoveOutRightTarget(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutRightTarget(?,?)}");
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
    
    public void callableMoveOutTarget(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveOutTarget(?,?)}");
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
    
    public void callableMoveInTarget(int intUserIndex, int intTargetIndex){
        CallableStatement stmt = null;
        
        try{
            openConnection();

            stmt = connect.prepareCall("{call BubbleUpMoveInTarget(?,?)}");
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
