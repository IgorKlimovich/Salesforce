@isTest
public class TestUpdateLeadQueue {
   
    public static String CRON_EXP = '0 0 0/1 1/1 * ? *';

    @isTest
    public static void testScheduledJobOpenOneRecord(){
        TestDataFactoryUpdateLeadQueue.createLeads(1, 'Open - not Contacted');      
        Test.startTest();
        UpdateLeadQueue ulq = new UpdateLeadQueue();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, ulq);
        ulq.execute(null);
        Lead leadBeforeUpdate = [SELECT id, OwnerId FROM Lead LIMIT 1];
        Test.stopTest();
        Lead leadAfterUpdate = [SELECT id, OwnerId FROM Lead LIMIT 1];
        System.assertNotEquals(leadBeforeUpdate.OwnerId, leadAfterUpdate.OwnerId);
    }

    @isTest
    public static void testScheduledJobCloseOneRecord(){
        TestDataFactoryUpdateLeadQueue.createLeads(1,'Closed - Converted');
        Test.startTest();
        Lead leadBeforeUpdate = [SELECT id, OwnerId from Lead limit 1];
        UpdateLeadQueue ulq = new UpdateLeadQueue();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, ulq);
        ulq.execute(null);
        Test.stopTest();
        Lead leadAfterUpdate = [SELECT id, OwnerId from Lead LIMIT 1];
        System.assertEquals(leadBeforeUpdate.OwnerId, leadAfterUpdate.OwnerId);
    }
    
    @isTest
    public static void testScheduledJobOpenManyRecords(){
        TestDataFactoryUpdateLeadQueue.createLeads(200, 'Open - not Contacted');
        Test.startTest();
        Map<Id,Lead> leadsMap = new Map<Id,Lead>([SELECT id, OwnerId FROM Lead]);
        UpdateLeadQueue ulq = new UpdateLeadQueue();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, ulq);
        ulq.execute(null);
        Test.stopTest();
        List<Lead> leadsAfterUpdate = [SELECT id, OwnerId FROM Lead];
        for(Lead lead : leadsAfterUpdate ){
            System.assertNotEquals(lead.OwnerId, leadsMap.get(lead.id).OwnerId);
        }
    }

    @isTest
    public static void testScheduledJobCloseManyRecords(){
        TestDataFactoryUpdateLeadQueue.createLeads(200, 'Closed - Converted');
        Test.startTest();
        Map<Id,Lead> leadsMap = new Map<Id,Lead>([SELECT id, OwnerId FROM Lead]);
        UpdateLeadQueue ulq = new UpdateLeadQueue();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, ulq);
        ulq.execute(null);
        Test.stopTest();
        List<Lead> leadsAfterUpdate = [SELECT id, OwnerId FROM Lead];
        for(Lead lead : leadsAfterUpdate ){
            System.assertEquals(lead.OwnerId, leadsMap.get(lead.id).OwnerId);
        }
    }
}
