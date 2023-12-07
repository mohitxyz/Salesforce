trigger mostPurchasedProd on OrderLineItem__c (after insert, after update, after undelete) {
    
    List<id> oLis = new List<id>();
    List<id> allOrderLis = new List<id>();
    List<id> aLis = new List<id>();
    Map<id, id> oaMap = new Map<id, id>();
    Map<id, id> oliOrdMap = new Map<id, id>();
    Map<String, Decimal> allProdMap = new Map<String, Decimal>();
    STRING  maxProd = '';
    Decimal maxProdQuant = 0;
    //Map<id, Map<String, Decimal>> OrderProd   = new Map<id, Map<String, Decimal>>();
    //Map<Map<String, Integer>, id> OrderProd = new Map<Map<String, Integer>, id>();
    
    for(OrderLineItem__c oli : Trigger.new)
    {
        oLis.add(oli.Order__c);  // not all order 
    }
    
    for(Order o : [SELECT id, AccountId FROM Order WHERE id IN :oLis])
    {
        aLis.add(o.AccountId);  // actual all account
    }
    
    for(Order o : [SELECT id, AccountId FROM Order WHERE AccountId IN :aLis])
    {
        oaMap.put(o.id, o.AccountId);  // actual all order, acount
    }
    
    for(OrderLineItem__c oli : [SELECT id, order__c FROM OrderLineItem__c WHERE order__c IN :oaMap.keySet()])
    {
        oliOrdMap.put(oli.id, oli.order__c);   // actual all OLI, order
    }
    
    for(OrderLineItem__c oli : [SELECT id, Order__c, product__c, quantity__c FROM OrderLineItem__c WHERE id IN :oliOrdMap.keySet()])
    {
        if(allProdMap.containsKey(oli.product__c))
        {
            allProdMap.put(oli.product__c, allProdMap.get(oli.product__c) + oli.quantity__c);
            
            if(maxProdQuant <  allProdMap.get(oli.product__c))
            {
                maxProd      = oli.product__c;
                maxProdQuant = allProdMap.get(oli.product__c);
            }
        }
        else
        {
            allProdMap.put(oli.product__c, oli.quantity__c);
            
            if(maxProdQuant <  oli.quantity__c)
            {
                maxProd      = oli.product__c;
                maxProdQuant = oli.quantity__c;
                //OrderProd.put(oli.Order__c, allProdMap ))
            }
        }
    }
     
}