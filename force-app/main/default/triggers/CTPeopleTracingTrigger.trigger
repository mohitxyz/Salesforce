trigger CTPeopleTracingTrigger on People_Tracing__c (before insert, before update, after update) {

    SWITCH ON Trigger.operationType
    {
        WHEN BEFORE_INSERT
        {
            CTPeopleTracingTriggerHandler.beforeInsert(Trigger.new);
        }
    }



}