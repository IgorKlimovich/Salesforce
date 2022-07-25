public with sharing class UpdateLeadQueueBatch implements Database.Batchable<sObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT ID, QueueId FROM QueueSobject WHERE SobjectType='Lead']);
    }

    public void execute(Database.BatchableContext bc, List<QueueSobject> scope){
        List<Lead> leadsForUpdate = new List<Lead>();
        List<Id> systemAdministratorIds = new List<Id>();
        for(User user :[SELECT id FROM User WHERE ProfileId in (SELECT id FROM Profile  WHERE name ='System Administrator')]){
            systemAdministratorIds.add(user.id);
        }
        Set<id> queuesQueueId = new Set<Id>();
        for(QueueSobject queue: scope){
            queuesQueueId.add(queue.QueueId);
        }
        List<Lead> leadsWithQueue=[SELECT id, OwnerId FROM Lead where OwnerId in:queuesQueueId ];
        Map<QueueSobject,List<Lead>> QueueWithLeadsMap = new Map<QueueSobject,List<Lead>>();
        for(QueueSobject queue:scope){
            List<Lead> listForMap = new List<Lead>();
            for(Lead lead:leadsWithQueue ){
                if(lead.OwnerId==queue.QueueId){
                    listForMap.add(lead);
                }
            }
            QueueWithLeadsMap.put(queue,listForMap);
        }
        for (Lead lead : [SELECT ID, status, Total_Score__c, OwnerId  FROM Lead WHERE
        (status LIKE 'Open%' AND Total_Score__c>3 AND OwnerId in :systemAdministratorIds) ORDER BY Total_Score__c DESC ]){
            QueueSobject queueForAssign = scope.get(0);
            Integer countLeadsInQueue = QueueWithLeadsMap.get(queueForAssign).size();
            for (QueueSobject queue: QueueWithLeadsMap.keySet()){
                if(QueueWithLeadsMap.get(queue).size()<countLeadsInQueue){
                    countLeadsInQueue=QueueWithLeadsMap.get(queue).size();
                    queueForAssign=queue;
                }
            }
            lead.OwnerId=queueForAssign.QueueId;
            List<Lead> listLead=QueueWithLeadsMap.get(queueForAssign);
            listLead.add(lead);
            leadsForUpdate.add(lead);
        }
        update leadsForUpdate;
    }

    public void finish(Database.BatchableContext bc){
            
    }
}