trigger CopyAccount on Account (after insert) {
    
    Set<id> aSet = new Set<id>();
    
    for(Account a : Trigger.new)
    {
        aSet.add(a.id);
    }
       // callout from Trigger is not supported, use future method instead 
    futureWalkaround.copy(aSet); 

    
    
}