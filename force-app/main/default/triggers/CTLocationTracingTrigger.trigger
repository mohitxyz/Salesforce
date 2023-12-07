trigger CTLocationTracingTrigger on Location_tracing__c (before insert) {

    SWITCH ON Trigger.operationType
    {
        WHEN BEFORE_INSERT
        {
            CTLocationTracingTriggerHandler.beforeInsert(Trigger.new);
        }
    }

}