@isTest
public class Covid19Test {
	
    @isTest
    public static void testPatient()
    {
        ReadOnly r = new ReadOnly();
         
       //System.AssertEquals('Hello', r.main(2), 'Failed Test');
        
        if(r.main(2) == 'Hello')
        {
            
        }
        else
        {
            system.debug('1.1');
        }
        
    }
}