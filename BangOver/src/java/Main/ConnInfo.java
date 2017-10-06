/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

import java.io.InputStream;
import java.nio.file.Files;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

/**
 * @author Kamurai
 */
public class ConnInfo 
{
    private final String uploadLocation;
    
    public ConnInfo()
    {
        uploadLocation = "C:/House/Programming/Netbeans/BangOver/web/Pictures/Targets/";
    }
    
    public boolean UploadToServer(Part file) 
    {
        try (InputStream input = file.getInputStream()) 
        {
            Files.copy(input, new File(uploadLocation, getFilename(file)).toPath());
        }
        catch (IOException e) 
        {
            return false;
        }
        return true;
    }
        
    private static String getFilename(Part part) 
    {
        for (String cd : part.getHeader("content-disposition").split(";")) 
        {
            if (cd.trim().startsWith("filename")) 
            {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }    
}
