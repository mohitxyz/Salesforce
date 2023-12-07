public with sharing class CTPersonScheduleApex implements Schedulable {

    public void execute(SchedulableContext ctx) {
        // Your code to be executed on schedule goes here
        System.debug('Person Scheduled job is running...');

        Database.executeBatch(new CTBatchPersonCleanup(), 200);
        // Add your logic here
    }
}