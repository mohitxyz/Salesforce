trigger TrigAbc on ABC__c (before update) {
    List<id> pLis = new List<id>();
    Map<id, id> pxMap = new Map<id, id>();
    Map<id, id> befMap = new Map<id, id>();
    List<abc__c> processLis = new List<abc__c>();
        
    for(abc__c a : Trigger.old)
    {
        befMap.put(a.id, a.PQR__c);
    }
    
    for(abc__c a : Trigger.new)
    {   
        
        if(befMap.get(a.Id) != a.PQR__c)        // update only those records which have changed 'account.pqr__c' 
        {
            pLis.add(a.PQR__c);  
            processLis.add(a);
        }       
    }
    
    for(xyz__c x : [SELECT id, pqrID__c FROM xyz__c WHERE pqrID__c IN :pLis])
    {
        pxMap.put(x.pqrID__c, x.id);
    }
    
    for(abc__c a : processLis)                
    {
        a.XYZ__c = pxMap.get(a.pqr__c);   
    }
}