/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Database.ConnInfo;
import Database.TargetDAO;
import Main.Universal;
import java.io.*;
import javax.faces.bean.ManagedBean;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.faces.bean.ViewScoped;
import java.util.ArrayList;
import javax.servlet.http.Part;

/**
 * @author Kamurai
 */
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
    private String TargetRelease1;
    public String getTargetRelease1()
    {
        return TargetRelease1;
    }
    public void setTargetRelease1(String input)
    {
        TargetRelease1 = input;
    }
    private String TargetRelease2;
    public String getTargetRelease2()
    {
        return TargetRelease2;
    }
    public void setTargetRelease2(String input)
    {
        TargetRelease2 = input;
    }
    private String TargetPlatform1;
    public String getTargetPlatform1()
    {
        return TargetPlatform1;
    }
    public void setTargetPlatform1(String input)
    {
        TargetPlatform1 = input;
    }
    private String TargetPlatform2;
    public String getTargetPlatform2()
    {
        return TargetPlatform2;
    }
    public void setTargetPlatform2(String input)
    {
        TargetName2 = input;
    }
    private String TargetGenre1;
    public String getTargetGenre1()
    {
        return TargetGenre1;
    }
    public void setTargetGenre1(String input)
    {
        TargetGenre1 = input;
    }
    private String TargetGenre2;
    public String getTargetGenre2()
    {
        return TargetGenre2;
    }
    public void setTargetGenre2(String input)
    {
        TargetGenre2 = input;
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
    private ArrayList<ArrayList<String>> gl = new ArrayList<ArrayList<String>>();
    public ArrayList<ArrayList<String>> getgl()
    {
        return gl;
    }
    public int getGLSize()
    {
        int monkey = gl.size();
        return monkey;
    }
    public void setGlobalList(LoginBean userBean) //set Global List
    {
        gl = PullGlobalList(userBean);
    }
    private ArrayList<ArrayList<String>> gc = new ArrayList<ArrayList<String>>();
    public ArrayList<ArrayList<String>> getgc()
    {
        return gc;
    }
    public int getGCSize()
    {
        int monkey = gc.size();
        return monkey;
    }
    public void setGlobalCounts() //set Global Counts
    {
        gc = PullGlobalCounts();
    }
    private ArrayList<ArrayList<String>> pl = new ArrayList<ArrayList<String>>();
    public ArrayList<ArrayList<String>> getpl()
    {
        return pl;
    }
    public void setPersonalList(LoginBean userBean) //set Personal List
    {
        pl = PullPersonalList(userBean.getCurrentUser().getUserIndex());
    }
    public int getPLSize()
    {
        int monkey = pl.size();
        return monkey;
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
    private String strTargetToAdd;
    public String getstrTargetToAdd()
    {
        return strTargetToAdd;
    }
    public void setstrTargetToAdd(String input)
    {
        strTargetToAdd = input;
    }
    private String strReleaseToAdd;
    public String getstrReleaseToAdd()
    {
        return strReleaseToAdd;
    }
    public void setstrReleaseToAdd(String input)
    {
        strReleaseToAdd = input;
    }
    private String strGenreToAdd;
    public String getstrGenreToAdd()
    {
        return strGenreToAdd;
    }
    public void setstrGenreToAdd(String input)
    {
        strGenreToAdd = input;
    }
    private String strPlatformToAdd;
    public String getstrPlatformToAdd()
    {
        return strPlatformToAdd;
    }
    public void setstrPlatformToAdd(String input)
    {
        strPlatformToAdd = input;
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
    private String strReleaseToSuggest;
    public String getstrReleaseToSuggest()
    {
        return strReleaseToSuggest;
    }
    public void setstrReleaseToSuggest(String input)
    {
        strReleaseToSuggest = input;
    }
    private String strPlatformToSuggest;
    public String getstrPlatformToSuggest()
    {
        return strPlatformToSuggest;
    }
    private String strGenreToSuggest;
    public String getstrGenreToSuggest()
    {
        return strGenreToSuggest;
    }
    public void setstrGenreToSuggest(String input)
    {
        strGenreToSuggest = input;
    }
    public void setstrPlatformToSuggest(String input)
    {
        strPlatformToSuggest = input;
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
        
        TargetRelease1 = new String();
        TargetRelease2 = new String();
        
        TargetPlatform1 = new String();
        TargetPlatform2 = new String();
        
        TargetGenre1 = "";
        TargetGenre2 = "";
        
        gl = new ArrayList<ArrayList<String>>();
        gc = new ArrayList<ArrayList<String>>();
        pl = new ArrayList<ArrayList<String>>();
        ul = new ArrayList<ArrayList<String>>();
        uc = new ArrayList<ArrayList<String>>();
        
        path = "./Pictures/";
        folder = "Targets/";
        advertfolder = "Adverts/";
        
        AdvertURL1 = "";
        AdvertURL2 = "";
        
        ManagementTargetUsername = "";
        
        strTargetToAdd = "";
        strReleaseToAdd = "";
        strGenreToAdd = "TwoDP";
        strPlatformToAdd = "NES";
        strURLToAdd = "";
        fileTargetToAdd = null;
        
        strTargetToSuggest = "";
        strReleaseToSuggest = "";
        strGenreToSuggest = "TwoDP";
        strPlatformToSuggest = "NES";
        strURLToSuggest = "";        
    }
    
    //Swap Positions
    public String SwapPositions(int intUserIndex, String strTarget1, String strTarget2)
    {
        String Result = "index";
        
        dao.callableSwapTargets(intUserIndex, strTarget1, strTarget2);
        
        return Result;
    }
    
    //Pull Global List
    public ArrayList<ArrayList<String>> PullGlobalList(LoginBean userBean)
    {
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> Sub = new ArrayList<String>();
        
        resultList = dao.callablePullGlobalList();
        
        return resultList;
    }
    
    //Pull Personal List
    public ArrayList<ArrayList<String>> PullPersonalList(int intUserIndex)
    {
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        
        resultList = dao.callablePullPersonalList(intUserIndex);
        
        return resultList;
    }
    
    //Pull Global Counts
    public ArrayList<ArrayList<String>> PullGlobalCounts()
    {
        ArrayList<ArrayList<String>> resultList = new ArrayList<ArrayList<String>>();
        
        resultList = dao.callablePullGlobalCounts();
        
        return resultList;
    }
    
    //Pull Random Target Pair: Pull 1 from Personal, plus adjacent (non-lock) or global if at ends
    public ArrayList<ArrayList<String>> PullTargetPair(String strUserIndex)
    {
        ArrayList<ArrayList<String>> pairList = new ArrayList<ArrayList<String>>();
        
        pairList = dao.callablePullTargetPair(strUserIndex);
        
        System.out.println(pairList);
        
        while(pairList.size() > 2)
        {
            pairList.remove(2);           
        }
        
        if(pairList.size() > 0)
        {
            TargetName1 = pairList.get(0).get(0);
            TargetRelease1 = pairList.get(0).get(1);
            TargetPlatform1 = pairList.get(0).get(2);
            TargetGenre1 = pairList.get(0).get(3);
            TargetURL1 = pairList.get(0).get(4);
        }
        else
        {
            TargetName1 = "Samara thinks there was an error: maybe refresh the page.";
            TargetRelease1 = "";
            TargetPlatform1 = "";
            TargetGenre1 = "";
            TargetURL1 = "_Samara.png";
        }
        
        if(pairList.size() > 1)
        {
            TargetName2 = pairList.get(1).get(0);
            TargetRelease2 = pairList.get(1).get(1);
            TargetPlatform2 = pairList.get(1).get(2);
            TargetGenre2 = pairList.get(1).get(3);
            TargetURL2 = pairList.get(1).get(4);
        }
        else
        {
            TargetName2 = "Samara thinks there was an error: maybe refresh the page.";
            TargetRelease2 = "";
            TargetPlatform2 = "";
            TargetGenre2 = "";
            TargetURL2 = "_Samara.png";
        }
        
        return pairList;
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
    
    //Add Target
    public String AddTarget(int intUserIndex)
    {
        String result = "Add";
        ConnInfo FileConnection = new ConnInfo();
        
        try{
            //take celebrity to add and connect to main site
            FileConnection.UploadToServer(fileTargetToAdd);
            
            //massage strURLToAdd as necessary
            setstrURLToAdd(fileTargetToAdd.getSubmittedFileName());

            dao.callableAddTarget(strTargetToAdd,strReleaseToAdd,strPlatformToAdd,strGenreToAdd,strURLToAdd,intUserIndex);
        }catch(Exception ex){
            result = "Index";
        }
        
        return result;
    }
    
    //Add Target Suggestion
    public String AddTargetSuggestion(int intUserIndex)
    {
        String result = "Add";
        
        try{
            dao.callableAddTargetSuggestion(strTargetToSuggest,strReleaseToSuggest,strPlatformToSuggest,strGenreToSuggest,strURLToSuggest,intUserIndex);
        }catch(Exception ex){
            result = "Index";
        }
        
        return result;
    }

    public String getPictureHost(){
        return Universal.getPictureHost();
    }
}   
