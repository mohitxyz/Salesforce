public class EmployeeBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {   
        String s1 = String.valueOf(System.today()-3);
        String s2 = String.valueOf(System.today());
        
        String query = 'SELECT id, Employee__c FROM Salary_Change__c WHERE Term_Date__c > ' + s1 +  ' AND ' + 'Effective_Date__c >= ' + s2;       
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Salary_Change__c> scope)
    {   
        List<id> empLis = new List<id> ();
        Map<id, Decimal> empSalaryMap = new Map<id, Decimal>();
        List<Employee__c> eLis = new List<Employee__c>();
                
        for(Salary_Change__c sc : scope)
        {
            empLis.add(sc.Employee__c);
        }
        
        for(Employee__c e : [SELECT id, CurrentSalary__c FROM Employee__c WHERE id IN :empLis])
        {
            empSalaryMap.put(e.id, e.CurrentSalary__c);
        }
        
        for(Salary_Change__c sc : [SELECT id, Employee__c, New_Salary__c FROM Salary_Change__c WHERE employee__c IN :empLis])
        {               
            if(empSalaryMap.get(sc.Employee__c) != sc.New_Salary__c)
            {   
                Employee__c emp = new Employee__c ();
                emp.id               = sc.Employee__c;
                emp.CurrentSalary__c = sc.New_Salary__c;
                eLis.add(emp);
            }
        }       
        UPDATE eLis;       
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }

}