trigger AcctDupes on Account (before insert) {
    
    Map <String, Integer> mp = new Map<String, Integer>();
    Set<String> aSet = new Set<String>();
    
    for(Account a : Trigger.new)
    {
        aSet.add(a.name);
    }
    
    for(Account a : [SELECT id, name FROM Account WHERE name IN :aSet])
    {   
        if(mp.containsKey(a.name))
        {
            mp.put(a.name, mp.get(a.name)+1);
        }
        else
        mp.put(a.name, 1);
    }
    
    for(Account a : Trigger.new)
    {
        if(mp.get(a.name) > 0 )
        {
            a.addError('Account already exists with this name');
        }
    }
}