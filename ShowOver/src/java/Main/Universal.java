package Main;

public class Universal
{
    public Universal()
    {

    }
    
    public String WebMaster()
    {
        String Result = "";
        Result += "Website managed by Kamurai.";
        return Result;
    }

    public String GetPath(int level)
    {
        if(level <= 0)
        {
            return "./";
        }
        else if(level == 1)
        {
            return "../";
        }
        else if(level == 2)
        {
            return "../../";
        }
        else if(level == 3)
        {
            return "../../../";
        }
        else if(level == 4)
        {
            return "../../../../";
        }
        else if(level == 5)
        {
            return "../../../../../";
        }
        else if(level == 6)
        {
            return "../../../../../../";
        }
        else if(level == 7)
        {
            return "../../../../../../../";
        }
        else
        {
            return "./";
        }
    }
    
    public static String getPictureHost(){
        return "http://htkb.info/Over/ShowOver/";
    }
}
