public interface Framework_Interface {

    void beforeInsert(List<sObject> newRecordList);
    
    void afterInsert(List<sObject> newRecordList, Map<id, sObject> newRecordMap);
    
    void beforeUpdate(List<sObject> newRecordList);
    
    void afterUpdate(List<sObject> newRecordList, Map<id, sObject> newRecordMap);
}