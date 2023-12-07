public class ManagerEmailBatch implements Database.batchable <sObject>, Database.stateful{
   
    List<id> managerLis; 
    Map<id, String> emMap;
    Map<id, List<Employee__c>> eeMap;
        
    public ManagerEmailBatch()
    {
        managerLis = new List<id>();
        emMap      = new Map<id, String>();
        eeMap      = new Map<id, List<Employee__c>>();
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {   
        String s = String.valueOf(System.today()-1);
        String query = 'SELECT id, employee__c FROM Salary_Change__c WHERE Effective_Date__c = ' + s;
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Salary_Change__c> scope)
    {
        List<id> scLis = new List<id>();
        
        for(Salary_Change__c s : scope)
        {
            scLis.add(s.employee__c);               
        }
        
        for(Employee__c e : [SELECT id, Manager__c, EmpId__c, CurrentSalary__c FROM Employee__c WHERE id IN :scLis])
        {
            managerLis.add(e.Manager__c);             // all manager List
        }
        
        for(Employee__c e : [SELECT id, email__c FROM Employee__c WHERE id IN :managerLis])
        {
            emMap.put(e.id, e.email__c);              // manager, manager email
        }
        
        // manager id, List<child employee>
        for(Employee__c e : [SELECT id, name, EmpId__c, CurrentSalary__c, manager__c FROM Employee__c WHERE manager__c IN : emMap.keySet()])
        {   
            List<Employee__c> emp = new List<Employee__c>();   // refresh list to get fresh list of child employees
            if(eeMap.containsKey(e.manager__c))
            {                  
                emp.addAll(eeMap.get(e.manager__c));
                emp.add(e);
                eeMap.put(e.manager__c, emp);
            }
            else
            {   
                emp.add(e);
                eeMap.put(e.manager__c, emp);
            }           
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        if(emMap.size() > 0)
        {
            for(Employee__c e : [SELECT id FROM Employee__c WHERE id IN :emMap.keySet()])   // one consolidated email for one manager
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
                    + emMap.size()
                    + ' records. Please find the attached success and error records CSV.';
                
                String subject  = 'Automatic Email for Salary Change - from ManagerEmailBatch';
                String finalstr = 'Manager, Employee Number, Current Salary \n';
                String attName  = 'SalaryChange' + system.now().format('YYYYMMDDhhmm') + '.csv';
                
                for(employee__c ee : eeMap.get(e.id))
                {
                    finalstr = finalstr + ee.name + ',' + ee.empId__c + ',' + ee.currentSalary__c + '\n';
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
    
}