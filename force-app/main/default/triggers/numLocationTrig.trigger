trigger numLocationTrig on Account (after insert) {
    List <contact> cont = new List <contact>();
    
    for(account acc : trigger.new){
        if(acc.NumberofLocations__c > 0){           
             for(integer i = 1; i<= acc.NumberofLocations__c; i++){                    
               Contact c = new Contact();
               c.AccountId = acc.id;
               c.lastname  = acc.name + String.valueOf(i);
               cont.add(c); 
             }            
        }      
    }
    INSERT cont;
}