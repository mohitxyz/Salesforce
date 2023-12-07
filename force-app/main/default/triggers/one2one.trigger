trigger one2one on XYZ__c (before insert, before update) {
   List<xyz__c> lis = new List<xyz__c>();
   for(xyz__c x: Trigger.new)
   {
       x.one2one__c = String.valueOf(x.pqrID__c);
       lis.add(x);
   }
}