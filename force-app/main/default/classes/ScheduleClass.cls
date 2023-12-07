public class ScheduleClass implements Schedulable{

    Public List<id> i = new List<id>();
     Public Static String endpoint = 'https://api.spoonacular.com/';
    Public Static string apiKey   = 'ae19643b82214556a7691670566cc5f5';
    
    public ScheduleClass(List<id> iLis)
    {
        i = iLis;
    }
    
    public void execute(SchedulableContext sc)
    {   
        
        system.debug('1.1');
        List<Account> ac = new List<Account>();
        for(Account a : [SELECT id, name FROM Account WHERE id IN :i])
        {
            ac.add(a);          
        }
        System.enqueueJob(new QueueableClass(ac));
    }
}