trigger AccAfter on Account (after insert) {
    
    List<Contact> cLis = new List<Contact>();
    
    for(Account a : Trigger.new)
    {
        Contact c = new Contact();
        c.AccountId = a.id;
        c.lastName = 'test1';
        
        cLis.add(c);
    }
    
    INSERT cLis;
}