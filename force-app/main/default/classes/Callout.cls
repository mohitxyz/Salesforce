public class Callout {
    
    public static final string endpoint = 'https://api.spoonacular.com/';
    public static final string apiKey   = 'ae19643b82214556a7691670566cc5f5';
    
    public void random()
    {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + 'recipes/random' + '?apiKey=' + apiKey);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) 
        system.debug('1.1 = ' + response.getBody());
   
    }
    
    public void getRecipe(String recId)
    {        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + 'recipes/' + recId + '/information' + '?apiKey=' + apiKey);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) 
        system.debug('1.2 = ' + response.getBody());
   
    }
    
    public void byIngredient(String ingred)
    {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + 'recipes/findByIngredients' + '?apiKey=' + apiKey + '&ingredients=' + ingred + '&number=2' );
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) 
        system.debug('1.3 = ' + response.getBody());
   
    }
}