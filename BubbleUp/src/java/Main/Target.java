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
    int rank = -1;
    public int getRank(){
        return rank;
    }
    public void setRank(int rank){
        this.rank = rank;
    }
    
    public Target(){}
    
    public Target(
        int targetIndex, 
        String label, 
        int parentIndex, 
        int rank
    ){
        this.targetIndex    = targetIndex;
        this.label          = label;
        this.parentIndex    = parentIndex;
        this.rank           = rank;
    }
    
    public Target(
        Target inTarget
    ){
        this.targetIndex    = inTarget.targetIndex;
        this.label          = inTarget.label;
        this.parentIndex    = inTarget.parentIndex;
        this.rank           = inTarget.rank;
    }
}
