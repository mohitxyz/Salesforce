public class CTPersonLocationTabController {

    @AuraEnabled(cacheable=true)
    public static List<Person__c> getRecentPerson() 
    {
        return CTPersonController.getRecentHealthChanges();
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Location__c> getRecentLocation() 
    {
        return CTLocationController.getRecentStatusChanges();
    }

    @AuraEnabled(cacheable=true)
    public static List<Person__c> searchPerson(String searchTerm) 
    {
        system.debug('1.3 = ' + searchTerm);
        return CTPersonController.searchPeople(searchTerm);
    }

    @AuraEnabled(cacheable=true)
    public static List<Location__c> searchLocation(String searchTerm) 
    {
        system.debug('1.3 = ' + searchTerm);
        return CTLocationController.searchLocations(searchTerm);
    }
    
}