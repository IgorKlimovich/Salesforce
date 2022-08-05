public with sharing class UpdateLeadQueueBatch implements Database.Batchable<sObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(UpdateLeadBatchDataManager.getQueueWithLeads());
    }

    public void execute(Database.BatchableContext bc, List<QueueSobject> scope){
        List<Lead> leadsForUpdate = new List<Lead>();
        List<Id> systemAdministratorIds = new List<Id>();
        List<User> sysAdminUsers = UpdateLeadBatchDataManager.getSystemAdministratorUsers();
        for(User user: sysAdminUsers){
            systemAdministratorIds.add(user.id);
        }
        Set<id> queuesQueueId = new Set<Id>();
        for(QueueSobject queue: scope){
            queuesQueueId.add(queue.QueueId);
        }
        List<Lead> leadsWithQueue = UpdateLeadBatchDataManager.getLeadsWithQueue(queuesQueueId);
        Map<QueueSobject, List<Lead>> QueueWithLeadsMap = new Map<QueueSobject, List<Lead>>();
        for(QueueSobject queue: scope){
            List<Lead> listForMap = new List<Lead>();
            for(Lead lead: leadsWithQueue ){
                if(lead.OwnerId == queue.QueueId){
                    listForMap.add(lead);
                }
            }
            QueueWithLeadsMap.put(queue, listForMap);
        }

        List<Lead> sysAdminOpenLeads = UpdateLeadBatchDataManager.getSysAdminOpenLeads(systemAdministratorIds);
        for (Lead lead: sysAdminOpenLeads){
            QueueSobject queueForAssign = scope.get(0);
            Integer countLeadsInQueue = QueueWithLeadsMap.get(queueForAssign).size();
            for (QueueSobject queue: QueueWithLeadsMap.keySet()){
                if(QueueWithLeadsMap.get(queue).size() < countLeadsInQueue){
                    countLeadsInQueue = QueueWithLeadsMap.get(queue).size();
                    queueForAssign = queue;
                }
            }
            lead.OwnerId = queueForAssign.QueueId;
            List<Lead> listLead = QueueWithLeadsMap.get(queueForAssign);
            listLead.add(lead);
            leadsForUpdate.add(lead);
        }
        if(leadsForUpdate.size()>0){
            update leadsForUpdate;
        }
    }

    public void finish(Database.BatchableContext bc){
            
    }
}