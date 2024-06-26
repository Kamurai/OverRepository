/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Database.LoginDAO;
import Main.User;
import Main.Validator;
import java.io.*;
import javax.faces.bean.ManagedBean;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.faces.bean.SessionScoped;
import javax.annotation.PreDestroy;

/**
 * @author Kamurai
 */
@ManagedBean(name="LoginBean")
@SessionScoped
public class LoginBean implements Serializable
{
    private Connection connect;
    private LoginDAO dao;
    private Validator validate;
    
    private User DefaultUser;
    public User getDefaultUser()
    {
        return DefaultUser;
    }
    public void setDefaultUser(User input)
    {
        DefaultUser = input;
    }
    private User CurrentUser;
    public User getCurrentUser()
    {
        return CurrentUser;
    }
    public void setCurrentUser(User input)
    {
        CurrentUser = input;
    }
    private String username;
    public String getUsername()
    {
        return username;
    }
    public void setUsername(String input)
    {
        username = input;
    }
    private String password;
    public String getPassword()
    {
        return password;
    }
    public void setPassword(String input)
    {
        password = input;
    }
    private String error;
    public String getError()
    {
        return error;
    }
    public void setError(String input)
    {
        error = input;
    }
    private String email;
    public String getEmail()
    {
        return email;
    }
    public void setEmail(String input)
    {
        email = input;
    }
    private String confirmPassword;
    public String getconfirmPassword()
    {
        return confirmPassword;
    }
    public void setconfirmPassword(String input)
    {
        confirmPassword = input;
    }
    
    //Genres
    private boolean boolTwoDP;
    public boolean getboolTwoDP()
    {
        return boolTwoDP;
    }
    public void setboolTwoDP(boolean input)
    {
        boolTwoDP = input;
    }
    private boolean boolThreeDP;
    public boolean getboolThreeDP()
    {
        return boolThreeDP;
    }
    public void setboolThreeDP(boolean input)
    {
        boolThreeDP = input;
    }
    private boolean boolFPS;
    public boolean getboolFPS()
    {
        return boolFPS;
    }
    public void setboolFPS(boolean input)
    {
        boolFPS = input;
    }
    private boolean boolFPP;
    public boolean getboolFPP()
    {
        return boolFPP;
    }
    public void setboolFPP(boolean input)
    {
        boolFPP = input;
    }
    private boolean boolVPuzzle;
    public boolean getboolVPuzzle()
    {
        return boolVPuzzle;
    }
    public void setboolVPuzzle(boolean input)
    {
        boolVPuzzle = input;
    }
    private boolean boolBulletstorm;
    public boolean getboolBulletstorm()
    {
        return boolBulletstorm;
    }
    public void setboolBulletstorm(boolean input)
    {
        boolBulletstorm = input;
    }
    private boolean boolFighting;
    public boolean getboolFighting()
    {
        return boolFighting;
    }
    public void setboolFighting(boolean input)
    {
        boolFighting = input;
    }
    private boolean boolStealth;
    public boolean getboolStealth()
    {
        return boolStealth;
    }
    public void setboolStealth(boolean input)
    {
        boolStealth = input;
    }
    private boolean boolSurvival;
    public boolean getboolSurvival()
    {
        return boolSurvival;
    }
    public void setboolSurvival(boolean input)
    {
        boolSurvival = input;
    }
    private boolean boolVN;
    public boolean getboolVN()
    {
        return boolVN;
    }
    public void setboolVN(boolean input)
    {
        boolVN = input;
    }
    private boolean boolIM;
    public boolean getboolIM()
    {
        return boolIM;
    }
    public void setboolIM(boolean input)
    {
        boolIM = input;
    }
    private boolean boolRPG;
    public boolean getboolRPG()
    {
        return boolRPG;
    }
    public void setboolRPG(boolean input)
    {
        boolRPG = input;
    }
    private boolean boolTRPG;
    public boolean getboolTRPG()
    {
        return boolTRPG;
    }
    public void setboolTRPG(boolean input)
    {
        boolTRPG = input;
    }
    private boolean boolARPG;
    public boolean getboolARPG()
    {
        return boolARPG;
    }
    public void setboolARPG(boolean input)
    {
        boolARPG = input;
    }
    private boolean boolSports;
    public boolean getboolSports()
    {
        return boolSports;
    }
    public void setboolSports(boolean input)
    {
        boolSports = input;
    }
    private boolean boolRacing;
    public boolean getboolRacing()
    {
        return boolRacing;
    }
    public void setboolRacing(boolean input)
    {
        boolRacing = input;
    }
    private boolean boolRTS;
    public boolean getboolRTS()
    {
        return boolRTS;
    }
    public void setboolRTS(boolean input)
    {
        boolRTS = input;
    }
    private boolean boolTBS;
    public boolean getboolTBS()
    {
        return boolTBS;
    }
    public void setboolTBS(boolean input)
    {
        boolTBS = input;
    }
    private boolean boolVE;
    public boolean getboolVE()
    {
        return boolVE;
    }
    public void setboolVE(boolean input)
    {
        boolVE = input;
    }
    private boolean boolMMO;
    public boolean getboolMMO()
    {
        return boolMMO;
    }
    public void setboolMMO(boolean input)
    {
        boolMMO = input;
    }
    private boolean boolMOBA;
    public boolean getboolMOBA()
    {
        return boolMOBA;
    }
    public void setboolMOBA(boolean input)
    {
        boolMOBA = input;
    }
    
