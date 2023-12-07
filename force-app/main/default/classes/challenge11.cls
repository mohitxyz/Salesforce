public class challenge11 {
    
    public static String main()
    {
        Account a = new Account();
        a.name   = 'WingNut Films';
        a.rating = 'warm';
        INSERT a;
        
        Opportunity o = new Opportunity();
        o.accountId = a.id; 
        o.Name      = 'Lord Of the rings';
        o.StageName = 'Qualification';
        o.CloseDate = Date.today();
        
        INSERT o;
        
        a.Name = 'New Line Cinema';
        UPDATE a;
        
        o.StageName = 'Closed-won';
        UPDATE o;
        
        DELETE o;
        
        UNDELETE o;
        
        return a.id + ' * ' + o.id;
    }
		
    
    
}