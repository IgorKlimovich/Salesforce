@isTest
public class TestCaseSolutionTrigger {

    @isTest
    public static void testCaseSolutionNoAnswer(){
        List<Case_Solution__c> caseSolutions = 
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5,CaseSolutionTriggerConstants.NEW_STATUS, 
            CaseSolutionTriggerConstants.CALL, CaseSolutionTriggerConstants.CONSULTATION);
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionTriggerConstants.NO_ANSWER;
        Test.startTest(); 
        Database.SaveResult result =  Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionTriggerConstants.NEW_STATUS, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionTriggerConstants.CONSULTATION, caseSolution.Solution_Results__c);
        }
    }

    @isTest
    public static void testCaseSolutionResolvedViaCall(){
        List<Case_Solution__c> caseSolutions =
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5, CaseSolutionTriggerConstants.NEW_STATUS,
            CaseSolutionTriggerConstants.CALL, CaseSolutionTriggerConstants.CONSULTATION); 
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionTriggerConstants.RESOLVED_VIA_CALL;
        Test.startTest();
        Database.SaveResult result = Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionTriggerConstants.RESOLVED, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionTriggerConstants.CANCELLED, caseSolution.Solution_Results__c);
        }
    }

    @isTest
    public static void testCaseSolutionResolvedInAdvance(){
        List<Case_Solution__c> caseSolutions =
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5, CaseSolutionTriggerConstants.NEW_STATUS,
            CaseSolutionTriggerConstants.EMAIL, CaseSolutionTriggerConstants.NEED_A_CHECK); 
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionTriggerConstants.RESOLVED_IN_ADVANCE;
        Test.startTest();
        Database.SaveResult result = Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionTriggerConstants.RESOLVED, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionTriggerConstants.CANCELLED, caseSolution.Solution_Results__c);
        }
    }
}
