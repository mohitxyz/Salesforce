trigger mostProd on OrderLineItem__c (after insert, after update, after undelete) {
    
    Map<id, List<OrderLineItem__c>>  prodMap  = new Map<id, List<OrderLineItem__c>>();
    Map<id, List<Integer>>  quantMap = new Map<id, List<Integer>>();
    
    Map<id, id> accOrdMap = new Map<id, id>();  // order, account
    List<id> ordLis = new List<id>();
    List<id> accLis = new List<id>();
    Map<id, String>  ordProdMap  = new Map<id, String>();
    Map<id, Decimal> ordQuantMap = new Map<id, Decimal>(); 
    List<Account> aLis = new List<Account>();
    
    for(OrderLineItem__c oli : Trigger.new)
    {
        ordLis.add(oli.Order__c);
    }
    
    for(Order o : [SELECT id, accountId FROM order WHERE id IN :ordLis])
    {
        accLis.add(o.AccountId);      // get the account parent and then traverse to the child and grand child
    }
    
    ordLis.clear();                   // to query fresh child
    
    for(Order o : [SELECT id FROM Order WHERE accountId IN :accLis])
    {
        ordLis.add(o.id);
    }
    
    for(Order o : [SELECT id, accountId, (SELECT id, product__c, quantity__c FROM OrderLineItems__r) FROM Order WHERE id IN :ordLis])
    {
        prodMap.put(o.id, o.OrderLineItems__r);    // orderid, OLI
    }
    
    for(Account a : [SELECT id FROM Account WHERE id IN :accLis])
    {   
        Map<String, Decimal> pMap = new Map<String, Decimal>();
        String  maxProd  = '';
        Decimal maxQuant = 0;
        
        for(Order o : [SELECT id FROM Order WHERE Accountid = :a.id])
        {               
            for(OrderLineItem__c oli : [SELECT id, product__c, quantity__c FROM OrderLineItem__c WHERE id IN :prodMap.get(o.id)])
            {   
                if(pMap.containsKey(oli.product__c))
                {
                    pMap.put(oli.product__c, pMap.get(oli.product__c) + oli.quantity__c);
                }
                else
                {
                    pMap.put(oli.product__c, oli.quantity__c);
                }
                
            }                        
        }
        
        for(String s : pMap.keyset())
        {   
            if(pMap.get(s) > maxQuant)
            {
                maxProd  = s;
                maxQuant = pMap.get(s);
            }
            
        }
        ordProdMap.put(a.id, maxProd);
        ordQuantMap.put(a.id, maxQuant);
    }
    
    for(Account a : [SELECT id, mostPurchased__c FROM Account WHERE id IN :ordProdMap.keySet()])
    {
        a.mostPurchased__c = ordProdMap.get(a.id) + ' , ' + ordQuantMap.get(a.id);
        aLis.add(a);
    }
    
    UPDATE aLis;
}