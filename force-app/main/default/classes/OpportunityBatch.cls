public class OpportunityBatch implements Database.Batchable<SObject>,Database.Stateful {
    List<account> accLis;
    Map<id, id> oaMap;
    Map<id, decimal> aMap;
    
    public OpportunityBatch()
    {
        accLis = new List<account>();
        oaMap  = new Map<id, id>();
        aMap   = new Map<id, decimal>();
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT id, Total_Opportunity__c FROM Account';
        return Database.getQueryLocator(query);        
    }
    
    public void execute(Database.BatchableContext BC, List<Account> scope)
    {
        for(Opportunity o : [SELECT id, AccountId, Amount FROM Opportunity WHERE accountId IN :scope])
        {
            oaMap.put(o.id, o.accountId);
        }
        
        for(Opportunity o : [SELECT id, amount, accountId FROM Opportunity WHERE id IN :oaMap.keySet()])
        {
            if(aMap.containsKey(o.AccountId))
            {
                aMap.put(o.AccountId, aMap.get(o.AccountId) + o.Amount);
            }
            else
            {
                aMap.put(o.AccountId, o.amount);
            }
        }  
        
        for(Account a : [SELECT id, Total_Opportunity__c FROM account WHERE id IN :aMap.keySet()])
        {
            a.Total_Opportunity__c = aMap.get(a.id);
            accLis.add(a);
        }
        UPDATE accLis;
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }
}