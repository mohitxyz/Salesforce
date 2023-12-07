public class CTLocationTriggerHandler {

    public static void beforeInsert(List<Location__c> triggerNew)
    {
        for(Location__c l : triggerNew)
        {
            l.Status__c = 'Green';
        }
    }

    public static void beforeUpdate(List<Location__c> triggerNew, Map<Id, Location__c> oldMap)
    {
        List<Id> redLocation = new List<Id>();

        for(Location__c l : triggerNew)
        {
            if(l.Status__c != oldMap.get(l.Id).Status__c)
            {
                l.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdate(List<Location__c> triggerNew, Map<Id, Location__c> oldMap)
    {
        List<Id> redLocation = new List<Id>();

        for(Location__c l : triggerNew)
        {
            if(l.Status__c != oldMap.get(l.Id).Status__c)
            {
                //l.Status_Update_Date__c = Date.today();

                if(l.Status__c == 'Red')
                {
                    redLocation.add(l.Id);
                }
            }
        }
        List<String> Health = new List<String>{'Green'};
  
        List<Id> Person = new List<Id>();
        List<Person__c> PersonList = new List<Person__c>();

        system.debug('1.6 = ' + redLocation);
        for(Location_tracing__c lt : [SELECT id, Person__c FROM Location_Tracing__c WHERE Location__c IN :redLocation AND Visit_Date__c = LAST_N_DAYS:10
                                           AND Person__r.Health_Status__c IN :Health])
        {
            Person.add(lt.Person__c);
        }

        if(Person.size() > 0)
        {
            for(Person__c p : [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :Person])
            {
                p.Health_Status__c = 'Yellow';
                PersonList.add(p);
            }

            UPDATE PersonList;
        }
    }

}