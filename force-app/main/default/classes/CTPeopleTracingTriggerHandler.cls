public class CTPeopleTracingTriggerHandler {

    public static void beforeInsert(List<People_Tracing__c> triggerNew)
    {

        //List<People_Tracing__c> lis = triggerNewMap.values();
        List<People_Tracing__c> dupe = CTPeopleTracingController.checkDuplicates(triggerNew);

        if(dupe.size() > 0)
        {
            for(People_Tracing__c p : dupe)
            {
                p.addError('Duplicate found');
            }
            
        }
    }

}