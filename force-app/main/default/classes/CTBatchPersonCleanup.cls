public class CTBatchPersonCleanup implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        // Query for the records you want to update
        return Database.getQueryLocator('SELECT Id FROM Person__c WHERE Status_Update_Date__c = LAST_N_DAYS:30');
    }

    public void execute(Database.BatchableContext context, List<sObject> scope) {
        List<Person__c> recordsToUpdate = new List<Person__c>();

        // Process each record and update Description__c field
        for (sObject record : scope) {
            Person__c customObj = (Person__c)record;
           // customObj.Description__c = 'Updated Description';
            recordsToUpdate.add(customObj);
        }

        // Update the records
        DELETE recordsToUpdate;
    }

    public void finish(Database.BatchableContext context) {
        // Optional: Add any post-processing logic here
    }

}