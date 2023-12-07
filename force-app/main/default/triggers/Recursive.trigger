trigger Recursive on Account (after insert) {
    
    System.debug('1.1 = ' + StopRecursive.fired);
    if(StopRecursive.fired == False)
    {   
        StopRecursive.fired = True;

        system.debug('recursive');
        Account a = new Account();
        a.name = '_rec1';
        INSERT a;  
    }
    
    
}