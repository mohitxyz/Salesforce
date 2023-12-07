public interface TriggerInterface {
	 void beforeInsert(List<sObject> newRecordList);
     void afterInsert(List<sObject> newRecordList, Map<id, sObject> newRecordMap);
    
     void beforeUpdate(Map<id, sObject> newRecordMap, Map<id, sObject> oldRecordMap);
     void afterUpdate(Map<id, sObject> newRecordMap, Map<id, sObject> oldRecordMap);
    
     void beforeDelete(List<sObject> oldRecordList, Map<id, sObject> oldRecordMap);
     void afterDelete(Map<Id, sObject> oldRecordMap);
    
     void afterUndelete(List<sObject> newRecordList, Map<id, sObject> newRecordMap);
}