trigger SchedulableTrigger on Account(after insert) {
    List<id> iLis = new List<id>();
    String cron = '0 15 21 12 03 ? 2023';
    for(Account a : Trigger.new)
    {
        iLis.add(a.id);
    }
    System.schedule('CallOutC', cron , new ScheduleClass(iLis));
    System.ScheduleBatch(new BatchClass(5), 'ScheduleBatch' , 30);
}