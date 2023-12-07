public class stat {
    
    public static integer i = 6;
    
  /*  public static void main()
    {
        system.debug('1.1 = ' + i );
        i = i+1;
    }
    */
    public void two()
    {   
        //i = i+2;
        system.debug('1.3 = ' + i );
    }
    
    static
    { 
        i = i+1;
       system.debug('static');
    }
    
    public stat()
    {
       i = i + 1; 
        system.debug('constru');
    }
}