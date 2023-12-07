public class BatchClass implements Database.Batchable<sObject>{
	
    Integer count;
    public BatchClass(Integer i)
    {
        count = i;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        String q = 'SELECT id, name FROM Account WHERE createddate < Today LIMIT :count';
        return Database.getQueryLocator(q);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> acLis)
    {
        System.debug('batch = ' + acLis);
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('finish');
    }
}