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
        else if(input == 1)
        {
            Result += "./Content/Content_BoardOver.xhtml";
        }
        else if(input == 2)
        {
            Result += "./Content/Content_MyList.xhtml";
        }
        else if(input == 3)
        {
            Result += "./Content/Content_GlobalList.xhtml";
        }
        else if(input == 4)
        {
            Result += "./Content/Content_Options.xhtml";
        }
        else if(input == 5)
        {
            Result += "./Content/Content_Add.xhtml";
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
        else if(input == 1)
        {
            Result += "BoardOver";
        }
        else if(input == 2)
        {
            Result += "MyList";
        }
        else if(input == 3)
        {
            Result += "GlobalList";
        }
        else if(input == 4)
        {
            Result += "Options";
        }
        else if(input == 5)
        {
            Result += "Add";
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
