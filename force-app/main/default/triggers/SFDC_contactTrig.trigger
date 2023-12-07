trigger SFDC_contactTrig on Contact (after insert, after update, after undelete) {
    
    Set<id> accId = new Set<id>();
    Map<id, List<contact>> acMap = new Map<id, List<contact>>();
    List<account> aLis = new List<account>();
    for(contact c : trigger.new)
    {
        if(c.accountId != null)
        {
           accId.add(c.accountId);     
        }       
    }
    
    for(account a : [SELECT id, (SELECT id, accountId FROM Contacts WHERE checked__c = True) FROM account WHERE id IN :accId])
    {
        acMap.put(a.id, a.contacts);
    }
    
    
    for(account a : [SELECT id, checked__c FROM account WHERE id IN :acMap.keySet()])
    {
        if(acMap.get(a.id).size() > 0 && (a.checked__c == False || a.checked__c == null))    
        {
            a.checked__c = True;
            aLis.add(a);
        }
        
        else if(acMap.get(a.id).size() == 0 && (a.checked__c == True || a.checked__c == null))
        {
            a.checked__c = False;
            aLis.add(a);
        }
    }
    UPDATE aLis;
}