trigger statChange on Contact (after insert, after update, after undelete) 
{
    /*Map<id, boolean> caMap = new Map<id, boolean>();
    
    for(contact c : Trigger.new)
    {
        caMap.put(c.id, c.checked__c);
    }
    
    for(contact a : [SELECT id, checked__c FROM contact WHERE id IN :caMap.keySet()])
    {
        
    }*/
}