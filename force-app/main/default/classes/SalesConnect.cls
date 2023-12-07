public class SalesConnect {
	public static String getRandomRecipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://003com-dev-ed.develop.my.salesforce.com/services/apexrest/ListCases');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer !AR4AQLkQMkHn6zm9vOI3uaToXEsWDi7slzpkwKRUXMCP8peT7QmX5H_wprZYtSFAdePppa.V_4NaClN8tkljosJxT3cK13nC');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }
        return '';
    }
}