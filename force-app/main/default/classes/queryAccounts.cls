public with sharing class queryAccounts {
    public queryAccounts() {

    }

    @AuraEnabled
    public static List<Account> getAccountsFromApex(Integer cnt)
    {
        List<Account> aLis = new List<Account>();

        aLis = [SELECT id, name FROM Account WHERE name!= ''  WITH SECURITY_ENFORCED LIMIT :cnt];

        return aLis;
    }
}