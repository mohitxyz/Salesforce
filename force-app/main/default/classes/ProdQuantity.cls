public class ProdQuantity {
	
    List<Account> aLis = new  List<Account>();
    //String w;
    
    public List<Account> getQuant(String lv_sWork)
    {  
        for(String ss : lv_sWork.split(';'))
        {   
            system.debug('1.1 ' + ss);
           // w = '%' + ss +'%';
            aLis.addAll([SELECT id, name FROM Account WHERE working_in__c INCLUDES(:ss)]);
        }
        
        return aLis;
    }
    
}