public class CTLocationTracingController {
    public CTLocationTracingController() {

    }

    public static List<Location_tracing__c> getVisitors(String locationId)
    {
        List<Location_tracing__c> ltList = [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
        FROM Location_Tracing__c 
        WHERE Location__r.Id = : locationId ORDER BY Visit_Date__c DESC];

        return ltList;
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds)
    {
        List<Location_Tracing__c> ltList = [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
        FROM Location_Tracing__c 
        WHERE Person__r.Id IN : personIds AND Visit_Date__c = LAST_N_DAYS:10];

        return ltList;
    }

    public static List<Location_tracing__c> getLocationsByLocationIds(Set<Id> locationIds)
    {
        List<Location_Tracing__c> ltList = [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
        FROM Location_Tracing__c 
        WHERE Location__r.Id IN : locationIds AND Visit_Date__c = LAST_N_DAYS:10 AND Person__r.Health_Status__c = 'Green'];

        return ltList;
    }

    public static List<Location_tracing__c> checkDuplicates(List<Location_tracing__c> locationTraces)
    {
        /* Method 1 */
        Set<String> st = new Set<String>();
        List<String> dupe = new List<String>();
        Set<id> personSet   = new Set<id>();
        Set<id> locationSet = new Set<id>();

        for(Location_tracing__c lc : locationTraces)
        {
            st.add(lc.Person__c + ',' + lc.Location__c);
            personSet.add(lc.Person__c);
            locationSet.add(lc.Location__c);
        }

        for(Location_tracing__c lc : [SELECT id, Person__c, Location__c 
                                       FROM Location_tracing__c 
                                       WHERE Person__c IN :personSet AND Location__c IN : locationSet])
        {
            if(st.contains(lc.Person__c + ',' + lc.Location__c))
            {
                dupe.add(lc.Person__c + ',' + lc.Location__c);
            } 
        }

        /*List<Location_tracing__c> retDupe = new List<Location_tracing__c>();
        for(Location_tracing__c lc : dupe)
        {
            system.debug('1.3 = ' + lc.id +','+ triggerNewMap );
            retDupe.add(triggerNewMap.get(lc.Id));
        }*/

        List<Location_tracing__c> retDupe = new List<Location_tracing__c>();
        for(Location_tracing__c lc : locationTraces)
        {
            if(dupe.contains(lc.Person__c + ',' + lc.Location__c))
            {
                retDupe.add(lc);
            }
        }

        return retDupe;
    }




}