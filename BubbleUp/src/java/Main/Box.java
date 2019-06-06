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
    String newValue = "";
    public String getNewValue(){
        return newValue;
    }
    public void setNewValue(String newValue){
        this.newValue = newValue;
    }
    
    public boolean isDirectionHorizontal(){
        return direction.equals("Horizontal");
    }
    
    public boolean isDirectionVertical(){
        return direction.equals("Vertical");
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
        
        resultString = "<table id='idMainStructure' class='classBox'>";
            resultString += "<tr class='classBoxLabelRow'>";
                resultString += "<td class='classBoxLabelHeader'>";
                    resultString += "Bubble Up! Dynamic Table Test";
                resultString += "</td>";
            resultString += "</tr>";
            
            resultString += "<tr class='classBoxSubRow'>";
                
            
            
            
            for(int x = 0; x < boxList.size(); x++){
                if(getDirection() == "Horizontal"){
                    resultString += "<tr><td>";
                }else{
                    resultString += "<td>";
                }            
                    resultString += printToHTML(boxList.get(x));
                if(getDirection() == "Horizontal"){
                    resultString += "</td></tr>";
                }else{
                    resultString += "</td>";
                }            
            }
            
            
            
                resultString += "<td>";
                    resultString += "<table class='classBoxLabelSection'>";
                        for(int y = 0; y < targetList.size(); y++){
                            resultString += "<tr><td class='classTarget'>";
                                resultString += targetList.get(y).getLabel();
                            resultString += "</td></tr>";
                        }
                    resultString += "</table>";
                resultString += "</td>";
            resultString += "</tr>";
        resultString += "</table>";
        
        return resultString;
    }
    
    private String printToHTML(Box box){
        String resultString = "";
        
        resultString = "<table class='classBox'>";
            resultString += "<tr class='classBoxLabelRow'>";
                resultString += "<td class='classBoxLabelHeader'>";
                    resultString += box.getLabel();
                resultString += "</td>";
            resultString += "</tr>";
            resultString += "<tr class='classBoxSubRow'>";
                for(int x = 0; x < box.boxList.size(); x++){
                    if(getDirection() == "Horizontal"){
                        resultString += "<tr><td>";
                    }else{
                        resultString += "<td>";
                    }            
                        resultString += printToHTML(box.boxList.get(x));
                    if(getDirection() == "Horizontal"){
                        resultString += "</td></tr>";
                    }else{
                        resultString += "</td>";
                    }            
                }
                resultString += "<td>";
                    resultString += "<table class='classBoxLabelSection'>";
                        for(int y = 0; y < box.targetList.size(); y++){
                            resultString += "<tr><td class='classTarget'>";
                                resultString += box.targetList.get(y).getLabel();
                            resultString += "</td></tr>";
                        }
                    resultString += "</table>";
                resultString += "</td>";
            resultString += "</tr>";
        resultString += "</table>";
        
        return resultString;
    }
    
    public String printToHTML1(){
        String resultString = "";
        
        resultString = "<div id='idDivMainStructure' class='classDivBox'>";
            resultString += "<div class='classDivBoxLabelRow'>";
                resultString += "<div class='classDivBoxLabelHeader'>";
                    resultString += "Bubble Up! Dynamic Div Test";
                resultString += "</div>";
            resultString += "</div>";
            
            resultString += "<div class='classDivBoxSubRow'>";
                for(int x = 0; x < boxList.size(); x++){
                    resultString += "<div class='";
                    if(getDirection() == "Horizontal"){
                        resultString += "classDivHorizontal ";
                    }else{
                        resultString += "classDivVertical ";
                    }            
                    resultString += "classDivBox'>";
                        resultString += printToHTML1(boxList.get(x));
                    resultString += "</div>";
                }   

                for(int x = 0; x < targetList.size(); x++){
                    resultString += "<div class='classDivTarget'>";
                        resultString += targetList.get(x).getLabel();
                    resultString += "</div>";
                }
            resultString += "</div>";
        resultString += "</div>";
        
        return resultString;
    }
    
    private String printToHTML1(Box box){
        String resultString = "";
        
        resultString = "<div class='classDivBox'>";
            resultString += "<div class='classDivBoxLabelRow'>";
                resultString += "<div class='classDivBoxLabelHeader'>";
                    resultString += box.getLabel();
                resultString += "</div>";
            resultString += "</div>";
            resultString += "<div class='classDivBoxSubRow'>";
                for(int x = 0; x < box.boxList.size(); x++){
                    resultString += "<div class='";
                    if(box.boxList.get(x).getDirection().equals("Horizontal")){
                        resultString += "classDivHorizontal ";
                    }else{
                        resultString += "classDivVertical ";
                    }            
                    resultString += "classDivBox'>";
                        resultString += printToHTML1(box.boxList.get(x));
                    resultString += "</div>";
                }   

                for(int x = 0; x < box.targetList.size(); x++){
                    resultString += "<div class='classDivTarget'>";
                        resultString += box.targetList.get(x).getLabel();
                    resultString += "</div>";
                }
            resultString += "</div>";
        resultString += "</div>";
        
        return resultString;
    }
}
