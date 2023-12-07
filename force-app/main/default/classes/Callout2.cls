public class Callout2 {
	
    public static void main(String s)
    {
        Http h_http = new Http();
        HttpRequest req = new HttpRequest();
        //HttpResponse response = new HttpResponse();
        
        req.setMethod('GET');
        req.setEndpoint('https://api.spoonacular.com/recipes/' + s + '/information');
        //req.setHeader('apiKey', 'ae19643b82214556a7691670566cc5f5');
        
        HttpResponse response = h_http.send(req);
        
        System.debug('1.1 = ' + response.getStatusCode() + ' ++ ' + response.getBody() );
        
    }
    
}