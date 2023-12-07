public class TriggerDispatcher {
	public static void run(TriggerInterface handler, System.TriggerOperation operationType) 
    {
		Switch on operationType
        {
            WHEN BEFORE_INSERT
            {
                handler.beforeInsert(Trigger.new);
            }
            WHEN AFTER_INSERT
            {
                handler.afterInsert(Trigger.new, Trigger.newMap);
            }
            WHEN BEFORE_UPDATE
            {
                handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
            }
            WHEN AFTER_UPDATE
            {
                handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
            }
            WHEN BEFORE_DELETE
            {
                handler.beforeDelete(Trigger.old, Trigger.oldMap);
            }
            WHEN AFTER_DELETE
            {
                handler.afterDelete(Trigger.oldMap);
            }
            WHEN AFTER_UNDELETE
            {
                handler.afterUndelete(Trigger.new, Trigger.newMap);
            }
        }
    }
}