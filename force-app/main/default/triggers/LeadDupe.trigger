trigger LeadDupe on Lead (before insert, before update) {
    
    if(trigger.isInsert)
    {   
        Map<String, List<Lead>> mp   = new Map<String, List<Lead>>();
        List<lead> lList = new List<Lead>();
        Set<String>       lSet = new Set<String>();
        
        for(Lead l : Trigger.new)
        {
            lSet.add(l.email);
        }
        
        for(Lead l : [SELECT id, email FROM Lead WHERE email IN :lSet])
        {
            if(mp.containsKey(l.Email))
            {   
                lList = mp.get(l.Email);
                lList.add(l);
                mp.put(l.Email, lList);
            }
            else
            {                   
                lLIst.add(l);
                mp.put(l.Email, lList);      
            }
                        
        }
        
        // fire error only when dupe email is found
        if(mp.size() > 0)
        {
            for(Lead l : Trigger.new)
            {
                if(mp.get(l.email).size() > 0)
                {
                    l.addError('Dupe email found');
                }
            }  
        }
             
    }
}