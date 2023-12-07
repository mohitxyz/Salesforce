public class SchedulableInterface implements Schedulable{
	
    public void execute(SchedulableContext sc)
    {
        List<Account> aLis = [SELECT id, name FROM Account WHERE createddate = TODAY];
        System.debug('created = ' + aLis);
    }
}