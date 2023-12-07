public class Trigger_Dispatcher {
	
    public static void run(Framework_Interface handler, System.TriggerOperation operationType)
    {
        Switch on operationType
        {
            When BEFORE_INSERT
            {
                handler.beforeInsert(Trigger.new);
            }
            when AFTER_INSERT
            {
                handler.afterInsert(Trigger.new, Trigger.newMap);
            }
            when BEFORE_UPDATE
            {
                handler.beforeUpdate(Trigger.new);
            }
            when AFTER_UPDATE
            {
                handler.afterUpdate(Trigger.new, Trigger.newMap);
            }
        }
    }
}