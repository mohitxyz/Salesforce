public class QueueableClass implements Queueable, Database.AllowsCallouts{
	
    Public Static String endpoint = 'https://api.spoonacular.com/';
    Public Static string apiKey   = 'ae19643b82214556a7691670566cc5f5';
    
    public list<Account> acc = new List<Account>();
    public QueueableClass(List<sObject> aLis)
    {
        for(sObject a : aLis)
        {
            acc.add((Account)a);
        }
    }
    
    public void execute(QueueableContext qc)
    {
       for(Account a : acc)
       {
           System.debug('Queue 1 = ' + a.name + a.id);
           
           Http http = new Http();
           HttpRequest request = new HttpRequest();
           request.setEndpoint(endpoint + 'recipes/random' + '?apiKey=' + apiKey);
           request.setMethod('GET');
           
           HttpResponse response = new HttpResponse();
           response = Http.send(request);
           
           System.debug('1.1 = ' + response.getStatusCode());
           
           if(response.getStatusCode() == 200)
               System.debug('1.2 = ' + response.getBody());
           
       }
    }
}