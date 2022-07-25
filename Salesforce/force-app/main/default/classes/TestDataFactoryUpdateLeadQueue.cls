@isTest
public with sharing class TestDataFactoryUpdateLeadQueue {

    public static void createLeads(Integer numLeads, String statusName){
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0; i<numLeads; i++) {
            Lead lead = new Lead(LastName='Test last name '+i, Company='Test company '+i,
            Budget__c='Budget Confirmed, Amount Known', Authority__c='Access to Buyer Confirmed', Status=statusName);
            testLeads.add(lead);
        }
        insert testLeads;
    }
}
