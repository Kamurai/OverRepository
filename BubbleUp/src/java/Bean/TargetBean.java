package Bean;

import Database.ConnInfo;
import Database.TargetDAO;
import java.io.*;
import javax.faces.bean.ManagedBean;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.faces.bean.ViewScoped;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.http.Part;
import Main.Box;

@ManagedBean(name="TargetBean")
@ViewScoped
public class TargetBean implements Serializable
{
    private Connection connect;
    private final TargetDAO dao;
    
    private String error;
    public String geterror()
    {
        return error;
    }
    public void seterror(String input)
    {
        error = input;
    }
    private String Advert1;
    public String getAdvert1()
    {
        return Advert1;
    }
    public void setAdvert1(String input)
    {
        Advert1 = input;
    }
    private String Advert2;
    public String getAdvert2()
    {
        return Advert2;
    }
    public void setAdvert2(String input)
    {
        Advert2 = input;
    }
    private String AdvertURL1;
    public String getAdvertURL1()
    {
        return AdvertURL1;
    }
    public void setAdvertURL1(String strInput)
    {
        AdvertURL1 = strInput;
    }
    private String AdvertURL2;
    public String getAdvertURL2()
    {
        return AdvertURL2;
    }
    public void setAdvertURL2(String strInput)
    {
        AdvertURL2 = strInput;
    }
    private String TargetName1;
    public String getTargetName1()
    {
        return TargetName1;
    }
    public void setTargetName1(String input)
    {
        TargetName1 = input;
    }
    private String TargetName2;
    public String getTargetName2()
    {
        return TargetName2;
    }
    public void setTargetName2(String input)
    {
        TargetName2 = input;
    }
    private String TargetURL1;
    public String getTargetURL1()
    {
        return TargetURL1;
    }
    public void setTargetURL1(String input)
    {
        TargetURL1 = input;
    }
    private String TargetURL2;
    public String getTargetURL2()
    {
        return TargetURL2;
    }
    public void setTargetURL2(String input)
    {
        TargetURL2 = input;
    }
    private Box structure = new Box();
    public Box getStructure()
    {
        return structure;
    }
    public void setStructure(LoginBean userBean) //set Personal List
    {
        structure = PullStructure(userBean.getCurrentUser().getUserIndex());
    }
    private ArrayList<ArrayList<String>> ul = new ArrayList<ArrayList<String>>();
    public ArrayList<ArrayList<String>> getul()
    {
        return ul;
    }
    public int getULSize()
    {
        int monkey = ul.size();
        return monkey;
    }
    private ArrayList<ArrayList<String>> uc = new ArrayList<ArrayList<String>>();
    public ArrayList<ArrayList<String>> getuc()
    {
        return uc;
    }
    public int getUCSize()
    {
        int monkey = uc.size();
        return monkey;
    }
    private String path;
    public String getpath()
    {
        return path;
    }
    public void setpath(String strInput)
    {
        path = strInput;
    }
    private String folder;
    public String getfolder()
    {
        return folder;
    }
    public void setfolder(String strInput)
    {
        folder = strInput;
    }
    private String advertfolder;
    public String getadvertfolder()
    {
        return advertfolder;
    }
    public void setadvertfolder(String strInput)
    {
        advertfolder = strInput;
    }
    private String ManagementTargetUsername;
    public String getManagementTargetUsername()
    {
        return ManagementTargetUsername;
    }
    public void setManagementTargetUsername(String userName)
    {
        ManagementTargetUsername = userName;
    }
    public void setstrValueToAdd(String input)
    {
        strValueToAdd = input;
    }
    private String strTargetToAdd;
    public String getstrTargetToAdd()
    {
        return strTargetToAdd;
    }
    public void setstrTargetToAdd(String input)
    {
        strTargetToAdd = input;
    }
    private String strURLToAdd;
    public String getstrURLToAdd()
    {
        return strURLToAdd;
    }
    public void setstrURLToAdd(String input)
    {
        strURLToAdd = input;
    }
    private String strValueToAdd;
    public String getstrValueToAdd()
    {
        return strValueToAdd;
    }
    private Part fileTargetToAdd;
    public Part getfileTargetToAdd()
    {
        return fileTargetToAdd;
    }
    public void setfileTargetToAdd(Part input)
    {
        fileTargetToAdd = input;
    }
    private String strTargetToSuggest;
    public String getstrTargetToSuggest()
    {
        return strTargetToSuggest;
    }
    public void setstrTargetToSuggest(String input)
    {
        strTargetToSuggest = input;
    }
    private String strURLToSuggest;
    public String getstrURLToSuggest()
    {
        return strURLToSuggest;
    }
    public void setstrURLToSuggest(String input)
    {
        strURLToSuggest = input;
    }
    private String strValueToSuggest;
    public String getstrValueToSuggest()
    {
        return strValueToSuggest;
    }
    public void setstrValueToSuggest(String input)
    {
        strValueToSuggest = input;
    }
    private Box currentBox;
    public Box getCurrentBox(){
        return currentBox;
    }
    public void setCurrentBox(Box input){
        currentBox = input;
    }
    
    
    public TargetBean()
    {
        connect = null;
        dao = new TargetDAO();
        error = "";
        
        Advert1 = new String();
        Advert2 = new String();
        
        TargetURL1 = new String();
        TargetURL2 = new String();
        
        TargetName1 = new String();
        TargetName2 = new String();
        
        structure = new Box();
        currentBox = new Box();
        ul = new ArrayList<ArrayList<String>>();
        uc = new ArrayList<ArrayList<String>>();
        
        path = "./Pictures/";
        folder = "Targets/";
        advertfolder = "Adverts/";
        
        AdvertURL1 = "";
        AdvertURL2 = "";
        
        ManagementTargetUsername = "";
        
        strTargetToSuggest = "";
        strURLToSuggest = "";
        strValueToSuggest = "F";
        
        strTargetToAdd = "";
        strURLToAdd = "";
        strValueToAdd = "F";
        fileTargetToAdd = null;
        
    }
    
    //Pull Personal Structure
    public Box PullStructure(int intUserIndex){
        Box resultBox = new Box();
        
        resultBox = dao.callablePullStructure(intUserIndex);
        
        structure = resultBox;
        currentBox = resultBox;
        
        return resultBox;
    }
    
    //Pull Random Advert Pair
    public void PullAdvertPair(){
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        
        resultList = dao.callablePullAdvertPair();
        
        //if valid
        if(resultList != null && resultList.size() > 0)
        {
            while(resultList.size() > 2)
            {
                resultList.remove(2);           
            }

            Advert1    = resultList.get(0).get(0);
            AdvertURL1 = resultList.get(0).get(1);
            Advert2    = resultList.get(1).get(0);
            AdvertURL2 = resultList.get(1).get(1);
        }else{
            Advert1     = "_Samara.png";
            AdvertURL1  = "http://www.google.com";
            Advert2     = "_Samara.png";
            AdvertURL2  = "http://www.google.com";
        }
    }    
}   