public class ContactCreationQueue implements Queueable {
	
    public List<Account> aLis;
   
    public ContactCreationQueue(List<Account> accLis)
    {
         system.debug('1.3 = ' + accLis); 
         aLis = accLis;
         system.debug('1.2 = ' + aLis);
        
    }
    
    public void execute(QueueableContext q)
    {
        List<Contact> finalCon = new List<Contact>();
        system.debug('1.1 = ' + aLis);
        for(Account a : aLis)
        {
            Contact c = new Contact();
            c.lastname      = a.name + 'Con';
            c.AccountId     = a.id;
            finalCon.add(c);
        }
        INSERT finalCon;
    }
}