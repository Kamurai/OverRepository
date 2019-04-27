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
                x--;
                
                //find children of last added child
                getBoxList().get(getBoxList().size()-1).addBoxesAndTargets(tempBoxes, tempTargets);
            }
        }
        
        for( int y = 0; y < tempTargets.size(); y++){
            //if a child of this box
            if(tempTargets.get(y).getParentIndex() == boxIndex){
                getTargetList().add(tempTargets.get(y));
                tempTargets.remove(y);
                y--;
            }
        }
    }
    
    public String printToHTML(){
        String resultString = "";
        
        resultString = "<div id='idMainStructure'>";
        
        for(int x = 0; x < boxList.size(); x++){
            resultString += "<div class='";
            if(getDirection() == "Horizontal"){
                resultString += "classHorizontal ";
            }else{
                resultString += "classVertical ";
            }            
            resultString += "classBox'>";
            resultString += boxList.get(x).getLabel();
            resultString += printToHTML(boxList.get(x));
                        
            resultString += "</div>";
        }   
        
        for(int x = 0; x < targetList.size(); x++){
            resultString += "<div class='classTarget'>";
            resultString += targetList.get(x).getLabel();
                        
            resultString += "</div>";
        }
        
        resultString += "</div>";
        
        return resultString;
    }
    
    private String printToHTML(Box box){
        String resultString = "";
        
        for(int x = 0; x < box.boxList.size(); x++){
            resultString += "<div class='";
            if(box.boxList.get(x).getDirection().equals("Horizontal")){
                resultString += "classHorizontal ";
            }else{
                resultString += "classVertical ";
            }            
            resultString += "classBox'>";
            resultString += box.boxList.get(x).getLabel();
            resultString += printToHTML(box.boxList.get(x));
                        
            resultString += "</div>";
        }   
        
        for(int x = 0; x < box.targetList.size(); x++){
            resultString += "<div class='classTarget'>";
            resultString += box.targetList.get(x).getLabel();
                        
            resultString += "</div>";
        }
        
        
        return resultString;
    }
}
