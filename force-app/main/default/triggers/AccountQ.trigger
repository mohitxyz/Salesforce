trigger AccountQ on Account (after insert) {
    ContactCreationQueue q = new ContactCreationQueue(Trigger.new);
    System.enqueueJob(q);
}