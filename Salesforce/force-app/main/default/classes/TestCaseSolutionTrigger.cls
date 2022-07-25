@isTest
public class TestCaseSolutionTrigger {

    @isTest
    public static void testOneCaseSolutionNoAnswer(){
        List<Case_Solution__c> caseSolutionsForUpdate = new List<Case_Solution__c>();
        List<Case_Solution__c> caseSolutions=
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 1, 'Consultation');
        for (Case_Solution__c caseSolution : caseSolutions) {
            caseSolution.Solution_Results__c='No answer';
            caseSolutionsForUpdate.add(caseSolution);
        }
        update caseSolutionsForUpdate;
        Test.startTest();
        List<Database.SaveResult> results =  Database.update(caseSolutionsForUpdate);
        Test.stopTest();   
        for(Database.SaveResult result : results) {
            System.assert(result.isSuccess());
        }
        List<Case_Solution__c> listAfterUpdate = [SELECT Id, Solution_Results__c FROM Case_Solution__c] ;
        System.assertEquals('No answer', listAfterUpdate[0].Solution_Results__c);
    }

    @isTest
    public static void testOneCaseSolutionResolvedViaCall(){
        List<Case_Solution__c> caseSolutionsForUpdate = new List<Case_Solution__c>();
        List<Case_Solution__c> caseSolutions=
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 1, 'Consultation');
        for (Case_Solution__c caseSolution : caseSolutions) {
            caseSolution.Solution_Results__c='Resolved via call';
            caseSolutionsForUpdate.add(caseSolution);
        }
        update caseSolutionsForUpdate;
        Test.startTest();
        List<Database.SaveResult> results =  Database.update(caseSolutionsForUpdate);
        Test.stopTest();   
        for(Database.SaveResult result : results) {
            System.assert(result.isSuccess());
        }
        List<Case_Solution__c> listAfterUpdate = [SELECT Id, Solution_Results__c FROM Case_Solution__c] ;
        System.assertEquals('Resolved via call', listAfterUpdate[0].Solution_Results__c);
    }

    @isTest
    public static void testSomeCaseSolutionResolvedViaCall(){
        List<Case_Solution__c> caseSolutionsForUpdate = new List<Case_Solution__c>();
        List<Case_Solution__c> caseSolutions=
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5, 'Consultation'); 
        Case_Solution__c caseForUpdate = caseSolutions[0];
        caseForUpdate.Solution_Results__c='Resolved via call';
        caseSolutionsForUpdate.add(caseForUpdate);
        update caseSolutionsForUpdate;
        Test.startTest();
        List<Database.SaveResult> results =  Database.update(caseSolutionsForUpdate);
        Test.stopTest();   
        for(Database.SaveResult result : results) {
            System.assert(result.isSuccess());
        }
        List<Case_Solution__c> listAfterUpdate = [SELECT Id, Solution_Results__c FROM Case_Solution__c
        WHERE id !=:caseForUpdate.id];
        for(Case_Solution__c caseSolution:listAfterUpdate){
        System.assertEquals('Cancelled', caseSolution.Solution_Results__c);
        }
    }

    @isTest
    public static void testManyCaseSolutionResolvedViaCall(){
        List<Case_Solution__c> caseSolutionsForUpdate = new List<Case_Solution__c>();
        List<Case_Solution__c> caseSolutions=
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(200, 2, 'Consultation');
        for (Case_Solution__c caseSolution : caseSolutions) {
            caseSolution.Solution_Results__c='Resolved via call';
            caseSolutionsForUpdate.add(caseSolution);
        }
        update caseSolutionsForUpdate;        
        Test.startTest();
        List<Database.SaveResult> results =  Database.update(caseSolutionsForUpdate);    
        Test.stopTest();   
        for(Database.SaveResult result : results) {
            System.assert(result.isSuccess());
        }
    }
}