public class CTPersonTriggerHandler {

    public static void beforeInsert(List<Person__c> triggerNew)
    {
        for(Person__c p : triggerNew)
            {
                p.Health_Status__c = 'Green';
                p.Token__c         = CTPersonController.getToken(p.Mobile__c);
            }
    }

    public static void beforeUpdate(List<Person__c> triggerNew, Map<Id, Person__c> triggerOldMap)
    {
        Map<Id, Person__c> pOld = triggerOldMap;
        for(Person__c p : triggerNew)
        {                 
            if(p.Health_Status__c != pOld.get(p.id).Health_Status__c)
            {
                p.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdate(List<Person__c> triggerNew, Map<Id, Person__c> triggerOldMap)
    {
        Map<Id, Person__c> pOld = triggerOldMap;
        Set<Id> statusChange = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();

        for(Person__c p : triggerNew)
        {                 
            if(p.Health_Status__c != pOld.get(p.id).Health_Status__c)
            {
                statusChange.add(p.Id);
            }

            if(p.Health_Status__c != pOld.get(p.id).Health_Status__c && p.Health_Status__c == 'Red')
            {
                redStatus.add(p.Id);
            }
        }

        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();

        List<Person__c> personToUpdate = new List<Person__c>();

        // lets add cohabitants
        orangeStatus.addAll(CTPersonController.getCohabitants(redStatus, alreadyProcessed));
        // lets add primaryContacts
        Set<Id> primaryContacts = CTPersonController.getPrimaryContacts(redStatus, alreadyProcessed);
        orangeStatus.addAll(primaryContacts);
        // lets add neighbours
        yellowStatus.addAll(CTPersonController.getNeighbours(redStatus, alreadyProcessed));
        // lets add secondaryContacts
        yellowStatus.addAll(CTPersonController.getSecondaryContacts(primaryContacts, alreadyProcessed));

        for (Id pid : orangeStatus) {
            personToUpdate.add(new Person__c(Id=pid, Health_Status__c = 'Orange'));
        }

        for (Id pid : yellowStatus) {
            personToUpdate.add(new Person__c(Id=pid, Health_Status__c = 'Yellow'));
        }

        if(personToUpdate.size() > 0){
            update personToUpdate;
        }

        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonIds(statusChange);
        system.debug('1.5 = ' + ',' + statusChange +','+ locationTraces );

        if(locationTraces != null && locationTraces.size() > 0){
            Set<Id> locationIds = new Set<Id>();
            for (Location_Tracing__c trace : locationTraces) {
                locationIds.add(trace.Location__c);
            }
            CTLocationController.updateRedScore(locationIds);
        }

    }    
    
}