trigger AccountNum on Account (after insert) {
    
    List<Contact> cLis = new List<Contact>();
    
    for(Account a : trigger.new)
    {
        for(integer i = 1; i<=a.NumberofLocations__c; i++)
        {   
            Contact c = new Contact();
            c.lastname  = 'name ' + String.valueOf(i);
            c.AccountId = a.id;
            cLis.add(c);     
        }
    }
    
    INSERT cLis;
}