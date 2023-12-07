trigger CTPersonTrigger on Person__c (before insert, before update, after update) {

    Switch On Trigger.operationType
    {
        WHEN BEFORE_INSERT 
        {
            CTPersonTriggerHandler.beforeInsert(Trigger.new);
        }

        WHEN BEFORE_UPDATE 
        {
            CTPersonTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }

        WHEN AFTER_UPDATE
        {
            CTPersonTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }

}