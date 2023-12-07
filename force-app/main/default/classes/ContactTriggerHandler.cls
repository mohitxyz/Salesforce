public class ContactTriggerHandler implements TriggerInterface {
    public static Boolean hasRun = False;
    
    public static void beforeInsert(List<sObject> newRecordList)
    {   
        /*if(hasRun == True) 
            Return;
        else
            hasRun = True; */
        
     	for(sObject s : newRecordList)
        {   
            Contact c = (Contact)s;
            c.lastname = c.lastname + '__Triggerinterface';
        }  
       /* Contact s = new Contact();
        s.lastname = 'cd3';
        
      try
        {
            INSERT s; 
        }
        
        catch(Exception e) 
        {
            system.debug('1.3 = ' + e);
            //return;
        } */
        
      
    }
    public static void afterInsert(List<sObject> newRecordList, Map<id, sObject> newRecordMap)
    {
        
    }
    
    public static void beforeUpdate(Map<id, sObject> newRecordMap, Map<id, sObject> oldRecordMap)
    {
        
    }
    public static void afterUpdate(Map<id, sObject> newRecordMap, Map<id, sObject> oldRecordMap)
    {
        
    }
    
    public static void beforeDelete(List<sObject> oldRecordList, Map<id, sObject> oldRecordMap)
    {
        
    }
    public static void afterDelete(Map<Id, sObject> oldRecordMap)
    {
        
    }
    
    public static void afterUndelete(List<sObject> newRecordList, Map<id, sObject> newRecordMap)
    {
        
    }

}