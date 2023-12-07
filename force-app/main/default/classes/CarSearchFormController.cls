public with sharing class CarSearchFormController {

	@AuraEnabled(cacheable=true)
	public static List<Car_Type__c> getCarTypes(){
		try {
			return [SELECT id, Name FROM Car_Type__c WITH SECURITY_ENFORCED];
		} 
		catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled(cacheable=true)
	public static List<Car__c> getCars(String carId){

	system.debug('1.1 = '+  carId);
	   if(carId != '')
	   {

		List<Car__c> car = [SELECT id, name, Picture__c, Contact__r.Name, Geolocation__latitude__s, Geolocation__longitude__s      // compound read-only fields __s
		FROM Car__c 
	   WHERE Available_for_rent__c = true AND Car_type__c = :carId  WITH SECURITY_ENFORCED];

	   System.debug('1.2 ' +','+ car);

		 return car;

	   }
	   else {

		List<car__c> car = [SELECT id, name, Picture__c, Contact__r.Name, Geolocation__latitude__s, Geolocation__longitude__s      // compound read-only fields __s
		FROM Car__c 
	   WHERE Available_for_rent__c = true WITH SECURITY_ENFORCED];

	   System.debug('1.3 ' +',' +  car);
		return car;
	   }
	}

	@AuraEnabled
	public static Id getExpId(Id carId)
	{
		Car_Experience__c rec = [SELECT Id FROM Car_Experience__c WHERE Car__c = :carId  WITH SECURITY_ENFORCED LIMIT 1];

		return rec.Id;
	}
}