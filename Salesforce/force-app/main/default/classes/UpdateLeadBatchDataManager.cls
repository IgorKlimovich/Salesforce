public class UpdateLeadBatchDataManager {

    public static String getQueueWithLeads(){
        return 'SELECT Id, QueueId FROM QueueSobject WHERE SobjectType=\'Lead\'';
    }

    public static List<User> getSystemAdministratorUsers(){
        return [SELECT Id FROM User
        WHERE ProfileId in (SELECT id FROM Profile  WHERE name =:UpdateLeadBatchConstants.SYSTEM_ADMINISTRATOR)];
    }

    public static List<Lead> getLeadsWithQueue(Set<Id> queuesQueueId){
        return [SELECT Id, OwnerId FROM Lead WHERE OwnerId IN:queuesQueueId];
    }

    public static List<Lead> getSysAdminOpenLeads(List<Id> systemAdministratorIds){
        return [SELECT Id, Status, Total_Score__c, OwnerId  FROM Lead 
        WHERE(Status LIKE: UpdateLeadBatchConstants.OPEN_STATUS AND Total_Score__c>3
        AND OwnerId IN :systemAdministratorIds) ORDER BY Total_Score__c DESC];
    }
}

