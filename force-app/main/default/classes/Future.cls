public class Future {
	
    @future
    public static void reportContact(List<id> lis)
    {
        List<Contact> cLis = [SELECT id, name FROM Contact WHERE id IN :lis];
        System.debug('1.1 = ' + cLis);
    }
}