package Main;

import java.util.List;
import java.util.ArrayList;

public class Box {
    int boxIndex = -1;
    public int getBoxIndex(){
        return boxIndex;
    }
    public void setBoxIndex(int boxIndex){
        this.boxIndex = boxIndex;
    }
    String direction = "";
    public String getDirection(){
        return direction;
    }
    public void setDirection(String direction){
        this.direction = direction;
    }
    String label = "";
    public String getLabel(){
        return label;
    }
    public void setLabel(String label){
        this.label = label;
    }
    int parentIndex = -2;
    public int getParentIndex(){
        return parentIndex;
    }
    public void setParentIndex(int parentIndex){
        this.parentIndex = parentIndex;
    }
    int orderRank = -1;
    public int getOrderRank(){
        return orderRank;
    }
    public void setOrderRank(int orderRank){
        this.orderRank = orderRank;
    }
    public List<Box> boxList = new ArrayList<Box>();
    public List<Box> getBoxList(){
        return boxList;
    }
    public void setBoxList(List<Box> boxList){
        this.boxList = boxList;
    }
    public List<Target> targetList = new ArrayList<Target>();
    public List<Target> getTargetList(){
        return targetList;
    }
    public void setTargetList(List<Target> targetList){
        this.targetList = targetList;
    }
    
    public Box(){}
    
    public Box(
        int boxIndex, 
        String direction, 
        String label, 
        int parentIndex, 
        int orderRank
    ){
        this.boxIndex = boxIndex;
        this.direction = direction;
        this.label = label;
        this.parentIndex = parentIndex;
        this.orderRank = orderRank;
    }
    
    public void addBoxesAndTargets(List<Box> tempBoxes, List<Target> tempTargets){
        Box resultBox = new Box();
        
        for( int x = 0; x < tempBoxes.size(); x++){
            //if a child of this box
            if(tempBoxes.get(x).getParentIndex() == boxIndex){
                getBoxList().add(tempBoxes.get(x));
                tempBoxes.remove(x);
                
                //find children of last added child
                getBoxList().get(getBoxList().size()-1).addBoxesAndTargets(tempBoxes, tempTargets);
            }
        }
        
        for( int x = 0; x < tempTargets.size(); x++){
            //if a child of this box
            if(tempTargets.get(x).getParentIndex() == boxIndex){
                getTargetList().add(tempTargets.get(x));
                tempTargets.remove(x);
            }
        }
    }
    
    
    
    
}
