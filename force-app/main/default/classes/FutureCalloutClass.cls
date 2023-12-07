public class FutureCalloutClass {
    
    Public Static String endpoint = 'https://api.spoonacular.com/';
    Public Static string apiKey   = 'ae19643b82214556a7691670566cc5f5';
    //Public Static Boolean call = True;
    @future(callout=True)
    public static void callOut(List<id> aLis)
    {
        for(Account a : [SELECT id, name FROM Account WHERE id IN :aLis])
        {
            System.debug('call = ' + a.name);
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint + 'recipes/random' + '?apiKey=' + apiKey);
            req.setMethod('GET');
            
            HttpResponse response = new HttpResponse();
            response = Http.send(req);
            
            System.debug('response = ' + response.getStatusCode());
            if(response.getStatusCode() == 200)
            System.debug('1.2 = ' + response.getbody());            
        }
    }
}