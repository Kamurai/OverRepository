/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import Bean.LoginBean;
import Main.User;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class LoginDAO extends DAO{
    
    public LoginDAO(){
        super();
    }
    
    public User callableLogIn(String strUsername, String strPassword){
        CallableStatement stmt = null;
        User returnUser;
        ResultSet rs;
        
        try{
            openConnection();
        
            stmt = connect.prepareCall("{call PlayOverGetValidUser(?,?)}");
            stmt.setString(1, strUsername);
            stmt.setString(2, strPassword);
            rs = stmt.executeQuery();
            
            rs.next();
            
            returnUser = new User(
                rs.getInt("UserIndex"), 
                rs.getInt("AdminLevel"), 
                rs.getBoolean("Online"),
                
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getBoolean("Memory"), 
                //Genres
                rs.getBoolean("TwoDP"), 
                rs.getBoolean("ThreeDP"), 
                rs.getBoolean("FPS"), 
                rs.getBoolean("FPP"), 
                rs.getBoolean("VPuzzle"), 
                rs.getBoolean("Bulletstorm"), 
                rs.getBoolean("Fighting"), 
                rs.getBoolean("Stealth"), 
                rs.getBoolean("Survival"), 
                rs.getBoolean("VN"), 
                rs.getBoolean("IM"), 
                rs.getBoolean("RPG"), 
                rs.getBoolean("TRPG"), 
                rs.getBoolean("ARPG"), 
                rs.getBoolean("Sports"), 
                rs.getBoolean("Racing"), 
                rs.getBoolean("RTS"), 
                rs.getBoolean("TBS"), 
                rs.getBoolean("VE"), 
                rs.getBoolean("MMO"), 
                rs.getBoolean("MOBA"), 
                //Platforms    
                rs.getBoolean("PC"), 
                rs.getBoolean("Atari"), 
                rs.getBoolean("Commodore64"), 
                rs.getBoolean("FAMICOM"), 
                rs.getBoolean("NES"), 
                rs.getBoolean("SNES"), 
                rs.getBoolean("N64"), 
                rs.getBoolean("Gamecube"), 
                rs.getBoolean("Wii"), 
                rs.getBoolean("WiiU"), 
                rs.getBoolean("NintendoSwitch"), 
                rs.getBoolean("Gameboy"), 
                rs.getBoolean("VirtualBoy"), 
                rs.getBoolean("GBA"), 
                rs.getBoolean("DS"), 
                rs.getBoolean("ThreeDS"), 
                rs.getBoolean("SegaGenesis"), 
                rs.getBoolean("SegaCD"), 
                rs.getBoolean("SegaDreamcast"), 
                rs.getBoolean("PS1"), 
                rs.getBoolean("PS2"), 
                rs.getBoolean("PS3"), 
                rs.getBoolean("PS4"), 
                rs.getBoolean("PSP"), 
                rs.getBoolean("PSVita"), 
                rs.getBoolean("Xbox"), 
                rs.getBoolean("Xbox360"), 
                rs.getBoolean("XboxOne"), 
                rs.getBoolean("Ouya"), 
                rs.getBoolean("OculusRift"),
                rs.getBoolean("Vive"),
                rs.getBoolean("PSVR")
            );
            
        }
        catch(Exception e){
            e.printStackTrace();
            returnUser = null;
        }finally{
            closeConnection();
        }
        
        return returnUser;
    }
    
    public boolean callableSetOnline(String user)
    {
        CallableStatement stmt = null;
        boolean result = false;
        
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call PlayOverSetOnlineStatus(?,?)}");
            stmt.setInt(1, 1);
            stmt.setString(2, user);
            stmt.executeUpdate();
            result = true;
        }catch(Exception e){
            e.printStackTrace();
            result = false;
        }finally{
            //close connection
            closeConnection();
        }
        
        return result;
    }
    
    public boolean callableSetOffline(String user)
    {
        CallableStatement stmt = null;
        boolean result = false;
        
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call PlayOverSetOnlineStatus(?,?)}");
            stmt.setInt(1, 0);
            stmt.setString(2, user);
            stmt.executeUpdate();
            result = false;
        }catch(Exception e){
            e.printStackTrace();
            result = true;
        }finally{
            //close connection
            closeConnection();
        }
        
        return result;
    }
    
    public void callableUpdateOptions(User targetUser)
    {
        CallableStatement stmt = null;
        ResultSet rs;
        
        //if all Genres are false
        if( !targetUser.getTwoDP() && 
            !targetUser.getThreeDP() && 
            !targetUser.getFPS() && 
            !targetUser.getFPP() && 
            !targetUser.getVPuzzle() && 
            !targetUser.getBulletstorm() && 
            !targetUser.getFighting() && 
            !targetUser.getStealth() && 
            !targetUser.getSurvival() && 
            !targetUser.getVN() && 
            !targetUser.getIM() && 
            !targetUser.getRPG() && 
            !targetUser.getTRPG() && 
            !targetUser.getARPG() && 
            !targetUser.getSports() && 
            !targetUser.getRacing() && 
            !targetUser.getRTS() && 
            !targetUser.getTBS() && 
            !targetUser.getVE() && 
            !targetUser.getMMO() && 
            !targetUser.getMOBA()
        ){
            //then set default to true
            targetUser.setTwoDP(true);
        }
        
        //if all Platforms are false
        if( !targetUser.getPC() && 
            !targetUser.getAtari() && 
            !targetUser.getCommodore64() && 
            !targetUser.getFAMICOM() && 
            !targetUser.getNES() && 
            !targetUser.getSNES() && 
            !targetUser.getN64() && 
            !targetUser.getGamecube() && 
            !targetUser.getWii() && 
            !targetUser.getWiiU() && 
            !targetUser.getNintendoSwitch() && 
            !targetUser.getGameboy() && 
            !targetUser.getVirtualBoy() && 
            !targetUser.getGBA() && 
            !targetUser.getDS() && 
            !targetUser.getThreeDS() && 
            !targetUser.getSegaGenesis() && 
            !targetUser.getSegaCD() && 
            !targetUser.getSegaDreamcast() && 
            !targetUser.getPS1() && 
            !targetUser.getPS2() && 
            !targetUser.getPS3() && 
            !targetUser.getPS4() && 
            !targetUser.getPSP() && 
            !targetUser.getPSVita() && 
            !targetUser.getXbox() && 
            !targetUser.getXbox360() && 
            !targetUser.getXboxOne() && 
            !targetUser.getOuya() && 
            !targetUser.getOculusRift() && 
            !targetUser.getVive() && 
            !targetUser.getPSVR()
        ){
            //then set default to true
            targetUser.setPC(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call PlayOverUpdateOptions(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            stmt.setBoolean(2, targetUser.getMemory());
            //Genres
            stmt.setBoolean(3, targetUser.getTwoDP());
            stmt.setBoolean(4, targetUser.getThreeDP());
            stmt.setBoolean(5, targetUser.getFPS());
            stmt.setBoolean(6, targetUser.getFPP());
            stmt.setBoolean(7, targetUser.getVPuzzle());
            stmt.setBoolean(8, targetUser.getBulletstorm());
            stmt.setBoolean(9, targetUser.getFighting());
            stmt.setBoolean(10, targetUser.getStealth());
            stmt.setBoolean(11, targetUser.getSurvival());
            stmt.setBoolean(12, targetUser.getVN());
            stmt.setBoolean(13, targetUser.getIM());
            stmt.setBoolean(14, targetUser.getRPG());
            stmt.setBoolean(15, targetUser.getTRPG());
            stmt.setBoolean(16, targetUser.getARPG());
            stmt.setBoolean(17, targetUser.getSports());
            stmt.setBoolean(18, targetUser.getRacing());
            stmt.setBoolean(19, targetUser.getRTS());
            stmt.setBoolean(20, targetUser.getTBS());
            stmt.setBoolean(21, targetUser.getVE());
            stmt.setBoolean(22, targetUser.getMMO());
            stmt.setBoolean(23, targetUser.getMOBA());
            //Platforms
            stmt.setBoolean(24, targetUser.getPC());
            stmt.setBoolean(25, targetUser.getAtari());
            stmt.setBoolean(26, targetUser.getCommodore64());
            stmt.setBoolean(27, targetUser.getFAMICOM());
            stmt.setBoolean(28, targetUser.getNES());
            stmt.setBoolean(29, targetUser.getSNES());
            stmt.setBoolean(30, targetUser.getN64());
            stmt.setBoolean(31, targetUser.getGamecube());
            stmt.setBoolean(32, targetUser.getWii());
            stmt.setBoolean(33, targetUser.getWiiU());
            stmt.setBoolean(34, targetUser.getNintendoSwitch());
            stmt.setBoolean(35, targetUser.getGameboy());
            stmt.setBoolean(36, targetUser.getVirtualBoy());
            stmt.setBoolean(37, targetUser.getGBA());
            stmt.setBoolean(38, targetUser.getDS());
            stmt.setBoolean(39, targetUser.getThreeDS());
            stmt.setBoolean(40, targetUser.getSegaGenesis());
            stmt.setBoolean(41, targetUser.getSegaCD());
            stmt.setBoolean(42, targetUser.getSegaDreamcast());
            stmt.setBoolean(43, targetUser.getPS1());
            stmt.setBoolean(44, targetUser.getPS2());
            stmt.setBoolean(45, targetUser.getPS3());
            stmt.setBoolean(46, targetUser.getPS4());
            stmt.setBoolean(47, targetUser.getPSP());
            stmt.setBoolean(48, targetUser.getPSVita());
            stmt.setBoolean(49, targetUser.getXbox());
            stmt.setBoolean(50, targetUser.getXbox360());
            stmt.setBoolean(51, targetUser.getXboxOne());
            stmt.setBoolean(52, targetUser.getOuya());
            stmt.setBoolean(53, targetUser.getOculusRift());
            stmt.setBoolean(54, targetUser.getVive());
            stmt.setBoolean(55, targetUser.getPSVR());
            rs = stmt.executeQuery();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public void callableClearMemories(User targetUser){
        CallableStatement stmt = null;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            openConnection();
        
            stmt = getConnect().prepareCall("{call PlayOverClearMemories(?)}");
            stmt.setInt(1, targetUser.getUserIndex());
            rs = stmt.executeQuery();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection();
        }
    }
    
    public boolean callableSignUp(String username, 
        String email,
        String password,
        //Genres
        boolean boolTwoDP,
        boolean boolThreeDP,
        boolean boolFPS,
        boolean boolFPP,
        boolean boolVPuzzle,
        boolean boolBulletstorm,
        boolean boolFighting,
        boolean boolStealth,
        boolean boolSurvival,
        boolean boolVN,
        boolean boolIM,
        boolean boolRPG,
        boolean boolTRPG,
        boolean boolARPG,
        boolean boolSports,
        boolean boolRacing,
        boolean boolRTS,
        boolean boolTBS,
        boolean boolVE,
        boolean boolMMO,
        boolean boolMOBA,
        //Platforms
        boolean boolPC,
        boolean boolAtari,
        boolean boolCommodore64,
        boolean boolFAMICOM,
        boolean boolNES,
        boolean boolSNES,
        boolean boolN64,
        boolean boolGamecube,
        boolean boolWii,
        boolean boolWiiU,
        boolean boolNintendoSwitch,
        boolean boolGameboy,
        boolean boolVirtualBoy,
        boolean boolGBA,
        boolean boolDS,
        boolean boolThreeDS,
        boolean boolSegaGenesis,
        boolean boolSegaCD,
        boolean boolSegaDreamcast,
        boolean boolPS1,
        boolean boolPS2,
        boolean boolPS3,
        boolean boolPS4,
        boolean boolPSP,
        boolean boolPSVita,
        boolean boolXbox,
        boolean boolXbox360,
        boolean boolXboxOne,
        boolean boolOuya,
        boolean boolOculusRift,
        boolean boolVive,
        boolean boolPSVR
    ){
        CallableStatement stmt = null;
        boolean result = false;
        ResultSet rs;
        
        //Update preferences to match check boxes (local variables)
        try{
            //open connection
            openConnection();
            
            stmt = getConnect().prepareCall("{call PlayOverSignUp(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            //Genres
            stmt.setBoolean(4, boolTwoDP);
            stmt.setBoolean(5, boolThreeDP);
            stmt.setBoolean(6, boolFPS);
            stmt.setBoolean(7, boolFPP);
            stmt.setBoolean(8, boolVPuzzle);
            stmt.setBoolean(9, boolBulletstorm);
            stmt.setBoolean(10, boolFighting);
            stmt.setBoolean(11, boolStealth);
            stmt.setBoolean(12, boolSurvival);
            stmt.setBoolean(13, boolVN);
            stmt.setBoolean(14, boolIM);
            stmt.setBoolean(15, boolRPG);
            stmt.setBoolean(16, boolTRPG);
            stmt.setBoolean(17, boolARPG);
            stmt.setBoolean(18, boolSports);
            stmt.setBoolean(19, boolRacing);
            stmt.setBoolean(20, boolRTS);
            stmt.setBoolean(21, boolTBS);
            stmt.setBoolean(22, boolVE);
            stmt.setBoolean(23, boolMMO);
            stmt.setBoolean(24, boolMOBA);
            //Platforms
            stmt.setBoolean(25, boolPC);
            stmt.setBoolean(26, boolAtari);
            stmt.setBoolean(27, boolCommodore64);
            stmt.setBoolean(28, boolFAMICOM);
            stmt.setBoolean(29, boolNES);
            stmt.setBoolean(30, boolSNES);
            stmt.setBoolean(31, boolN64);
            stmt.setBoolean(32, boolGamecube);
            stmt.setBoolean(33, boolWii);
            stmt.setBoolean(34, boolWiiU);
            stmt.setBoolean(35, boolNintendoSwitch);
            stmt.setBoolean(36, boolGameboy);
            stmt.setBoolean(37, boolVirtualBoy);
            stmt.setBoolean(38, boolGBA);
            stmt.setBoolean(39, boolDS);
            stmt.setBoolean(40, boolThreeDS);
            stmt.setBoolean(41, boolSegaGenesis);
            stmt.setBoolean(42, boolSegaCD);
            stmt.setBoolean(43, boolSegaDreamcast);
            stmt.setBoolean(44, boolPS1);
            stmt.setBoolean(45, boolPS2);
            stmt.setBoolean(46, boolPS3);
            stmt.setBoolean(47, boolPS4);
            stmt.setBoolean(48, boolPSP);
            stmt.setBoolean(49, boolPSVita);
            stmt.setBoolean(50, boolXbox);
            stmt.setBoolean(51, boolXbox360);
            stmt.setBoolean(52, boolXboxOne);
            stmt.setBoolean(53, boolOuya);
            stmt.setBoolean(54, boolOculusRift);
            stmt.setBoolean(55, boolVive);
            stmt.setBoolean(56, boolPSVR);
            rs = stmt.executeQuery();
            
            result = true;
        }catch(Exception e){
            e.printStackTrace();
            result = false;
        }finally{
            closeConnection();
        }
        
        return result;
    }
}
