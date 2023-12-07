trigger AccountDel on Account (before delete) {
    
    Map<id, Integer> mp = new Map<id, Integer>();
    Set<id> cSet = new Set<id>();
    
    for(Account a : trigger.old)
    {
        cSet.add(a.id);
    }
    
    for(Contact c : [SELECT id, accountId FROM Contact WHERE AccountId IN :cSet])
    {   
        if(mp.containsKey(c.AccountId))
        {
            mp.put(c.AccountId, mp.get(c.AccountId)+1);
            
            system.debug('ss ' + mp.get(c.AccountId));
        }
        else
        mp.put(c.AccountId, 1);
    }
    
    for(Account a : Trigger.old)
    {
        if(mp.get(a.id) > 0)
        a.adderror('Can not delete Account - child Contacts exists');    
    } 
}