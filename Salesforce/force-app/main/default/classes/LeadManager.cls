public class LeadManager {

    public static String getSysAdminOpenLeads(){
        return 'SELECT Id, Status, Total_Score__c, OwnerId  FROM Lead  WHERE(Status LIKE \'Open%\''+
        ' AND Total_Score__c>3 AND OwnerId IN '+
        '(SELECT Id FROM User WHERE User.Profile.name=\'System Administrator\')) ORDER BY Total_Score__c DESC';
    }

      public static List<QueueSobject> getQueueWithLeads(){
        return [SELECT Id, QueueId FROM QueueSobject WHERE SobjectType =: LeadConstants.LEAD];
    }

    public static List<Lead> getLeadsWithQueue(Set<Id> queuesQueueId){
        return [SELECT Id FROM Lead WHERE OwnerId IN: queuesQueueId];
    }

    public static Set<Id> getSetQueueQueueId(List<QueueSobject> queueSobjectList){
        Set<Id> ids = new Set<Id>();
        for(QueueSobject queue: queueSobjectList){
            ids.add(queue.QueueId);
        }
        return ids;
    }

    public static  Map<QueueSobject, List<Lead>> getQueueWithLeadsMap(List<QueueSobject> listQueueSobjest, List<Lead> leadsWithQueue){
        Map<QueueSobject, List<Lead>> QueueWithLeadsMap = new Map<QueueSobject, List<Lead>>();
        for(QueueSobject queue: listQueueSobjest){
            List<Lead> listForMap = getListLeadForMap(queue, leadsWithQueue);
            QueueWithLeadsMap.put(queue, listForMap);
        }
        return QueueWithLeadsMap;
    }
    
    public static List<Lead> getListLeadForMap(QueueSobject queue, List<Lead> leadsWithQueue ){
        List<Lead> listForMap = new List<Lead>();
        for(Lead lead: leadsWithQueue ){
            if(lead.OwnerId == queue.QueueId){
                listForMap.add(lead);
            }
        }
        return listForMap;
    }

    public static List<Lead> getLeadsForUpdate(List<Lead> scope,List<QueueSobject> listQueueSobjest,
            Map<QueueSobject, List<Lead>>  QueueWithLeadsMap){
        List<Lead> leadsForUpdate = new List<Lead>(); 
        for (Lead lead: scope){
            QueueSobject queueForAssign = getQueueForAssign(listQueueSobjest, QueueWithLeadsMap);
            lead.OwnerId = queueForAssign.QueueId;
            List<Lead> listLead = QueueWithLeadsMap.get(queueForAssign);
            listLead.add(lead);
            leadsForUpdate.add(lead);
        }
        return leadsForUpdate;
    }

    public static QueueSobject getQueueForAssign (List<QueueSobject> listQueueSobjest,
            Map<QueueSobject, List<Lead>>  QueueWithLeadsMap){
        QueueSobject queueForAssign = listQueueSobjest.get(0);
        Integer countLeadsInQueue = QueueWithLeadsMap.get(queueForAssign).size();
        for (QueueSobject queue: QueueWithLeadsMap.keySet()){
            if(QueueWithLeadsMap.get(queue).size() < countLeadsInQueue){
                countLeadsInQueue = QueueWithLeadsMap.get(queue).size();
                queueForAssign = queue;
            }
        }
        return queueForAssign;
    }
}