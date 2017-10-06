/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

/**
 *
 * @author Kamurai
 */
public class Validator 
{
    public Validator()
    {
        
    }
    
    public boolean ValidateInputBox(String input)
    {
        boolean Result = false;
          
        if(input.length() > 50 )
        {
            return Result;
        }
        
        for( int x=0; x < input.length(); x++ )
        {
            if( !IsNumber(input.charAt(x)) || !IsLetter(input.charAt(x))  )
            {
                return Result;
            }
        }
      
        return Result;        
    }
    
    public boolean ValidateInputBoxAllowSpecial(String input)
    {
        boolean Result = false;
          
        if(input.length() > 50 )
        {
            return Result;
        }
        
        for( int x=0; x < input.length(); x++ )
        {
            if( !IsNumber(input.charAt(x)) || !IsLetter(input.charAt(x)) || !IsTitleSpecial(input.charAt(x)) )
            {
                return Result;
            }
        }
      
        return Result;        
    }
    
    public boolean ValidateEmail(String input)
    {
        boolean Result = false;
        String first = "";
        String second = "";
        String third = "";
        
        
        if(input.length() > 50 )
        {
            return Result;
        }
        /*
                
        for( int x=0; x < input.length(); x++ )
        {
            if( !IsNumber(input.charAt(x)) && !IsLetter(input.charAt(x)) && !IsEmailSpecial(input.charAt(x)) )
            {
                return Result;
            }
            else
            {
                if( input.charAt(x) == '@' )
                {
                    if( x > 1 )
                    {
                        first = input.substring(0, x);
                    }
                    else
                    {
                        return Result;
                    }
                }
                else if( input.charAt(x) == '.'  )
                {
                    if( x > first.length()+3 && x > 4 )
                    {
                        second = input.substring(first.length(), x);
                        third = input.substring(x, input.length());
                    }
                    else
                    {
                        return Result;
                    }
                    
                }
                
            }
        }
        */
        Result = true;
        return Result;        
    }
    
    
    
    
    public boolean IsEmailSpecial(char input)
    {
        boolean Result = false;
        
        if( input == '@' )
        {
            Result = true;
        }
        else if( input == '.' )
        {
            Result = true;
        }
        
        return Result;
    }
    
    public boolean IsTitleSpecial(char input)
    {
        boolean Result = false;
        
        if( input == ':' )
        {
            Result = true;
        }
        else if( input == '\'' )
        {
            Result = true;
        }
        else if( input == '.' )
        {
            Result = true;
        }
        else if( input == '&' )
        {
            Result = true;
        }
        else if( input == ',' )
        {
            Result = true;
        }
        
        return Result;
    }
    
    public boolean IsNumber(char input)
    {
        boolean Result = false;
        
        if( input == 0 )
        {
            Result = true;
        }
        else if( input == 1 )
        {
            Result = true;
        }
        else if( input == 2 )
        {
            Result = true;
        }
        else if( input == 3 )
        {
            Result = true;
        }
        else if( input == 4 )
        {
            Result = true;
        }
        else if( input == 5 )
        {
            Result = true;
        }
        else if( input == 6 )
        {
            Result = true;
        }
        else if( input == 7 )
        {
            Result = true;
        }
        else if( input == 8 )
        {
            Result = true;
        }
        else if( input == 9 )
        {
            Result = true;
        }
        
        return Result;
    }
    
    public boolean IsLetter(char input)
    {
        boolean Result = false;
        
        if( (input == 'a') || (input == 'A') )
        {
            Result = true;
        }
        else if( (input == 'b') || (input == 'B') )
        {
            Result = true;
        }
        else if( (input == 'c') || (input == 'C') )
        {
            Result = true;
        }
        else if( (input == 'd') || (input == 'D') )
        {
            Result = true;
        }
        else if( (input == 'e') || (input == 'E') )
        {
            Result = true;
        }
        else if( (input == 'b') || (input == 'B') )
        {
            Result = true;
        }
        else if( (input == 'f') || (input == 'F') )
        {
            Result = true;
        }
        else if( (input == 'g') || (input == 'G') )
        {
            Result = true;
        }
        else if( (input == 'h') || (input == 'H') )
        {
            Result = true;
        }
        else if( (input == 'i') || (input == 'I') )
        {
            Result = true;
        }
        else if( (input == 'j') || (input == 'J') )
        {
            Result = true;
        }
        else if( (input == 'k') || (input == 'K') )
        {
            Result = true;
        }
        else if( (input == 'l') || (input == 'L') )
        {
            Result = true;
        }
        else if( (input == 'm') || (input == 'M') )
        {
            Result = true;
        }
        else if( (input == 'n') || (input == 'N') )
        {
            Result = true;
        }
        else if( (input == 'o') || (input == 'O') )
        {
            Result = true;
        }
        else if( (input == 'p') || (input == 'P') )
        {
            Result = true;
        }
        else if( (input == 'q') || (input == 'Q') )
        {
            Result = true;
        }
        else if( (input == 'r') || (input == 'R') )
        {
            Result = true;
        }
        else if( (input == 's') || (input == 'S') )
        {
            Result = true;
        }
        else if( (input == 't') || (input == 'T') )
        {
            Result = true;
        }
        else if( (input == 'u') || (input == 'U') )
        {
            Result = true;
        }
        else if( (input == 'v') || (input == 'V') )
        {
            Result = true;
        }
        else if( (input == 'w') || (input == 'W') )
        {
            Result = true;
        }
        else if( (input == 'x') || (input == 'X') )
        {
            Result = true;
        }
        else if( (input == 'y') || (input == 'Y') )
        {
            Result = true;
        }
        else if( (input == 'z') || (input == 'Z') )
        {
            Result = true;
        }
        
        
        return Result;
    }
    
}
