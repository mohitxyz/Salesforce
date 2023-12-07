trigger TestLead on Lead (before insert, before update) {
    if(True){
        for(lead l : Trigger.new){
        if(l.status == 'Closed - Converted' || l.status == 'Closed - Not Converted'){
            if(Trigger.oldMap.get(l.id).status == 'Open - Not Contacted'){
                l.status.addError('Cant directly close');
} 
            
}
    }
    
    }
}