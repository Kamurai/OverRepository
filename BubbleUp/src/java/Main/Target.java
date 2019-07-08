package Main;

import Bean.LoginBean;
import java.util.ArrayList;

public class Target {
    int targetIndex = -1;
    public int getTargetIndex(){
        return targetIndex;
    }
    public void setTargetIndex(int targetIndex){
        this.targetIndex = targetIndex;
    }
    String label = "";
    public String getLabel(){
        return label;
    }
    public void setLabel(String label){
        this.label = label;
    }
    int parentIndex = -1;
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
    
    public Target(){}
    
    public Target(
        int targetIndex, 
        String label, 
        int parentIndex, 
        int orderRank
    ){
        this.targetIndex    = targetIndex;
        this.label          = label;
        this.parentIndex    = parentIndex;
        this.orderRank      = orderRank;
    }
    
    public Target(
        Target inTarget
    ){
        this.targetIndex    = inTarget.targetIndex;
        this.label          = inTarget.label;
        this.parentIndex    = inTarget.parentIndex;
        this.orderRank      = inTarget.orderRank;
    }
}
