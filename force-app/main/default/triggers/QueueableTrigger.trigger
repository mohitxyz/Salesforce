trigger QueueableTrigger on Account (after insert) {
    
    System.enqueueJob(new QueueableClass(Trigger.new));
}