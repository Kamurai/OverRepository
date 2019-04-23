/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Database.ManagementDAO;
import Main.User;
import java.io.*;
import javax.faces.bean.ManagedBean;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.faces.bean.ViewScoped;
import java.util.ArrayList;
import java.util.List;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.ListDataModel;
import javax.faces.model.DataModel;

/**
 * @author Kamurai
 */
@ManagedBean(name="ManagementBean")
@ViewScoped
public class ManagementBean implements Serializable
{
    private Connection connect;
    private ManagementDAO dao;
    private String error;
    public String geterror()
    {
        return error;
    }
    public void seterror(String input)
    {
        error = input;
    }
    private List<User> userList;
    public List<User> getuserList()
    {
        return userList;
    }
     public void setUserDataList() //set User Data Model
    {
        userList = new ArrayList<User>(PullUserDataModel());
    }
    public int getuserListSize()
    {
        int monkey = userList.size();
        return monkey;
    }
    private ArrayList<ArrayList<String>> ul;
    public ArrayList<ArrayList<String>> getul()
    {
        return ul;
    }
    public void setul() //set User List
    {
        ul = PullUserList();
        //dataModel = new ListDataModel<User>(ul);
    }
    public int getULSize()
    {
        int monkey = ul.size();
        return monkey;
    }
    private ArrayList<ArrayList<String>> uc;
    public ArrayList<ArrayList<String>> getuc()
    {
        return uc;
    }
    public int getUCSize()
    {
        int monkey = uc.size();
        return monkey;
    }
    public void setUserCounts()//set User Counts
    {
        uc = PullUserCounts();
    }
    private String ManagementTargetUsername;
    public void setManagementTargetUsername(String userName)
    {
        ManagementTargetUsername = userName;
    }
    public String getManagementTargetUsername()
    {
        return ManagementTargetUsername;
    }
    private DataModel<User> dataModel;
    public DataModel<User> getdataModel()
    {
        return dataModel;
    }
    
    
    public ManagementBean()
    {
        connect = null;
        dao = new ManagementDAO();
        error = "";
        
        userList = new ArrayList<User>(PullUserDataModel());
        ul = new ArrayList<ArrayList<String>>(PullUserList());
        uc = new ArrayList<ArrayList<String>>(PullUserCounts());
        
        ManagementTargetUsername = "";
        dataModel = new ListDataModel<User>(PullUserDataModel());
    }
    
    public void UpdateUser(ValueChangeEvent e)
    {
        int adminLevel = Integer.parseInt( e.getNewValue().toString() );
        String username = getdataModel().getRowData().getUsername();
        
        
        dao.callableUpdateUser(username, adminLevel);
    }
    
    //Pull User Data Model
    public List<User> PullUserDataModel()
    {
        List<User> resultList = new ArrayList<User>();
        
        resultList = dao.callablePullUserDataModel();
        
        return resultList;
    }
    
    //Pull User List
    public ArrayList<ArrayList<String>> PullUserList()
    {
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        
        resultList = dao.callablePullUserList();
        
        return resultList;
    }
    
    //Pull User Counts
    public ArrayList<ArrayList<String>> PullUserCounts()
    {
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        
        resultList = dao.callablePullUserCounts();
        
        return resultList;
    }
}   
