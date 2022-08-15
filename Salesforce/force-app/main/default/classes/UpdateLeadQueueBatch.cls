public with sharing class UpdateLeadQueueBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(LeadManager.getSysAdminOpenLeads());
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<QueueSobject> listQueueSobjest =LeadManager.getQueueWithLeads();
        if(!listQueueSobjest.isEmpty()){
            Set<id> queuesQueueId = LeadManager.getSetQueueQueueId(listQueueSobjest);
            List<Lead> leadsWithQueue = LeadManager.getLeadsWithQueue(queuesQueueId);
            Map<QueueSobject, List<Lead>> QueueWithLeadsMap =
                LeadManager.getQueueWithLeadsMap(listQueueSobjest, leadsWithQueue);
            List<Lead> leadsForUpdate = LeadManager.getLeadsForUpdate(scope, listQueueSobjest, QueueWithLeadsMap);
            if(leadsForUpdate.size()>0){
                update leadsForUpdate;
            }
        }
    }

    public void finish(Database.BatchableContext bc){
            
    }
}