trigger Scen4 on Contact (before insert,before update) {
    Map<id, id> caMap = new Map<id, id>();
    List<id> aList = new List<id>();
    Map<id, string> aphone = new Map<id, string>();
    List<Contact> cRes = new List<Contact>();
       system.debug('1.2'); 
    for(Contact c : Trigger.new)
    {
        caMap.put(c.id, c.AccountId);
        
        system.Debug('1.3' + c.id + '  ' + c.AccountId);
    }
    
    for(id i : caMap.keySet())
    {
        aList.add(i);
        
        system.debug('1.4 ' + i);
    }
    
    for(Account a : [SELECT id, phone FROM Account WHERE id IN:aList])
    {
        aphone.put(a.id, a.phone);
        
        system.debug('1.5 ' + a.id  + ' ' + a.Phone);
    }
    
    for(Contact c : [SELECT id, phone, AccountId FROM Contact WHERE id IN :caMap.keySet()])
    {
        system.debug('1.1' + c.AccountId + aphone.get(c.AccountId));
        c.Phone = aphone.get(c.AccountId);
        cRes.add(c);
    }
    INSERT cRes;
}