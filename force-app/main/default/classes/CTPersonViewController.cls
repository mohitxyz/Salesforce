public class CTPersonViewController {
    public CTPersonViewController() {

    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getPersonViewHeader(){
        Map<String, Integer> mp = new Map<String, Integer>();   

        try {                
                AggregateResult[] ag = [SELECT COUNT(Id) label_count, Health_Status__c FROM Person__c GROUP BY Health_Status__c];

                for(AggregateResult a: ag)
                {
                    mp.put(String.valueOf(a.get('Health_Status__c')), Integer.valueOf(a.get('label_count')));
                }

                return mp;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        finally
        {
            
        }
    }

    
    @AuraEnabled(cacheable=true) 
    public static Map<String, Integer> getLocationViewHeader(){
        Map<String, Integer> mp = new Map<String, Integer>();   

        try {                
                AggregateResult[] ag = [SELECT COUNT(Id) label_count, Status__c FROM Location__c GROUP BY Status__c];

                for(AggregateResult a: ag)
                {
                    mp.put(String.valueOf(a.get('Status__c')), Integer.valueOf(a.get('label_count')));
                }

                return mp;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        finally
        {
            
        }
    }


}