    //Settings
    private boolean boolPC;
    public boolean getboolPC()
    {
        return boolPC;
    }
    public void setboolPC(boolean input)
    {
        boolPC = input;
    }
    private boolean boolAtari;
    public boolean getboolAtari()
    {
        return boolAtari;
    }
    public void setboolAtari(boolean input)
    {
        boolAtari = input;
    }
    private boolean boolCommodore64;
    public boolean getboolCommodore64()
    {
        return boolCommodore64;
    }
    public void setboolCommodore64(boolean input)
    {
        boolCommodore64 = input;
    }
    private boolean boolFAMICOM;
    public boolean getboolFAMICOM()
    {
        return boolFAMICOM;
    }
    public void setboolFAMICOM(boolean input)
    {
        boolFAMICOM = input;
    }
    private boolean boolNES;
    public boolean getboolNES()
    {
        return boolNES;
    }
    public void setboolNES(boolean input)
    {
        boolNES = input;
    }
    private boolean boolSNES;
    public boolean getboolSNES()
    {
        return boolSNES;
    }
    public void setboolSNES(boolean input)
    {
        boolSNES = input;
    }
    private boolean boolN64;
    public boolean getboolN64()
    {
        return boolN64;
    }
    public void setboolN64(boolean input)
    {
        boolN64 = input;
    }
    private boolean boolGamecube;
    public boolean getboolGamecube()
    {
        return boolGamecube;
    }
    public void setboolGamecube(boolean input)
    {
        boolGamecube = input;
    }
    private boolean boolWii;
    public boolean getboolWii()
    {
        return boolWii;
    }
    public void setboolWii(boolean input)
    {
        boolWii = input;
    }
    private boolean boolWiiU;
    public boolean getboolWiiU()
    {
        return boolWiiU;
    }
    public void setboolWiiU(boolean input)
    {
        boolWiiU = input;
    }
    private boolean boolNintendoSwitch;
    public boolean getboolNintendoSwitch()
    {
        return boolNintendoSwitch;
    }
    public void setboolNintendoSwitch(boolean input)
    {
        boolNintendoSwitch = input;
    }
    private boolean boolGameboy;
    public boolean getboolGameboy()
    {
        return boolGameboy;
    }
    public void setboolGameboy(boolean input)
    {
        boolGameboy = input;
    }
    private boolean boolVirtualBoy;
    public boolean getboolVirtualBoy()
    {
        return boolVirtualBoy;
    }
    public void setboolVirtualBoy(boolean input)
    {
        boolVirtualBoy = input;
    }
    private boolean boolGBA;
    public boolean getboolGBA()
    {
        return boolGBA;
    }
    public void setboolGBA(boolean input)
    {
        boolGBA = input;
    }
    private boolean boolDS;
    public boolean getboolDS()
    {
        return boolDS;
    }
    public void setboolDS(boolean input)
    {
        boolDS = input;
    }
    private boolean boolThreeDS;
    public boolean getboolThreeDS()
    {
        return boolThreeDS;
    }
    public void setboolThreeDS(boolean input)
    {
        boolThreeDS = input;
    }
    private boolean boolSegaGenesis;
    public boolean getboolSegaGenesis()
    {
        return boolSegaGenesis;
    }
    public void setboolSegaGenesis(boolean input)
    {
        boolSegaGenesis = input;
    }
    private boolean boolSegaCD;
    public boolean getboolSegaCD()
    {
        return boolSegaCD;
    }
    public void setboolSegaCD(boolean input)
    {
        boolSegaCD = input;
    }
    private boolean boolSegaDreamcast;
    public boolean getboolSegaDreamcast()
    {
        return boolSegaDreamcast;
    }
    public void setboolSegaDreamcast(boolean input)
    {
        boolSegaDreamcast = input;
    }
    private boolean boolPS1;
    public boolean getboolPS1()
    {
        return boolPS1;
    }
    public void setboolPS1(boolean input)
    {
        boolPS1 = input;
    }
    private boolean boolPS2;
    public boolean getboolPS2()
    {
        return boolPS2;
    }
    public void setboolPS2(boolean input)
    {
        boolPS2 = input;
    }
    private boolean boolPS3;
    public boolean getboolPS3()
    {
        return boolPS3;
    }
    public void setboolPS3(boolean input)
    {
        boolPS3 = input;
    }
    private boolean boolPS4;
    public boolean getboolPS4()
    {
        return boolPS4;
    }
    public void setboolPS4(boolean input)
    {
        boolPS4 = input;
    }
    private boolean boolPSP;
    public boolean getboolPSP()
    {
        return boolPSP;
    }
    public void setboolPSP(boolean input)
    {
        boolPSP = input;
    }
    private boolean boolPSVita;
    public boolean getboolPSVita()
    {
        return boolPSVita;
    }
    public void setboolPSVita(boolean input)
    {
        boolPSVita = input;
    }
    private boolean boolXbox;
    public boolean getboolXbox()
    {
        return boolXbox;
    }
    public void setboolXbox(boolean input)
    {
        boolXbox = input;
    }
    private boolean boolXbox360;
    public boolean getboolXbox360()
    {
        return boolXbox360;
    }
    public void setboolXbox360(boolean input)
    {
        boolXbox360 = input;
    }
    private boolean boolXboxOne;
    public boolean getboolXboxOne()
    {
        return boolXboxOne;
    }
    public void setboolXboxOne(boolean input)
    {
        boolXboxOne = input;
    }
    private boolean boolOuya;
    public boolean getboolOuya()
    {
        return boolOuya;
    }
    public void setboolOuya(boolean input)
    {
        boolOuya = input;
    }
    private boolean boolOculusRift;
    public boolean getboolOculusRift()
    {
        return boolOculusRift;
    }
    public void setboolOculusRift(boolean input)
    {
        boolOculusRift = input;
    }
    private boolean boolVive;
    public boolean getboolVive()
    {
        return boolVive;
    }
    public void setboolVive(boolean input)
    {
        boolVive = input;
    }
    private boolean boolPSVR;
    public boolean getboolPSVR()
    {
        return boolPSVR;
    }
    public void setboolPSVR(boolean input)
    {
        boolPSVR = input;
    }
    
    
    public LoginBean()
    {
        connect = null;
        dao = new LoginDAO();
        validate = new Validator();

        DefaultUser = new User(
        -1,
        0,
        false,
                
        "",
        "",
        true,
                
        //Genres
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        //Platforms
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
        );
        CurrentUser = new User(DefaultUser);
        
        username = "";
        password = "";
        error = "";
        email = "";
        confirmPassword = "";
        
        //Genres
        boolTwoDP = false;
        boolThreeDP = false;
        boolFPS = false;
        boolFPP = false;
        boolVPuzzle = false;
        boolBulletstorm = false;
        boolFighting = false;
        boolStealth = false;
        boolSurvival = false;
        boolVN = false;
        boolIM = false;
        boolRPG = false;
        boolTRPG = false;
        boolARPG = false;
        boolSports = false;
        boolRacing = false;
        boolRTS = false;
        boolTBS = false;
        boolVE = false;
        boolMMO = false;
        boolMOBA = false;
        
        //Settings
        boolPC = false;
        boolAtari = false;
        boolCommodore64 = false;
        boolFAMICOM = false;
        boolNES = false;
        boolSNES = false;
        boolN64 = false;
        boolGamecube = false;
        boolWii = false;
        boolWiiU = false;
        boolNintendoSwitch = false;
        boolGameboy = false;
        boolVirtualBoy = false;
        boolGBA = false;
        boolDS = false;
        boolThreeDS = false;
        boolSegaGenesis = false;
        boolSegaCD = false;
        boolSegaDreamcast = false;
        boolPS1 = false;
        boolPS2 = false;
        boolPS3 = false;
        boolPS4 = false;
        boolPSP = false;
        boolPSVita = false;
        boolXbox = false;
        boolXbox360 = false;
        boolXboxOne = false;
        boolOuya = false;
        boolOculusRift = false;
        boolVive = false;
        boolPSVR = false;
        
    }
    
