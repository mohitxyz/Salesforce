trigger LeadSource on Lead (before insert, before Update) {
	for(Lead l : trigger.new)
    {
        if(l.LeadSource == 'web')
        {
            l.Rating = 'cold';
        }
        else
        l.Rating = 'hot';
        //l.Rating = 'hot';
        
    }
}