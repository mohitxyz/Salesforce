trigger OrderApp_AccountTrigger on Account (before insert) {
      
    Switch ON trigger.operationType{
        when BEFORE_INSERT{
            for(Account acc :Trigger.new){
                List<Account> aLis = [SELECT id FROM Account WHERE ownerId = :acc.OwnerId];
                User u             = [SELECT id, ProfileId FROM User WHERE id = :acc.ownerId]; 
                Profile p          = [SELECT id, name  FROM Profile WHERE id = :u.ProfileId];  
                
                if(aLis.size() >= 5 && p.name == 'Business Profile'){
                    acc.addError('A single Business user can only have 5 accounts');
                }
                else if(aLis.size() >= 10 && p.name == 'Sales Profile'){
                    acc.addError('A single Sales user can only have 5 accounts');
                }             
            }
        }
    }  
}