    public String LogIn(String targetPage)
    {
        String result = "Login";
        
        CurrentUser = dao.callableLogIn(username, password);
        
        if(CurrentUser != null){
            CurrentUser.setLoggedOn(dao.callableSetOnline(CurrentUser.getUsername()));
            
            if(CurrentUser.getLoggedOn()){
                result = targetPage;
            }
        }
        
        return result;                
    }
    
    public String LogOut()
    {
        String Result = "Login";
        int rows = -1;
        
        //Update Username
        dao.callableSetOffline(CurrentUser.getUsername());
        
        //reset variables
        CurrentUser = new User(DefaultUser);
        
        return Result;
    }
    
    @PreDestroy
    public void preDestroyLogOut()
    {
        dao.callableSetOffline(CurrentUser.getUsername());
    }
    
    public void UpdateOptions(){
        dao.callableUpdateOptions(CurrentUser);
    }
    
    public void clearMemories(){
        dao.callableClearMemories(CurrentUser);
    }
    
    public String SignUp(){
        String result = "SignUp";
        
        if( password.compareTo(confirmPassword) != 0 )
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            result = "SignUp";
        }else if(
                //Genres
                !boolTwoDP &&
                !boolThreeDP &&
                !boolFPS &&
                !boolFPP &&
                !boolVPuzzle &&
                !boolBulletstorm &&
                !boolFighting &&
                !boolStealth &&
                !boolSurvival &&
                !boolVN &&
                !boolIM &&
                !boolRPG &&
                !boolTRPG &&
                !boolARPG &&
                !boolSports &&
                !boolRacing &&
                !boolRTS &&
                !boolTBS &&
                !boolVE &&
                !boolMMO &&
                !boolMOBA &&
                //Platforms
                !boolPC &&
                !boolAtari &&
                !boolCommodore64 &&
                !boolFAMICOM &&
                !boolNES &&
                !boolSNES &&
                !boolN64 &&
                !boolGamecube &&
                !boolWii &&
                !boolWiiU &&
                !boolNintendoSwitch &&
                !boolGameboy &&
                !boolVirtualBoy &&
                !boolGBA &&
                !boolDS &&
                !boolThreeDS &&
                !boolSegaGenesis &&
                !boolSegaCD &&
                !boolSegaDreamcast &&
                !boolPS1 &&
                !boolPS2 &&
                !boolPS3 &&
                !boolPS4 &&
                !boolPSP &&
                !boolPSVita &&
                !boolXbox &&
                !boolXbox360 &&
                !boolXboxOne &&
                !boolOuya &&
                !boolOculusRift &&
                !boolVive &&
                !boolPSVR
                )
        {
            error = "You didn't select any preferences.";
            result = "SignUp";
        }else if( !validate.ValidateEmail(email) )
        {
            error = "You didn't enter a valid e-mail.";
            result = "SignUp";
        }else{
            if(dao.callableSignUp(username,
                    email,
                    password,
                    //Genres
                    boolTwoDP,
                    boolThreeDP,
                    boolFPS,
                    boolFPP,
                    boolVPuzzle,
                    boolBulletstorm,
                    boolFighting,
                    boolStealth,
                    boolSurvival,
                    boolVN,
                    boolIM,
                    boolRPG,
                    boolTRPG,
                    boolARPG,
                    boolSports,
                    boolRacing,
                    boolRTS,
                    boolTBS,
                    boolVE,
                    boolMMO,
                    boolMOBA,
                    //Platforms
                    boolPC,
                    boolAtari,
                    boolCommodore64,
                    boolFAMICOM,
                    boolNES,
                    boolSNES,
                    boolN64,
                    boolGamecube,
                    boolWii,
                    boolWiiU,
                    boolNintendoSwitch,
                    boolGameboy,
                    boolVirtualBoy,
                    boolGBA,
                    boolDS,
                    boolThreeDS,
                    boolSegaGenesis,
                    boolSegaCD,
                    boolSegaDreamcast,
                    boolPS1,
                    boolPS2,
                    boolPS3,
                    boolPS4,
                    boolPSP,
                    boolPSVita,
                    boolXbox,
                    boolXbox360,
                    boolXboxOne,
                    boolOuya,
                    boolOculusRift,
                    boolVive,
                    boolPSVR
            )){
                result = "Login";
            }else{
                result = "SignUp";
            }
        }
        
        return result;
    }
    
    //Determine if current user is authorized to edit target user
    public boolean isAuthorized(User rowUser)
    {
        boolean result = false;
        
        if(CurrentUser.getAdminLevel() >= rowUser.getAdminLevel() && CurrentUser.getAdminLevel() != 0){
            result = true;
        }else{
            result = false;
        }
        
        return result;
    }
}
