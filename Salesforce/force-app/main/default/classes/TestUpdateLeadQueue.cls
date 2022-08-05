@isTest
public class TestUpdateLeadQueue {

    @isTest
    public static void testScheduledJobOpenOneRecord(){
        TestDataFactoryUpdateLeadQueue.createLeads(1, UpdateLeadBatchConstants.OPEN_NOT_CONTACTED);      
        Test.startTest();
        System.schedule(UpdateLeadBatchConstants.SCHEDULE_NAME, UpdateLeadBatchConstants.CRON_EXP, new UpdateLeadQueue());
        Lead leadBeforeUpdate = TestDataFactoryUpdateLeadQueue.getTestLead();
        Test.stopTest();
        Lead leadAfterUpdate = TestDataFactoryUpdateLeadQueue.getTestLead();
        System.assertNotEquals(leadBeforeUpdate.OwnerId, leadAfterUpdate.OwnerId);
    }

    @isTest
    public static void testScheduledJobCloseOneRecord(){
        TestDataFactoryUpdateLeadQueue.createLeads(1, UpdateLeadBatchConstants.CLOSED_CONVERTED);
        Test.startTest();
        Lead leadBeforeUpdate = TestDataFactoryUpdateLeadQueue.getTestLead();
        System.schedule(UpdateLeadBatchConstants.SCHEDULE_NAME, UpdateLeadBatchConstants.CRON_EXP, new UpdateLeadQueue());
        Test.stopTest();
        Lead leadAfterUpdate = TestDataFactoryUpdateLeadQueue.getTestLead();
        System.assertEquals(leadBeforeUpdate.OwnerId, leadAfterUpdate.OwnerId);
    }
    
    @isTest
    public static void testScheduledJobOpenManyRecords(){
        TestDataFactoryUpdateLeadQueue.createLeads(200, UpdateLeadBatchConstants.OPEN_NOT_CONTACTED);
        Test.startTest();
        Map<Id,Lead> leadsMap = new Map<Id,Lead>(TestDataFactoryUpdateLeadQueue.getTestLeadList());
        System.schedule(UpdateLeadBatchConstants.SCHEDULE_NAME, UpdateLeadBatchConstants.CRON_EXP, new UpdateLeadQueue());
        Test.stopTest();
        List<Lead> leadsAfterUpdate = TestDataFactoryUpdateLeadQueue.getTestLeadList();
        for(Lead lead: leadsAfterUpdate ){
            System.assertNotEquals(lead.OwnerId, leadsMap.get(lead.id).OwnerId);
        }
    }

    @isTest
    public static void testScheduledJobCloseManyRecords(){
        TestDataFactoryUpdateLeadQueue.createLeads(200, UpdateLeadBatchConstants.CLOSED_CONVERTED);
        Test.startTest();
        Map<Id,Lead> leadsMap = new Map<Id,Lead>(TestDataFactoryUpdateLeadQueue.getTestLeadList());
        System.schedule(UpdateLeadBatchConstants.SCHEDULE_NAME, UpdateLeadBatchConstants.CRON_EXP, new UpdateLeadQueue());
        Test.stopTest();
        List<Lead> leadsAfterUpdate = TestDataFactoryUpdateLeadQueue.getTestLeadList();
        for(Lead lead: leadsAfterUpdate ){
            System.assertEquals(lead.OwnerId, leadsMap.get(lead.id).OwnerId);
        }
    }
}
