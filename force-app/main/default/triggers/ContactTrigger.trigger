trigger ContactTrigger on Contact (before insert,after insert, before update, after update, before delete, after delete, after undelete) {
	If (ContactTriggerHandler.hasRun == True)
    {
        system.debug('1.1 = recusion');
        for(Contact c : Trigger.new)
        {
            c.addError('recursion');
        }
        //return;
    }	
    else
        ContactTriggerHandler.hasRun = True;
    
    system.debug('1.2 = ' + Trigger.new);
    
    TriggerDispatcher.run(new ContactTriggerHandler(), Trigger.operationType);
}