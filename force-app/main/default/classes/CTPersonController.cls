public class CTPersonController {
    public CTPersonController() {

    }

    public static List<Person__c> getRecentHealthChanges()
    {
        List<Person__c> pLis = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC Nulls last LIMIT 100];

        return pLis;
    } 

    public static List<Person__c> searchPeople(String searchTerm)
    {
        String selectq = 'SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c';
        String fromq = ' FROM Person__c';
        String whereq;
        String s1 = searchTerm + '%';
        whereq = ' WHERE Name Like ' +  '\'' + s1+  '\'';
        
        String suffixq = ' ORDER BY Status_Update_Date__c DESC nulls last';
system.debug('1.2 = ' + selectq + fromq + whereq + suffixq +',' + searchTerm);
        List<sObject> pLis = Database.query(selectq + fromq + whereq + suffixq);
        List<Person__c> ppLis = new List<Person__c>();

        for(sObject s : pLis)
        {
            ppLis.add( (Person__c)s );
        }
        
        //List<Person__c> pLis = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Name Like :s OR Mobile__c Like :s OR Token__c Like :s ORDER BY Status_Update_Date__c DESC nulls last];

        return ppLis; 
    } 

    public static Person__c getPersonById(String personId)
    {
        Person__c p = new Person__c();
        try
        {
             p = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE id = :personId LIMIT 1];
        }
        catch(exception e)
        {
             p = null;   
        }

        return p;
    }

    public static Map<String, Integer> getHealthStatusCount()
    {
        Map<String, Integer> mp = new Map<String, Integer>();
       // List<Person__c> persons = [SELECT Count(id), Health_Status__c FROM Person__c GROUP BY Health_Status__c ];
       // AggregateResult[] AG = [];

        for(AggregateResult p : [SELECT Count(Id)label_Count, Health_Status__c FROM Person__c GROUP BY Health_Status__c])
        {
            mp.put(String.valueOf(p.get('Health_Status__c')), Integer.valueOf(p.get('label_Count')));
        }

        return mp;
        
    }

    public static String getToken(String mobile)
    {
        Blob value = Blob.valueOf(mobile);
        Blob hash  = Crypto.generateDigest('MD5', value);

        System.debug('1.1 = ' + value + ',' + hash);

        return EncodingUtil.base64Encode(hash);
    }

    public static Set<Id> getCohabitants(Set<Id> personIds, Set<Id> alreadyProcessed)
    {
        Set<String> stat = new Set<String>{'Green', 'Yellow'};

        List<People_Tracing__c> pt = [SELECT id, Person_1__c, Person_2__c, Contact_Type__c FROM People_Tracing__c 
                                      WHERE (Person_1__c = :personIds OR Person_2__c = :personIds) AND Contact_Type__c = 'Cohabitant' ];
                            
        Set<Id> pLis = new Set<Id>();        
        for(People_Tracing__c p : pt)
        {
            if(!personIds.contains(p.Person_1__c))
            {
                pLis.add(p.Person_1__c);
                alreadyProcessed.add(p.Person_1__c);
            }
            if(!personIds.contains(p.Person_2__c))
            {
                pLis.add(p.Person_2__c);
                alreadyProcessed.add(p.Person_2__c);
            }
        }

        for(Person__c p : [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :pLis])
        {
            if(!stat.contains(p.Health_Status__c))
            {
                pLis.remove(p.Id);
            }
        }
        return pLis;  
    }

    public static Set<Id> getNeighbours(Set<Id> personIds, Set<Id> alreadyProcessed)
    {
        Set<String> stat = new Set<String>{'Green', 'Yellow', 'Orange'};

        List<People_Tracing__c> pt = [SELECT id, Person_1__c, Person_2__c, Contact_Type__c FROM People_Tracing__c 
                                      WHERE (Person_1__c = :personIds OR Person_2__c = :personIds) AND Contact_Type__c = 'Neighbour' ];
                            
        Set<Id> pLis = new Set<Id>();        
        for(People_Tracing__c p : pt)
        {
            if(!personIds.contains(p.Person_1__c))
            {
                pLis.add(p.Person_1__c);
                alreadyProcessed.add(p.Person_1__c);
            }
            if(!personIds.contains(p.Person_2__c))
            {
                pLis.add(p.Person_2__c);
                alreadyProcessed.add(p.Person_2__c);
            }
        }

        for(Person__c p : [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :pLis])
        {
            if(!stat.contains(p.Health_Status__c))
            {
                pLis.remove(p.Id);
            }
        }
        return pLis;  
    }

    public static Set<Id> getPrimaryContacts(Set<Id> personIds, Set<Id> alreadyProcessed)
    {
        Set<String> stat = new Set<String>{'Green', 'Yellow'};

        List<People_Tracing__c> pt = [SELECT id, Person_1__c, Person_2__c, Contact_Type__c FROM People_Tracing__c 
                                      WHERE (Person_1__c = :personIds OR Person_2__c = :personIds) AND Contact_Type__c = 'Other' AND Contact_Date__c = LAST_N_DAYS:10 ];
                            
        Set<Id> pLis = new Set<Id>();        
        for(People_Tracing__c p : pt)
        {
            if(!personIds.contains(p.Person_1__c))
            {
                pLis.add(p.Person_1__c);
                alreadyProcessed.add(p.Person_1__c);
            }
            if(!personIds.contains(p.Person_2__c))
            {
                pLis.add(p.Person_2__c);
                alreadyProcessed.add(p.Person_2__c);
            }
        }

        for(Person__c p : [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :pLis])
        {
            if(!stat.contains(p.Health_Status__c))
            {
                pLis.remove(p.Id);
            }
        }
        return pLis;  
    }

    public static Set<Id> getSecondaryContacts(Set<Id> personIds, Set<Id> alreadyProcessed)
    {
        Set<String> stat = new Set<String>{'Green', 'Yellow'};

        List<People_Tracing__c> pt = [SELECT id, Person_1__c, Person_2__c, Contact_Type__c FROM People_Tracing__c 
                                      WHERE (Person_1__c = :personIds OR Person_2__c = :personIds) AND Contact_Type__c = 'Other' AND Contact_Date__c = LAST_N_DAYS:10 ];
                            
        Set<Id> pLis = new Set<Id>();        
        for(People_Tracing__c p : pt)
        {
            if(!personIds.contains(p.Person_1__c))
            {
                pLis.add(p.Person_1__c);
                alreadyProcessed.add(p.Person_1__c);
            }
            if(!personIds.contains(p.Person_2__c))
            {
                pLis.add(p.Person_2__c);
                alreadyProcessed.add(p.Person_2__c);
            }
        }

        for(Person__c p : [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :pLis])
        {
            if(!stat.contains(p.Health_Status__c))
            {
                pLis.remove(p.Id);
            }
        }
        return pLis;  
    }
















}