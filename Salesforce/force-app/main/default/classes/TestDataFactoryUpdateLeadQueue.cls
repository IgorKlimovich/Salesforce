@isTest
public with sharing class TestDataFactoryUpdateLeadQueue {

    public static void createLeads(Integer numLeads, String statusName){
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0; i<numLeads; i++) {
            Lead lead = new Lead(LastName = UpdateLeadBatchConstants.TEST_LAST_NAME + i,
             Company = UpdateLeadBatchConstants.TEST_LAST_NAME + i,
             Budget__c = UpdateLeadBatchConstants.BUDGET_CONFIRMED_AMOUNT_KNOWN, 
             Authority__c = UpdateLeadBatchConstants.ACCESS_TO_BUYER_CONFIRMED, Status=statusName);
            testLeads.add(lead);
        }
        insert testLeads;
    }

    public static Lead getTestLead(){
        return [SELECT id, OwnerId FROM Lead LIMIT 1];
    }

    public static List<Lead> getTestLeadList(){
        return [SELECT id, OwnerId FROM Lead];
    }
}

