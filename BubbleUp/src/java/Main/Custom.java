package Main;

public class Custom
{
    private int level;
    private int page;
    private int extension;

    private Universal bob;

    public Custom()
    {
        bob = new Universal();
    }

    public String Content(int input)
    {
        String Result = "";
        
        if(input <= 0)
        {
            Result += "./Content/Content_index.xhtml";
        }
        else if(input == 6)
        {
            Result += "./Content/Content_Login.xhtml";
        }
        else if(input == 7)
        {
            Result += "./Content/Content_SignUp.xhtml";
        }
        else if(input == 8)
        {
            Result += "./Content/Content_Management.xhtml";
        }
       
        return Result;
    }
    
    public String Page(int input)
    {
        String Result = "";
        
        if(input <= 0)
        {
            Result += "index";
        }
        else if(input == 6)
        {
            Result += "index";
        }
        else if(input == 7)
        {
            Result += "SignUp";
        }
        else if(input == 8)
        {
            Result += "Management";
        }
       
        return Result;
    }
}
