global class WrappNew 
{	
    public class Wrapper
    {
        string a;
        string b;
        string c;
        
        public Wrapper(String i, String j, String k)
        {
            a = i;
            b = j;
            c = k;
        }
    }
    
	public static void main()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://003com-dev-ed.develop.my.salesforce.com/services/apexrest/wrapp');
        request.setMethod('GET');
        request.setheader('Content-Type', 'application/json; charset=utf8');
        request.setHeader('Authorization', 'Bearer !AR4AQPRsEdCb.I7.RFXquxgAHpfyYijXfpqXP8FMLMz2nQ.hdAeATWckv_YQ30TYjVtPS2fkjxSvo1oPsGO.6hISmWD1eyKp');
        //request.setBody('body');
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        
        system.debug('2.1 = ' + response.getBody() + ' <> ' + response.getStatusCode());
        
        
    }
}