trigger CreateTask on Opportunity (after insert) {
    for(Opportunity o : trigger.new){
        Task t = new Task();
        t.subject     = 'Apple Watch Promo';
        t.Description = 'Send One ASAP';
        t.priority    = 'High';
        t.whatId      = o.id;
        INSERT t;
        System.debug('1.1' + t.id);
}
}