global class futureWalkaround {
    
    global class WrapperJSON
    {
        String aName;
        String aWebsite;
       // String aRating;
        
        public WrapperJSON(String n, String w)
        {
            aName    = n;
            aWebsite = w;
           // aRating  = r;
        }
    }
    
    @future(callout=true)
    public static void copy(Set<id> aSet)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String json_obj;
        request.setEndpoint('https://003com-dev-ed.develop.my.salesforce.com/services/apexrest/copyAccount');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer !AR4AQCsVSax6.NszRpTeknIhkeH_KKlPNpYSrxVdw.3cs4jskDTmXEqeHWIQsxelkJdYb52yDipmN5noG.8rWI_Dr2kGUYG1');
        request.setheader('Content-Type', 'application/json; charset=utf8');
        
        for(Account a : [SELECT name, website, rating FROM Account WHERE id IN :aSet])
        {
            WrapperJSON obj = new WrapperJSON(a.name, a.Website);
            json_obj = JSON.serialize(obj);
        }
        
        //json_obj = '{"aName":"callK","aWebsite":"ewe@gmail.com","aRating":"hot"}';
                
        request.setBody(json_obj);
        
        HttpResponse response = http.send(request);
      
        system.debug('1.1 = ' + response.getStatusCode());
        system.debug('1.2 = ' + response.getbody());
        
        if (response.getStatusCode() == 200) {
           
        }
       
}
}