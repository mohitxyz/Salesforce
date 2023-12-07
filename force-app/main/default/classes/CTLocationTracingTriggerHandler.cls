public with sharing class CTLocationTracingTriggerHandler {

 public static void beforeInsert(List<Location_tracing__c> triggerNew)
    {

        //List<Location_tracing__c> lis = triggerNewMap.values();
        List<Location_tracing__c> dupe = CTLocationTracingController.checkDuplicates(triggerNew);

        system.debug('1.1 = ' + dupe);
        if(dupe.size() > 0)
        {
            for(Location_tracing__c p : dupe)
            {
                p.addError('Duplicate found');
            }
            
        }
    }

}