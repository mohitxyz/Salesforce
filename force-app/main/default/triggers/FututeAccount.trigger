trigger FututeAccount on Account (after insert) {
    List<id> aLis = new List<id>();
    for(Account a: Trigger.new)
    {
        aLis.add(a.id);
    }
    
    FutureCalloutClass.callOut(aLis);
}