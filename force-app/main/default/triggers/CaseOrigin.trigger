trigger CaseOrigin on Case (before insert) {
	
    for(Case c : Trigger.new)
    {
        if(c.origin == 'Email')
        {
            c.Status = 'new';
            c.Priority = 'Medium';
        }
    }
}