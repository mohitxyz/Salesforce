trigger Scen3 on Account (after insert) {
   List<Contact> cLis = new List<Contact>(); 
   Map<id, integer> acMap = new Map<id, integer>(); 
   for(account a : Trigger.new)
   { 
       acMap.put(a.id, Integer.valueOf(a.NumOfLocations__c));
   }
    
   for(account a : [SELECT id, name, phone FROM account WHERE id IN :acMap.keySet()])
   {   
       for(integer i = 1; i<= acMap.get(a.id); i++)
       {
           Contact c   = new Contact();
           c.lastname  = a.name + STRING.valueOf(math.random()).substring(0,8);
           c.phone     = a.phone;
           c.AccountId = a.Id;
           cLis.add(c);
       }
       
   }
   INSERT cLis;
}