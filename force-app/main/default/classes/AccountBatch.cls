public class AccountBatch implements Database.Batchable<SObject>,Database.Stateful{
    List<id> accLis;
    
    public AccountBatch(){
        accLis = new List<id>();
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT id, BillingState, BillingCountry FROM Account WHERE BillingCountry = \'USA\'  AND BillingState = null';
        return Database.getQueryLocator(query);
        
    }
    
    public void execute(Database.BatchableContext BC, List<Account> scope){
        for(Account acc : scope)
        {                
             accLis.add(acc.id);   
        }
    }
    
    public void finish(Database.BatchableContext BC){
        if(accLis.size() > 0)
        {
            AsyncApexJob a = [SELECT id, ApexClassId,
                              JobItemsProcessed, TotalJobItems,
                              NumberOfErrors, CreatedBy.Email
                              FROM AsyncApexJob
                              WHERE id = :BC.getJobId()];
            String body = 'Your batch job '
                + 'AccountUpdateBatch '
                + 'has finished. \n'
                + 'There were total'
                + accLis.size()
                + ' records. Please find the attached success and error records CSV.';
            String subject = 'Account - Apex Batch Result for AccountUpdateBatch';
            String finalstr = 'Id, BillingState, \n';
            String attName = 'AccountRec' + system.now().format('YYYYMMDDhhmm') + '.csv';
            
            for(id i : accLis)
            {
                string recordString = '"' + i + '","' + 'California' + '"\n';
                finalstr = finalstr +recordString;
            }
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.EmailFileAttachment[] emailAttList = new List<Messaging.EmailFileAttachment>();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
           
            efa.setFileName(attName);
            efa.setBody(Blob.valueOf(finalstr));
            emailAttList.add(efa);
            
            email.setSubject( subject );
            email.setToAddresses( new String[] {a.CreatedBy.Email} );
            email.setPlainTextBody( body );
            email.setFileAttachments(emailAttList);
            
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }
}