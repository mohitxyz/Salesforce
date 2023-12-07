trigger Contact_Other on Contact (before insert) {
    // note : Contact id will not be privided so code accordingly>>
    List<id> aLis = new List<id>();
    //List<Contact> cInsert = new List<Contact>();
    
    Map<id, Account> mpAcc = new Map<id, Account>();
    
    for(Contact c : Trigger.new)
    {
        aLis.add(c.AccountId);
    }
    
    for(Account a : [SELECT phone FROM Account WHERE id IN :aLis])
    {
        mpAcc.put(a.id, a);
    }
    
    for(Contact c :Trigger.new)
    {          
        c.otherPhone = mpAcc.get(c.AccountId).phone;
    }

}